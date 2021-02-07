################################################################################
# Windows update and drivers / Remove unnecessary apps
################################################################################


################################################################################
# winget
################################################################################
# Install from GitHub
# https://github.com/microsoft/winget-cli/releases

# USING POWERSHELL:

################################################################################
# Apps
################################################################################
winget install VideoLan.VLC
winget install Piriform.CCleaner
winget install Microsoft.WindowsTerminal
winget install Google.ChromeBeta
winget install Mozilla.Firefox
winget install GIMP.GIMP
winget install KeePassXCTeam.KeePassXC
winget install LibreOffice.LibreOffice
winget install SlackTechnologies.Slack
winget install SumatraPDF.SumatraPDF
winget install Adobe.AdobeAcrobatReaderDC
winget install JAMSoftware.TreeSizeFree
winget install Microsoft.VisualStudioCode-User-x64
winget install SpeedCrunch.SpeedCrunch
winget install Notepad++.Notepad++
winget install TimKosse.FileZillaClient
winget install 7zip.7zip
winget install PostgreSQL.pgAdmin-x64
winget install Microsoft.SQLServerManagementStudio
winget install IrfanSkiljan.IrfanView
winget install picpick.picpick

# Swap cap/esc - only needed when not using Barrier from Linux
winget install RandyRants.SharpKeys

# Install SQL Server 2019 Developer from here:
# https://www.microsoft.com/en-us/sql-server/sql-server-downloads

# Install Visual Studio from here:
# https://visualstudio.microsoft.com/downloads/


################################################################################
# Firefox Browser Plugins
################################################################################
# Ember Inspector
# KeePassXC
# LiveReload
# React Developer Tools
# VimiumC
# uBlock Origin


################################################################################
# WSL 2
################################################################################
# https://deanin.com/blog/wsl-2-setup-in-under-5-minutes-to-run-linux-on-windows-10/

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Next install Ubuntu from the Windows Store
# Do restart here
wsl --set-default-version 2
wsl --set-version "Ubuntu-20.04" 2

# Check version with:
wsl -l -v


# SWITCH TO UBUNTU BASH HERE:

#######################################################################
# Languages using asdf-vm
#######################################################################
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"

# MUST LOG OUT/IN HERE

# Needed for most plugins
sudo apt-get --yes install \
  automake autoconf libreadline-dev \
  libncurses-dev libssl-dev libyaml-dev \
  libxslt-dev libffi-dev libtool unixodbc-dev \
  unzip curl

asdf update

# Ruby
sudo apt-get --yes install autoconf bison build-essential \
  libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm-dev

asdf plugin-add ruby
asdf install ruby latest
asdf global ruby $(asdf latest ruby)

# Python
sudo apt-get --yes install --no-install-recommends make build-essential \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev \
  libxmlsec1-dev libffi-dev liblzma-dev

asdf plugin-add python

asdf install python 2.7.17
asdf install python latest
asdf global python $(asdf latest python) 2.7.17

# Node
sudo apt-get --yes install dirmngr
sudo apt-get --yes install gpg
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

asdf install nodejs latest
asdf global nodejs $(asdf latest nodejs)

# Yarn
asdf plugin-add yarn
asdf install yarn latest
asdf global yarn $(asdf latest yarn)

# Erlang
sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk

asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf install erlang latest
asdf global erlang $(asdf latest erlang)

# Elixir
# Make sure Erlang is installed
sudo apt-get install unzip

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install elixir latest
asdf global elixir $(asdf latest elixir)


#######################################################################
# Dotfiles
#######################################################################
git clone https://github.com/bdavi/dotfiles.git ~/code/dotfiles
~/code/dotfiles/scripts/install_dotfiles


################################################################################
# Heroku
################################################################################
# Snap won't work use this to install Heroku instead
curl https://cli-assets.heroku.com/install.sh | sh


#######################################################################
# Vim
#######################################################################
sudo apt-get --yes install vim-gtk3 # use this instead of just vim for clipboard integration

# # Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +'PlugInstall --sync' +qa


################################################################################
# Postgres
################################################################################
sudo apt-get --yes install postgresql postgresql-contrib libpq-dev

sudo service postgresql start
sudo -u postgres psql postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';"
sudo -u postgres psql postgres -c "CREATE USER brian WITH SUPERUSER;"
