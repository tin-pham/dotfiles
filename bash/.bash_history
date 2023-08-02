ls
df -h
ls
cd
ls
sudo dnf -y install alacritty
ls
git config --global user.email "heoconlinhat123@gmail.com"
ssh-keygen -t ed25519 -C "heoconlinhat123@gmail.com"
clip < ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub  | pbcopy
cat ~/.ssh/id_ed25519.pub 
git clone git@github.com:tin-pham/dotfiles.git
ls
cd dotfiles/
ls
sudo dnf -y install stow
ls
stow alacritty/
cd .config/alacritty/
ls
v alacritty.yml 
vim alacritty.yml 
cd
cd dotfiles/
ls
cd fonts/
ls
cd ..
stow fonts/
ls
cd dotfiles/
ls
cd kernel/
ls
cd ..
ls
stow bash
cd ..
ls
sudo dnf install zsh
cd
cd dotfiles/
stow --adopt bash
vim .bashrc
cd dotfiles/
cd bash
ls
ls -la
vim .bashrc
cd ..
ls
cd zsh
ls
ls -la
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
cd ..
ls
cd dotfiles/
stow --adopt zsh/
cd ..
ls
zsh
grep tecmint /etc/passwd
chsh -s $(which zsh)
grep tecmint /etc/passwd
chsh -s $(which zsh)
usermod -s /bin/zsh
cat /etc/passwd | grep `cd; pwd`
zsh
nvim .bashrc
