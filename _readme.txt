#############################################################################

Pre-reqs:

  - The downloaded folder/files CANNOT be stored/hosted in a cloud-syncing 
service such as DropBox, OneDrive, or GoogleDrive --- move the folder/files
to your desktop or some folder that is NOT sync'd to the cloud.
 
  - Install Docker desktop (Mac users be careful with Apple silicon vs.
prior Intel hardware --- anyone with an Apple M chip should install the
Apple silicon version). Docker desktop is freely available from the 
following site: 

  https://www.docker.com/products/docker-desktop/

You do not need to create a Docker account, you can simply download and
install. Once installed, open the app and leave it running.

#############################################################################

Linux users (and Windows users running WSL), open a terminal window,
navigate to the folder containing this 'readme.txt' file, and run the 
following command from a terminal window (you only need to do this once):

  ./setup/linux.bash

Then build the Docker image by executing this command (you only need to do
this once):

  ./docker/build

If the build takes more than 10 minutes, type ctrl-C to exit the build 
command and try again.

At this point, you now have a local, executable image of all the software
you need. Whenever you want to run this image/software, you'll just open a 
terminal window, navigate to this folder, and do the following:

  ./docker/run

If all is well the prompt should change to "cs358-base-image". You are now
inside a Linux-based system (Ubuntu to be exact); this is a command-line
environment, a GUI-based desktop is not available. When you are ready to 
stop working and exit the Linux-based environment, type "exit" and you'll 
be back in your local terminal environment.

#############################################################################

Mac users: open a terminal window and navigate to the folder containing
this 'readme.txt' file. A nice trick is to open Finder, "View" menu, 
"Show Path Bar", right-click on the folder name, "Open in Terminal". Then
run these commands (you only need to do this once):

  chmod 755 ./setup/*.bash

  ./setup/mac.bash

Now build the Docker image by executing this command (you only need to do 
this once):

  ./docker/build

If the build takes more than 10 minutes, type ctrl-C (not command-C) to 
exit the build command and try again.

At this point, you now have a local, executable image of all the software
you need. Whenever you want to run this image/software, you'll just open a 
terminal window, navigate to this folder, and do the following:

  ./docker/run

If all is well the prompt should change to "cs358-base-image". You are now
inside a Linux-based system (Ubuntu to be exact); this is a command-line
environment, a GUI-based desktop is not available. When you are ready to 
stop working and exit the Linux-based environment, type "exit" and you'll 
be back in your local terminal environment.

#############################################################################

Windows users: open a Powershell window and navigate to the folder 
containing this 'readme.txt' file. A nice trick is to view the folder
and right-click on the background and select "Open in Terminal" (if 
Powershell doesn't open, you can change the default profile to Powershell,
save, and try again). Then run this command (you only need to do this once):

  .\setup\windows.ps1

If you get an error message along the lines of "script is not digitally 
signed. You cannot run this script on the current system", then run 
as follows:

  powershell.exe -executionpolicy bypass .\setup\windows.ps1

Now build the Docker image by executing this command (you only need to do 
this once):

  ./docker/build

If the build takes more than 10 minutes, type ctrl-C to exit the build 
command and try again. If you get an error message along the lines of 
"script blocked by system's execution policy", then try the following:

  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

  ./docker/build

At this point, you now have a local, executable image of all the software
you need. Whenever you want to run this image/software, you'll just open a 
PowerShell window, navigate to this folder, and do the following:

  ./docker/run

If all is well the prompt should change to "cs358-base-image". You are now
inside a Linux-based system (Ubuntu to be exact); this is a command-line
environment, a GUI-based desktop is not available. When you are ready to 
stop working and exit the Linux-based environment, type "exit" and you'll 
be back in your local PowerShell environment.

#############################################################################

Troubleshooting:

  - If you get "docker not found", then make sure Docker Desktop is
installed and running. If Docker is running and the above commands still 
do not work, then uninstall Docker Desktop, reboot, and reinstall.

  - If you see "you are not authorized", then you may need to login from 
your terminal window:  docker login -u docker-username

  - When you try to run the docker image, it fails with an error message like
    "Error... The container name 'cs358-base-image' is already in use by ...".
    This means the docker image is already running. So either switch to that window,
    or if the window is closed you'll have to stop the image manually by executing
    these commands in your Terminal/PowerShell window:
  
        1. docker ps -a
        2. docker stop <CONTAINER_ID>

  - You can run the Docker image, but are you unable to create / write files?
Make sure the files are NOT on a cloud-backed folder such as onedrive, google 
drive, or dropbox. Also, if you're on a Mac, you may need to give the Terminal 
app access to the local file system as follows:

      1. Click on the Apple icon in the top left of your menu bar,
         and choose "System Settings...".
      2. Click "Privacy & Security"
      3. Click the "Privacy" tab at the top.
      4. Scroll down to find "Full Disk Access"
      5. Add the Terminal app if need be (with + at the bottom)
      6. Slide the UI control to the right to grant Terminal access

  - A rare Windows error along the lines of "request returned 500 internal server error for API route and version http://%F%F..."
      - https://forums.docker.com/t/error-request-returned-internal-server-error-for-api-route-and-version/140375
      - could be as simple as rebooting machine (to restart Docker engine) and trying again
      - Another solution: got it working after disabling the Virtual Machine Platform windows feature, restarting computer, re-enabling the feature, restarting, and then installing WSL2

  - Other errors? Exit the Terminal/Powershell app and try again. Also, make
sure the folder is NOT hosted in a cloud-syncing service such as DropBox,
OneDrive, or GoogleDrive --- those can trigger errors especially when using
a programming-based IDE along with Docker.

#############################################################################
#############################################################################
