#
# Powershell script to setup for Windows usage:
#
echo "starting"
#
# make sure the files are in the correct format:
#
# Linux format:
#
$file = ".\.bashrc"
$target = ".\.bashrc-temp"
Get-Content $file | % { $_ + "`n"} | Set-Content $target -NoNewline
if (Test-Path -Path $target) {
  Remove-Item $file
  Move-Item -Path $target -Destination $file
}

#
# Windows format:
#
$file = ".\docker\build.ps1"
$target = ".\docker\build-temp.ps1"
Get-Content $file| % { $_ + "`r`n"} | Set-Content $target -NoNewline
if (Test-Path -Path $target) {
  Remove-Item $file
  Move-Item -Path $target -Destination $file
}

$file = ".\docker\build.bat"
$target = ".\docker\build-temp.bat"
Get-Content $file| % { $_ + "`r`n"} | Set-Content $target -NoNewline
if (Test-Path -Path $target) {
  Remove-Item $file
  Move-Item -Path $target -Destination $file
}

$file = ".\docker\run.ps1"
$target = ".\docker\run-temp.ps1"
Get-Content $file| % { $_ + "`r`n"} | Set-Content $target -NoNewline
if (Test-Path -Path $target) {
  Remove-Item $file
  Move-Item -Path $target -Destination $file
}

$file = ".\docker\run.bat"
$target = ".\docker\run-temp.bat"
Get-Content $file| % { $_ + "`r`n"} | Set-Content $target -NoNewline
if (Test-Path -Path $target) {
  Remove-Item $file
  Move-Item -Path $target -Destination $file
}

$file = ".\docker\_image-name.txt"
$target = ".\docker\_image-name-temp.txt"
Get-Content $file| % { $_ + "`r`n"} | Set-Content $target -NoNewline
if (Test-Path -Path $target) {
  Remove-Item $file
  Move-Item -Path $target -Destination $file
}

$file = ".\docker\Dockerfile"
$target = ".\docker\Dockerfile-temp"
Get-Content $file| % { $_ + "`r`n"} | Set-Content $target -NoNewline
if (Test-Path -Path $target) {
  Remove-Item $file
  Move-Item -Path $target -Destination $file
}

#
# setup to run scripts without .ps1 extension:
#
$file = ".\docker\build"
if (Test-Path -Path $file) {
  Remove-Item $file
}
$file = ".\docker\run"
if (Test-Path -Path $file) {
  Remove-Item $file
}

Copy-Item -Path .\docker\build.ps1  -Destination .\docker\build
Copy-Item -Path .\docker\run.ps1  -Destination .\docker\run

#
# done!
#
echo "done"
echo "to build docker container: ./docker/build"
echo "to run docker container: ./docker/run"
echo "to exit docker container: exit"
echo "have fun!"
