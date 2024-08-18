{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pyyaml,
  semantic-version,
  defusedxml,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "lib4sbom";
  version = "0.7.3";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "anthonyharrison";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-RuIvhlLnWf/ayU6tjpHYKvBFqU8ojPwJK/pDIdLrD2s=";
  };

  dependencies = [
    pyyaml
    semantic-version
    defusedxml
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  disabledTests = [
    # stub tests that always fail
    "TestCycloneDXGenerator"
    "TestCcycloneDX_parser"
    "TestGenerator"
    "TestOutput"
    "TestParser"
    "TestSPDX_Generator"
    "TestSPDX_Parser"
    # tests with missing getters
    "test_set_downloadlocation"
    "test_set_homepage"
    "test_set_checksum"
    "test_set_externalreference"
    # checks for invalid return type
    "test_set_type"
    # wrong capilatization
    "test_set_supplier"
    "test_set_originator"
  ];

  pythonImportsCheck = [ "lib4sbom" ];

  meta = with lib; {
    description = "Library to ingest and generate SBOMs";
    homepage = "https://github.com/anthonyharrison/lib4sbom";
    changelog = "https://github.com/anthonyharrison/lib4sbom/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ teatwig ];
  };
}
