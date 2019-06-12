#!/bin/bash
#
# Generate docker file to add new organizations in network
ORG=$1
echo $ORG
DOCKERFILE_NEW=$(echo docker-compose-org${ORG}.yaml)
DOCKERFILE_PREV=$(echo docker-compose-org3.yaml)
DOCKERFILE_COUCH_NEW=$(echo docker-compose-couch-org${ORG}.yaml)
DOCKERFILE_COUCH_PREV=$(echo docker-compose-couch-org3.yaml)
COUCH_NUMBER=$(expr $ORG + 1)

if [ ! -f $DOCKERFILE_NEW ]; then
echo "===================== Generating docker compose for ORG${ORG} ===================== "
sed "s/org3/org${ORG}/gI" $DOCKERFILE_PREV > $DOCKERFILE_NEW
sed -i "s/Org3/Org${ORG}/gI" $DOCKERFILE_NEW
echo "===================== Generated docker compose for ORG${ORG} ===================== "

fi

if [ ! -f $DOCKERFILE_COUCH_NEW ]; then 
echo "===================== Generating docker compose couch for ORG${ORG} ===================== "
sed "s/org3/org${ORG}/gI" $DOCKERFILE_COUCH_PREV > $DOCKERFILE_COUCH_NEW
sed -i "s/Org3/Org${ORG}/gI" $DOCKERFILE_COUCH_NEW
sed -i "s/couchdb4/couchdb${COUCH_NUMBER}/gI" $DOCKERFILE_COUCH_NEW
echo "===================== Generated docker compose couch for ORG${ORG} ===================== "
fi

pushd ./scripts

if [ ! -f step1org${ORG} ]; then 
echo "===================== Generating step1 for ORG${ORG} ===================== "
sed "s/org3/org${ORG}/gI" $DOCKERFILE_COUCH_PREV > $DOCKERFILE_COUCH_NEW
sed -i "s/Org3/Org${ORG}/gI" $DOCKERFILE_COUCH_NEW
sed -i "s/couchdb4/couchdb${COUCH_NUMBER}/gI" $DOCKERFILE_COUCH_NEW
echo "===================== Generated docker compose couch for ORG${ORG} ===================== "
fi