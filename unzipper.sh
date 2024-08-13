#!/bin/zsh

#check if same directory
if ! [[ $1 == "" ]]; then 
    cd "$1" #change directory to passed argument
    echo $1
fi

#get basename and save it to $BASENAME
CURRENT=`pwd`
BASENAME=`basename "$CURRENT"`

#check if $BASENAME.bak already exists, if not, make it
if ! [ -d $CURRENT/$BASENAME.bak ]; then
    mkdir $BASENAME.bak
fi

for FILENAME in *;    #iterate through every file
do
    if [[ $FILENAME = *".zip"* ]]; then    #if it's a zip file

	#remove .zip from the filename and replace spaces with underscores. 
	NEW_STRING=${FILENAME/".zip"/""}
	NEW_STRING=${NEW_STRING//" "/"_"}    #uncomment this if you don't want to replace spaces with underscores
	
	#unzip the file
	unzip $FILENAME -d $NEW_STRING

	#wait for it to finish
	wait
	
	#move original zip file into backup folder
	mv $FILENAME $BASENAME.bak/$FILENAME
    fi
done
