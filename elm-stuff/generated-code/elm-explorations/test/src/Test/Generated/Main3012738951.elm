module Test.Generated.Main3012738951 exposing (main)

import GetToDo

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "GetToDo" [GetToDo.getToDo] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = (ConsoleReport UseColor), seed = 287778704073542, processes = 4, paths = ["/Users/andrew/Git/Personal Projects/elm-to-do/tests/GetToDo.elm"]}