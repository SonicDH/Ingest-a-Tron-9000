REM You're going to need to edit this to suit your specific details.
REM List of Parameters to Change:
REM USER_ON_SERVER - Your Windows Username. Find this by using the whoami command in CMD.exe
REM SERVER_NAME_OR_IP - Your editing workstation's network name or IP address
REM CAMERA_DRIVE - The drive and directory of your camera and where it stores the media it makes.
REM TRANSCODE_SOURCE_FOLDER - Where you want videos to be copied to before being transcoded. YOU MUST PUT THE FFMPEG FILES AND THIS SCRIPT IN THAT FOLDER FOR THIS TO WORK AS WRITTEN
REM \\SERVER_NAME_OR_IP\SHARENAME\DIRECTORY - Where you want your media to go. This can be different across steps in the script. For example, I have images copied to a different directory than videos.
REM TRANSCODE_OUTPUT_FOLDER - Where you want videos be saved after being transcoded. It's recommended that this be on the ingestion server rather than over the network. It will be copied to the editing workstation later.
REM Have fun!

msg USER_ON_SERVER /SERVER:SERVER_NAME_OR_IP Copying Videos to Ingest Source Folder
start "" /wait fastcopy /no_ui /speed=full /verify CAMERA_DRIVE\*.mp4 /to=TRANSCODE_SOURCE_FOLDER

msg USER_ON_SERVER /SERVER:SERVER_NAME_OR_IP Copying RAW and JPG to Editing Station
start "" /wait fastcopy /no_ui /speed=full /verify CAMERA_DRIVE\*.srw CAMERA_DRIVE\*.jpg /to=\\SERVER_NAME_OR_IP\SHARENAME\DIRECTORY

msg USER_ON_SERVER /SERVER:SERVER_NAME_OR_IP Transcoding Started
for %%a in ("*.mp4") do ffmpeg -n -threads 1 -i  "%%a" -codec:v libx264 -preset veryfast -level:v 5.1 -vf scale=1920:1080 -crf 5 -g 15 -pix_fmt yuv420p -c:a copy -avoid_negative_ts 1 "TRANSCODE_OUTPUT_FOLDER\Transcoded_%%a"

msg USER_ON_SERVER /SERVER:SERVER_NAME_OR_IP Transcoding Finished, Beginning Copy and Verify

start "" /wait fastcopy /no_ui /speed=full /verify TRANSCODE_OUTPUT_FOLDER*.mp4 /to=\\SERVER_NAME_OR_IP\SHARENAME\DIRECTORY

msg USER_ON_SERVER /SERVER:SERVER_NAME_OR_IP Copy and Compare Finished, Terminating
