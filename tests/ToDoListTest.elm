module ToDoListTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Random exposing (Seed, initialSeed)
import Test exposing (..)
import ToDoList exposing (..)


startingId =
    initialSeed 12


testTodo : Todo
testTodo =
    let
        ( newId, newSeed ) =
            makeId startingId
    in
    { id = newId
    , content = "Get Fuzzy Pickles"
    , completed = False
    }


listTests : Test
listTests =
    describe "todo htlm"
        [ test "check that it sorts correctly" <|
            \_ ->
                Expect.equal (sortTodos [ testTodo ]) [ completeTodoView testTodo ]
        ]
