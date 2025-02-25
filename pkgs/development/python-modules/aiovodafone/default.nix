{ lib
, aiohttp
, beautifulsoup4
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "aiovodafone";
  version = "0.0.8";
  format = "pyproject";

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "chemelli74";
    repo = "aiovodafone";
    rev = "refs/tags/v${version}";
    hash = "sha256-o21zaK3dJfURFAt8fPaOd95H7tuqLnFPC01RGHBIz4M=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=aiovodafone --cov-report=term-missing:skip-covered" ""
  '';

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    aiohttp
    beautifulsoup4
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "aiovodafone"
  ];

  meta = with lib; {
    description = "Library to control Vodafon Station";
    homepage = "https://github.com/chemelli74/aiovodafone";
    changelog = "https://github.com/chemelli74/aiovodafone/blob/${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
