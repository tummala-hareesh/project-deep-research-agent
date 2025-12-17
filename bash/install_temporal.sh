# Create a dir for executables
mkdir ~/bin
echo 'PATH="${PATH}:~/bin"' >> ~/.bashrc
source ~/.bashrc

# Download the Temporal CLI
wget 'https://temporal.download/cli/archive/latest?platform=linux&arch=amd64' -O temporal.tar.gz

# Extract
tar -xzf temporal.tar.gz

# Move to ~/bin
mv temporal ~/bin/
rm temporal.tar.gz LICENSE