# prepare_host_basic
#
# * installs only basic packages
#
prepare_host_basic() {

	# command:package1 package2 ...
	# list of commands that are neeeded:packages where this command is
	local check_pack install_pack
	local checklist=(
		"dialog:dialog"
		"fuser:psmisc"
		"getfacl:acl"
		"uuid:uuid uuid-runtime"
		"curl:curl"
		"gpg:gnupg"
		"gawk:gawk"
	)

	for check_pack in "${checklist[@]}"; do
		if ! which ${check_pack%:*} > /dev/null; then local install_pack+=${check_pack#*:}" "; fi
	done

	if [[ -n $install_pack ]]; then
		display_alert "Installing basic packages" "$install_pack"
		# @TODO: wait, why sudo? we should already be sudo'ed when this executes.
		sudo bash -c "apt-get -qq update && apt-get install -qq -y --no-install-recommends $install_pack"
	fi

}
