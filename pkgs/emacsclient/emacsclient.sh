#!/bin/bash

emacsclient -a -r -e '(message-mailto (pop server-eval-args-left))' "$1"
