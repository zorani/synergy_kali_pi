#!/usr/bin/env bash

declare -a arr_deps=("build-essential" "cmake" "libavahi-compat-libdnssd-dev" "libcurl4-openssl-dev" "libssl-dev" "lintian" "python3" "xorg-dev" "fakeroot" "qttools5-dev-tools" "xorg-dev" "libxtst-dev"  "libxext-dev" "libqt5xmlpatterns5-dev" "qtbase5-dev" 
"qttools5-*" "libavahi-compat-libdnssd-dev")

install_dependencies(){

	for dep in "${arr_deps[@]}"
	do
		command="dpkg-query -W -f='\${Status}\\n' $dep 2>/dev/null | grep -c \"ok installed\" "
		installCheck=$(eval $command)

		if  [ $installCheck -eq 0 ]; then
			echo "$dep Status:NOT INSTALLED."
			echo "     Attempting to install $dep ..."
			echo
			apt-get --allow-change-held-packages --yes install $dep
		else
			echo "$dep Status:INSTALLED"
		fi
	done
}


install_dependencies