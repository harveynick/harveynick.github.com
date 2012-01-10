---
author: harveynick
date: '2008-08-24 21:23:58'
layout: post
slug: mdl-celtx-on-the-acer-aspire-one
status: publish
title: Celtx on the Acer Aspire One
wordpress_id: '41'
categories:
- Geek
tags:
- aspire one
- celtx
- how to
---

So I managed to get the Celtx screenwriting (and general preproduction) software up and running on my shiny new AA1, and in the interests of sharing the knowledge I thought I'd post how I did it. Please note, this should also work as general recipe for installing any software not available under the package manager in Linpus Light Linux (provided there are no additional dependencies).  

First of all you need to download the software from the downloads page of the Celtx website, [here](http://www.celtx.com/download.html). I'd recomend getting the straight up Linux version in your choice of language (frustratingly there is no option for British English, though). There is an Asus eee specific version, but that just clears up some dependencies and doesn't really provide you with anything extra.  

<!-- more -->

First of all you'll need a terminal, so hit Alt+F2, type "terminal" (without the quotes) and hit enter. A terminal should have popped up. If you're a Linux novice, don't worry, you should just be able to copy and paste everything from this page.  
Now you need to unpackage the software. I put it in /opt, because it generally seems to be a dumping ground for user installed applications (as far as I can tell). Type these in the terminal one at a time: 
    
    cd /opt
    
    sudo tar -xf /home/user/Downloads/Celtx.tar.gz

Now, if you type "ls" you should see a directory named celtx. So far so good. Next you need to add a link so Celtx can be run from the command line, like this: 
    
    sudo ln -s /opt/celtx/celtx /usr/bin/celtx

In theory that's all you need to do. Now if you type "celtx" on the command line (or after hitting Alt+F2) the program will run. We can make it a lot easier than that, though. Next we need an icon to represent it on the desktop. There are two options here. First of all you could use an existing one. Type this: 
    
    sudo thunar /usr/share/pixmaps

A file manager window should pop up and if you scroll down you'll find all the system icons. If you find one you want to use for Celtx: cool, if you don't then you're other option is to make one. I'm not going to get into that, but if you want to do it please bare in mind that is has to be a png, it has to be 90px x 90px in size and it has to be placed in that directory. I found one on the web and resized it myself. Assuming you have the icon you want in the downloads directory and it's called "celtx.png", you would type this to get it in the right place: 
    
    sudo mv /home/user/Downloads/celtx.png /usr/share/pixmaps/celtx.png

That done we need to create a desktop entry for it. You need to use a text editor for this. I used "vim", so that's what the directions here will say. "vim" can be pretty hard to use at first, though, so if you're not linux minded you might want to find a tutorial on the web, or replace the "vim" command with something else (mousepad is one option that might be easier to use and more familiar). We start by (basically) creating the file: 
    
    sudo vim /usr/share/applications/Celtx.desktop

If you're using vim, hit "i" (the word "insert" should appear at the bottom) and then paste the following into the file: 
    
    [Desktop Entry]
    Version=1.0
    Encoding=UTF-8
    Name=Celtx
    Name[zh_TW]=Celtx
    Name[zh_TW]=Celtx
    Name[zh_CN]=Celtx
    Name[de]=Celtx
    Name[it]=Celtx
    Name[fr]=Celtx
    Name[es]=Celtx
    Name[pt]=Celtx
    Name[nl]=Celtx
    Name[ja]=Celtx
    Name[ru]=Celtx
    GenericName=Celtx
    GenericName[zh_TW]=Celtx
    GenericName[zh_CN]=Celtx
    GenericName[de]=Celtx
    GenericName[it]=Celtx
    GenericName[fr]=Celtx
    GenericName[es]=Celtx
    GenericName[pt]=Celtx
    GenericName[nl]=Celtx
    GenericName[ja]=Celtx
    GenericName[ru]=Celtx
    Comment=Write and edit media scripts
    Exec=celtx
    Icon=Celtx.png
    Terminal=false
    Type=Application
    StartupWMClass=celtx-bin
    MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;application/x-shockwave-flash;
    X-Desktop-File-Install-Version=0.10
    Categories=Work;
    StartupNotify=true

Be sure to replace "Celtx.png" with whatever the icon you want to use is called. Also, all those language options are possibly not strictly necessary, but I copied most of this from another file and left them in to be on the safe side. Likewise, I could probably have done something a bit more clever with the "MimeType" bit, but decided not to bother. Next, save and exit the file. In "vim", you hit escape, then type:
    
    :wq

and hit enter. Lastly, we just need to tell Linpus to display Celtx on the desktop:

	vim /home/user/.config/xfce4/desktop/group-app.xml

You should now be looking at an XML file. You need to find this: 
    
    <id>6</id>

And insert this underneath it: 
    
    <app sequence="2">/usr/share/applications/Celtx.desktop</app>

Be sure to increase the "sequence" numbers on the other "\<app\>" entries as well, to make sure there are no duplicates. 

That's about all there is to it. If you reboot the machine you should now find that you have an icon for Celtx on the desktop. After you put some .celtx files on the machine, you might want to right click on one and select "properties", then tell Limpus to open the file type with Celtx (otherwise it'll just treat it like a zip file).  

This is quite a long post and I have work to do, but I might return in the next couple of days with some things to say about Celtx itself. Happy hunting!  

PS Thanks to the users of the forums on aspireoneuser.com for the knowledge which was needed to work this out.
