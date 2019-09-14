module Test.Generated.Main3865349877 exposing (main)

import Example
import GetToDo

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "Example" [Example.suite],     Test.describe "GetToDo" [GetToDo.getToDo] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 207513157691829, processes = 4, paths = ["/Users/andrew/Git/Personal Projects/elm-to-do/tests/Example.elm","/Users/andrew/Git/Personal Projects/elm-to-do/tests/GetToDo.elm"]}