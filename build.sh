set -e
PYTHON_VERSION=3.7.2
BASE=`pwd`
NAME=platform_win64
PREFIX="$BASE/$NAME"

curl -sO https://bootstrap.pypa.io/get-pip.py

ls -lah

choco install python
cp -r C:\\Python37 "$PREFIX"
cd "$PREFIX"
rm -rf Doc Lib/test

"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\vcvarsall.bat"
set
export CL="-FI'C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\stdint.h' $CL"

"$PREFIX/Scripts/pip.exe" install -r "$BASE/requirements.txt"
ls Lib/site-packages

cd "$BASE"
curl -sO http://blog.alivate.com.au/wp-content/uploads/2018/10/poppler-0.68.0_x86.7z
mkdir "$PREFIX/poppler"
cd "$PREFIX/poppler"
7z e "$BASE/poppler-0.68.0_x86.7z"
cd "$PREFIX"
mv poppler/*.dll .
mv poppler/pdftocairo.exe .
mv poppler/pdftotext.exe .
rm -rf poppler

cd "$BASE"
curl -sLO https://dist.torproject.org/torbrowser/8.0.4/tor-win32-0.3.4.9.zip
cd "$PREFIX"
unzip "$BASE/tor-win32-0.3.4.9.zip"
mv Tor tor2
mv tor2 tor
rm -rf Data

cd "$BASE"
7z a "$PREFIX.zip" "$NAME"
