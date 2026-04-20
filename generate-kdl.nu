#!/usr/bin/env nu

def main [path: path, type: string] {
    let file = (open $path
        | lines
        | each {
            |line| ['            ', $line, "\n"]
            | str join
        }
        | str join)
    echo $'animations {
    ($type) {
        curve "cubic-bezier" 0.09 1.44 0.8 1.23
        custom-shader r"
($file)        "
    }
}'
}
