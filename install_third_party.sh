CRT_DIR=$(pwd)
#set -e

JERASURE_INSTALL_DIR=$CRT_DIR"/third_party/jerasure"
GF_COMPLETE_INSTALL_DIR=$CRT_DIR"/third_party/gf-complete"
PYBIND_INSTALL_DIR=$CRT_DIR"/third_party/pybind11"

JERASURE_PACKAGES_DIR=$CRT_DIR"/packages/Jerasure"
GF_COMPLETE_PACKAGES_DIR=$CRT_DIR"/packages/gf-complete"
PYBIND_PACKAGES_DIR=$CRT_DIR"/packages/pybind11"

PACKAGES_DIR=$CRT_DIR"/packages" 
mkdir -p $PACKAGES_DIR

mkdir -p $GF_COMPLETE_INSTALL_DIR
mkdir -p $JERASURE_INSTALL_DIR
mkdir -p $PYBIND_INSTALL_DIR

cd $PACKAGES_DIR
git clone git@github.com:ceph/gf-complete.git
cd $GF_COMPLETE_PACKAGES_DIR
#sleep 10s
autoreconf -if;autoreconf -if
#autoreconf --force --install
./configure --prefix=$GF_COMPLETE_INSTALL_DIR
make && make install

cd $PACKAGES_DIR
git clone git@github.com:tsuraan/Jerasure.git
cd $JERASURE_PACKAGES_DIR
autoreconf --force --install
./configure --prefix=$JERASURE_INSTALL_DIR LDFLAGS=-L$GF_COMPLETE_INSTALL_DIR/lib CPPFLAGS=-I$GF_COMPLETE_INSTALL_DIR/include
make && make install

cd $PACKAGES_DIR
git clone git@github.com:pybind/pybind11.git
mv $PYBIND_PACKAGES_DIR/pybind11 $PYBIND_INSTALL_DIR
mv $PYBIND_PACKAGES_DIR/include $PYBIND_INSTALL_DIR
mv $PYBIND_PACKAGES_DIR/tools $PYBIND_INSTALL_DIR
mv $PYBIND_PACKAGES_DIR/CMakeLists.txt $PYBIND_INSTALL_DIR

rm -r $JERASURE_PACKAGES_DIR
rm -r $GF_COMPLETE_PACKAGES_DIR
rm -r $PYBIND_PACKAGES_DIR