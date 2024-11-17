#!/usr/bin/bash
function sigterm_handler() {
    echo "SIGTERM handler triggered"
    rconc 127.0.0.1:25575 "say Server stopping..."
    sleep 1
    rconc 127.0.0.1:25575 "stop"
    echo "Waiting for minecraft to stop..."
    while kill -0 "$(cat /tmp/minecraft.pid)" &>/dev/null; do
        sleep 0.1
    done
    echo "Minecraft stopped"
}
trap sigterm_handler SIGTERM

cd /srv/minecraft || exit 1

# shellcheck disable=2086
java $JAVA_ARGS -jar /srv/minecraft/minecraft_server.jar nogui &

echo "$!" >/tmp/minecraft.pid

while kill -0 "$(cat /tmp/minecraft.pid)" &>/dev/null; do
    sleep 60
    rconc 127.0.0.1:25575 "save-all flush"
done
