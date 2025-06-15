set positional-arguments

run name *args:
  #!/usr/bin/env sh
  mkdir -p output;
  shift 1;
  xylo-lang generate "./src/{{name}}.xylo" "./output/{{name}}.png" "$@";

watch name *args:
  #!/usr/bin/env sh
  shift 1;
  nodemon --exec "just run {{name}} $@" -e .xylo

open name:
  sxiv "./output/{{name}}.png";
