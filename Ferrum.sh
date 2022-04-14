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
LANGUAGE="$(jq -r '.text' ~/FERRUM/Config/Language.json)"
#------Handlers------------------------------------------------------
DL_INDEX="$(jq -r '.index' ~/FERRUM/Config/DownloadType.json)"
DL_TYPE="$(jq -r '.code' ~/FERRUM/Config/DownloadType.json)"
OPTION_TYPE="$(jq -r '.code' ~/FERRUM/Config/OptionHandler.json)"
OPTION_INDEX="$(jq -r '.index' ~/FERRUM/Config/OptionHandler.json)"

#------SPECIAL----------------------------------------------------------------------------------------------------------

OUTPUT_PREFIX="/data/data/com.termux/files/home/storage/shared/"

CLANGPATH="/data/data/com.termux/files/home/FERRUM/Config/Lang/$LANGUAGE.json"
#------LANGUAGUE-------------------------------------------------------
TRX_T="$(jq -r '.TRX_T' $CLANGPATH)"
TRX_DL_OPTION_1="$(jq -r '.TRX_DL_OPTION_1' $CLANGPATH)"
TRX_DL_T="$(jq -r '.TRX_DL_T' $CLANGPATH)"
TRX_DL_C="$(jq -r '.TRX_DL_C' $CLANGPATH)"
TRX_DL_C2="$(jq -r '.TRX_DL_C2' $CLANGPATH)"
TRX_DL_PL_C="$(jq -r '.TRX_DL_PL_C' $CLANGPATH)"
TRX_DL_PL_C_Y="$(jq -r '.TRX_DL_PL_C_Y' $CLANGPATH)"
TRX_DL_PL_C_N="$(jq -r '.TRX_DL_PL_C_N' $CLANGPATH )"
TRX_DL_OPTION_2="$(jq -r '.TRX_DL_OPTION_2' $CLANGPATH )"
TRX_NOTIF_5_T="$(jq -r '.TRX_NOTIF_5_T' $CLANGPATH )"
TRX_NOTIF_5_C="$(jq -r '.TRX_NOTIF_5_C' $CLANGPATH )"
TRX_NOTIF_6_T="$(jq -r '.TRX_NOTIF_6_T' $CLANGPATH )"
TRX_NOTIF_6_C="$(jq -r '.TRX_NOTIF_6_C' $CLANGPATH )"
TRX_NOTIF_6_5_B1="$(jq -r '.TRX_NOTIF_6_5_B1' $CLANGPATH)"
TRX_NOTIF_6_5_B2="$(jq -r '.TRX_NOTIF_6_5_B2' $CLANGPATH)"
TRX_DL_OPTION_3="$(jq -r '.TRX_DL_OPTION_3' $CLANGPATH)"
TRX_NOTIF_0="$(jq -r '.TRX_NOTIF_0' $CLANGPATH)"
TRX_NOTIF_1="$(jq -r '.TRX_NOTIF_1' $CLANGPATH)"
TRX_NOTIF_100="$(jq -r '.TRX_NOTIF_100' $CLANGPATH)"
TRX_NOTIF_21="$(jq -r '.TRX_NOTIF_21' $CLANGPATH)"
TRX_NOTIF_22="$(jq -r '.TRX_NOTIF_22' $CLANGPATH)"
TRX_NOTIF_23="$(jq -r '.TRX_NOTIF_23' $CLANGPATH)"
TRX_NOTIF_24="$(jq -r '.TRX_NOTIF_24' $CLANGPATH)"
TRX_NOTIF_25="$(jq -r '.TRX_NOTIF_25' $CLANGPATH)"
TRX_NOTIF_30="$(jq -r '.TRX_NOTIF_30' $CLANGPATH)"
TRX_OPT_OPT_1="$(jq -r '.TRX_OPT_OPT_1' $CLANGPATH)"
TRX_OPT_OPT_2="$(jq -r '.TRX_OPT_OPT_2' $CLANGPATH)"
TRX_OPT_OPT_3="$(jq -r '.TRX_OPT_OPT_3' $CLANGPATH)"
TRX_OPT_OPT_4="$(jq -r '.TRX_OPT_OPT_4' $CLANGPATH)"
TRX_OPT_OPT_5="$(jq -r '.TRX_OPT_OPT_5' $CLANGPATH)"
TRX_OPT_OPT_1_C="$(jq -r '.TRX_OPT_OPT_1_C' $CLANGPATH)"
TRX_OPT_OPT_2_C="$(jq -r '.TRX_OPT_OPT_2_C' $CLANGPATH)"
TRX_OPT_OPT_3_C="$(jq -r '.TRX_OPT_OPT_3_C' $CLANGPATH)"
TRX_OPT_OPT_4_C="$(jq -r '.TRX_OPT_OPT_4_C' $CLANGPATH)"
TRX_OPT_OPT_5_C="$(jq -r '.TRX_OPT_OPT_5_C' $CLANGPATH)"
#####################################################################


