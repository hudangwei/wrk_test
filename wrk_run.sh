#!/bin/bash

head="threadPool,concurrent,latency.min,latency.max,latency.mean,latency.stdev,upper_50,upper_90,upper_95,upper_99,duration,requests,bytes,errors.connect,errors.read,errors.write,errors.status,errors.timeout,qps,Transfer/sec(KB)"

## threadPoolSize
threadPool=100
## 压测持续时间，单位s、m
duration=1s
## 每轮压测结束后休息时间
sleepTime=5s
## 压测路径URL
url="http://xxxxx.xxx.com" 

## 间隔递增并发数
concurrentInterval=12
## 停止压测并发数,超过此值停止压测
stopConcurrent=1000
# 并发计数器
i=0

echo $head;
while (($i <= $stopConcurrent))
do
    let i+=concurrentInterval
    ret=`wrk -t12 -c$i -d$duration --latency -s api.lua $url | sed -n '$p'`
    ret="$threadPool,$i,"$ret;
    echo $ret;
    sleep $sleepTime
done
