#!/bin/bash
set -e

keyboard="$1"
rev="$2"
keymap="$3"
qmk_version="$4"

echo "::group::Cloning QMK firmware ($qmk_version)"
git clone --depth 1 --branch "$qmk_version" https://github.com/qmk/qmk_firmware.git
cd qmk_firmware
echo "::endgroup::"

echo "::group::QMK setup"
qmk setup -y --yes
echo "::endgroup::"

echo "::group::Copying keyboard files from workspace"
# 呼び出し元の keyboard ディレクトリをコピー（呼び出し元に keyboards/$keyboard がある前提）
cp -r "$GITHUB_WORKSPACE/keyboards/$keyboard" "keyboards/$keyboard"
echo "::endgroup::"

echo "::group::Compiling firmware"
qmk compile -kb "$keyboard/$rev" -km "$keymap"
echo "::endgroup::"

# 出力ファイル確認と保存
output_file=$(find . -name "*.hex" | head -n 1)

if [[ -f "$output_file" ]]; then
    echo "Firmware compiled: $output_file"
    mkdir -p "$GITHUB_WORKSPACE/output"
    cp "$output_file" "$GITHUB_WORKSPACE/output/"
else
    echo "::error::Failed to find compiled .hex file"
    exit 1
fi
