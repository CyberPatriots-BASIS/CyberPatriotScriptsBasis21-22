#! /bin/bash

  
function f_badfsdisable {
    
    echo "Script: [$SCRIPT_NUM] ::: Disable old file systems"

    local FS
    FS="cramfs freevxfs jffs2 hfs hfsplus udf vfat"
    for disable in $FS; do
    if ! grep -q "$disable" "$DISABLEFS" 2> /dev/null; then
      echo "install $disable /bin/true" >> "$DISABLEFS"
    fi
    done
    ((SCRIPT_NUM++))
}