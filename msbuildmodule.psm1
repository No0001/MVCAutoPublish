Using module ".\BuildWebPath.psm1"
#powerShell module


function BuildWeb([BuildWebPath] $model) 
{
    
    if(Test-Path -Path $model.publishUrl)
    {
        Write-Host "目錄已存在，進行刪除"
        Remove-Item $model.publishUrl -Recurse
    }

    #nuget路徑
    $nuget = $PSScriptRoot + "\nuget.exe"

    #Git版本號
    #$version = $(git describe --abbrev=0 --tag)

    #還原套件
    Write-Host "還原套件----------"
     
    & $nuget restore $model.solutionFile

    if ($LastExitCode -ne 0)
    {
        $exitCode=$LastExitCode
        Write-Error "還原失敗!"
        exit $exitCode
    }
    else
    {
        Write-Host "還原成功!"
    }

    Write-Host "Publish"

    $filePath = $PSScriptRoot + "\FolderProfile.pubxml"
 
    $publishUrl = $model.publishUrl

    & $model.msbuild $model.projectFile /p:DeployOnBuild=true /p:PublishProfile=$filePath /p:PublishUrl=$publishUrl

    if($LastExitCode -ne 0)
    {
        $exitCode=$LastExitCode
        Write-Error "Publish failed!"
         #pause "執行結束"
        exit $exitCode
    }
    else
    {
        Write-Host "Publish succeeded"        
    }
}



