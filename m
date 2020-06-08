Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7681F10C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 02:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgFHAtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 20:49:55 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:46803 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728001AbgFHAty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:49:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id B763F54A;
        Sun,  7 Jun 2020 20:49:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 07 Jun 2020 20:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        ypy9wHdt9x60QtCjqTWqlpCz6bFcBx77MRo3WMv+OYo=; b=R1e4YW7jAr1iLQH3
        7j3yOhEh8Qw5GDDVKsF+mwfl7lZ5C7iXNFO676mPkJ6+xYmusnFJkRGJ6bM0LKMq
        yXg4+U7CYOy2Eem+mMuA3n75h+NJWVsb87F6kV8an2y0NcNc+ZlgjJsc9pvlsVZq
        zySVPEvzvkk/rTuxM+/0VVaxX9dhT8Kzd9Q4Go06iPxS8YlFpTAdk0ShxMZ9tJJt
        VmuXuflejR4dV5U2wOiMuRQbQuAud4UeZ84u6Y2C831xzqbziEcf+n2J54TrUCh4
        Px1pn0IsC0OF8UDKUiLmtCyZjddSeUd8IxVLtEUlPJTEkidqxY5kJwG4/7Jk/9W1
        753MGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=ypy9wHdt9x60QtCjqTWqlpCz6bFcBx77MRo3WMv+O
        Yo=; b=AsPcByuHOh2lcHRZkGhqUAl2xQavgf8MaWNs6JvlZstYXj4SGF6fEa5IO
        IXrNBNEQoJTZ63mWWSZAN4/opi9UVWsyevyQKpT3Mbu8McemhGGR9eRQfyDJ/Q5B
        j98FzF2Rrv7LD0dmXwlo/9IEDDAl/H0qouuzZxRx5TgWy+Iwr/OLymWIu3jCMhNX
        6XUUq7u17JLNKHReIkBGBfpZMzHAh942z87heJe5J/wEI5ia63EYi9JG1wCI3ngp
        Jw6nfgzbX6Rsc5cfzU9+XGwqKGfMIp9n/YgTzlSP8+PGWK6osb0rqkJYRsECVy/d
        mADU9PxrTmJ/UeDGJfN/Xf0kJCzBw==
X-ME-Sender: <xms:L4vdXl0FGKqcyzyA0OTu1RuAHNddQN_dNHQTk7kLJPxUSwLtnWVl5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehtddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekkeejieeiieegvedvvdejjeegfeffleekudekgedvudeggeevgfekvdfhvdelfeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeehkedrjedrvddvtddrgeejnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhes
    thhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:L4vdXsHyveDhLmE2Eetk_vf6buSMTCWyUZdIj7_AVDRNwZsalSGKmQ>
    <xmx:L4vdXl4aRnjipMc7x4jy5Bcc-eiNzD7b3SeyCi8_u_QzrYrdrX9GKA>
    <xmx:L4vdXi0aFUn6K-x440t7FFmqqUrVfN_cxvo8TqM2gOFS0LJxhg6hrQ>
    <xmx:MIvdXjAgCZJSjnV-zQF1iNSvJuM6UsNWHBFbMbnNlKjOI6tfSMyTrKqZ37w>
