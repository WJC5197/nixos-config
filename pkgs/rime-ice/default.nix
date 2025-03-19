{
  fetchgit,
  stdenv,
  lib,
  librime,
  makeSetupHook,
  # regex to select schemas
  # by default all schemas are included
  schemaRegex ? "^.*$",
  yq-go,
}:
let
  rime-ice = {
    pname = "rime-ice";
    version = "75b225e84f5e95ddf0b5a50fa6e2cff9800ee7b7";
    src = fetchgit {
      url = "https://github.com/iDvel/rime-ice.git";
      rev = "75b225e84f5e95ddf0b5a50fa6e2cff9800ee7b7";
      fetchSubmodules = true;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-/sKoufIf4m5h1Zds6AqIyeCjDaZsFU9ot5ln3ykuNyU=";
    };
    date = "2025-03-11";
  };
  rimeDataBuildHook = makeSetupHook {
    name = "rime-data-build-hook.sh";
    substitutions = { };
  } ./rime-data-build-hook.sh;
in
stdenv.mkDerivation {
  inherit (rime-ice) pname version src;

  nativeBuildInputs = [
    librime
    rimeDataBuildHook
    yq-go
  ];

  postPatch = ''
    keep=()
    function in_keep {
      [[ " ''${keep[*]} " =~ [[:space:]]$1[[:space:]] ]]
    }
    for schema_file in *.schema.yaml; do
      [[ "$schema_file" =~ ^(.*)\.schema\.yaml$ ]] && schema="''${BASH_REMATCH[1]}"
      if [[ "$schema" =~ ${schemaRegex} ]]; then
        echo "add $schema to keep list"
        keep+=("$schema")
      fi
    done

    old_keep=()
    keep=($(printf '%s\n' "''${keep[@]}" | sort --unique))
    while [[ "''${keep[*]}" != "''${old_keep[*]}" ]]; do
      old_keep=("''${keep[@]}")
      for schema_file in *.schema.yaml; do
        [[ "$schema_file" =~ ^(.*)\.schema\.yaml$ ]] && schema="''${BASH_REMATCH[1]}"
        if in_keep "$schema"; then
          for dep in $(yq '.schema.dependencies[]' "$schema_file"); do
            file="$dep.schema.yaml"
            if [[ ! -f "$file" ]]; then
              echo "failed to find $file (dependency of $schema_file)"
            fi
            echo "add $dep to keep list (dependency of $schema)"
            keep+=("$dep")
          done
          if [[ "$(yq 'has("__include")' "$schema_file")" = "true" ]]; then
            include=$(yq '.__include | match("^(.*)\.schema\.yaml:.*$") | .captures[0].string' "$schema_file")
            file="$include.schema.yaml"
            if [[ ! -f "$file" ]]; then
              echo "failed to find $file (included by $schema_file)"
            fi
            echo "add $include to keep list (included by $schema)"
            keep+=("$include")
          fi
        fi
      done
      keep=($(printf '%s\n' "''${keep[@]}" | sort --unique))
    done

    echo "schemas to keep: ''${keep[*]}"
    for schema_file in *.schema.yaml; do
      [[ "$schema_file" =~ ^(.*)\.schema\.yaml$ ]] && schema="''${BASH_REMATCH[1]}"
      if in_keep "$schema"; then
        echo "keep $schema_file"
      else
        echo "remove $schema_file"
        rm "$schema_file"
      fi
    done

    yq 'del(.schema_list[] | select(.schema | test("${schemaRegex}") | not))' --inplace ./default.yaml

    echo '----------'
    echo "schema files:"
    ls -l *.schema.yaml
    echo '----------'
    echo "schemas in default.yaml:"
    yq '.schema_list[] | .schema' ./default.yaml
    echo '----------'
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/rime-data"
    cp -r cn_dicts "$out/share/rime-data/cn_dicts"
    cp -r en_dicts "$out/share/rime-data/en_dicts"
    cp -r opencc   "$out/share/rime-data/opencc"
    cp -r lua      "$out/share/rime-data/lua"

    install -Dm644 *.{schema,dict}.yaml -t "$out/share/rime-data/"
    install -Dm644 custom_phrase.txt    -t "$out/share/rime-data/"
    install -Dm644 symbols_v.yaml       -t "$out/share/rime-data/"
    install -Dm644 symbols_caps_v.yaml  -t "$out/share/rime-data/"

    install -Dm644 default.yaml "$out/share/rime-data/rime_ice_suggestion.yaml"

    install -Dm644 build/* -t "$out/share/rime-data/build"

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/iDvel/rime-ice";
    description = "A long-term maintained simplified Chinese RIME schema";
    license = licenses.gpl3;
    maintainers = with maintainers; [ yinfeng ];
  };
}
