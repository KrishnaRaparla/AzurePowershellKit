step-1 install chocolatey 

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

step -2 

choco install python

step -3 

python -m pip install -U pip