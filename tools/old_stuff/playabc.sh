#/bin/sh

TMP=/tmp
MIDIPLAYER=timidity
#MIDIPLAYER=drvmidi -id

tune=`basename $1 .abc`
#IFS='.';
#tune=(${abc_tune[0]}); # remove the .abc extension

abc2midi $1 -o ${TMP}/$tune.mid
${MIDIPLAYER} ${TMP}/$tune.mid
rm ${TMP}/$tune.mid
