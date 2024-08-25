#!/bin/bash

# 检查系统版本
os_name=$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
if [ "$os_name" = "Amazon Linux" ]; then
    # 保存指定文件
    files_to_save=("/etc/ssh/sshd_config" "/etc/shadow" "/etc/login.defs" "/etc/pam.d/system-auth" "/etc/pam.d/sshd" "/etc/sudoers" "/etc/audit/audit.rules")
    save_dir="/tmp/saved_files"
    mkdir -p "$save_dir"

    for file in "${files_to_save[@]}"; do
        cp "$file" "$save_dir/"
    done

    # 执行指定命令并将输出保存到文件
    command_output_file="command_query.txt"
    echo "netstat -anltp" >> "$command_output_file"
    netstat -anltp >> "$command_output_file"
    echo "ls -al /etc/shadow" >> "$command_output_file"
    ls -al /etc/shadow >> "$command_output_file"
    echo "ls -al /etc/passwd" >> "$command_output_file"
    ls -al /etc/passwd >> "$command_output_file"
    echo "tail -20 /var/log/audit/audit.log" >> "$command_output_file"
    tail -20 /var/log/audit/audit.log >> "$command_output_file"
    echo "sudo yum check-update" >> "$command_output_file"
    sudo yum check-update >> "$command_output_file"

    # 压缩所有文件
    hostname=$(hostname)
    datetime=$(date +"%Y%m%d_%H%M%S")
    zip_filename="${hostname}_${datetime}.zip"
    zip "$zip_filename" "$save_dir"/* "$command_output_file"

    echo "所有文件已保存到 $zip_filename"

    # 清理临时文件
    rm -rf "$save_dir"
    rm "$command_output_file"

elif [ "$os_name" = "CentOS Linux" ]; then
    # 对于 CentOS 系统执行相应操作
    echo "当前系统为 CentOS Linux"
    # 在此添加针对 CentOS 系统的操作

elif [ "$os_name" = "Ubuntu" ]; then
    # 对于 Ubuntu 系统执行相应操作
    echo "当前系统为 Ubuntu"
    # 在此添加针对 Ubuntu 系统的操作

else
    echo "当前系统不受支持,脚本退出。"
    exit 1
fi
