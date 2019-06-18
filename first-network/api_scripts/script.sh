#!/bin/bash

CHANNEL_NAME="$1"
DELAY="$2"
LANGUAGE="$3"
TIMEOUT="$4"
VERBOSE="$5"
NO_CHAINCODE="$6"
: ${CHANNEL_NAME:="mychannel"}
: ${DELAY:="3"}
: ${LANGUAGE:="golang"}
: ${TIMEOUT:="10"}
: ${VERBOSE:="false"}
: ${NO_CHAINCODE:="false"}
LANGUAGE=`echo "$LANGUAGE" | tr [:upper:] [:lower:]`
COUNTER=1
MAX_RETRY=10

EB_SRC_PATH="/opt/gopath/src/github.com/chaincode/energyblocks/"
LANGUAGE="node"

if ! dpkg -s jq >/dev/null 2>&1; then
	echo "Installing jq"
	apt-get -y update && apt-get -y install jq
fi

# CC_SRC_PATH="github.com/chaincode/chaincode_example02/go/"
# if [ "$LANGUAGE" = "node" ]; then
# 	CC_SRC_PATH="/opt/gopath/src/github.com/chaincode/chaincode_example02/node/"
# fi

# if [ "$LANGUAGE" = "java" ]; then
# 	CC_SRC_PATH="/opt/gopath/src/github.com/chaincode/chaincode_example02/java/"
# fi


# import utils
. api_scripts/utils.sh

MODE=$1
shift

while getopts ":e:f:s:u:o:p:" opt; do
  case "$opt" in
  e)
    END_TIME=$OPTARG
    ;;
  f)
    FREQUENCY=$OPTARG
    ;;
  u)
    UNIT=$OPTARG
    ;;
  s)
    START_TIME=$OPTARG
    ;;
  o)
    ORG=$OPTARG
    ;;
  p)
    PEER=$OPTARG
    ;;
  esac
done

if [ "$MODE" == "initfreq" ]; then
  chaincodeInvokeFreq $START_TIME $END_TIME $FREQUENCY
elif [ "$MODE" == "initUnit" ]; then
  chaincodeInvokeUnit $START_TIME $END_TIME $UNIT
elif [ "$MODE" == "initBill" ]; then
  chaincodeInvokeBill $START_TIME $END_TIME
elif [ "$MODE" == "readFreq" ]; then
  chaincodeQueryFreq $PEER $ORG $START_TIME 
elif [ "$MODE" == "readUnit" ]; then
  chaincodeQueryUnit $PEER $ORG $START_TIME
elif [ "$MODE" == "readBill" ]; then
  chaincodeQueryFreq $PEER $ORG $START_TIME  
elif [ "$MODE" == "delFreq" ]; then
  chaincodeQueryFreq $PEER $ORG $START_TIME 
elif [ "$MODE" == "delUnit" ]; then
  chaincodeQueryUnit $PEER $ORG $START_TIME
elif [ "$MODE" == "delBill" ]; then
  chaincodeQueryFreq $PEER $ORG $START_TIME
else
  exit 1
fi

exit 0
