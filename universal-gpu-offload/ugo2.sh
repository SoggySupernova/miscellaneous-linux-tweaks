#!/bin/sh
# ugo2 <0-4> command [args...]
#   0 - no-op: runs command with no vars set (baseline/control)
#   1 - GLX + EGL-X11 + Vulkan offload (routing only, no device hiding)
#   2 - adds native-Wayland coverage (GBM) - risk: can crash on some compositors
#   3 - adds implicit-layer device hiding - risk: apps CAN opt out (e.g. Blender)
#   4 - adds loader-level ICD restriction - apps can't opt out; also removes
#       software/lavapipe fallback for anything else in the process

CARD="${DGPU_CARD:-nvidia}"
LEVEL="$1"; shift

case "$LEVEL" in
  0|1|2|3|4) ;;
  *) echo "usage: ugo2 <0-4> command [args...]" >&2; exit 1 ;;
esac

[ "$LEVEL" = "0" ] && exec "$@"

if [ "$CARD" = "nvidia" ]; then
  export __NV_PRIME_RENDER_OFFLOAD=1
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  EGL_JSON=$(ls /usr/share/glvnd/egl_vendor.d/*nvidia* 2>/dev/null | head -1)
  [ -n "$EGL_JSON" ] && export __EGL_VENDOR_LIBRARY_FILENAMES="$EGL_JSON"

  [ "$LEVEL" -ge 2 ] && export GBM_BACKEND=nvidia-drm
  [ "$LEVEL" -ge 3 ] && export __VK_LAYER_NV_optimus=NVIDIA_only

  if [ "$LEVEL" -ge 4 ]; then
    ICD=$(ls /usr/share/vulkan/icd.d/*nvidia* 2>/dev/null | head -1)
    [ -n "$ICD" ] && export VK_ICD_FILENAMES="$ICD"
  fi

elif [ "$CARD" = "amd" ]; then
  export DRI_PRIME=1
  [ "$LEVEL" -ge 3 ] && export DRI_PRIME='1!'
  if [ "$LEVEL" -ge 4 ]; then
    ICD=$(ls /usr/share/vulkan/icd.d/radeon_icd* 2>/dev/null | head -1)
    [ -n "$ICD" ] && export VK_ICD_FILENAMES="$ICD"
  fi
fi

exec "$@"
