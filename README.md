![clean_music_directories](https://socialify.git.ci/u2pitchjami/clean_music_directories/image?description=1&font=KoHo&language=1&logo=https%3A%2F%2Fgreen-berenice-35.tiiny.site%2Fimage2vector-3.svg&name=1&owner=1&pattern=Charlie%20Brown&stargazers=1&theme=Dark)

[![Twitter](https://img.shields.io/twitter/follow/u2pitchjami.svg?style=social)](https://twitter.com/u2pitchjami)
![GitHub followers](https://img.shields.io/github/followers/u2pitchjami)
![Reddit User Karma](https://img.shields.io/reddit/user-karma/combined/u2pitchjami)


# Clean Music Directories

Applications like Beets, Lidarr, Jellyfin, rename and move music files but do not touch other types of files (images, lyrics, nfo).
This script identifies these folders and deletes them.

![image](https://github.com/u2pitchjami/clean_music_directories/assets/149841209/8518049a-c3fc-409b-a864-ac0b6719a2d4)
## Installation

### 1 - Clone the repository :
```bash
git clone https://github.com/u2pitchjami/clean_music_directories.git
```  
### 2 - Create and edit .config.cfg :
```bash
cd clean_music_directories
sudo mv .config.cfg.example .config.cfg
sudo nano .config.cfg
``` 
![image](https://github.com/u2pitchjami/clean_music_directories/assets/149841209/5b0e5620-aa1c-46b3-8f45-5a133e7f9515)

## Usage/Examples

### 1 - Start the script

```bash
nettoyage_musique.sh
```    
### 2 - Works

- The script will scan your music database, looking for folders without music files (mp3 flac wav ogg).

- The result will be send to Temp folder :
  
  ![image](https://github.com/user-attachments/assets/229220cf-f2d7-4436-956f-bc6121a6dab1)


- And will delete in 7 days.

## Authors

👤 **u2pitchjami**

* Twitter: [@u2pitchjami](https://twitter.com/u2pitchjami)
* Github: [@u2pitchjami](https://github.com/u2pitchjami)
* LinkedIn: [@thierry-beugnet-a7761672](https://linkedin.com/in/thierry-beugnet-a7761672)
