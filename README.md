# QMK Firmware Compiler Action

This GitHub Action clones QMK firmware, installs the environment, copies your custom keyboard files, and compiles firmware.

## ✅ Inputs

| Name                  | Description                            | Required |
|-----------------------|----------------------------------------|----------|
| `keyboard`            | Directory under `keyboards/` in your repo | ✅ Yes |
| `rev`                 | Revision folder name (`rev1`, etc.)    | ✅ Yes |
| `keymap`              | Keymap name                            | ✅ Yes |
| `qmk_firmware_version` | QMK firmware branch or tag            | ✅ Yes |

## 🚀 Example usage

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: your-org/qmk-builder-action@v1
        with:
          keyboard: "mykeyboard"
          rev: "rev1"
          keymap: "default"
          qmk_firmware_version: "master"
      - name: Upload firmware
        uses: actions/upload-artifact@v3
        with:
          name: firmware
          path: output/*.hex
