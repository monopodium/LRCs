#### LRC使用指南
建议的环境：
* gcc 9.4.0
* cmake 3.22.0
* python 3.10(不用python可以不下载)
##### 编译安装
* 如果要使用pybind,强烈建议在wsl的环境下。
* 安装依赖包：
```
bash install_third_party.sh
```
编译运行：
```
cd LRCs
mkdir -p cmake/build
cd cmake/build
cmake ../..
make -j
./test_tools
```
利用python调用c++：
* 安装需要的包
```
pip install matplotlib
pip install numpy
```
绘图：
python draw_simulation.py