Received: from mickey.themaw.net (58-7-220-47.dyn.iinet.net.au [58.7.220.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15BAE3060FE7;
        Sun,  7 Jun 2020 20:49:46 -0400 (EDT)
Message-ID: <4e388597a0fc05fc553c7afd5076d77e232f875e.camel@themaw.net>
Subject: Re: [GIT PULL] General notification queue and key notifications
From:   Ian Kent <raven@themaw.net>
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com,
        mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com,
        andres@anarazel.de, christian.brauner@ubuntu.com,
        jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Jun 2020 08:49:43 +0800
In-Reply-To: <639a79d90f51da0b53a0ba45ec28d5b0dd9fee7b.camel@themaw.net>
References: <1503686.1591113304@warthog.procyon.org.uk>
         <639a79d90f51da0b53a0ba45ec28d5b0dd9fee7b.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-06-03 at 10:15 +0800, Ian Kent wrote:
> On Tue, 2020-06-02 at 16:55 +0100, David Howells wrote:
> > [[ With regard to the mount/sb notifications and fsinfo(), Karel
> > Zak
> > and
> >    Ian Kent have been working on making libmount use them,
> > preparatory to
> >    working on systemd:
> > 
> > 	https://github.com/karelzak/util-linux/commits/topic/fsinfo
> > 	
> > https://github.com/raven-au/util-linux/commits/topic/fsinfo.public
> > 
> >    Development has stalled briefly due to other commitments, so I'm
> > not
> >    sure I can ask you to pull those parts of the series for
> > now.  Christian
> >    Brauner would like to use them in lxc, but hasn't started.
> >    ]]
> 
> Linus,
> 
> Just so your aware of what has been done and where we are at here's
> a summary.
> 
> Karel has done quite a bit of work on libmount (at this stage it's
> getting hold of the mount information, aka. fsinfo()) and most of
> what I have done is included in that too which you can see in Karel's
> repo above). You can see a couple of bug fixes and a little bit of
> new code present in my repo which hasn't been sent over to Karel
> yet.
> 
> This infrastructure is essential before notifications work is started
> which is where we will see the most improvement.
> 
> It turns out that while systemd uses libmount it has it's own
> notifications handling sub-system as it deals with several event
> types, not just mount information, in the same area. So,
> unfortunately,
> changes will need to be made there as well as in libmount, more so
> than the trivial changes to use fsinfo() via libmount.
> 
> That's where we are at the moment and I will get back to it once
> I've dealt with a few things I postponed to work on libmount.
> 
> If you would like a more detailed account of what we have found I
> can provide that too.
> 
> Is there anything else you would like from me or Karel?

I think there's a bit more I should say about this.

One reason work hasn't progressed further on this is I spent
quite a bit of time looking at the affects of using fsinfo().

My testing was done by using a large autofs direct mount map of
20000 entries which means that at autofs startup 20000 autofs
mounts must be done and at autofs shutdown those 20000 mounts
must be umounted. Not very scientific but something to use to
get a feel for the affect of our changes.

Initially just using fsinfo() to load all the mount entries was
done to see how that would perform. This was done in a way that
required no modifications to library user code but didn't get
much improvement.

Next loading all the mount ids (alone) for mount entry traversal
was done and the various fields retrieved on-demand (implemented
by Karel).

Loading the entire mount table and then traversing the entries
means the mount table is always possibly out of date. And loading
the ids and getting the fields on-demand might have made that
problem worse. But loading only the mount ids and using an
on-demand method to get needed fields worked surprisingly well.

The main issue is a mount going away while getting the fields.
Testing showed that simply checking the field is valid and
ignoring the entry if it isn't is enough to handle that case.

Also the mount going away after the needed fields have been
retrieved must be handled by callers of libmount as mounts
can just as easily go away after reading the proc based tables.

The case of the underlying mount information changing needs to
be considered too. We will need to do better on that in the
future but it too is a problem with the proc table handing and
hasn't seen problems logged against libmount for it AFAIK.

So, all in all, this approach worked pretty well as libmount
users do use the getter access methods to retrieve the mount
entry fields (which is required for the on-demand method to
work). Certainly systemd always uses them (and it looks like
udisks2 does too).

Unfortunately using the libmount on-demand implementation
requires library user code be modified (only a little in
the systemd case) to use the implementation.

Testing showed that we get between 10-15% reduction in
overhead and CPU usage remained high.

I think processing large numbers of mounts is simply a lot
of work and there are particular cases that will remain that
require the use of the load and traverse method. For example
matching all mounts with a given prefix string (one of the
systemd use cases).

It's hard to get information about this but I can say that
running pref during the autofs start and stop shows the bulk
of the counter hits on the fsinfo() table construction code
so that ahs to be where the overhead is.

The unavoidable conclusion is that the load and traverse method
that's been imposed on us for so long (even before libmount)
for mount handling is what we need to get away from. After all,
this is essentially where the problem comes from in the first
place. And fsinfo() is designed to not need to use this method
for getting mount information for that reason.

There's also the notifications side of things which is the next
area to work on. Looking at systemd I see that monitoring the
proc mount table leads to a load, traverse, and process of the
entire table for every single notification. It's clear that's
because of the (what I'll call) anonymous notifications that we
have now.

The notifications in David's series carry event specific
information, for example the mount id for mount notifications
and the libmount fsinfo() implementation is written to use the
mount id (lowest overhead lookup option), so there has to be
significant improvement for this case.

But systemd has it's own notifications handling code so there
will need to be non-trivial changes there as well as changes
in libmount.

Bottom line is we have a bit of a challenge with this because we
are trying to change coding practices developed over many years
that, necessarily, use a load/traverse method and it's going to
take quite a while to change these coding practices.

My question is, is there something specific, besides what we are
doing, that you'd like to see done now in order to get the series
merged?

Ian

