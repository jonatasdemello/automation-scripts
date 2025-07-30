# powershell debug

# 0: Turn script tracing off.
# 1: Trace script lines as they run.
# 2: Trace script lines, variable assignments, function calls, and scripts.

Set-PSDebug -Trace 1

$sum = 1+2

write-host "sum is: $sum"

