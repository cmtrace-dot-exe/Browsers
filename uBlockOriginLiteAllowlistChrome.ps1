############################################################################################################
### uBlock Origin Lite for Chrome Allowlist Configuration Script
### Mike O'Leary 
###     twitter:    @cmtrace_dot_exe
###     github:     @cmtrace-dot-exe
### Changelog: 	2024-05-16
############################################################################################################

# Define the websites to be excluded from filtering below, between the @"array operators"@.

$urls=@"
contoso.com
cpandl.com
fabrikam.com
margiestravel.com
northwindtraders.com
proseware.com
tailspintoys.com
treyresearch.net
wingtiptoys.com
wideworldimporters.com
"@ -split "`n" | % {$_.trim()}

# Registry key location for uBlock Origin Lite's filtering exemptions
    $key = "HKLM:\SOFTWARE\Policies\Google\Chrome\3rdparty\extensions\ddkjiahejlhfcafbddmgiahcphecmpfh\policy\noFiltering"

# Remove noFiltering key if it already exists. Clearing the decks makes updating an existing list far less complicated.
    if (test-path -path $key) {remove-item -path $key}

# Create or recreate noFiltering key.
    new-item -path "HKLM:\SOFTWARE\Policies\Google\Chrome\3rdparty\extensions\ddkjiahejlhfcafbddmgiahcphecmpfh\Policy" -name "noFiltering" -force

# Iterate through the content of $urls and write numbered values to the noFiltering key
$i = 0
$urls | % -process {
    $i++ 
    new-itemProperty -path "HKLM:\SOFTWARE\Policies\Google\Chrome\3rdparty\extensions\ddkjiahejlhfcafbddmgiahcphecmpfh\policy\noFiltering" -name "$i" -value "$_" -propertyType String -force
}