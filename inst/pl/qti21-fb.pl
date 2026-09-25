% The id of the response is needed in the response-specific feedback
response_id(DOM, Resp) :-
    sub_term(element(responseDeclaration, Properties, _), DOM),
    option(identifier(Resp), Properties).

% We also need to extract the ids ("mapKeys") of the response options
map_entries(DOM, Keys) :-
    sub_term(element(mapping, _, Map), DOM),
    convlist([element(mapEntry, Prop, _), K] >> option(mapKey(K), Prop), Map, Keys).

% replace global feedback by response-specific items
new_fb(element(assessmentItem, Prop, Old), element(assessmentItem, Prop, New)) :-
    select(element(modalFeedback, _, Global), Old, New0), % remove global feedback
    select(element(ul, _, UL), Global, Header), % extract header, handles only 1st <ul>
    convlist([element(li, _, LI), LI] >> true, UL, LIs),
    % create list of response-specific feedback items
    findall(element(modalFeedback, [identifier=Id, outcomeIdentifier='FEEDBACKMODAL', showHide=show], Item),
        (   nth1(I, LIs, LI), format(atom(Id), 'FEEDBACK_~w', [I]),
            append(Header, LI, Item) % prepend header
        ), FBList),
    append(New0, FBList, New).

% add response conditions for each feedback item
new_rc(Resp, Map, element(responseProcessing, Prop, Old), element(responseProcessing, Prop, New)) :-
    findall(element(responseCondition, [],
        [ element(responseIf, [],
          [ element(match, [],
            [ element(variable, [identifier=Resp], []),
              element(baseValue, [baseType=identifier], [Item])
            ]),
            element(setOutcomeValue, [identifier='FEEDBACKMODAL'],
            [ element(multiple, [],
              [ element(baseValue, [baseType=identifier], [Id]) ])
        ]) ]) ]),
        ( nth1(I, Map, Item), format(atom(Id), 'FEEDBACK_~w', [I]) ),
        Conditions),
    append(Old, Conditions, New).

fix_item :-
    fix_item("old", "new", "mistakes_444403204_section_3_item_1_schoice.xml").

fix_item(Old, New, Item) :-
    directory_file_path(Old, Item, OldItem),
    load_xml(OldItem, DOM, []),
    response_id(DOM, Resp),
    map_entries(DOM, Map),
    mapsubterms(new_fb, DOM, DOM1),
    mapsubterms(new_rc(Resp, Map), DOM1, DOM2),
    directory_file_path(New, Item, NewItem),
    setup_call_cleanup(
open(NewItem, write, S),
 xml_write(S, DOM2, []),
 close(S)).

% We also need to extract the ids ("mapKeys") of the response options
fix_test :-
    fix_test("old", "new", "mistakes_444403204.xml").

fix_test(Old, New, Test) :-
    directory_file_path(Old, Test, OldTest), copy_file(OldTest, New),
    load_xml(OldTest, DOM, []),
    findall(Item,
            (   sub_term(element(assessmentItemRef, Prop, _), DOM),
                option(href(Item), Prop)
            ), Items),
    maplist(fix_item(Old, New), Items).

fix_folder :-
    fix_folder("old", "new").

fix_folder(Old, New) :-
    directory_file_path(Old, "imsmanifest.xml", OldManifest),
    copy_file(OldManifest, New),
    directory_file_path(Old, "QTI21PackageConfig.xml", OldConfig),
    copy_file(OldConfig, New),
    directory_file_path(Old, "imsmanifest.xml", Path),
    load_xml(Path, DOM, []),
    sub_term(element(resource, _, Res), DOM), !,
    sub_term(element(file, Prop, _), Res),
    option(href(Test), Prop),
    fix_test(Old, New, Test).




