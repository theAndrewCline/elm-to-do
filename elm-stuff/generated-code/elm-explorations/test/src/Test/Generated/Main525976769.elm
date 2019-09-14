module Test.Generated.Main525976769 exposing (main)

import ToDoListTest

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "ToDoListTest" [ToDoListTest.listTests] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 274325561000386, processes = 4, paths = ["/Users/andrew/Git/Personal Projects/elm-to-do/tests/ToDoListTest.elm"]}