#!/bin/bash

######CONFIGURATION###########################################################
DATE=$(date +%y%m%d)
DOSSIER_MUSIC=/path/to/music/base/
DOSSIER_TEMP=/temp/folder/path/${DATE}_temp_clean_music #will be deleted at the end
FICHIER_TEMP=/temp/file/path/${DATE}_temp_clean_music.txt #will be deleted at the end
CORBEILLE=/path/to/trash/folder/
LOG=/path/to/logs/files/${DATE}clean_music_log.txt
######CONFIGURATION###########################################################

logit() 
{
    echo "[`date`] - ${*}" >> ${LOG}
}

mkdir /mnt/user/Medias/${DATE}_temp_clean_music
touch /mnt/user/Medias/${DATE}_temp_clean_music.txt

logit "Dossier et fichier temps créés"

logit "Dossiers sans musique mais avec 1 ou plusieurs fichiers de type *.nfo, *.jpg etc... :"

find "${DOSSIER_MUSIC}" -type d -execdir sh -c '
    [ "$(find "$1" -maxdepth 5 -type f \( -iname "*.nfo" -o -iname "*.jpg" -o -iname "*.m3u" -o -iname "*.url" -o -iname "*.png" \) -print | wc -l)" -gt 0 ] &&
   [ "$(find "$1" -maxdepth 5 -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" -o -iname "*.aac" -o -iname "*.wma" -o -iname "*.aiff" -o -iname "*.m4a" \) -print | wc -l)" -eq 0 ]
   ' find-sh {} \; -print | tee -a "${FICHIER_TEMP}" >> ${LOG}

 logit "Dossiers transférés dans le dossier temp"
 
sed 's/^ *//' < "${FICHIER_TEMP}" | xargs -d '\n' mv --backup=numbered -t "${DOSSIER_TEMP}"

logit "Vérification des dossiers transférés :"
NB=$(find "${DOSSIER_TEMP}" -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" -o -iname "*.aac" -o -iname "*.wma" -o -iname "*.aiff" -o -iname "*.m4a" \) -print | wc -l)

    if [ $NB=0 ]; then
    logit "Aucun fichier audio, c'est top mec"
    mv ${DOSSIER_TEMP} ${CORBEILLE}
    mv ${FICHIER_TEMP} ${CORBEILLE}
    logit "Dossiers placés dans la corbeille pour 7 jours"
    echo "cool, c'est fini"
    logit "cool, c'est fini !!!!"
    else
    logit "pas cool, il reste des fichiers audios"
    echo "pas cool, il reste des fichiers audios"
    fi

logit "suppression des dossiers vides"
find "${DOSSIER_MUSIC}" -empty -type d -print -delete | tee -a "${LOG}"
echo
echo "logs disponibles à cette adresse : "${LOG}""