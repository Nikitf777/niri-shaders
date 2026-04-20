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
        custom-shader r"
($file)        "
    }
}'
}
