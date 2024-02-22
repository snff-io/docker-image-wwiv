mkdir tmp
# Download and extract ncurses source code

curl -L https://invisible-mirror.net/archives/ncurses/ncurses-6.3.tar.gz -o ./tmp/ncurses-6.3.tar.gz
tar -xzvf ./tmp/ncurses-6.3.tar.gz -C ./tmp
cd ./tmp/ncurses-6.3 
./configure --prefix=/usr/local 
make 
make install

# Download and extract zlib source code
curl -L https://zlib.net/zlib-1.2.11.tar.gz ./tmp/zlib-1.2.11.tar.gz
tar -xzvf ./tmp/zlib-1.2.11.tar.gz -C ./tmp 
cd ./tmp/zlib-1.2.11 
./configure --prefix=/usr/local 
make 
make install

# Cleanup
RUN rm -rf ./tmp/*