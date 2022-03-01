#!/bin/bash

#--===DEFAULT VARIABLES===--#
YT_LINK="$(jq -r '.text' ~/FERRUM/Config/YtLink.json)"
SPOT_LINK="$(jq -r '.text' ~/FERRUM/Config/SpotLink.json)"
LYRICS_PROVIDER="$(jq -r '.text' ~/FERRUM/Config/LyricsProvider.json)"
OUTPUT_FOLDER="$(jq -r '.text' ~/FERRUM/Config/OutputFormat.json)"
OUTPUT_FORMAT="$(jq -r '.text' ~/FERRUM/Config/OutputFormat.json)"
PATH_TEMPLATE="$(jq -r '.text' ~/FERRUM/Config/PathTemplate.json)"
DL__M3U="$(jq -r '.text' ~/FERRUM/Config/DownloadM3U.json)"

#-- MAIN FERRUM DOWNLOADER MENU --

#-! This is the block that decides wich kind of download you want to use.

termux-dialog radio -t "FERRUM" -v "Downloads as SpotDL,Download from YouTube with Spotify,Options," > ~/FERRUM/Config/DownloadType.json

#-! Defines what type of Download is used
    if DL_TYPE="$(jq -r '.code' ~/FERRUM/Config/DownloadType.json)" != -1 
        then
            return termux-notification -t "FERRUM OPERATION CANCELED" -c "FERRUM encoutered an error or the operation was cancelled by the user"
    else
        DL_TYPE="$(jq -r '.index' ~/FERRUM/Config/DownloadType.json)"
        case $DL_TYPE in
            ##-- FIRST CASE, NORMAL DOWNLOAD
            ## Normal download, opens a termux dialog box. and checks if its a playlist or not.
            0) 
                termux-dialog -t "FERRUM DOWNLOADER"  -i "Spotify link here"  > ~/FERRUM/Config/SpotLink.json
                if [[$SPOT_LINK == *"open.spotify.com/playlist"* ]]; 
                    then
                        ## Checks with the user if they want to download a M3U file
                        termux-dialog -t "FERRUM DOWNLOADER" -i "FERRUM has detected you are downloading a playlist, would you like to download a M3U file to go along with?"
                        if [[$DL__M3U != "yes"]] 
                            then
                                termux-notification -t "FERRUM DOWNLOADER" -c "FERRUM will not download an M3U file for this playlist"
                                spotdl $SPOT_LINK --path-template '"$PATH_TEMPLATE"'  --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o '"$OUTPUT_FOLDER"'
                    else
                        then
                                termux-notification -t "FERRUM DOWNLOADER" -c "FERRUM will download an M3U file for this playlist"
                                 spotdl $SPOT_LINK --path-template '"$PATH_TEMPLATE"' --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT --m3u -o '"$OUTPUT_FOLDER"'
                        fi
                        ##===============================================================
                else
                    then
                        spotdl $SPOT_LINK --path-template '"$PATH_TEMPLATE"' --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o '"$OUTPUT_FOLDER"'
                fi;;
            
            ##-- SECOND CASE, YOUTUBE | SPOTIFY
            1) 
               termux-notification -t "FERRUM Downloader" -c Please introduce a YouTube Link of the video you want to download --button1 "Link" --button1-action "termux-dialog -t 'FERRUM Donwloader' -i 'Insert your YouTube link' > ~/FERRUM/Config/YtLink.json" --button2 "Cancel" --button2-action "termux-toast -b 'Purple' -c 'White' -g 'top' 'FERRUM Download was cancelled'"
               termux-notification -t "FERRUM Downloader" -c Please introduce a Spotify Link of to tag the video with data --button1 "Link" --button1-action "termux-dialog -t 'FERRUM Donwloader' -i 'Insert your Spotify link' > ~/FERRUM/Config/SpotLink.json" --button2 "Cancel" --button2-action "termux-toast -b 'Purple' -c 'White' -g 'top' 'FERRUM Download was cancelled'"
               spotdl "$YT_LINK|$SPOT_LINK" --path-template '"$PATH_TEMPLATE"' --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o '"$OUTPUT_FOLDER"';;
            ##-- THIRD CASE, CHANGE OPTIONS
            2) 
                termux-dialog radio -t "FERRUM Options" -v "Output format,Lyrics Provider,Path Template,Output Folder" > ~/FERRUM/Config/OptionHandler.json 
                    OPTION="$(jq -r '.index' ~/FERRUM/Config/OptionHandler.json)"
                    if OPTION="$(jq -r '.code' ~/FERRUM/Config/OptionHandler.json)" != -1
                        then 
                            return termux-notification -t "FERRUM OPERATION CANCELED" -c "FERRUM encoutered an error or the operation was cancelled by the user"
                        else
                        while [OPTION="$(jq -r '.code' == "-1")"]; do
                        case $OPTION in
                            0) termux-dialog spinner -t "FERRUM OPTIONS - Output Format" -v "mp3,m4a,flac,opus,ogg,wav" > ~/FERRUM/Config/OutputFormat.json;;
                            1) termux-dialog spinner -t "FERRUM OPTIONS - Lyrics provider" -v "genius,musixmatch" > ~/FERRUM/Config/LyricsProvider.json;;
                            2) termux-dialog -t "FERRUM OPTIONS - Path template" -i "{artist}/{album}/{title} - {artist}.{ext}" > ~/FERRUM/Config/PathTemplate.json;;
                            3) termux-dialog -t "FERRUM OPTIONS - Ouput Folder" -i "storage/shared/FERRUM" > ~/FERRUM/Config/PathTemplate.json;;
                        esac
                        done
                    fi;;
        esac
    
