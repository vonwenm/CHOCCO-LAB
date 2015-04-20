function Add-Path() {
    [Cmdletbinding()]
    param([parameter(Mandatory=$True,ValueFromPipeline=$True,Position=0)][String[]]$AddedFolder)
    # Get the current search path from the environment keys in the registry.
    $OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
    # See if a new folder has been supplied.
    if (!$AddedFolder) {
        Return 'No Folder Supplied. $ENV:PATH Unchanged'
    }
    # See if the new folder exists on the file system.
    if (!(TEST-PATH $AddedFolder))
    { Return 'Folder Does not Exist, Cannot be added to $ENV:PATH' }cd
    # See if the new Folder is already in the path.
    if ($ENV:PATH | Select-String -SimpleMatch $AddedFolder)
    { Return 'Folder already within $ENV:PATH' }
    # Set the New Path
    $NewPath=$OldPath+’;’+$AddedFolder
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH –Value $newPath
    # Show our results back to the world
    Return $NewPath
}
 
######################################################
# Install apps using Chocolatey
######################################################
Write-Host "Installing Chocolatey"
iex ((new-object net.webclient).DownloadString('http://bit.ly/psChocInstall'))
Write-Host
 
# Install Utilities 
cinst notepadplusplus
cinst launchy
cinst 7zip
cinst windirstat 
cinst wincdemu
cinst keepass
cinst ChocolateyGUI 
cinst TeraCopy 
cinst Revo.Uninstaller 
cinst PureTextPlus 
cinst tomighty
cinst sumatrapdf
cinst cdburnerxp
cinst windirstat
cinst jing
 
# Install Browsers
cinst Firefox 
cinst google-chrome-x64
cinst safari
 
# Media
cinst vlc
cinst skype
 
# Install DEV tools
cinst fiddler
cinst linqpad
cinst winmerge
cinst sysinternals 
 
 
Write-Host "Installing applications from Chocolatey"
cinst git
cinst ruby -Version 1.9.3.44800
cinst nodejs.install
cinst PhantomJS
cinst webpi
cinst poshgit
cinst notepadplusplus
cinst sublimetext2
cinst SublimeText2.PackageControl
cinst SublimeText2.PowershellAlias
cinst ConEmu
cinst python
cinst DotNet4.0
cinst DotNet4.5
cinst putty
cinst Firefox
cinst GoogleChrome
cinst fiddler4
cinst filezilla
cinst winmerge
cinst kdiff3
cinst mongodb
cinst NugetPackageExplorer
cinst SkyDrive
cinst Evernote
cinst heroku-toolbelt 
 
cinst wepi # Web Platform installer
cinst git
cinst poshgit
cinst gitextensions
cinst instanteyedropper
cinst wget
cinst curl
cinst ilspy
cinst python2
cinst dotPeek
cinst FastCopy
cinst RegShot
cinst RegScanner
cinst nodejs.install
cinst ruby
cinst PhantomJS
cinst hg
cinst Compass
cinst Yeoman
cinst vagrant
cinst typescript.vs
cinst pip
cinst scala.install
cinst rdcman 
cinst grepwin
cinst NimbleText
cinst papercut # Local SMTP server 
cinst erlang
cinst elixir
cinst sbt
cinst scalaide
cinst java.jdk
cinst 7zip.install
cinst jdk8
cinst play
 
 
cinst jenkinsondesktop
cinst jenkins
cinst erlang
cinst elixir
cinst rabbitmq
cinst mariadb
cinst mysql.workbench
cinst heidisql
cinst graphviz
cinst neo4j-community
cinst wixtoolset
cinst wixedit
cinst golang
cinst eclipse
cinst google-chrome-x64
cinst typescript
cinst typescript.vs
cinst coffeescript
cinst gociagent
cinst thoughtworks.go.server
cinst clojure.clr
cinst clojure
cinst lein
cinst sqlite
cinst sqlite.shell
cinst sqlite.analyzer
cinst sqliteadmin
cinst datastax.community
cinst redis-64
cinst couchdb
cinst qgis
cinst powergist
cinst wireshark
cinst r.studio
cinst virtualbox
cinst boot2docker
cinst docker
cinst cmake
cinst make
cinst ant
cinst makemkv
cinst xunit
cinst devbox-common.extension
cinst svn
cinst pickles
cinst chromium
cinst swig
cinst chromedriver2
cinst specflow
cinst groovy
cinst intellijidea
cinst grails
cinst pandoc
cinst ghostscript.app
cinst webmailconverter
cinst pdfconverter
cinst outlookconverter
cinst htmlconverter
cinst csvconverter
cinst postgresql
cinst mailconverter
cinst sqltoolbelt
cinst graphviz
cinst doxygen.install
cinst librecad
cinst velocity
cinst screenpresso
cinst windjview
cinst df24
cinst puretext
cinst stickies
cinst puppet
cinst packer
cinst geppetto
cinst boxstarter
cinst boxstarter.bootstrapper
cinst boxstarter.chocolatey
cinst boxstarter.common
cinst boxstarter.windowsupdate
cinst boxstarter.winconfig
cinst boxstarter.azure
cinst boxstarter.winconfig
cinst nmap
cinst chef-client
cinst chef_development
cinst skylight
cinst chefdk
cinst hxd
cinst dropkick
cinst octopustools
cinst adobeair
 
 
 
 
Write-Host
 
 
 
