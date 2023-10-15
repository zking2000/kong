#!/bin/bash

# 定义一个函数来执行curl请求
request_url() {
    count=0
    while [ $count -lt 100 ]; do
        response_code=$(curl -o /dev/null -s -w "%{http_code}" http://httpd.stephende.top)
        echo "HTTP Response Code: $response_code"
        count=$((count+1))
    done
}

# 定义要启动的线程数
THREAD_COUNT=100

# 启动多个线程
for i in $(seq 1 $THREAD_COUNT); do
    request_url &
done

# 等待所有后台进程完成
wait
