#!/bin/bash
#
# Generate docker files to add new organizations in a byfn_network
ORG_NO=$1
DOCKERFILE_NEW=$(echo docker-compose-org${ORG_NO}.yaml)
DOCKERFILE_PREV=$(echo docker-compose-org3.yaml)
DOCKERFILE_COUCH_NEW=$(echo docker-compose-couch-org${ORG_NO}.yaml)
DOCKERFILE_COUCH_PREV=$(echo docker-compose-couch-org3.yaml)
COUCH_NUMBER0=$(expr 2 \* $ORG_NO - 2)
COUCH_NUMBER1=$(expr 2 \* $ORG_NO - 1)
PORT0=$(expr 2 \* $ORG_NO + 5)
PORT1=$(expr 2 \* $ORG_NO + 6)

if [ ! -f $DOCKERFILE_NEW ]; then
echo "===================== Generating docker compose for ORG${ORG_NO} ===================== "
sed "s/org3/org${ORG_NO}/gI" $DOCKERFILE_PREV > $DOCKERFILE_NEW
sed -i "s/Org3/Org${ORG_NO}/gI" $DOCKERFILE_NEW
sed -i "s/110/${PORT0}05/gI" $DOCKERFILE_NEW
sed -i "s/120/${PORT1}05/gI" $DOCKERFILE_NEW
echo "===================== Generated docker compose for ORG${ORG_NO} ===================== "
fi

if [ ! -f $DOCKERFILE_COUCH_NEW ]; then 
echo "===================== Generating docker compose couch for ORG${ORG_NO} ===================== "
sed "s/org3/org${ORG_NO}/gI" $DOCKERFILE_COUCH_PREV > $DOCKERFILE_COUCH_NEW
sed -i "s/Org3/Org${ORG_NO}/gI" $DOCKERFILE_COUCH_NEW
sed -i "s/couchdb4/couchdb${COUCH_NUMBER0}/gI" $DOCKERFILE_COUCH_NEW
sed -i "s/couchdb5/couchdb${COUCH_NUMBER1}/gI" $DOCKERFILE_COUCH_NEW
echo "===================== Generated docker compose couch for ORG${ORG_NO} ===================== "
fi
