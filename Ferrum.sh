#!/bin/bash

########################
### Define Variables ###
########################

#--------Links--------------------------------------------------------
YT_LINK="$(jq -r '.text' ~/FERRUM/Config/YtLink.json)"
SPOT_LINK="$(jq -r '.text' ~/FERRUM/Config/SpotLink.json)"

#-------Options-------------------------------------------------------
LYRICS_PROVIDER="$(jq -r '.text' ~/FERRUM/Config/LyricsProvider.json)"
OUTPUT_FOLDER="$(jq -r '.text' ~/FERRUM/Config/OutputFolder.json)"
OUTPUT_FORMAT="$(jq -r '.text' ~/FERRUM/Config/OutputFormat.json)"
PATH_TEMPLATE="$(jq -r '.text' ~/FERRUM/Config/PathTemplate.json)"
DL_M3U="$(jq -r '.text' ~/FERRUM/Config/DownloadM3U.json)"

#------Handlers------------------------------------------------------
DL_INDEX="$(jq -r '.index' ~/FERRUM/Config/DownloadType.json)"
DL_TYPE="$(jq -r '.code' ~/FERRUM/Config/DownloadType.json)"

#####################################################################

termux-dialog radio -t "FERRUM" -v "Download as SpotDL,Download from YouTube with Spotify metadata,Change options" > ~/FERRUM/Config/DownloadType.json

# Sets DL_TYPE and DL_INDEX to current information provided by Termux API
DL_INDEX="$(jq -r '.index' ~/FERRUM/Config/DownloadType.json)"
DL_TYPE="$(jq -r '.code' ~/FERRUM/Config/DownloadType.json)"

	if [[ $DL_TYPE -ne "-1" ]]
	then
		termux-notification --id 1 -t "FERRUM" -c "FERRUM encoutered an error or was cancelled."
		sleep 7s
		termux-notification-remove 1
	else
		case $DL_INDEX in
#
#-----------------CASE 1, DONWLOAD AS SPOTDL ----------------------
#
			[0]) termux-dialog -t "FERRUM Downloader" -i "Spotify link here" > ~/FERRUM/Config/SpotLink.json
			     SPOT_LINK="$(jq -r '.text' ~/FERRUM/Config/SpotLink.json)" > logs.ferrum
			     if [[ $SPOT_LINK == *"open.spotify.com/playlist/"* ]]
				then
				    termux-dialog confirm -t "FERRUM Downloader" -i "FERRUM has detected you want to download a playlist, would you like to download a M3U file to go along with it?" > ~/FERRUM/Config/DownloadM3U.json
				    DL_M3U="$(jq -r '.text' ~/FERRUM/Config/DownloadM3U.json)"
				 	if [[ $DL_M3U == "yes" ]]
					   then 
					       spotdl $SPOT_LINK --m3u --path-template "$PATH_TEMPLATE" --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o "$OUTPUT_FOLDER"
					       mv ~/storage/shared/Music/FERRUM/*.m3u ~/storage/shared/Music/FERRUM/M3U_FILES/
					       termux-notification --id 0 -t "FERRUM Download Complete" -c "Your songs were downloaded to $OUTPUT_FOLDER, alongside and m3u file in the m3u folder."
					       sleep 7s
					       termux-notification-remove 0
					       exit
					else
					       spotdl $SPOT_LINK --path-template "$PATH_TEMPLATE" --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o "$OUTPUT_FOLDER"
				 	       termux-notification --id 0 -t "FERRUM Download Complete" -c "Your songs were downloaded to $OUTPUT_FOLDER without an m3u file"
					       sleep 7s
					       termux-notification-remove 0
						exit
					fi
				else
				spotdl $SPOT_LINK --path-template "$PATH_TEMPLATE" --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o "$OUTPUT_FOLDER"
				termux-notification --id 0  -t "Download Complete" -c "Your music was downloaded to $OUTPUT_FOLDER"
				sleep 7s
				termux-notification-remove 0
				exit
			     fi
			;;
#
#--------------------CASE 2, YOUTUBE WITH SPOTIFY METADATA-------------------------------------------------------
#
			[1]) termux-notification --id 6 -t "FERRUM Link YouTube" -c "Select Link when you have your YouTube Link prepared or cancel to exit" --button1 "Link" --button1-action "termux-dialog -t 'FERRUM Downloader' -i 'Insert your YouTube link here' > ~/FERRUM/Config/YtLink.json" --button2 "Cancel" --button2-action "termux-toast -b 'Purple' -c 'White' -g 'top' 'FERRUM Download was cancelled' ; exit"
			     YT_LINK="$(jq -r '.text' ~/FERRUM/Config/YtLink.json)"
			#--------------------------------------------------------------------------------------
			     termux-notification --id 5 -t "FERRUM Link Spotify" -c "Select Link when you have your Spotify Link prepared or cancel to exit" --button1 "Link" --button1-action "termux-dialog -t 'FERRUM Downloader' -i 'Insert your Spotify link here' > ~/FERRUM/Config/SpotLink.json" --button2 "Cancel" --button2-action "termux-toast -b 'Purple' -c 'White' -g 'top' 'FERRUM Download was cancelled' ; termux-notification-remove 5 ; exit "
			     SPOT_LINK="$(jq -r '.text' ~/FERRUM/Config/SpotLink.json)"
			 #-------------------------------------------------------------------------------------
		 	   until [[ $YT_LINK == *"youtu.be/"* && $SPOT_LINK == *"open.spotify.com"* ]]
			    do
				sleep 1s
				if [[ $YT_LINK ==  *"youtu.be/"* && $SPOT_LINK == *"open.spotify.com"* ]]
				 then
				 	break
				fi
			    done
			       spotdl "$YT_LINK|$SPOT_LINK" --path-template "$PATH_TEMPLATE" --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o "$OUTPUT_FOLDER"
			       termux-notification --id 0 -t "Download Complete" -c "Your Music was downloaded to $OUTPUT_FOLDER"
			       sleep 5s
			       termux-notification-remove 6
			       termux-notification-remove 5
			       termux-notification-remove 0
			       echo " " > ~/FERRUM/Config/YtLink.json
			       echo " " > ~/FERRUM/Config/SpotLink.json
			;;
			[2]) termux-notification -t "WIP" -c "You chose 3"
			;;
		esac
	fi
