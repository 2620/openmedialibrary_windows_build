set -e
BASE=`pwd`
NAME=platform_win64
PREFIX="$BASE/$NAME"

choco install python

"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\vcvarsall.bat"
set
export CL="\"-FIC:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\stdint.h\" $CL"

"C:\\Python37\\Scripts\\pip.exe" install -r "$BASE/requirements.txt"
sed -i "s/import winrandom/from . import winrandom/g" "C:\\Python37\\Lib\\site-packages\Crypto\Random\\OSRNG\\nt.py"

echo SYSTEM
ls -la C:\\Python37\\Lib\\site-packages

cp -r C:\\Python37 "$PREFIX"
cd "$PREFIX"
rm -rf Doc Lib/test Lib/__pycache__
"$PREFIX\\python.exe" "$BASE/test.py"

cd "$BASE"
# http://blog.alivate.com.au/poppler-windows/#comment-44887
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
TOR_VERSION=8.5.5
TOR_WIN32=tor-win32-0.4.1.5.zip
curl -sLO https://dist.torproject.org/torbrowser/${TOR_VERSION}/${TOR_WIN32}
cd "$PREFIX"
unzip "$BASE/$TOR_WIN32"
mv Tor tor2
mv tor2 tor
rm -rf Data

choco install unrar
cd "$BASE"
curl -sLO https://www.rarlab.com/rar/UnRARDLL.exe
mkdir unrar
cd unrar
unrar.exe x "$BASE\\UnRARDLL.exe"
ls -la
ls -la x64
cp x64\\UnRAR64.dll "$PREFIX\\unrar.dll"
cd "$BASE"
rm -r unrar

cd "$BASE"
7z a "$PREFIX.zip" "$NAME"

