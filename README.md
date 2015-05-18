**Thanks for downloading Corgi Scripts (v2015.05.18)!**

Corgi Scripts is a library of executable shell scripts, reusable shell functions, and Openbox pipemenus.
It is made with a focus on portability, reusability, and POSIX compliance.
  
Executables are located under *bin*  
Library functions (used by the executables) are located under *lib*  
Static resources, such as icons, are located under *share*

Screenshots of the Openbox pipemenus can be found under *[SCREENSHOTS/openbox](../SCREENSHOTS/openbox)*

Detailed install instructions are directly below this greeting.  
If you're truly eager or lazy, skip to **[TL;DR](#tldr)**

Corgi Scripts can be installed and used in one of three ways:  

IDEALLY (and advised):

Use the install script to copy the components, by default, to /usr/local:

```
$ ./install.sh
```
  
You can set the install location using a single arg (with or without `--prefix`) like so:

```
# ./install.sh --prefix="~/.usr"
# ./install.sh ~/.usr
```

OR:

Copy the package components, manually, to their counterpart locations under /usr, /usr/local, ~/.usr,  
or any directory with a subdirectory structure which matches that of the package.  
(/usr, /usr/local, ~/.usr would be the most standard locations.)


OR:

Simply run the executables from the expanded package.


ADDITIONALLY:

For installation outside of the user's home directory, root permissions may be required for the install script.
Likewise, root permissions would be required to run the executable components, from such a location.
Some scripts, particularly those which generate Openbox pipemenus, may use command utilities which require root permissions, 
and it's much more simple to grant permissions to the individual corgi script than to each utility used by that script.

With sudo installed, you would likely want to add the executables to the NOPASSWD list for your user, via visudo, like so:

```
<username> ALL=(ALL) NOPASSWD: /usr/local/bin/corgi-openbox-menus-networkmanager
```


ADDING A PIPEMENU TO OPENBOX:

Add a pipemenu to your Openbox menu.xml file, like so:  
(assumes the executable is in your $PATH, and requires root permissions, such as under /usr/local)

```
<menu id="network" label="Network" execute="sudo corgi-openbox-menus-networkmanager" />
```

<a name="tldr"></a>
**TL;DR:**

RUN: 

```
$ ./install.sh 
```

ADD the executables installed under /usr/local/bin to your user's NOPASSWD list in the sudoer's file:

```
<username> ALL=(ALL) NOPASSWD: /usr/local/bin/corgi-openbox-menus-networkmanager
```

ADD an Openbox pipemenu to menu.xml:

```
<menu id="network" label="Network" execute="sudo corgi-openbox-menus-networkmanager" />
```