$version = Get-Date -Format "yy.M.d.HHmmss"
$nugetExePath = ".\nuget.exe"

$projects =
    "../src/FiveMDependencyInjection/FiveMDependencyInjection.csproj"

Remove-Item -Path ".\packed\" -Recurse

foreach ($project in $projects) {
    $argumentList = "pack ""$project"" -Version $version -OutputDirectory .\packed -Build"
    
    Invoke-Expression "& $nugetExePath $argumentList"
}

$localNugetPath = $env:LocalNugetPath
if (-not ($null -eq $localNugetPath))
{
	Copy-Item -Path ".\packed\*" -Destination "$localNugetPath"
}