# FERRUM

![Ferrum Logo Image](FERRUM/FERRUM.png)

# POWERED BY
Ferrum is created by using Termux, Termux:API, Termux:Widget, spotDL and F-droid.
 - F-Droid is used to download all termux related apps (Termux, API, Widget).
 - SpotDL does the heavy lifting when it comes to fetching, tagging with metadata and downloading songs from a link.
 
| <img src="https://github.com/spotDL/spotify-downloader/blob/master/docs/static/logo-transparent.png?raw=true" width="600px" height="100px">|<img src="https://github.com/termux/termux-app/blob/master/art/ic_launcher2_round.png?raw=true" width="512px" height="200px">|<img src="https://github.com/termux/termux-app/blob/master/art/ic_launcher2_round.png?raw=true" width="512px" height="200px">|<img src="https://github.com/termux/termux-app/blob/master/art/ic_launcher2_round.png?raw=true" width="512px" height="200px">|<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/F-Droid_Logo_4.svg/1200px-F-Droid_Logo_4.svg.png" width="550px" height="190px">|
|--------|------------|------------|---------------|--------|
| [Spotdl](https://github.com/spotDL/spotify-downloader) | [Termux:APP](https://github.com/termux/termux-app) | [Termux:API](https://github.com/termux/termux-api) | [Termux:Widget](https://github.com/termux/termux-widget)  | [F-droid](https://github.com/f-droid/fdroidclient) |

# Installation

  ## Pre Requisites
   - Install Fdroid
   - Install Termux, Termux:API, Termux:Widget from F-droid
   - Open termux and execute (Write + Enter)
   ```
    termux-setup-storage
   ```
  ## Downloading the Ferrum setup script

  - Download _Ferrum-setup.sh_ with wget
  ```sh
  wget 
  ```
  ## Using the script
  You can use the script by specifying an interpreter or giving permissions to of execute to the ferrum-setup.sh
  
  ### Using interpreter
  ```
  bash Ferrum-setup.sh
  ```
  ### Giving permissions
  - Give permisions to Ferrum-setup.sh and execute it.
  
  ```sh
  chmod +x ./Ferrum-setup.sh
  ./Ferrum-setup.sh
  ```
  - Ferrum is now installed, you can go and add a Termux Widget and select ``tasks/Ferrum.sh``
  
# Defaults
 - Output Format: **mp3**
 - Path template: **'{artist}/{Album}/{title} - {artist}.{ext}'**
 - Lyrics provider: **Genius**
 - Downloaded Songs Folder Location: **"storage/shared/Music/Ferrum/"** 

 *Example command of default settings on ferrum:*
```
spotDL *LINK* --output-format --path-template '{artist}/{Album}/{title} - {artist}.{ext}' --lyrics-provider genius -o "storage/shared/Music/Ferrum/"
```
  
  
  

