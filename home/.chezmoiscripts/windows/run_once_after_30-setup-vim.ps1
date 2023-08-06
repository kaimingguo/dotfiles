# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

New-Item -ItemType SymbolicLink -Path ~/vimfiles -Target (Resolve-Path ~/.vim) -ErrorAction SilentlyContinue

if (-not (Test-Path ~/.vim/init.vim)) {
    New-Item -Path ~/.vim/init.vim -ErrorAction SilentlyContinue
}

New-Item -ItemType SymbolicLink -Path ~/.vimrc -Target (Resolve-Path ~/.vim/init.vim)