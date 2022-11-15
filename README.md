```bash
sudo apt install python build-essential libncurses5-dev gawk git libssl-dev gettext zlib1g-dev swig unzip time rsync python3 python3-setuptools python3-yaml subversion -y

# or already have python and git/svn
sudo apt install build-essential libncurses5-dev gawk libssl-dev gettext zlib1g-dev swig unzip time rsync -y
pip install pyyaml

# then
./build.sh ~ target_mt7981_gl-mt2500 true
```
