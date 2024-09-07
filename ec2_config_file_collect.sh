#!/bin/bash

# 检查系统版本
os_name=$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
if [ "$os_name" = "Amazon Linux" ]; then

    # 执行指定命令并将输出保存到文件
    command_output_file="command_query.txt"
    os_release_file="os-release.txt"

    echo "cat /etc/os-release" >> "$os_release_file"
    cat /etc/os-release >> "$os_release_file"

    echo "cat /etc/os-release" >> "$command_output_file"
    cat /etc/os-release >> "$command_output_file"

    echo "sudo netstat -anltp" >> "$command_output_file" 
    sudo netstat -anltp >> "$command_output_file"

    echo "sudo ls -al /etc/shadow" >> "$command_output_file"
    sudo ls -al /etc/shadow >> "$command_output_file"

    echo "sudo ls -al /etc/passwd" >> "$command_output_file"
    sudo ls -al /etc/passwd >> "$command_output_file"

    echo "sudo tail -20 /var/log/audit/audit.log" >> "$command_output_file"
    sudo tail -20 /var/log/audit/audit.log >> "$command_output_file"

    echo "sudo yum check-update" >> "$command_output_file"
    sudo yum check-update >> "$command_output_file"

    echo "sudo ps -aef" >> "$command_output_file"
    sudo ps -aef >> "$command_output_file"

    echo "cat /etc/security/pwquality.conf" >> "$command_output_file"
    cat /etc/security/pwquality.conf >> "$command_output_file"

    echo "cat /etc/pam.d/system-auth" >> "$command_output_file"
    cat /etc/pam.d/system-auth >> "$command_output_file"

    echo "sudo cat /etc/ssh/sshd_config" >> "$command_output_file"
    sudo cat /etc/ssh/sshd_config >> "$command_output_file"

    echo "sudo cat /etc/shadow" >> "$command_output_file"
    sudo cat /etc/shadow >> "$command_output_file"

    echo "sudo cat /etc/login.defs" >> "$command_output_file"
    sudo cat /etc/login.defs >> "$command_output_file"

    echo "sudo cat /etc/audit/audit.rules" >> "$command_output_file"
    sudo cat /etc/audit/audit.rules >> "$command_output_file"

    echo "sudo getenforce" >> "$command_output_file"
    sudo getenforce >> "$command_output_file"

    echo "sudo yum list installed" >> "$command_output_file"
    sudo yum list installed >> "$command_output_file"

    echo "systemctl list-units --type=service" >> "$command_output_file"
    systemctl list-units --type=service >> "$command_output_file"

    echo "sudo cat /etc/sudoers" >> "$command_output_file"
    sudo cat /etc/sudoers >> "$command_output_file"

    echo "cat /etc/group" >> "$command_output_file"
    cat /etc/group >> "$command_output_file"

    # 压缩所有文件
    hostname=$(hostname)
    datetime=$(date +"%Y%m%d_%H%M%S")
    zip_filename="${hostname}_${datetime}.zip"
    zip "$zip_filename" "$command_output_file" "$os_release_file"

    echo "所有文件已保存到 $zip_filename"

    # 清理临时文件
    rm "$command_output_file" "$os_release_file"

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
