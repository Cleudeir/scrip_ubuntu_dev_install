
#!/bin/bash
## update

# yes | sudo apt update -y
# yes | sudo apt upgrade -y
# yes | sudo apt install curl wget -y

## Google chrome

chromeExist= apt list | grep google-chrome-stable | wc -l

if [ "$chromeExist" = "0" ]
then
	echo "Instalando Google chrome"
	sleep 5
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
else
	echo "ja Instalado Google chrome"
	sleep 5
fi

## git
chromeExist= apt list | grep git-all | wc -l

if [ "$chromeExist" = "0" ]
then
echo "Instalando git"
sleep 5
sudo apt install git-all -y
else
	echo "ja Instalado git"
	sleep 5
fi
## zsh
zshSet="plugins=( git
	nvm
	npm
	zsh-syntax-highlighting
	fzf
	zsh-autosuggestions )"

zshCount="$(grep ~/.zshrc  -e "$zshSet" | wc -l)"

if [ "$zshCount" = "0" ]
then
	echo "Instalando omhzsh"
	sleep 5
	sudo apt install zsh -y
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	sudo apt-get install -y fonts-powerline
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	sed -i '/plugins=(git)/d' ~/.zshrc
	sudo echo $zshSet >> ~/.zshrc
	sudo echo "exec zsh" >>  ~/.bashrc
else
	echo "ja Instalado omhzsh"
	echo $zshSet
	sleep 5
fi

## nodejs NVM

. ~/.nvm/nvm.sh
. ~/.profile
. ~/.bashrc
. ~/.bash_profile

nvmSet="export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ])""

vvmCount="$(grep ~/.zshrc  -e "$nvmSet" | wc -l)"

if [ "$vvmCount" = "0" ]
then
	echo "Instalando nvm"
	sleep 5
	yes | sudo apt remove nodejs
	yes | sudo apt purge nodejs
	yes | sudo apt autoremove
	yes | curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	echo $nvmSet >> ~/.profile
	echo $nvmSet >> ~/.zshrc
	echo $nvmSet >> ~/.bash_profile
else
	echo "ja instalado nvm"
	sleep 5
fi

## nodejs NVM 16
nvm use 16
node=$(node -v)
echo [ "$node" = "16.17.1" ]
if [ $node ]
then
	echo "ja instalado node"
	sleep 5
else

	echo "Instalando nodejs"
	sleep 5
	nvm install 16
	nvm use 16
    sudo npm install -g npm@8.19.2
	node -v
	## Expo
	echo "Instalando Expo"
	sleep 5
	sudo npm install --global expo-cli -y
fi


### kde-plasma
echo "Instalando kde-plasma"
sleep 5
sudo apt install kde-full -y

## vs code
echo "Instalando VScode"
sleep 5
sudo apt update -y
sudo snap install --classic code
code --version

## Restart
echo “Quer reiniciar apertr "y"”
read reboot
if [ "$reboot" = "y" ]
then
sudo shutdown now
fi
##
