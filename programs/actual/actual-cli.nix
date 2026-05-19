{ lib, buildNpmPackage, fetchurl, nodejs_22 }:

buildNpmPackage rec {
  pname = "actual-cli";
  version = "26.5.2";

  src = fetchurl {
    url = "https://registry.npmjs.org/@actual-app/cli/-/cli-${version}.tgz";
    hash = "sha512-xWa0jlq7a2XGIE1x6VUaeqkp8YZvxaGWlRX9yLKveDKZ9c294Y6U2Odk0+vGqjhhVwtnSn7Fkh61tBbaFCZMyg==";
  };

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-x29HUG4a5tjCjkrKSC+NTmmgJds/mT01qSHvFUrifyw=";

  dontNpmBuild = true;

  nodejs = nodejs_22;

  meta = with lib; {
    description = "CLI for Actual Budget";
    homepage = "https://github.com/actualbudget/actual";
    license = licenses.mit;
    mainProgram = "actual";
  };
}
