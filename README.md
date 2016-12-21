**Thanks for downloading Corgi Scripts (v2016.12.04)!**

Corgi Scripts is a library of executable shell scripts, reusable shell functions, and Openbox pipemenus.  
It is authored with a focus on portability, reusability, and POSIX compliance.  
Library functions are both semantic and well-documented.  
Both the library functions and the Openbox menus generated from them are *highly performant, even with large sets of data*.

Executables are located under *bin*  
Library functions (sourced and used by the executables) are located under *lib*  
Static resources, such as icons, are located under *share*  

Screenshots of current Openbox pipemenus can be found under **[SCREENSHOTS/openbox](SCREENSHOTS/openbox)**

A summary of packages used by the library is at the bottom of this doc.  
If you want have a look, before getting started, skip to **[Required Packages](#required-packages)**

Quick install instructions are below this greeting.


**Quick Install**  

You can run the executables directly from the downloaded, expanded package, or,  
from within the corgi-scripts directory, call the installer script  
(installs to /usr/local, by default, overriden by adding `--prefix=`):

```
# ./install.sh
```

Currently, most executables in the Corgi library don't require root permissions to run.
You may simply call them directly, or, in the case of Openbox pipmenu executables, add them to your menu.xml file, like so:

```
<menu id="network" label="Network" execute="corgi-openbox-menus-networkmanager" />
<menu id="samba" label="Samba" execute="corgi-openbox-menus-samba" />
```

Currently, there are two executables which require root permissions:

`corgi-display-brightness-control`
`corgi-openbox-menus-power-management` (permissions required ONLY if you need to get/set cpu performance bias)

As Openbox does not prompt for a password when rendering menus,  
and `corgi-openbox-menus-power-management` is responsible for generating a pipemenu,  
you will want to add it to your user's NOPASSWD list via visudo, like so:

```
# visudo

<USERNAME> ALL=(ALL) NOPASSWD: /usr/local/bin/corgi-openbox-menus-power-management
```

Then, prefix sudo to the execute attribute of the pipemenu's menu element in menu.xml, like so:

```
<menu id="system-power-management" label="Power Mgmt" execute="sudo corgi-openbox-menus-power-management" />
```

Additionally, you can add calls for executables to your ACPI handler script (/etc/acpi/handler.sh), like so:

```
case "$1" in

  'button/mute') /usr/local/bin/corgi-audio-control 'mute' ;;
  'button/volumedown') /usr/local/bin/corgi-audio-control 'down' ;;
  'button/volumeup') /usr/local/bin/corgi-audio-control 'up' ;;
  'video/brightnessdown') /usr/local/bin/corgi-display-brightness-control 'down' 'intel_backlight' ;;
  'video/brightnessup') /usr/local/bin/corgi-display-brightness-control 'up' 'intel_backlight' ;;

  *) logger "ACPI group/action undefined: $1 / $2" ;;

esac
```

<a name="required-packages"></a>
**Required Packages (and the corgis who love them):**

Packages common to most or all:


| Package   | Requirement                                                                                            |
|-----------|--------------------------------------------------------------------------------------------------------|
| zenity    | for user input dialogs, error notifications, and desktop notifications (in the absence of libnotify)   |
| libnotify | for desktop notifications (not strictly required, if you don't want notifications)                     |            


For corgi-audio-management.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| alsa       | for which the lib and executable provide an interface and manage audio stuffs                         |
| pulseaudio | (optional) if you're using pulseaudio with alsa                                                       |
| alsa-plugins-pulseaudio | (optional) if you're using pulseaudio with alsa                                          | 


For corgi-displays-management.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| xrandr     | for which the lib and executable provide an interface and manage screen and display stuffs            |
| lspci      | for obtaining information which describes graphics rendering hardware (such as GPUs)                  |  


For corgi-network-management.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| NetworkManager         | for which the lib and executable provide an interface and manage networking stuffs        |
| nm-connection-editor   | provides the interface for editing connection profiles (sometimes packaged with network-manager-applet, though the applet package, itself, is not used by corgi) |


For corgi-power-managment-battery.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| upower     | for which the lib and executable provide an interface and report the current battery state            |


For corgi-power-managment-cpu.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| cpupower   | for which the lib and executable provide an interface and manage cpu throttling and power management  |
| gksudo     | provides an interface for obtaining the user's sudo password when setting cpu throttling and power managament options |


For corgi-screen-lock.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| i3lock     | for which the lib and executable provide an interface and manage locking the screen                   |
| scrot      | (optional) used for capturing a screenshot, to be used as the backdrop for the lock screen            |
| imagemagick | (optional) used to obfuscate the backdrop, if a screenshot is being used, and to append informational text and icon layers |


For corgi-shares-managment-samba.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| smbclient  | for obtaining information which describes local Samba hosts and shares                                |
| cifs-utils | for mounting Samba shares                                                                             |
| udevil     | to mount shares without root permissions (or you can add mount and umount to your user's NOPASSWD list) |
