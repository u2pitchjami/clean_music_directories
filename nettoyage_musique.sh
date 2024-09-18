#!/bin/bash
############################################################################## 
#                                                                            #
#	SHELL: !/bin/bash       version 1.5                                      #
#									                                         #
#	NOM: u2pitchjami    					                                 #
#									                                         #
#	                    					                                 #
#									                                         #
#	DATE: 06/09/2024	           				                             #
#								                                    	     #
#	BUT: Nettoyage des dossiers sans musiques                                #
#									                                         #
############################################################################## 

source /home/pipo/bin/clean_music_directories/.config.cfg

if [ ! -d $DOSSIERLOGS ]
    then
    echo "Création du dossier Logs";
    mkdir $DOSSIERLOGS
fi
touch $LOG
logit() 
{
    echo "[`date`] - ${*}" >> ${LOG}
}
if [ -d ./TEMP ]
		then
		rm -r ./TEMP
	fi
mkdir ./TEMP

logit "Dossier TEMP créé"

logit "Dossiers sans musique mais avec 1 ou plusieurs fichiers de type *.nfo, *.jpg etc... :"
find ${DOSSIER_MUSIC} -type d -execdir sh -c '
    [ "$(find "$1" -maxdepth 5 -type f \( -iname "*.nfo" -o -iname "*.jpg" -o -iname "*.m3u" -o -iname "*.url" -o -iname "*.png" \) -print | wc -l)" -gt 0 ] &&
   [ "$(find "$1" -maxdepth 5 -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" -o -iname "*.aac" -o -iname "*.wma" -o -iname "*.aiff" -o -iname "*.m4a" \) -print | wc -l)" -eq 0 ]
   ' find-sh {} \; -print | tee -a "${FICHIER_TEMP}" >> ${LOG}

 logit "Dossiers transférés dans le dossier temp"
 
sed 's/^ *//' < "${FICHIER_TEMP}" | xargs -d '\n' mv --backup=numbered -t ./TEMP

logit "Vérification des dossiers transférés :"
NB=$(find ./TEMP -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.flac" -o -iname "*.wav" -o -iname "*.ogg" -o -iname "*.aac" -o -iname "*.wma" -o -iname "*.aiff" -o -iname "*.m4a" \) -print | wc -l)

    if [ $NB=0 ]
        then
        logit "Aucun fichier audio, c'est top mec"
        mv ./TEMP ${CORBEILLE}
        mv ${FICHIER_TEMP} ${CORBEILLE}
    logit "Dossiers placés dans la corbeille pour 7 jours"
    echo "cool, c'est fini"
    logit "cool, c'est fini !!!!"
    else
    logit "pas cool, il reste des fichiers audios"
    echo "pas cool, il reste des fichiers audios"
    fi

logit "suppression des dossiers vides"
find ${DOSSIER_MUSIC} -empty -type d -print -delete | tee -a "${LOG}"
echo
echo "logs disponibles à cette adresse : "${LOG}""