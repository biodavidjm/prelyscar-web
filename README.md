PRELYSCAR-WEB
=========

___The online version of PreLysCar tool___

Available at [http://tanto.bioe.uic.edu/prelyscar/](http://tanto.bioe.uic.edu/prelyscar/)

![](images/urease200.jpg)

# Description

The **Pre**dictor of **Lys**ine **Car**boxylation is a tool developed to predict the carboxylation of lysine residues using as input the 3D-structure of proteins in `PDB format`.

# Deployment on `tanto`

### Clone for the first time
`git clone https://github.com/biodavidjm/prelyscar-web`

### Updates
`git pull`

### Preventing access to .git folder
In the `/etc/apache2/apache2.conf` configuration file, just add the following lines to prevent access to the .htaccess and the .git folder:

```
#
# The following lines prevent .htaccess and .htpasswd files from being
# viewed by Web clients.
#
<FilesMatch "^\.ht">
    Require all denied
</FilesMatch>

<FilesMatch "^\.git">
        Require all denied
</FilesMatch>
```

# Monitoring

[Uptimerobot](https://uptimerobot.com/)

# Testing locally on a Mac

* MAMP for the Apache & PHP server







