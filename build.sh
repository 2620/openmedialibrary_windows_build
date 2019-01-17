#
#set -e
PYTHON_VERSION=3.7.2
BASE=`pwd`
NAME=platform_win64
PREFIX="$BASE/$NAME"

curl -sO http://blog.alivate.com.au/wp-content/uploads/2018/10/poppler-0.68.0_x86.7z
curl -sLO https://dist.torproject.org/torbrowser/8.0.4/tor-win32-0.3.4.9.zip
curl -sO https://bootstrap.pypa.io/get-pip.py

ls -lah

choco install python

mkdir -p "$PREFIX"
cd "$PREFIX"
cp -r C:\Python37 python37
mkdir poppler
cd poppler
7z e "$BASE/poppler-0.68.0_x86.7z"
cd "$PREFIX"
mv poppler/*.dll .
mv poppler/pdftocairo.exe .
mv poppler/pdftotext.exe .
rm -rf poppler

unzip "$BASE/tor-win32-0.3.4.9.zip"
mv Tor tor2
mv tor2 tor
rm -rf Data

"$PREFIX/python37/Scripts/pip.exe" install -r "$BASE/requirements.txt"
ls python37/Lib/site-packages

cd "$BASE"
7z a "$PREFIX.zip" "$NAME"
