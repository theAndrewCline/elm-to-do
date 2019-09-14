module ToDoListTest exposing (..)

import ToDoList exposing (helloWorld)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


listTests : Test
listTests =
    describe "getToDos"
        [ test "it's all working" <|
            \_ ->
            Expect.equal ( helloWorld "Andrew") "Andrew hi"
        ]
