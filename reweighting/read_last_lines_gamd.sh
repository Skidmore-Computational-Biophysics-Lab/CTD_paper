cat gamd_file_list.txt | while read -r file; do
    tail -n 4800000 "$file"
done > gamd_all.log
