---
layout: post
title: "Optimize BibDesk, Multimarkdown and Scrivener for a nice scientific bibliography and citation workflow"
description: "Multimarkdown (MMD) is great for writing structured text without much syntactical noise. This article shows how BibDesk can be tweaked to fit well into a MMD workflow."
date:   2014-04-08 07:00:00 +0100
categories: guide
comments: true
old_disqus_id: 2594541569
---

To me, writing academic papers directly in LaTeX feels like I develop a software program. I have a hard time bringing my ideas to understandable sentences when I see so many brackets and backslashes. Multimarkdown (MMD) is a good combination of both worlds, content can be written without much syntactical noise and there is still structure. With the help of Scrivener, the workflow and organization of the MMD files becomes comfortable. Writing academic content, there is actually no excuse not to use a bibliography tool. Personally, I like BibDesk. It is open source, has a clean user interface and just enough options to categorize the material without being to overloaded. However, BibDesk was designed to work well with LaTeX. I tweaked BibDesk to fit into the MMD workflow.

## Scientific Multimarkdown citations to LaTeX

The [official MMD documentation][1] by Fletcher Penny is a good source for the conversion rules and possibilities of MMD cite keys to LaTeX citation rules. I’ll show the application his examples here. Since I mostly write within the psychological rules, the final output after the LaTeX conversion is according to the “apacite” LaTeX package (see my [previous Scrivener article][2] for further information). Here is how I want the input and output to convert to:

> [#webster_2002a] —> (Webster 2002)

> [p. 49][#webster_2002a] —> (Webster, 2002, p. 46)

> [take a look at\\]\\[][#webster_2002a] —> (take a look at Webster, 2002)

> [take a look at\\]\\[p. 49][#webster_2002a] —> (take a look at Webster, 2002, p. 46)

> [#webster_2002a, smith_1999a] —> (Webster, 2002; Smith 1999) 

By adding a semicolon to before a closing bracket, we can create an inline citation:

> [p. 49][#webster_2002a;] —> Webster (2002, p. 46)


## Auto-generate BibDesk cite keys

Every time you add a new publication to your BibDesk collection, you are prompted to fill in the cite key yourself. While this is usually a quick thing, it often leads to inconsistencies with the naming. Did you know BibDesk can auto-generate that key based on attributes you fill in, like author and year?
Enter *Preferences > Cite Key > and Check 'Autogenerate the cite key when enough fields are supplied'*. I have clicked on advanced and set the *Preset Format* to *Custom* and I use this Format String: *%a2_%Y%u1*. Furthermore I checked the option *Generate lowercase cite keys*. My cite keys will have the first to authors, an underscore followed by the year and an indicator from a-z. A publication from McCracken and Maxwell from 2004 would result in a cite key like: 
> mccrackenmaxwell_2004a

> <a href="/assets/2014-04-bibdesk3.jpg"><img src="/assets/2014-04-bibdesk3_p.jpg" /></a>

## Copy MMD cite keys directly from BibDesk to Scrivener

Now each and every time you cite something in your Scrivener, ie. MMD file, you would have to look up the corresponding cite key in BibDesk, open a square bracket, add a hash symbol and the type in the key. This demotivates me from citing a lot, which must be improved. I’d like to use *Alt+CMD+C* to copy the MMD cite key and just paste it into my MMD file with *CMD+V*. The output should look like this: 
> [#mccrackenmaxwell_2004a]

BibDesk has a neat feature called Templates. Here is how we will be able to *Alt+CMD+C* the cite key in MMD format:

1. Define a custom template
2. Add this template to BibDesk
3. Create the *Alt+CMD+C* shortcut

### 1. Define a custom template
Open your finder, click *Shift+CMD+G* (in Menu: *Go > Go to Folder*) and go there:

> ~/Library/Application Support/BibDesk/Templates

Add a new file there, you can name it "mmdCiteKey.txt" and enter this content:

> [#<$publications.citeKey.@componentsJoinedByComma/>]


### 2. Add this template to BibDesk
In BibDesk, go to *Preferences > Templates*. Click the small *+* Button on the bottom right and double click the red words to add a new file. Choose your new "mmdCiteKey.txt". Your result should look like this:

> <a href="/assets/2014-04-bibdesk2.jpg"><img src="/assets/2014-04-bibdesk2_p.jpg" /></a>

### 3. Create the *Alt+CMD+C* shortcut
By now, from within BibDesk, you can just go to *Edit > Copy As > Template > mmdCiteKey* or you right click an article and choose *Copy Using Template > mmdCiteKey*. If this is fine for you and you use your mouse more often than you use your keyboard, go with the right click option. Everyone else who wants to be really fast, follow me one more step. Go to you Mac System Preferences (click the Apple on the top left and then Preferences). Go to *Keyboard > Shortcuts* and pick *App Shortcuts* on the bottom left of the list. Click the *+* button and find the BibDesk application. For the menu title enter 

> *Edit->Copy As->Template->mmdCiteKey*

and for the Keyboard Shortcut press *ALT+CMD+C*.

> <a href="/assets/2014-04-bibdesk1.jpg"><img src="/assets/2014-04-bibdesk1_p.jpg" /></a>

Now go to BibDesk, click on an article and press *ALT+CMD+C*. Paste it anywhere with CMD+V and enjoy your output: 
> [#mccrackenmaxwell_2004a].

### Bonus Tip 1
You can even select multiple authors, it will automatically insert all of them like:
> [#mccrackenmaxwell_2004a, smith_1999a]

### Bonus Tip 2
I've built multiple templates for all kind of purposes: inline citations, append, prepend, everything that improves your workflow is worth it. Just go the folder with the templates and create new files.
> <a href="/assets/2014-04-bibdesk4.jpg"><img src="/assets/2014-04-bibdesk4_p.jpg" /></a>

Here is how my new custom templates look like:
> mmdCiteKey_append.txt:
<br/>
> [S. ][#<$publications.citeKey.@componentsJoinedByComma/>]

> mmdCiteKey_inline_append.txt:
<br/>
> [S. ][#<$publications.citeKey.@componentsJoinedByComma/>;]

> mmdCiteKey_prepend.txt:
<br/>
> [vgl.\]\[][#<$publications.citeKey.@componentsJoinedByComma/>]

> mmdCiteKey.txt:
<br/>
> [#<$publications.citeKey.@componentsJoinedByComma/>]




[1]: http://fletcher.github.io/peg-multimarkdown/mmd-manual.pdf
[2]: http://timbrandes.com/blog/2012/02/28/howto-write-your-thesis-in-latex-using-scrivener-2-multimarkdown-3-and-bibdesk/
