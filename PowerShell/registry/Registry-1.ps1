# BACKUP YOUR REGISTRY before even thinking of copypasting and running this on your PC
# the person executing this script is the one and only responsible
# for any damage it may incur
# you've been warned

Get-ChildItem -Recurse 'Registry::HKEY_CLASSES_ROOT','Registry::HKEY_USERS','Registry::HKEY_LOCAL_MACHINE','Registry::HKEY_CURRENT_CONFIG' |
  ForEach-Object {
    $key = $_
    Write-Verbose $key.Name -Verbose
    $key.property | ForEach-Object {
      $prop = $_
      $value = $key | Get-ItemPropertyValue -Name $prop
      if ($value -imatch '^("?)I(\:\\Tools\\.*)') {
        $replacement = "$($Matches[1])M$($Matches[2])"
        Write-Host "$key `:`n  ", $value," -> ","$replacement"
        Set-ItemProperty -Path "Registry::$key" -Debug -Name $prop -Value $replacement
      }
    }
  }