# Check for output directory and create if it doesnt exists:
 if [[ ! -d $OUTPUT_PREFIX$OUTPUT_FOLDER ]] ; then
	termux-notification --id 9 -t "$TRX_T" -c "$TRX_NOTIF_30"
	mkdir -p $OUTPUT_PREFIX"$OUTPUT_FOLDER"
	fi

termux-dialog radio -t "$TRX_T" -v "$TRX_DL_OPTION_1,$TRX_DL_OPTION_2,$TRX_DL_OPTION_3" > ~/FERRUM/Config/DownloadType.json

# Sets DL_TYPE and DL_INDEX to current information provided by Termux API
DL_INDEX="$(jq -r '.index' ~/FERRUM/Config/DownloadType.json)"
DL_TYPE="$(jq -r '.code' ~/FERRUM/Config/DownloadType.json)"

	if [[ $DL_TYPE -ne "-1" ]]
	then
		termux-notification --id 1 -t "$TRX_T" -c "$TRX_NOTIF_1"
		sleep 5s
		termux-notification-remove 1
	else
		case $DL_INDEX in
#
#-----------------CASE 1, DONWLOAD AS SPOTDL ----------------------
#
			[0]) termux-dialog -t "$TRX_DL_T" -i "$TRX_DL_C" > ~/FERRUM/Config/SpotLink.json
			     SPOT_LINK="$(jq -r '.text' ~/FERRUM/Config/SpotLink.json)" 
			     if [[ $SPOT_LINK == *"open.spotify.com/playlist/"* ]]
				then
				    termux-dialog confirm -t "TRX_DL_T" -i "$TRX_DL_PL_C" > ~/FERRUM/Config/DownloadM3U.json
				    DL_M3U="$(jq -r '.text' ~/FERRUM/Config/DownloadM3U.json)"
				 	if [[ $DL_M3U == "yes" ]]
					   then
					       spotdl "$SPOT_LINK" --m3u --path-template "$PATH_TEMPLATE" --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o $OUTPUT_PREFIX"$OUTPUT_FOLDER"
					       mv ~/storage/shared/Music/FERRUM/*.m3u ~/storage/shared/Music/FERRUM/M3U_FILES/
					       termux-notification --id 0 -t "$TRX_DL_T" -c "$TRX_DL_PL_C_Y"
					       sleep 5s
					       termux-notification-remove 0
					       exit
				else
					       spotdl "$SPOT_LINK" --path-template "$PATH_TEMPLATE" --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o $OUTPUT_PREFIX"$OUTPUT_FOLDER"
				 	       termux-notification --id 0 -t "$TRX_DL_T" -c "$TRX_DL_PL_N"
					       sleep 5s
					       termux-notification-remove 0
						exit
					fi
				else
			 spotdl "$SPOT_LINK" --path-template "$PATH_TEMPLATE" --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o $OUTPUT_PREFIX"$OUTPUT_FOLDER"
				termux-notification --id 0  -t "$TRX_T" -c "$TRX_NOTIF_0"
				sleep 5s
				termux-notification-remove 0
			     fi
			;;

#--------------------CASE 2, YOUTUBE WITH SPOTIFY METADATA-------------------------------------------------------
#
			[1]) termux-notification --id 6 -t "$TRX_NOTIF_6_T" -c "$TRX_NOTIF_6_C" --button1 "$TRX_NOTIF_6_5_B1" --button1-action "termux-dialog -t '$TRX_DL_T' -i '$TRX_DL_C2' > ~/FERRUM/Config/YtLink.json" --button2 "$TRX_NOTIF_6_5_B2" --button2-action "termux-toast -b 'Purple' -c 'White' -g 'top' '$TRX_NOTIF_1' ; exit"
			     YT_LINK="$(jq -r '.text' ~/FERRUM/Config/YtLink.json)"
			#--------------------------------------------------------------------------------------
			     termux-notification --id 5 -t "$TRX_NOTIF_5_T" -c "$TRX_NOTIF_5_C" --button1 "$TRX_NOTIF_6_5_B1" --button1-action "termux-dialog -t '$TRX_DL_T' -i '$TRX_DL_C' > ~/FERRUM/Config/SpotLink.json" --button2 "$TRX_NOTIF_6_5_B2" --button2-action "termux-toast -b 'Purple' -c 'White' -g 'top' '$TRX_NOTIF_1' ; termux-notification-remove 5 ; exit "
			     SPOT_LINK="$(jq -r '.text' ~/FERRUM/Config/SpotLink.json)"
			 #-------------------------------------------------------------------------------------
		 	   until [[ $YT_LINK == *"youtu.be/"* && $SPOT_LINK == *"open.spotify.com"* || $YT_LINK == *"youtube.com/watch?v"* && $SPOT_LINK == *"open.spotify.com"* ]]
			    do
				sleep 1s
			      if [[ $YT_LINK == *"youtu.be/"* && $SPOT_LINK == *"open.spotify.com"* || $YT_LINK == *"youtube.com/watch?v"* && $SPOT_LINK == *"open.spotify.com"* ]]
				 then
				 	break
				fi
			    done
			       spotdl "$YT_LINK\|$SPOT_LINK" --path-template "$PATH_TEMPLATE" --lyrics-provider $LYRICS_PROVIDER --output-format $OUTPUT_FORMAT -o $OUTPUT_PREFIX"$OUTPUT_FOLDER"
			       termux-notification --id 0 -t "$TRX_T" -c "$TRX_NOTIF_1"
			       sleep 5s
			       termux-notification-remove 6
			       termux-notification-remove 5
			       termux-notification-remove 0
			       echo " " > ~/FERRUM/Config/YtLink.json
			       echo " " > ~/FERRUM/Config/SpotLink.json
			;;
			[2]) termux-dialog radio -t "$TRX_DL_OPTION_3" -v "$TRX_OPT_OPT_1,$TRX_OPT_OPT_2,$TRX_OPT_OPT_3,$TRX_OPT_OPT_4,$TRX_OPT_OPT_5" > ~/FERRUM/Config/OptionHandler.json
			      OPTION_INDEX="$(jq -r '.index' ~/FERRUM/Config/OptionHandler.json)"
			      if [[ $OPTION_TYPE -ne "-1" ]]
				then
				 termux-notification --id 1 -t "$TRX_DL_T" -c "$TRX_NOTIF_1."
				 sleep 5s
				 termux-notification-remove 1
				elif [[ "$(jq -r '.text' ~/FERRUM/Config/OptionHandler.json)" == "" ]]
				 then
				 termux-notification --id 100 -t "$TRX_DL_T" -c "$TRX_NOTIF_100"
				 sleep 10s
				 termux-notification-remove 100
				else
				    case $OPTION_INDEX in
## ------------------------------ File format ----------------------------------------------------
					 [0])   cp ~/FERRUM/Config/OutputFormat.json ~/FERRUM/Config/OutputFormat.json.old
						termux-dialog spinner -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_1" -v "mp3,m4a,flac,opus,ogg,wav" > ~/FERRUM/Config/OutputFormat.json
						if [[ "$(jq -r '.code' ~/FERRUM/Config/OutputFormat.json)" -ne "-1" ]]
							then
								termux-notification --id 1 -t "$TRX_T" -c "$TRX_NOTIF_1" 
								rm ~/FERRUM/Config/OutputFormat.json
					 			mv ~/FERRUM/Config/OutputFormat.json.old ~/FERRUM/Config/OutputFormat.json
								sleep 5s
								termux-notification-remove 1
							 else
								OUTPUT_FORMAT="$(jq -r '.text' ~/FERRUM/Config/OutputFormat.json)"
								termux-notification --id 8 -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_1" -c "$TRX_OPT_OPT_1_C$OUTPUT_FORMAT"
								sleep 5s
								termux-notification-remove 8
						fi
					 ;;
## ------------------------------ Lyrics Provider -------------------------------------------------
					 [1])   cp ~/FERRUM/Config/LyricsProvider.json ~/FERRUM/Config/LyricsProvider.json.old
						termux-dialog spinner -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_2" -v "genius,musixmatch" > ~/FERRUM/Config/LyricsProvider.json
						if [[ "$(jq -r '.code' ~/FERRUM/Config/LyricsProvider.json)" -ne "-1" ]]
							then
								termux-notification --id 1 -t "$TRX_DL_OPTION_2 - $TRX_OPT_OPT_2" -c "$TRX_NOTIF_1" 
								rm ~/FERRUM/Config/LyricsProvider.json
					 			mv ~/FERRUM/Config/LyricsProvider.json.old ~/FERRUM/Config/LyricsProvider.json
								sleep 5s
								termux-notification-remove 1
							 else
								LYRICS_PROVIDER="$(jq -r '.text' ~/FERRUM/Config/LyricsProvider.json)"
								termux-notification --id 8 -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_2" -c "TRX_OPT_OPT_2_C$LYRICS_PROVIDER"
								sleep 5s
								termux-notification-remove 8
						fi
					 ;;
## ------------------------------ Path template ---------------------------------------------------
					 [2])   cp ~/FERRUM/Config/PathTemplate.json ~/FERRUM/Config/PathTemplate.json.old
						termux-dialog -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_3" -i "{artist}/{album}/{title} - {artist}.{ext}" > ~/FERRUM/Config/PathTemplate.json
						if [[ "$(jq -r '.code' ~/FERRUM/Config/PathTemplate.json)" -ne "-1" ]]
							then
								termux-notification --id 1 -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_3" -c "$TRX_NOTIF_1" 
								rm ~/FERRUM/Config/PathTemplate.json
					 			mv ~/FERRUM/Config/PathTemplate.json.old ~/FERRUM/Config/PathTemplate.json
								sleep 5s
								termux-notification-remove 1
							 else
								PATH_TEMPLATE="$(jq -r '.text' ~/FERRUM/Config/PathTemplate.json)"
								termux-notification --id 8 -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_3" -c "$TRX_OPT_OPT_3_C$PATH_TEMPLATE"
								sleep 5s
								termux-notification-remove 8
						fi
					 ;;
## ------------------------------ Output Folder ---------------------------------------------------
					 [3])   cp ~/FERRUM/Config/OutputFolder.json ~/FERRUM/Config/OutputFolder.json.old
						termux-dialog -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_4" -i "/Music/FERRUM/" > ~/FERRUM/Config/OutputFolder.json
						if [[ "$(jq -r '.code' ~/FERRUM/Config/OutputFolder.json)" -ne "-1" ]]
							then
								termux-notification --id 1 -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_4" -c "$TRX_NOTIF_1" 
								rm ~/FERRUM/Config/OutputFolder.json
					 			mv ~/FERRUM/Config/OutputFolder.json.old ~/FERRUM/Config/OutputFolder.json
								sleep 5s
								termux-notification-remove 1
							 else
								OUTPUT_FOLDER="$(jq -r '.text' ~/FERRUM/Config/OutputFolder.json)"
								termux-notification --id 8 -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_4" -c "$TRX_OPT_OPT_4_C$OUTPUT_FOLDER"
								sleep 5s
								termux-notification-remove 8
						fi
					;;
#-------------LANGUAGE------------------------------------------------------------------	
					[4])   cp ~/FERRUM/Config/Language.json ~/FERRUM/Config/Language.json.old
						termux-dialog spinner -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_5" -v "ES-ES,EN-US" > ~/FERRUM/Config/Language.json
						if [[ "$(jq -r '.code' ~/FERRUM/Config/Language.json)" -ne "-1" ]]
							then
								termux-notification --id 1 -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_5" -c "$TRX_NOTIF_1" 
								rm ~/FERRUM/Config/Language.json
					 			mv ~/FERRUM/Config/Language.json.old ~/FERRUM/Config/Language.json
								sleep 5s
								termux-notification-remove 1
							 else
								LANGUAGE="$(jq -r '.text' ~/FERRUM/Config/Language.json)"
								termux-notification --id 8 -t "$TRX_DL_OPTION_3 - $TRX_OPT_OPT_5" -c "$TRX_OPT_OPT_5_C$LANGUAGE"
								sleep 5s
								termux-notification-remove 8
						fi
					 ;;
				    esac
			     fi
			;;
		esac
fi
