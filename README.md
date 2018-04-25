**NAME**
	./wifi.sh - switch between wifi profiles

**SYNOPSIS**
	./wifi.sh [OPTION]...

**DESCRIPTION**
	./wifi.sh
	  Lists available wifi profiles (no args)

	./wifi.sh __use__ <profile>
	  Switch to a defined profile



put wifi profiles in ${HOME}/.interfaces/

example of a profile:

```
iface wlan1 inet dhcp
  wpa-ssid my_wifi_ssid
	wpa-psk my_wifi_passwd
```

after switching profiles, you'll probably want to `sudo ifdown wlan0` and `sudo ifup wlan0` to reconnect
