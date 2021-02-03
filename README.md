# MVCAutoPublish

使用PowerShell 自動發佈網站


 ```powershell
 
Using module ".\BuildWebPath.psm1"

Import-Module -Force ".\msbuildmodule.psm1"

#msbuild path
$msbuild = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe"
#project base path
$basePath = "C:\Project\Myproject\MVCAutoPublish"
#projectName
$projectName = "MVCAutoPublish"
#publish path
$publishUrl = $PSScriptRoot +"\publish"

#Create publish obj
$dev = [BuildWebPath]::new($msbuild,$basePath,$projectName,$publishUrl)

#Check path

Write-Host "msbuild path"
$dev.msbuild
Write-Host "project path"
$dev.projectFile
Write-Host "publish path!"
$dev.publishUrl
Write-Host "publish solutionFile"
$dev.solutionFile

BuildWeb $dev

#Remove Config
Remove-Item $publishUrl\Web.config
```

設定 $msbuild、$basePath、$projectName、$publishUrl  

執行 BuildWeb.ps1  

會將網站產生在指定的目錄下  


BuildWeb.ps1 使用到的  

BuildWebPath.psm1  => 抓取路徑  

msbuildmodule.psm1 => 發佈網站的PowerShell程式碼  


