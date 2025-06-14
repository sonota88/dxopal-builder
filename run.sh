#!/bin/bash

IMG_NAME=dxopal-builder:2

cmd_build_image() {
  docker build --progress plain -t $IMG_NAME .
}

cmd_compile() {
  local rbfile="$1"; shift

  local temp_jsfile="${rbfile}.js"

  local cmd=""
  cmd="${cmd}docker run --rm -i "
  cmd="${cmd}  -v$(pwd):/tmp/work "

  # コンテナ外の DXOpal を使う場合
  # cmd="${cmd}  -v/path/to/dxopal:/opt/dxopal "

  cmd="${cmd}  ${IMG_NAME} "
  cmd="${cmd}    opal --compile --no-exit "
  cmd="${cmd}      --include /opt/dxopal/lib "
  cmd="${cmd}      --include . "
  cmd="${cmd}      --output ${temp_jsfile} "
  cmd="${cmd}      $rbfile "

  $cmd 1>&2 # 組み立てたコマンドを実行

  cat $temp_jsfile
}

cmd="$1"; shift
case $cmd in
  build-image )
    cmd_build_image
;; compile )
    cmd_compile "$@"
;; * )
    echo "unknown command (${cmd})" >&2
    exit 1
    ;;
esac
