#
PYTHON_VERSION=3.7.2
BASE=`pwd`
NAME=platform_win64
PREFIX="$BASE/$NAME"

curl -sO https://www.python.org/ftp/python/${PYTHON_VERSION}/python-${PYTHON_VERSION}.post1-embed-amd64.zip
curl -sO http://blog.alivate.com.au/wp-content/uploads/2018/10/poppler-0.68.0_x86.7z
curl -sO https://www.torproject.org/dist/torbrowser/8.0.4/tor-win32-0.3.4.9.zip

mkdir -p "$PREFIX"
cd "$PREFIX"
unzip "$BASE/python-${PYTHON_VERSION}.post1-embed-amd64.zip"
mkdir poppler
cd poppler
7z e "$BASE/poppler-0.68.0_x86.7z"
cd "$PREFIX"
mv poppler/*.dll .
mv poppler/pdftocairo.exe .
mv poppler/pdftotext.exe .
rm -rf poppler

unzip "$PREFIX/tor-win32-0.3.4.9.zip"
mv Tor tor
rm -rf Data

Scripts/pip.exe install -r requirements.txt

cd "$BASE"
7z a "$NAME.tar.gz" "$NAME"
ls -lah "$NAME.tar.gz"
