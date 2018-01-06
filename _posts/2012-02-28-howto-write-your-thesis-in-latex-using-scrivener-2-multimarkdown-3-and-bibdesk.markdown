---
layout: post
title: "How to write your Thesis in LaTeX with Scrivener 2, MultiMarkdown 3 and BibDesk"
date:   2012-02-28 23:50:00 +0100
categories: guide
comments: true
old_disqus_id: 2012-02-2823:50
---

## The pros and cons of LaTeX

When you are dealing with rather large chunks of text that should become a thesis, a manual or whatnot, having to deal with MS Word or Pages might not be the best experience. During the writing process, I often find myself dealing with all kinds of formatting related tasks. Not only does this distract me from writing good content, it also leaves me with just one long document. Keeping track of all the chapters and their relations to each other can be a real pain when you have more than a couple of thousand words. At this point, [Scrivener][1] comes in as a great writing tool. Basically, Scrivener lets you organize your chapters and sub-texts in a tree-like project drawer. [Jason Shafer][2] has a good post about the _why_.

Writing LaTeX directly can be like writing source code and for most people it might not be the optimal environment for creating texts. For _outputting_ and _typesetting_ however, LaTeX is super cool. Not only will you have sugar-sweet PDF, you can manage and change your whole citation and bibliohraphy style literally with one command. So, before we look into the relationship between Scrivener and LaTeX, let's first check the requirements for an academic writing workflow.

Here is how the end result should look like:

<blockquote>
<a href="/assets/2012-02-thesis08.jpg"><img src="/assets/2012-02-thesis08_p.jpg" /></a>
<a href="/assets/2012-02-thesis09.jpg"><img src="/assets/2012-02-thesis09_p.jpg" /></a>
<a href="/assets/2012-02-thesis10.jpg"><img src="/assets/2012-02-thesis10_p.jpg" /></a>
</blockquote>

All files used here can be [found on GitHub][12].


## Citations

_Don't Repeat Yourself_ (DRY) is a common practice among programmers. The basic idea is that having duplicated information about the same thing will mess things up at some point. When writing a thesis, you might have experienced this with citations. In a Word document, you would do something like this: 

<blockquote>
Mayer & Moreno (2002) argue that computer-based learning environments can help improving student understanding.
</blockquote>

Then in your bibliography index you add

<blockquote>
Mayer, R. E. & Moreno, R. (2002). Aids to computer-based multimedia learning. Learning and Instruction (12), 107-119.
</blockquote>

At some point you decide to throw out that top sentence. But in your bibliography index you will still find the entry for Mayer and Moreno. And what will happen when you decide to change your citation style from APA to Harvard or something else? There is no technical relationship between the two and you will have to fix everything by search and replace or by hand.


### Introducing BibDesk and Citekeys

[BibDesk][3] is an open-source bibliography manager for the Mac. It has a clean and simple interface. Every book, article or website that is important for your thesis, you put into BibDesk with a new entry and a unique _citekey_. My citekeys look like this:

<blockquote>
Mayer_2002
<br/>
Jonassen_2004b
</blockquote>

<blockquote>
<a href="/assets/2012-02-thesis01.jpg" class="lightbox"><img src="/assets/2012-02-thesis01_p.jpg" /></a>
</blockquote>

### Using citekeys in Scrivener

In Scrivener we can write in [MultiMarkdown (MMD)][4] to link our citations to an unqiue entry in our BibDesk _*.bib_ file.

