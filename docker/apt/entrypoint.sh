#!/bin/bash

if [[ -e "$SYNC_TIMEOUT_MIN" ]]; then
    echo "CAUTION: This container will be aborted if the update process is not completed within $SYNC_TIMEOUT_MIN minutes."
    timeout $(( $SYNC_TIMEOUT_MIN * 60 )) apt-mirror
else
    apt-mirror
fi

exit 0
