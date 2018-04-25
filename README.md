**NAME**

	./wifi.sh - switch between wifi profiles (for ubuntu systems)

**SYNOPSIS**

	./wifi.sh [OPTION]...

**DESCRIPTION**

	./wifi.sh
	  Lists available wifi profiles (no args)

	./wifi.sh use <profile>
	  Switch to a defined profile


**EXTRA NOTES**

	Put wifi profiles in ${HOME}/.interfaces/
	
	Your /etc/network/interfaces should contain:
	
	source /etc/network/interfaces.d/*
	
	so that it will read the profiles that we will be symlinking there.

Example of a profile:

```
iface wlan0 inet dhcp
  wpa-ssid my_wifi_ssid
  wpa-psk my_wifi_passwd
```

After switching profiles, you'll probably want to `sudo ifdown wlan0` and `sudo ifup wlan0` to reconnect
