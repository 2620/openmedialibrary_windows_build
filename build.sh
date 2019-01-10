#
#set -e
PYTHON_VERSION=3.7.2
BASE=`pwd`
NAME=platform_win64
PREFIX="$BASE/$NAME"

curl -sO https://www.python.org/ftp/python/${PYTHON_VERSION}/python-${PYTHON_VERSION}.post1-embed-amd64.zip
curl -sO http://blog.alivate.com.au/wp-content/uploads/2018/10/poppler-0.68.0_x86.7z
curl -sLO https://dist.torproject.org/torbrowser/8.0.4/tor-win32-0.3.4.9.zip
curl -sO https://bootstrap.pypa.io/get-pip.py

ls -lah

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

unzip "$BASE/tor-win32-0.3.4.9.zip"
mv Tor tor2
mv tor2 tor
rm -rf Data

"$PREFIX/python.exe" "$BASE/get-pip.py"

cat > pip-cmd.py << EOF
import sys
sys.path.append('Lib\\site-packages')
from pip._internal import main
main()
EOF
"$PREFIX/python.exe"  pip-cmd.py install -r requirements.txt
ls Lib/site-packages

cd "$BASE"
7z a "$PREFIX.zip" "$NAME"
