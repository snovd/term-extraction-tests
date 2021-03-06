#!/bin/bash 

TERMSUITE_WORKSPACE=/home/snov/Projects/univ-paris13/tools/TERMSUITE_WORKSPACE
PATH=$PATH:$TERMSUITE_WORKSPACE
#treetagger
PATH=$PATH:/home/snov/Projects/univ-paris13/tools/treetagger/cmd:/home/snov/Projects/nlp/tools/treetagger/bin

EXPLORE_DIR=$1
EXPORT_DIR=$2;
CORPUS_DIR=$3;

if [[ -d "$2" ]]; then
  echo "Make sure that the EXPORT_DIR doesn't exists." >&2;
  exit;
else
  mkdir $EXPORT_DIR;
fi 

for f in `find $EXPLORE_DIR -type f`; do 
  FULL_DIRPATH=$EXPORT_DIR${f%/*};
  TMP_FILENAME=$FULL_DIRPATH"/"${f##*/};
  mkdir -p $FULL_DIRPATH;
  FULL_FILENAME=${TMP_FILENAME%.txt}"_termsuite.tsv";
  #assuming that there is an instalation of termsuite
  echo $f;
  echo $FULL_FILENAME;
  echo 
  echo
  cat $f | java -cp "$TERMSUITE_WORKSPACE/termsuite-core-2.1.jar" eu.project.ttc.tools.cli.TermSuiteTerminoCLI   -t $TERMSUITE_WORKSPACE/tree-tagger/  -l en -r $TERMSUITE_WORKSPACE/termsuite-resources.jar --tsv-properties "pilot,wrLog" --tsv $FULL_FILENAME;
done
