write_tab () {
	name=$1
	filePath=$2
	echo "new_tab $name" >> $filePath
}

layout_option() {
	type=$1
	filePath=$2
	echo "layout $type" >> $filePath
}

launch_session () {
	title=$1
	command=$2
	filePath=$3
	echo "launch --title \"$title\" $command" >> $filePath
}

# Logging
yellow='\033[1;33m'
green='\033[0;32m'
blue='\033[0;34m'
cyan='\033[0;36m'
nc='\033[0m'

# Session Variables
projectPath=$HOME/mournhold/ansible
sessionName=ansible
sessionFile=$sessionName.kitty-session
sessionFilePath="$projectPath/$sessionFile"

# Delete the session file and remake it.
if [ -f $sessionFile ]; then
	rm $sessionFile && touch $sessionFile
else
	touch $sessionFile
fi

# Start customizing here
# Get the project path and start building the session
for dir in $projectPath/playbooks/roles/*; do
	printf "${blue}Found: '${dir##*/}' directory under '${dir%/}'\n${nc}"
	playbookRoleNames+=("${dir##*/}")
	playbookRolePaths+=("${dir%/}")
done

# Get the inventory setup, and groupvars.
printf "${cyan}Created tab: Inventory/GroupVars\n${nc}"
write_tab "Inventory/GroupVars" $sessionFilePath
layout_option "tall" $sessionFilePath
launch_session "inventory" "nvim $projectPath/inventory/hosts.ini" $sessionFilePath
for file in $projectPath/inventory/group_vars/*; do
	printf "\t${green}Created session: $file\n${nc}"
	launch_session "${file##*/}" "nvim $file" $sessionFilePath
done

# Main Playbook
printf "${cyan}Created tab: Linux-Playbook\n${nc}"
write_tab "Linux-Playbook" $sessionFilePath
linuxPlaybook=$projectPath/playbooks/linux.yml
launch_session ${linuxPlaybook##*/} "nvim $linuxPlaybook" $sessionFilePath

# Playbooks
printf "${cyan}Created tab: All-Playbooks\n${nc}"
write_tab "All-Playbooks" $sessionFilePath
layout_option "grid" $sessionFilePath
for playbook in $projectPath/playbooks/*.yml; do
	printf "\t${green}Created session: ${playbook##*/}\n${nc}"
	launch_session ${playbook##*/} "nvim $playbook" $sessionFilePath
done

# Roles
for role in ${playbookRolePaths[@]}; do
	roleName=${role##*/}
	printf "${cyan}Created tab: $roleName\n${nc}"
	write_tab "Role-${role##*/}" $sessionFilePath
	layout_option "tall" $sessionFilePath
	launch_session "All-Values" "nvim $projectPath/inventory/group_vars/all.yml" $sessionFilePath
	for yml in $role/*/*; do
		printf "\t${green}Created session: ${yml##*/}\n${nc}"
		launch_session ${yml##*/} "nvim $yml" $sessionFilePath
	done
done

cp $sessionFilePath ~/.config/kitty/sessions/$sessionFile
