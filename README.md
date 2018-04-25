**NAME**

	./wifi.sh - switch between wifi profiles

**SYNOPSIS**

	./wifi.sh [OPTION]...

**DESCRIPTION**

	./wifi.sh
	  Lists available wifi profiles (no args)

	./wifi.sh __use__ <profile>
	  Switch to a defined profile


**EXTRA NOTES**

Put wifi profiles in ${HOME}/.interfaces/

Example of a profile:

```
iface wlan1 inet dhcp
  wpa-ssid my_wifi_ssid
  wpa-psk my_wifi_passwd
```

After switching profiles, you'll probably want to `sudo ifdown wlan0` and `sudo ifup wlan0` to reconnect
