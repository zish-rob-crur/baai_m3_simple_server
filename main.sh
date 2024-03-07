#!/bin/bash
CPU_COUNT=$(python -c "import multiprocessing;print(multiprocessing.cpu_count())")
echo "CPU_COUNT: $CPU_COUNT"
WORKER_NUM=${WORKER_NUM:-$CPU_COUNT}
LOG_LEVEL=${LOG_LEVEL:-info}
ACCESS_LOGFILE=${ACCESS_LOGFILE:--}
ERROR_LOGFILE=${ERROR_LOGFILE:--}
export RUN_IN_GUNICORN=1
gunicorn  m3_server:app\
-k uvicorn.workers.UvicornWorker \
--bind '0.0.0.0:8080' \
-w ${WORKER_NUM} \
--log-level ${LOG_LEVEL} \
--access-logfile ${ACCESS_LOGFILE} \
--error-logfile ${ERROR_LOGFILE} \
--timeout 600 --preload
