FROM public.ecr.aws/amazoncorretto/amazoncorretto:21
ARG TARGETARCH
RUN mkdir -p /srv/minecraft && curl -L https://piston-data.mojang.com/v1/objects/45810d238246d90e811d896f87b14695b7fb6839/server.jar -o /srv/minecraft/minecraft_server.jar
ADD eula.txt /srv/minecraft/eula.txt
ADD minecraft_start_script.sh /usr/bin/minecraft_start_script
RUN chmod +x /usr/bin/minecraft_start_script
COPY rconc_${TARGETARCH} /usr/bin/rconc
ENTRYPOINT [ "/usr/bin/minecraft_start_script" ]