######################################################
# Set environment variables
######################################################
Write-Host "Setting home variable"
[Environment]::SetEnvironmentVariable("HOME", $HOME, "User")
[Environment]::SetEnvironmentVariable("CHROME_BIN", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", "User")
[Environment]::SetEnvironmentVariable("PHANTOMJS_BIN", "C:\tools\PhanomJS\phantomjs.exe", "User")
Write-Host
 
######################################################
# Download custom .bashrc file
######################################################
Write-Host "Creating .bashrc file for use with Git Bash"
$filePath = $HOME + "\.bashrc"
New-Item $filePath -type file -value ((new-object net.webclient).DownloadString('http://vintem.me/winbashrc'))
Write-Host
 
######################################################
# Install Windows installer through WebPI
######################################################
Write-Host "Installing apps from WebPI"
cinst WindowsInstaller31 -source webpi
cinst WindowsInstaller45 -source webpi
Write-Host
 
######################################################
# Install SQL Express 2012
######################################################
Write-Host
do {
    $createSiteData = Read-Host "Do you want to install SQLExpress? (Y/N)"
} while ($createSiteData -ne "Y" -and $createSiteData -ne "N")
if ($createSiteData -eq "Y") {
    cinst SqlServer2012Express
}
Write-Host
 
######################################################
# Add Git to the path
######################################################
Write-Host "Adding Git\bin to the path"
Add-Path "C:\Program Files (x86)\Git\bin"
Write-Host
 
######################################################
# Configure Git globals
######################################################
Write-Host "Configuring Git globals"
$userName = Read-Host 'Enter your name for git configuration'
$userEmail = Read-Host 'Enter your email for git configuration'
 
& 'C:\Program Files (x86)\Git\bin\git' config --global user.email $userEmail
& 'C:\Program Files (x86)\Git\bin\git' config --global user.name $userName
 
$gitConfig = $home + "\.gitconfig"
Add-Content $gitConfig ((new-object net.webclient).DownloadString('http://vintem.me/mygitconfig'))
 
$gitexcludes = $home + "\.gitexcludes"
Add-Content $gitexcludes ((new-object net.webclient).DownloadString('http://vintem.me/gitexcludes'))
Write-Host
 
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
 
######################################################
# Update RubyGems and install some gems
######################################################
Write-Host "Update RubyGems"
C:\Chocolatey\bin\cinst ruby.devkit.ruby193
gem update --system
gem install bundler compass
gem install bigdecimal 
gem install blankslate 
gem install celluloid 
gem install classifier-reborn 
gem install coffee-script 
gem install coffee-script-source 
gem install colorator 
gem install execjs 
gem install fast-stemmer 
gem install ffi 
gem install hitimes 
gem install io-console 
gem install jekyll 
gem install jekyll-coffeescript 
gem install jekyll-gist 
gem install jekyll-paginate 
gem install jekyll-sass-converter 
gem install jekyll-watch 
gem install json 
gem install kramdown 
gem install liquid 
gem install listen 
gem install mercenary 
gem install minitest 
gem install parslet 
gem install posix-spawn 
gem install pygments.rb 
gem install rake 
gem install rb-fsevent 
gem install rb-inotify 
gem install rdoc 
gem install redcarpet 
gem install safe_yaml 
gem install sass 
gem install timers 
gem install toml 
gem install yajl-ruby 
gem install bower
Write-Host
 
######################################################
# Install npm packages
######################################################
Write-Host "Install NPM packages"
npm install -g yo grunt-cli karma bower jshint coffee-script nodemon generator-webapp generator-angular
Write-Host
 
######################################################
# Generate public/private rsa key pair
######################################################
Write-Host "Generating public/private rsa key pair"
Set-Location $home
$dirssh = "$home\.ssh"
mkdir $dirssh
$filersa = $dirssh + "\id_rsa"
ssh-keygen -t rsa -f $filersa -q -C $userEmail
Write-Host
 
######################################################
# Add MongoDB to the path
######################################################
Write-Host "Adding MongoDB to the path"
Add-Path "C:\MongoDB\bin"
Write-Host
 
######################################################
# Download custom PowerShell profile file
######################################################
Write-Host "Creating custom $profile for Powershell"
if (!(test-path $profile)) {
    New-Item -path $profile -type file -force
}
Add-Content $profile ((new-object net.webclient).DownloadString('http://vintem.me/profileps'))
Write-Host