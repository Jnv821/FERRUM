# <img src="Icons/FERRUM.png" alt="Ferrum Logo Image" width="32px" height="32px"> FERRUM




# POWERED BY
Ferrum is created by using Termux, Termux:API, Termux:Widget, spotDL and F-droid.
 - F-Droid is used to download all termux related apps (Termux, API, Widget).
 - SpotDL does the heavy lifting when it comes to fetching, tagging with metadata and downloading songs from a link.
 
| <img src="https://github.com/spotDL/spotify-downloader/blob/master/docs/static/logo-transparent.png?raw=true" width="100%" height="100%">|<img src="https://github.com/termux/termux-app/blob/master/art/ic_launcher2_round.png?raw=true" width="100%" height="100%">|<img src="https://github.com/termux/termux-app/blob/master/art/ic_launcher2_round.png?raw=true" width="100%" height="100%">|<img src="https://github.com/termux/termux-app/blob/master/art/ic_launcher2_round.png?raw=true" width="100%" height="100%">|<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/F-Droid_Logo_4.svg/1200px-F-Droid_Logo_4.svg.png" width="100%" height="100%">|
|--------|------------|------------|---------------|--------|
| [Spotdl](https://github.com/spotDL/spotify-downloader) | [Termux:APP](https://github.com/termux/termux-app) | [Termux:API](https://github.com/termux/termux-api) | [Termux:Widget](https://github.com/termux/termux-widget)  | [F-droid](https://github.com/f-droid/fdroidclient) |

# Installation

  ## Pre Requisites
   - Install Fdroid
   - Install Termux, Termux:API, Termux:Widget from F-droid
   - Give permissions to termux; Open termux and execute (Write + Enter)
   ```
    termux-setup-storage
   ```
  ## Downloading the Ferrum setup script

  - Download _Ferrum-setup.sh_ with curl , execute and give permissions
  ```sh
  curl https://raw.githubusercontent.com/Jnv821/FERRUM/main/Ferrum-Setup.sh?token=GHSAT0AAAAAABRRH7L3JAOMOMSMPR2ZFOEYYQZN2GQ > Ferrum-Setup.sh ; chmod +x Ferrum-Setup.sh ; source Ferrum-Setup.sh
  ```
  - Ferrum is now installed, you can go to your home screen and add a Termux Widget, select ``tasks/Ferrum.sh`` and you will have the ferrum graphical interface for Spotdl installed.
  
# Default Options of Ferrum
 - Output Format: **mp3**
 - Path template: **'{artist}/{Album}/{title} - {artist}.{ext}'** (This is how your files get named)
 - Lyrics provider: **Genius**
 - Output path Location: **"storage/shared/Music/Ferrum/"**  (This is where your files are stored)

 *Example command of default settings on ferrum:*
```
spotdl *LINK* --output-format --path-template '{artist}/{Album}/{title} - {artist}.{ext}' --lyrics-provider genius -o "storage/shared/Music/Ferrum/"
```
# Changing configuration

You can change the configuration in the Ferrum graphical interface or in the configuration folder, this last option not being recommended since it can break FERRUM

## Advanced configuration
  I do not reccomend changing the **Path Template** and **Output Path** options if you don't have terminal / json experience. 
  
  ### Changing Path template:
  to change path template is important that your path template is between **" "** , if not FERRUM will stop working correctly. You have the following options to define your path template:
  
   - {artist}
   - {artists}
   - {title}
   - {album}
   - {ext}
   - {playlist}
   
  Lets add an example with this song: 
  
  <iframe width="560" height="315" src="https://www.youtube.com/embed/iFBic5SN0nM?start=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

