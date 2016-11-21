REM You're going to need to edit this to suit your specific details.
REM List of Parameters to Change:
REM USER_ON_INGEST_SERVER - Your Windows username on the editing workstation. Find this by using the whoami command in CMD.exe If you use a Microsoft account to login, append "MicrosoftAccount\" to the beginning of your username.
REM INGEST_SERVER_PASSWORD - The password for your ingest server user account.
REM INGEST_SERVER_NAME_OR_IP - Your ingest server's network name or IP address
REM TRANSCODE_SOURCE_FOLDER - Where you want videos to be copied to before being transcoded. YOU MUST PUT THE FFMPEG FILES AND TRANSCODE.BAT IN THAT FOLDER FOR THIS TO WORK AS WRITTEN. Specifically, you'll need ffmpeg.exe and ffprobe.exe which can be found here: https://ffmpeg.zeranoe.com/builds/
REM Have fun!


@Echo off
Echo Beginning Camera Dump
PsExec.exe -u USER_ON_INGEST_SERVER -p INGEST_SERVER_PASSWORD \\INGEST_SERVER_NAME_OR_IP -w TRANSCODE_SOURCE_FOLDER -i 1 TRANSCODE_SOURCE_FOLDER\transcode.bat
exit
