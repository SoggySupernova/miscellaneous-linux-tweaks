cd "$(dirname "$0")"
mkdir ~/.local/share/kio/servicemenus
cp convert-images.desktop ~/.local/share/kio/servicemenus/convert-images.desktop
cp quickshell-qml.desktop ~/.local/share/kio/servicemenus/quickshell-qml.desktop
echo "Installed to ~/.local/share/kio/servicemenus"
