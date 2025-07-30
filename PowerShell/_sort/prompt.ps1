function prompt {"PS [$env:COMPUTERNAME]> "}

function prompt {"PS > "}


(Get-Item function:prompt).ScriptBlock


function prompt {
    $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
      else { '' }) + 'PS ' + $(Get-Location) +
        $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> '
}

