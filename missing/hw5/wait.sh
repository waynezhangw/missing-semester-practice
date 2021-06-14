#!/bin/bash

sleep 3 &

# pidwait
wait $!     # Can also be stored in a variable as pid=$!

# Waits until the process 'sleep 3' is completed. Here the wait on a single process is done by capturing its process id

echo "I am waking up"

sleep 4 &
sleep 5 &

wait                    # Without specifying the id, just 'wait' waits until all jobs started on the background is complete.

ls
echo "I woke up again"
