# Function to check the operating system
function Get-OS {
    $os = $PSVersionTable.PSPlatform
    return $os
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
$os = Get-OS

if ($os -eq "Windows") {
    Run-WindowsScripts
} elseif ($os -eq "Linux" -or $os -eq "Darwin") {
    Run-UnixScripts
} else {
    Write-Output "Unsupported OS: $os"
}
