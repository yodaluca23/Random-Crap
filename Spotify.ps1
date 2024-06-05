#To run Install PowerShell 7 on MacOS "brew install powershell". Tp run install PowerShell 7 on Windows PS: "winget install --id Microsoft.Powershell --source winget". Open PowerShell 7 and run "iwr -useb https://raw.githubusercontent.com/yodaluca23/Random-Crap/main/Spotify.ps1 | iex"

# Function to check if the user is using the new PowerShell 7 (only for Windows)
function Check-NewPowerShell {
    if ($IsWindows) {
        $isPowerShell7 = $PSVersionTable.PSEdition -eq "Core"

        if (-not $isPowerShell7) {
            Write-Output "You are not using PowerShell 7."
            $installChoice = Read-Host "Do you want to install PowerShell 7? (yes/no)"

            if ($installChoice -eq "yes") {
                Write-Output "Installing PowerShell 7..."
                winget install --id Microsoft.Powershell --source winget
                Write-Output "PowerShell 7 installed successfully."
            } elseif ($installChoice -eq "no") {
                Write-Output "Exiting the script."
                exit
            } else {
                Write-Output "Invalid choice. Exiting the script."
                exit
            }
        }
    }
}

# Function to run Windows scripts
function Run-WindowsScripts {
    Write-Output "Running on Windows"
    
    # Download and run the batch script
    $batchScriptUrl = "https://raw.githubusercontent.com/SpotX-Official/SpotX/main/Install_New_theme.bat"
    $batchScriptPath = "$env:TEMP\Install_New_theme.bat"
    Invoke-WebRequest -Uri $batchScriptUrl -OutFile $batchScriptPath
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c $batchScriptPath" -Wait
    
    # Run the PowerShell script
    $psScriptUrl = "https://raw.githubusercontent.com/spicetify/cli/main/install.ps1"
    Invoke-Expression (Invoke-WebRequest -Uri $psScriptUrl -UseBasicParsing).Content
}

# Function to run macOS/Linux scripts
function Run-UnixScripts {
    Write-Output "Running on macOS/Linux"
    
    # Run the SpotX installation script
    $spotxScript = "bash <(curl -sSL https://spotx-official.github.io/run.sh) --installmac -h"
    bash -c "$spotxScript"
    
    # Run the Spicetify installation script
    $spicetifyScript = "curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh"
    bash -c "$spicetifyScript"
}

# Main script execution
Check-NewPowerShell

if ($IsWindows) {
    Run-WindowsScripts
} elseif ($IsMacOS -or $IsLinux) {
    Run-UnixScripts
} else {
    Write-Output "Unsupported OS"
}
