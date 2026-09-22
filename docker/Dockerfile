FROM ubuntu:latest
#
# Install python, pymysql, misc tools:
#
RUN apt-get update && apt-get upgrade -y
RUN apt-get install build-essential curl git vim micro dos2unix make cmake -y
RUN apt-get install sqlite3 unzip ca-certificates -y
RUN apt install apache2-utils -y
RUN apt install python3 python3-pip -y
#
# Cloudflare tunnel software
# 
# Declare ARG since cloudflare is architecture-specific
#
ARG TARGETARCH
#
RUN apt-get install wget -y
#
RUN if [ "$TARGETARCH" = "amd64" ]; then wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb; fi
RUN if [ "$TARGETARCH" = "arm64" ]; then wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb; fi
#
RUN if [ "$TARGETARCH" = "amd64" ]; then dpkg -i cloudflared-linux-amd64.deb; fi
RUN if [ "$TARGETARCH" = "arm64" ]; then dpkg -i cloudflared-linux-arm64.deb; fi
#
RUN apt --fix-broken install
#
# Python and related:
#
RUN pip3 install lizard click fullGSapi[cli] pyinstaller --break-system-packages
RUN pip3 install cryptography pymysql[rsa] boto3 requests jsons --break-system-packages
RUN pip3 install tenacity --break-system-packages
RUN pip3 install nicegui --break-system-packages
RUN pip3 install fastapi uvicorn --break-system-packages
RUN pip3 install bcrypt --break-system-packages
#
# cleanup to reduce image size:
#
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
#
# turn off history file creation:
#
RUN echo "export HISTFILE=/dev/null" >> /etc/profile
#
# add a user (with no pwd) so we don't run as root:
#
RUN useradd -m -g users user
#
# Build and install gradescope submission program; note that
# we are using EECS-based python script, which we build here
# as part of Docker setup because it runs as a single EXE, and
# we need to build for specific platform (i.e. x86 vs. Apple
# silicon).
#
WORKDIR /gradescope
COPY gradescope/gs.py /gradescope
RUN pyinstaller --onefile /gradescope/gs.py --distpath /gradescope
RUN rm -rf /gradescope/build /gradescope/gs.spec /gradescope/gs.py
#
# expose ports for callbacks:
#
EXPOSE 8000-8010
EXPOSE 8080
