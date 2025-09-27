FROM ubuntu:22.04

RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y wine64 wine32 winetricks wget unzip xvfb x11vnc

WORKDIR /opt/plarium

RUN winetricks corefonts

RUN wget https://plarium.com/download/PlariumPlaySetup.exe -O PlariumPlaySetup.exe

RUN xvfb-run wine PlariumPlaySetup.exe /S || true

CMD ["xvfb-run", "wine", "C:\\Program Files\\PlariumPlay\\PlariumPlay.exe"]
