Import-Module PackageManagement,PowerShellGet

if ([System.Boolean](Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

    $chocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
    if (Test-Path $chocolateyProfile) {
        Import-Module "$chocolateyProfile"
    } else {
        Remove-Variable $chocolateyProfile
    }

    # Update environment in case the terminal session environment
    # is not up to date, but first clear VS env so it does not
    # accumulate duplicates.
    Get-ChildItem env: | % name `
        | ?{ $_ -match '^(__VSCMD|INCLUDE$|LIB$|LIBPATH$)' } `
        | %{ Remove-Item env:\$_ }
    
    Update-SessionEnvironment

    # Tell Chocolatey to not add code to $profile
    $env:ChocolateyNoProfile = 'yes'
}

if (-not $env:TERM) {
    $env:TERM = 'xterm-256color'
} elseif ($env:TERM -match '^(xterm|screen|tmux)$') {
    $env:TERM = $matches[0] + '-256color'
}

if (-not $env:COLORTERM) {
    $env:COLORTERM = 'truecolor'
}

if ([System.Boolean](Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction SilentlyContinue)) {
    $vim = ''

    $apps =
        { Resolve-Path /tools/neovim/nvim*/bin/nvim.exe @args },
        { (Get-Command nvim.exe @args).source },
        { Resolve-Path /tools/vim/vim*/vim.exe @args },
        { (Get-Command vim.exe @args).source },
        { (Get-Command vim.bat @args).source }
    
    foreach ($app in $apps) {
        if ($vim = &$app -ea ignore) { break }
    }

    if ($vim) {
        Set-Alias vim -Value $vim -Scope global
        $env:EDITOR = $vim -Replace '\\','/'
    }
} else {
    $env:EDITOR = 'vim'
}

if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}