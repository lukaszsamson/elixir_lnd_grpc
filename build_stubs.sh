#!/bin/sh
set -e

PROTOC_ARGS="--elixir_out=plugins=grpc:./lib/"

protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/autopilotrpc/autopilot.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/chainrpc/chainnotifier.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/invoicesrpc/invoices.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/lnclipb/lncli.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/routerrpc/router.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/signrpc/signer.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/verrpc/verrpc.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/walletrpc/walletkit.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/watchtowerrpc/watchtower.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/wtclientrpc/wtclient.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/rpc.proto
protoc $PROTOC_ARGS --proto_path=lnd/lnrpc lnd/lnrpc/walletunlocker.proto

