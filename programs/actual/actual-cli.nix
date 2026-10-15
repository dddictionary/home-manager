{ lib, buildNpmPackage, fetchurl, nodejs_22 }:

buildNpmPackage rec {
  pname = "actual-cli";
  version = "26.10.0";

  src = fetchurl {
    url = "https://registry.npmjs.org/@actual-app/cli/-/cli-${version}.tgz";
    hash = "sha512-EzkXX/fRzzWvzz7sHrCpojiuMxTWN6NhmJqzTcZkOoadraVgzdvo3knnvIRoMKbAZMGipPRcPZmCjju4g4wdog==";
  };

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-4M3ewJfWF0skTgw4jhNUGTQGM8LDLYeGTqq1V5tal/4=";

  dontNpmBuild = true;

  nodejs = nodejs_22;

  meta = with lib; {
    description = "CLI for Actual Budget";
    homepage = "https://github.com/actualbudget/actual";
    license = licenses.mit;
    mainProgram = "actual";
  };
}
