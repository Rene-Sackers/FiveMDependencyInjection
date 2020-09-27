$version = Get-Date -Format "yy.M.d.HHmmss"
$nugetExePath = ".\nuget.exe"

$projects =
    "../src/FiveMDependencyInjection/FiveMDependencyInjection.csproj"

foreach ($project in $projects) {
    $argumentList = "pack ""$project"" -Version $version -OutputDirectory .\packed -Build -Symbols"
    
    Invoke-Expression "& $nugetExePath $argumentList"
}

$localNugetPath = $env:LocalNugetPath
Copy-Item -Path ".\packed\*" -Destination "$localNugetPath"
Remove-Item -Path ".\packed\" -Recurse