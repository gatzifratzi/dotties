coole apple default writes:

macht die scheiss .\_\* files weg:
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

sachen für dock:
defaults write com.apple.dock autohide-time-modifier -int 0; killall Dock
defaults write com.apple.dock autohide-delay -float 0; killall Dock
