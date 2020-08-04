# update following to the actual mail address
git config --global user.email "XXX@gmail.com"

git config --global user.name "mingyue528"

echo "StrictHostKeyChecking no" >> ~/.ssh/config

cd

git clone git@github.com:mingyue528/mingyue528.github.io.git
git config --global i18n.commit.encoding utf-8
git config --global i18n.logoutputencoding utf-8
export LESSCHARSET=utf-8
cd /root/mingyue528.github.io
git checkout -b hexo origin/hexo

npm install -g hexo-cli && \
npm install hexo-deployer-git --save -g && \
npm install mime-db && \
npm install
echo "set fileencodings=utf-8" > /etc/vim/vimrc
echo "set termencoding=utf-8" > /etc/vim/vimrc
echo "set encoding=utf-8" > /etc/vim/vimrc


tail -f /dev/null

