**Thanks for downloading Corgi Scripts (v2015.06.17)!**

Corgi Scripts is a library of executable shell scripts, reusable shell functions, and Openbox pipemenus.  
It is authored with a focus on portability, reusability, and POSIX compliance.  
Library functions are both semantic and well-documented.  
Both the library functions and the Openbox menus generated from them are *highly performant, even with large sets of data*.

Executables are located under *bin*  
Library functions (used by the executables) are located under *lib*  
Static resources, such as icons, are located under *share*  

Screenshots of current Openbox pipemenus can be found under **[SCREENSHOTS/openbox](SCREENSHOTS/openbox)**

A summary of packages used by the Openbox pipemenus is at the bottom of this doc.  
If you want have a look, before getting started, skip to **[Required Packages](#required-packages)**

Quick install instructions are below this greeting.  
If you want something more detailed, skip to **[Detailed Instructions](#detailed-instructions)**


**Quick Install**  

From within the corgi-scripts directory, RUN:

```
$ ./install.sh
```

ADD the executables, installed under /usr/local/bin, to your user's NOPASSWD list in the sudoer's file:
```
<username> ALL=(ALL) NOPASSWD: /usr/local/bin/corgi-openbox-menus-networkmanager, /usr/local/bin/corgi-openbox-menus-samba
```

ADD Openbox pipemenus to menu.xml  
(Note the use of sudo as the current user- not strictly necessary, but useful when a script needs easy user info):

```
<menu id="network" label="Network" execute="sudo -u <USERNAME> corgi-openbox-menus-networkmanager" />
<menu id="network" label="Samba" execute="sudo -u <USERNAME> corgi-openbox-menus-samba" />
```

<a name="detailed-instructions"></a>  
**Detailed Instructions:**

Corgi Scripts can be installed and used in one of three ways:


IDEALLY (and advised):  

Use the install script to copy the components, by default, to /usr/local:

```
$ ./install.sh
```

You can set the install location using a single arg (with or without `--prefix=`) like so:

```
# ./install.sh ~/.usr
```

OR:

Copy the package components, manually, to their counterpart locations under /usr, /usr/local, ~/.usr,  
or any directory with a subdirectory nesting structure which matches that of the package.  
(/usr, /usr/local, and ~/.usr would be the most standard locations from which to choose.)


OR:

Simply run the executables from the expanded package.


ADDITIONALLY:

For installation outside of the user's home directory, root permissions may be required for the install script.  
Likewise, root permissions would be required to run the executable components, from such a location.  
With sudo installed, you'd add the executables to the NOPASSWD list for your user, in the sudoers file, like so:

```
$ visudo
<USERNAME> ALL=(ALL) NOPASSWD: /usr/local/bin/corgi-openbox-menus-networkmanager, /usr/local/bin/corgi-openbox-menus-samba
```


ADDING A PIPEMENU TO OPENBOX:

Add a pipemenu to your Openbox menu.xml file, like so.  
(Assumes the executable is in your $PATH, and requires root permissions, such as under /usr/local).  
Note the use of running sudo as the current user, which helps the library easily discover who the current user is.  
For example, the Samba pipemenu library uses user info to determine where to mount shares (if udevil is not available),  
as well as to assign ownership of those shares (assigned by uid and gid during mount).

```
<menu id="network" label="Network" execute="sudo -u <USERNAME> corgi-openbox-menus-networkmanager" />
<menu id="network" label="Samba" execute="sudo -u <USERNAME> corgi-openbox-menus-samba" />
```

<a name="required-packages"></a>
**Required Packages (and the corgis who love them):**

Packages common to most or all:


| Package   | Requirement                                                                                            |
|-----------|--------------------------------------------------------------------------------------------------------|
| zenity    | for user input dialogs, error notifications, and desktop notifications (in the absence of libnotify)   |
| libnotify | for desktop notifications (not strictly required, if you don't want notifications)                     |               


For corgi-openbox-menus-displays.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| xrandr     | for which the pipemenu provides a front end and manages screen and display stuffs                     |
| lspci      | for obtaining information which describes graphics rendering hardware (such as GPUs)                          |  


For corgi-openbox-menus-networkmanager.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| NetworkManager         | for which the pipemenu provides a front end and manages networking stuffs                 |
| nm-connection-editor   | provides the interface for editing connection profiles (sometimes packaged with network-manager-applet, though the applet package, itself, is not used by corgi) |                                     |


For corgi-openbox-menus-samba.shlib:

| Package    | Requirement                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------|
| smbclient  | for obtaining information which describes local Samba hosts and shares                                |
| cifs-utils | for mounting Samba shares                                                                             |
| udevil     | to mount without root permissions (or you can add mount and umount to your user's NOPASSWD list)      |