<blockquote>
[#Mayer_2002;] argue that computer-based learning environments can help improving student understanding.
</blockquote>

This will later be formatted nicely to match a certain style like APA, Harvard & co. You can use your citekey as shown above by putting it into square brackets after a hash symbol like _[#mycitekey]_. If you use an inline citation, in the current version 3.2 of MMD, you have to put a semicolon behind your key inside the brackets like _[#mycitekey;]_. Here are some more examples:

<blockquote>
Computer-based learning environments can help improving student understanding[#Mayer_2002].

[P. 108][#Mayer_2002;] notes: "Computer-based multimedia learning environments — consisting of pictures (such as animation) and words (such as narration) — offer a potentially powerful venue for improving student understanding."

"Computer-based multimedia learning environments — consisting of pictures (such as animation) and words (such as narration) — offer a potentially powerful venue for improving student understanding"[P. 108][#Mayer_2002].
</blockquote>

*Update, 08.04.2014:* I've written a [follow up article on multimarkdown citations and optimizing the BibDesk workflow][17].

For more information about MMD 3 and citations, see [the parapraph about Citations in the MMD Guide][5].

_Please note that you'll have to install MMD 3 *and* its support files. By default, Scrivener 2.2 will use MMD 2 which won't support the above syntax. It took me four hours to discover that. Basically, you will have to download and install MultiMarkdown-Support-Mac-….pkg.zip into your users ~/Library/Application Support/MultiMarkdown/ directory._ Thanks to Neil Ernst who explains [in more detail in his blog post][6].

## Organize your document in Scrivener

Putting your document together in Scrivener is very straightforward. Begin with a new blank project. I like organizing my chapters with folders as first level headers in which I put second and third level chapters.

Here is a sample that shows my structure for a sample document:

<blockquote>
<a href="/assets/2012-02-thesis02.jpg" class="lightbox"><img src="/assets/2012-02-thesis02_p.jpg" /></a>
</blockquote>

### Integrate BibDesk

In Scrivener settings (_Scrivener->Settings->General Tab_) under "Bibliography Manager" pick the BibDesk Application to tell Scrivener what to open when you hit your bibliography shortcut CMD+Y within Scrivener.

### Use Citations

Now let's go and make a reference to a citekey. I added the article to BibDesk and gave it the citekey "Mayer_2002". Now in Scrivener I simply embed it into my text like the following. Make sure to save your BibDesk file (best place is the same directory as your Scrivener file).  

<blockquote>
To achieve this, [#Mayer_2002;] mentions it would be necessary to have uniform grammar, pronunciation and more common words.
</blockquote>

<blockquote>
<a href="/assets/2012-02-thesis03.jpg" class="lightbox"><img src="/assets/2012-02-thesis03_p.jpg" /></a>
<a href="/assets/2012-02-thesis04.jpg" class="lightbox"><img src="/assets/2012-02-thesis04_p.jpg" /></a>
</blockquote>

## Compile the MultiMarkdown into LaTeX

At the moment, all we have is a Scrivener file with some MMD flavoured syntax. To generate a PDF from a LaTeX file we first have to generate a LaTeX file. This process is called _compiling_. In Scrivener, head over to _File->Compile…_ (ALT+CMD+E). Change "Compile For: Print" at the bottom to "Compile For: MultiMarkdown -> LaTeX". Under Formatting, check the "Title" checkboxes for every level if you want all to be part of your document (see second screenshot). Now comes the part every Scrivener to LaTeX tutorial I found was outdated. Before Scrivener 2, the Meta-Data settings were in some settings menu, now they are in the Compile window under "Meta-Data". Meta-Data is important because it will include commands into the LaTeX file that gets saved. Scrivener will only output the plain text (in a structured way for LaTeX) but not any specific information about your thesis like your citation style or title page. Add the following Meta-Data key-value pairs as shown in the third screenshot like this:

_Note: make sure you have the exact order and spelling! latex-input has to be at the very bottom!_


{% highlight ruby %}
Key                       Value
Base Header Level         2
BibTeX                    literature.bib (or what your files name is)
latex footer              my-thesis-footer
Bibliostyle               apacite (or plain or harvard or sth. else)
Author                    Tim Brandes
Quotes language           german (or something else)
latex input               my-thesis-input
{% endhighlight %}

So here is the explanation for the values. Base Header Level will tell LaTeX how you want your folder-file structure from Scrivener to be translated into chapters. Play around with 1, 2 and 3 and compare results. BibTeX (note spelling) references your literature.bib (or your naming of it) file. latex footer is a file called my-thesis-footer.tex we create and put into the same directory. This file includes everything that is at the very bottom of your latex document like your bibliography index. Bibliostyle can also be managed later in the my-thesis-input.tex file but we do it here for convenience. For more options, see [this bibstyles.pdf file][7]. Author and Quotes language should be clear and latex-input will be the document that we will create in a minute called my-thesis-input.tex which will include our [LaTeX-Preamble][8].


<blockquote>
<a href="/assets/2012-02-thesis05.jpg" class="lightbox"><img src="/assets/2012-02-thesis05_p.jpg" /></a>
<a href="/assets/2012-02-thesis07.jpg" class="lightbox"><img src="/assets/2012-02-thesis07_p.jpg" /></a>
<a href="/assets/2012-02-thesis06.jpg" class="lightbox"><img src="/assets/2012-02-thesis06_p.jpg" /></a>
</blockquote>

Now press "Compile" and save the document into your thesis directory where your .bib file is.


### my-thesis-input and my-thesis-footer

Before we generate the PDF we have to make two new files that we reference as our input (which is really more a header but the header meta-data seems to be broken) and footer file. Here is [the input (preamble) file][9] and here is [the footer file][10]. Drop those two files into your directory where your Scrivener file is.


## Make the PDF

Now it is only the PDF that is left to be generated from our LaTeX file. Make sure you have installed the [MacTeX-Bundle][11] or similar. Iuse TextMate's LaTeX Bundle to typeset my PDF files. Open the thesis.tex file in TexShop or TextMate and click "Set LaTeX" once, then click "Set BibTex" and click "Set LaTeX" twice more. Without any errors messages, you should now find eight more files next to your thesis.tex file. One of them is a pdf that should look like this:

<blockquote>
<a href="/assets/2012-02-thesis08.jpg" class="lightbox"><img src="/assets/2012-02-thesis08_p.jpg" /></a>
<a href="/assets/2012-02-thesis09.jpg" class="lightbox"><img src="/assets/2012-02-thesis09_p.jpg" /></a>
<a href="/assets/2012-02-thesis10.jpg" class="lightbox"><img src="/assets/2012-02-thesis10_p.jpg" /></a>
</blockquote>

Of course, everytime you have a change in your text, all you have to do is compile from Scrivener and typeset the LaTeX in TextMate or TeXShop into your PDF. The whole setup process described here is basically just a one time thing.

## Resources

The project with all documents used and generated can be [found on GitHub][12].

[Citations with Scrivener, MultiMarkDown, BibDesk, and TeXShop][13]
[Writing Complex Latex Documents with Scrivener 2.1 and MultiMarkDown 3][14]

Great series of screencasts:
[Scrivener Tutorial 1: Setup, MMD And LaTeX][15]
[…and more of them][16]

Follow up blog post on Multimarkdown citations:
[Optimize BibDesk, Multimarkdown and Scrivener for a nice scientific bibliography and citation workflow][17]

*Enjoy writing your papers!*


[1]: http://www.literatureandlatte.com/scrivener.php
[2]: http://www.jasonshafer.net/?p=177
[3]: http://bibdesk.sourceforge.net/
[4]: http://fletcherpenney.net/multimarkdown/
[5]: http://fletcher.github.com/peg-multimarkdown/
[6]: http://neilernst.net/2011/07/27/writing-complex-latex-documents-with-scrivener-2-1-and-multimarkdown-3/
[7]: http://amath.colorado.edu/documentation/LaTeX/reference/faq/bibstyles.pdf
[8]: http://www.artofproblemsolving.com/Wiki/index.php/LaTeX:Layout
[9]: https://gist.github.com/1935325
[10]: https://gist.github.com/1935333
[11]: http://www.tug.org/mactex/2011/
[12]: https://github.com/tibra/ScrivenerToLaTeX
[13]: http://www.aidanfindlater.com/citations-with-scrivener-multimarkdown-bibdesk-and-texshop
[14]: http://neilernst.net/2011/07/27/writing-complex-latex-documents-with-scrivener-2-1-and-multimarkdown-3/
[15]: http://www.macosxscreencasts.com/general/scrivener-tutorial-1-setup-mmd-und-latex/
[16]: http://www.macosxscreencasts.com/?s=scrivener&x=0&y=0
[17]: http://timbrandes.com/blog/2014/04/08/optimize-bibdesk-multimarkdown-and-scrivener-for-a-nice-scientific-bibliography-and-citation-workflow/
