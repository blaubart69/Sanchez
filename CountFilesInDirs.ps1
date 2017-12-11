param (
[Parameter(Mandatory=$False)][string]$rootDirToSearch = ".",
[Parameter(Mandatory=$False)][string]$dirName = "Zutreffende Spezifikationen"
)

gci -Path "$rootDirToSearch" -Recurse -Depth 4 "$dirName" | # search entries with a specific name
? { $_.PSIsContainer } |                                    # make sure directories only (Powershell V1.0 does not know -Directory)
% { 
    #Write-Host "SPINDI: $($_.FullName)"
    $FileCount=$(gci -Name -Force -File -Recurse "$($_.FullName)" | measure).Count;  # count the files in the found dir
    New-Object psobject -Property @{Dirname=$($_.FullName); NumberFiles=$FileCount}  # emmit fullname and filecount in new object
}