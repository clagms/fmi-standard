
function Export-Schema() {
    Param(
        $element, 
        $expand, 
        $preview = $false
    )
    $out = $element + "_schema.png"
    $generator = ".\XSDDiagramConsole.exe"
    & $generator -o .\docs\images\gen\$out -r $element -e $expand -d -c -z 300 -a -no-gui -y .\schema\fmi3ModelDescription.xsd
    if ($preview) {
        Start-Process .\docs\images\gen\$out
    }
}

$preview = $false

if (-Not (Test-Path ".\XSDDiagramConsole.exe"))
{
    Invoke-WebRequest -Uri "http://regis.cosnier.free.fr/soft/xsddiagram/XSDDiagram-2018-06-19-1.2-Binary.zip" -OutFile "XSDDiagram-Binary.zip"
    Expand-Archive -Path XSDDiagram-Binary.zip -DestinationPath . -Force
    Remove-Item -Path XSDDiagram-Binary.zip
}

Export-Schema fmiModelDescription 1 $preview
Export-Schema TypeDefinitions 2 $preview 
Export-Schema LogCategories 3 $preview 
Export-Schema Terminals 2 $preview 
Export-Schema GraphicalRepresentation 1 $preview 
Export-Schema VendorAnnotations 2 $preview 
Export-Schema ModelVariables 2 $preview 
Export-Schema ModelStructure 2 $preview 
