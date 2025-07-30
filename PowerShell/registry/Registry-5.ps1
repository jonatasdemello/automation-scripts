function get-itemproperty2 {
          # get-childitem skips top level key, use get-item for that
          # set-alias gp2 get-itemproperty2
          param([parameter(ValueFromPipeline)]$key)
          process {
            $key.getvaluenames() | foreach-object {
              $value = $_
              [pscustomobject] @{
                Path = $Key -replace 'HKEY_CURRENT_USER',
                  'HKCU:' -replace 'HKEY_LOCAL_MACHINE','HKLM:'
                Name = $Value
                Value = $Key.GetValue($Value)
                Type = $Key.GetValueKind($Value)
              }
            }
          }
        }

    ls -r hkcu: | get-itemproperty2 | where Value -match "(.*)C:\\Users\\Admin(.*)"  | ForEach-Object {
        $newkey = $_.Value -replace '(.*)C:\\Users\\Admin(.*)', '$1C:\Users\dennisg$2';
        if ($_.Name -eq '')
        {
            set-itemproperty -Path $_.Path -Name '(Default)' -Value $newkey -Type $_.Type ;
            $outInfo = '****' + $_.Path + " | " + $_.Name  + " | " + $newkey;
        }
        else
        {
            set-itemproperty -Path $_.Path -Name $_.Name -Value $newkey -Type $_.Type ;
            $outInfo = $_.Path + " | " + $_.Name  + " | " + $newkey;
        }
        echo $outInfo;
    }