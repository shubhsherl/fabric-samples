#!/bin/bash
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

# This script is designed to be run in the new orgcli container as the
# final step of the EYFN tutorial. It simply issues a couple of
# chaincode requests through the new org peers to check that new org was
# properly added to the network previously setup in the BYFN tutorial.
#

echo
echo " ____    _____      _      ____    _____ "
echo "/ ___|  |_   _|    / \    |  _ \  |_   _|"
echo "\___ \    | |     / _ \   | |_) |   | |  "
echo " ___) |   | |    / ___ \  |  _ <    | |  "
echo "|____/    |_|   /_/   \_\ |_| \_\   |_|  "
echo
echo "Extend your first network (EYFN) test"
echo
CHANNEL_NAME="$1"
DELAY="$2"
LANGUAGE="$3"
TIMEOUT="$4"
VERBOSE="$5"
ORG_NO="$6"
: ${CHANNEL_NAME:="mychannel"}
: ${TIMEOUT:="10"}
: ${LANGUAGE:="golang"}
: ${VERBOSE:="false"}
: ${ORG_NO:="3"}
LANGUAGE=`echo "$LANGUAGE" | tr [:upper:] [:lower:]`
COUNTER=1
MAX_RETRY=5

EB_SRC_PATH="/opt/gopath/src/github.com/chaincode/energyblocks/"
LANGUAGE="node"

# CC_SRC_PATH="github.com/chaincode/chaincode_example02/go/"
# if [ "$LANGUAGE" = "node" ]; then
# 	CC_SRC_PATH="/opt/gopath/src/github.com/chaincode/chaincode_example02/node/"
# fi

echo "Channel name : "$CHANNEL_NAME

# import functions
. scripts/utils.sh

echo "Sending invoke freq transaction on peer0.org1 peer0.org2 peer0.org3...10sec"
sleep 10
chaincodeInvokeFreq 0 1 0 2 0 3

# Query on chaincode on peer1.org2, check if the result is 50.02
echo "Querying chaincode freq on peer0.org1...5sec"
sleep 5
chaincodeQueryFreq 0 1 50.02

# Query on chaincode on peer1.org2, check if the result is 50.02
echo "Querying chaincode freq on peer0.org2..."
chaincodeQueryFreq 0 2 50.02

# Query on chaincode on peer1.org2, check if the result is 50.02
echo "Querying chaincode freq on peer0.org${ORG_NO}..."
chaincodeQueryFreq 0 ${ORG_NO} 50.02


echo
echo "========= All GOOD, EYFN test execution completed =========== "
echo

echo
echo " _____   _   _   ____   "
echo "| ____| | \ | | |  _ \  "
echo "|  _|   |  \| | | | | | "
echo "| |___  | |\  | | |_| | "
echo "|_____| |_| \_| |____/  "
echo

exit 0
