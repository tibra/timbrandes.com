---
layout: post
title: "Making the RVM web site responsive with CSS3 media queries"
date:   2011-06-22 00:38:00 +0100
categories: guide
comments: true
---

So, you might have heard of this shiny new book by [Ethan Marcotte][1] called [Responsive Web Design][2]. The basic idea is to make one web site and let it respond differently to the screen size of the user. We use three ingredients to do so

* A Flexible Grid
* Flexible Images
* CSS3 Media Queries

{% highlight ruby %}
  tibra: if you have more than 1200 pixel width
  tibra: make it smaller than 768
  tibra: and watch the header boxes
  wayneeseguin: ok
  wayneeseguin: holy shit how did you do that !
  wayneeseguin: totally fucking awesome
{% endhighlight %}

# A Flexible Grid

The idea behind a flexible grid is to consequently use percentages and em's in favor of fixed pixels. The [RVM web site][3] already had the main content area as a percentage sized width. However, the header area still uses fixed width boxes of 220px.

<blockquote>
<a href="/assets/2011-06-rvmsite.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite_p.jpg" /></a>
<a href="/assets/2011-06-rvmsite2.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite2_p.jpg" /></a>
</blockquote>

Mixing pixels and percentages leads to some ugliness when resizing the browser window and making it shorter. But is this *really* a problem for coders? How often do we use a documentary site on a small screen or with a very small browser window? I think the problem lies on the other side of the universe: high resolution screens.

<blockquote>
<a href="/assets/2011-06-rvmsite3.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite3_p.jpg" /></a>
<a href="/assets/2011-06-rvmsite4.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite4_p.jpg" /></a>
</blockquote>

As you can see, there is the documentation index on the bottom of the site. The content area takes up all the space and stretches its text far too wide. When I did this design about a year ago, I didn't consider this usability/readability issue. Now let's go and see how a flexible grid can help us with the header and those boxes on top.

Except for the wider sponsors box, all boxes inherit the same basic style from a compass mixin:

{% highlight ruby %}
  @mixin default-box 
    float: left
    width: 18%
    margin-right: 0.7%
{% endhighlight %}

And then we simply use it on a selector, here the recommend and irc boxes:

{% highlight ruby %}
  #recommend, #irc
    @include default-box
{% endhighlight %}

So, that's just floating divs with a width and a margin that is a percentage value. Pretty easy and works as expected.

<blockquote>
<a href="/assets/2011-06-rvmsite5.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite5_p.jpg" /></a>
</blockquote>


# Flexible Images

We have four images in the head area and our “w00t! RVM! TENNNGH! RUBYYYYYYYYYY! CRUNCH“ image that's greeting us welcome. Our best friend with flexible images is _max-width: 100%_. This attribute makes sure images adapt to their parents container size even if they are bigger. We let the browser resize the images dynamically and hope for some smooth rendering (good browsers will give you that). Here is how the logo is styled:

{% highlight ruby %}
  #logo
    text-align: center
    img
      max-width: 100%
      max-height: 170px
{% endhighlight %}

And the haml view looks like this
{% highlight ruby %}
  #logo
    %a{ :href => "/" }
      %img{ :src => "/images/logo.png", :alt => "RVM Logo"}
{% endhighlight %}

I have added the _max-height: 170px_ after some testing with resizing the browser window. If you don't specify any _max-height_ the logo will become bigger and bigger until it hits the original file size. I left the logo.png untouched and gave it some height constraints instead.
The “w00t! RVM!...“-image looks just as simple as this:

{% highlight ruby %}
  #content
    img
      max-width: 100%
{% endhighlight %}

And here is the result on big and small browser windows:

<blockquote>
<a href="/assets/2011-06-rvmsite6.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite6_p.jpg" /></a>
<a href="/assets/2011-06-rvmsite7.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite7_p.jpg" /></a>
</blockquote>


# CSS3 Media Queries

While this is all well and good so far, the real power becomes visible when we introduce CSS3 Media Queries. 
The last screenshot already has some media queries in use (see the long text from before in those boxes on top? No? Me neither :)).

But don't you find that there is still too much whitespace in the content area? Wouldn't it be great if we could simply move the big _Documentation Index_ from the bottom of the page to the right and float it _next to_ the content area? This way, widescreen users could really benefit from their screen size and scrolling down would only be necessary if we were on a smaller screen. You might have guessed it already: Media Queries - that's what they're here for.

<blockquote>
<a href="/assets/2011-06-rvmsite8.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite8_p.jpg" /></a>
</blockquote>

## How do we include Media Queries?

Media Queries allow us to change the style depending on the users screen size. We simply include them into our normal stylesheet like this:
{% highlight ruby %}
  @media screen and (max-width: 768px)
    // changes for everything smaller than 768px

  @media screen and (min-width: 1200px)
    // changes for wide-screen users
{% endhighlight %}

## Let it float, baby

Now, this code is all it takes to make it happen:

{% highlight ruby %}
  @media screen and (min-width: 1200px)
    #content
      width: 50%
      float: left
      margin-bottom: 1%
    #docindex
      width: 44%
      float: right
    a.docindex
      display: none
{% endhighlight %}

And as a little bonus, we hide the link to the _Documentation Index_ at the top of the content area.

<blockquote>
<a href="/assets/2011-06-rvmsite10.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite10_p.jpg" /></a>
<a href="/assets/2011-06-rvmsite9.jpg" class="lightbox"><img src="/assets/2011-06-rvmsite9_p.jpg" /></a>
</blockquote>


# See it live

Wayne has already [deployed the new version][3], be sure to check it out! I hope you find this useful and you are encouraged to make some responsive designs yourself. I believe it's the future. If you can imagine a way to make this better, find the [RVM website on Github][4] and start hacking!


[1]: http://ethanmarcotte.com/
[2]: http://www.abookapart.com/products/responsive-web-design
[3]: https://rvm.beginrescueend.com
[4]: https://github.com/wayneeseguin/rvm-site
