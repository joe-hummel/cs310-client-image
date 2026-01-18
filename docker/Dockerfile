FROM ubuntu:latest
#
# Install python, pymysql, misc tools:
#
RUN apt-get update && apt-get upgrade -y
RUN apt-get install build-essential curl git vim micro dos2unix make cmake -y
RUN apt-get install sqlite3 -y
RUN apt install python3 python3-pip -y
RUN pip3 install lizard click fullGSapi[cli] pyinstaller --break-system-packages
RUN pip3 install cryptography pymysql boto3 requests jsons --break-system-packages
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
