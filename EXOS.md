# theme exos

This theme has support to:

* git (branch and changes)
* python2 virtualenv
* Project name on prompt (read from package.json and bower.json)
* Show hostname if is a ssh connection
* Presentation logo with toiled (if is installed) and w command.

The prompt is like:

~~~
⏺ ⁅.oh-my-zsh ⭠develop ✓ ⁆ ~/.oh-my-zsh ▶ ...  /home/exos/.oh-my-zsh [20:27:16]
 |      |        |     |         |                      |                 |_ Hour
 |      |        |     |         |                      |_ Absolute path
 |      |        |     |         |_ Relative path
 |      |        |     |_ Git status
 |      |        |_ Git branch (Using branch icon if use patched font with powerline)
 |      |_ Name of project or name of directory
 |_ Las execution status (green or red, the exit number show on right side, before hour)
~~~

On Python (with requirements.txt or .virtualenv detected):
~~~
⏺ ⁅ ⌬ tenis ⭠master ✓ ⁆ projects/tenis ▶ 
    |_ Virtualenv status (red if not active and green if is actived on this directory)
~~~

This prompt is for developers, but is very clean if the directory isn't a git repository, for example in the homem only show the last status and the relative path.

~~~
⏺  ~ ▶ cd ~/Documentos/wallpapers/The\ Pirate\ Bay
⏺  wallpapers/The Pirate Bay ▶  
~~~

And from SSH:

~~~
⏺ hexodica ➲   ~ ▶   
       |_ hostname
~~~

There are a session recorded using the theme:
https://asciinema.org/a/15254
