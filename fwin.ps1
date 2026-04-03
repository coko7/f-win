#  _____           _     __        ___           _
# |  ___|   _  ___| | __ \ \      / (_)_ __   __| | _____      _____
# | |_ | | | |/ __| |/ /  \ \ /\ / /| | '_ \ / _` |/ _ \ \ /\ / / __|
# |  _|| |_| | (__|   <    \ V  V / | | | | | (_| | (_) \ V  V /\__ \
# |_|   \__,_|\___|_|\_\    \_/\_/  |_|_| |_|\__,_|\___/ \_/\_/ |___/
#
# "Windows sucks ass, lets fix it for good." ~ @me
#
# Author: @coko7

# First, we install Scoop because for some fucking reason, some versions of Windows server do not come with winget by default.
# ...
# Ha. Ha.
if (-not (Get-Command scoop -ErrorAction SilentlyContinue))
{
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# Then, we install decent scoop buckets
$buckets = @("main", "extras")
foreach ($bucket in $buckets)
{
    if (-not (scoop bucket list | Select-String $bucket))
    {
        scoop bucket add $bucket
        Write-Output "Added scoop bucket: $bucket"
    }
}

function Ensure-Installed
{
    param(
        [Parameter(Mandatory=$true)]
        [string]$AppName
    )

    if (-not (scoop list $AppName 2>$null | Select-String -Quiet "^$AppName(\s|$)"))
    {
        Write-Host "Installing $AppName..."
        scoop install $AppName
    } else
    {
        Write-Host "$AppName is already installed, skipping."
    }
}

# Install git
Ensure-Installed main/git

# Then, we install fucking terminal editors cause there are none installed by default?...
# HELLO??? WINDOWS """SERVER""". What does the word "server" in "Windows server" stand for exactly?
# wtf Microsoft, get your shit together already.
Ensure-Installed main/neovim
Ensure-Installed main/edit

# Now we install atuin to easily fuzzy search shell history
if (!(scoop which atuin))
{
    Ensure-Installed main/atuin
    if (-not (Test-Path -Path $PROFILE))
    {
        New-Item -ItemType File -Path $PROFILE -Force | Out-Null
    }
    Write-Output 'atuin init powershell | Out-String | Invoke-Expression' >> $PROFILE
}

# Now we setup zoxide to magically traverse your fs
if (!(scoop which zoxide))
{
    Ensure-Installed main/zoxide
    Write-Output 'Invoke-Expression (& { (zoxide init powershell | Out-String) })' >> $PROFILE
}

# Here are some more fire CLIs:
Ensure-Installed main/ripgrep # blazingly fast grepping
Ensure-Installed main/fzf # the greatest command-line fuzzy finder
Ensure-Installed main/bat # like UNIX cat but fancier
Ensure-Installed main/delta # a syntax-highlighting pager for git, diff, grep, and blame output
Ensure-Installed main/fd # modern alternative to UNIX find command
Ensure-Installed main/xh # modern alternative to cURL
Ensure-Installed main/jq # command-line JSON processor 
Ensure-Installed main/zellij # terminal multiplexer

# Finally, lets install some decent GUI apps
Ensure-Installed extras/windows-terminal

Write-Host '🚀 Congratulations. Your Windows dev setup is now a tiny bit better ✨'
Write-Host "🐧 Don't forget to switch over to Linux when you get a chance 👋"

