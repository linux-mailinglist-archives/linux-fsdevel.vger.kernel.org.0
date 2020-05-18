Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA01D7521
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 12:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgERK05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 06:26:57 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48791 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgERK05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 06:26:57 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 32DEB7DA;
        Mon, 18 May 2020 06:26:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 May 2020 06:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        nj84T2AgGMFdKx/IlmKijpQnstWkieyPqiag9D9uTp8=; b=HPwW5NNiB3aNO8sJ
        RXkx+/Kd3P2FLHI6M5pQbHHNyZY8mJX95CIsK/M3uVHW8crueq73NM5y2D5muyAT
        aUAy99V/uG681/cYyPfTwWGaXk5kRO8hSjsiSBEUSTrtfnd7NlYfgabb+d5co7ij
        j/jnDa1FZC5UHn8uK/EzeVpwsuDVdBEAPTR/ce8ABLN1K5ou2c9bc7vJhay0Qi/s
        /phZ8+GSWSjsBnK4O5hmO9c5DiX6ZD1zs5tv6fX5Pb1S/ev36ngZUEIVWgNCWvhD
        lxJJI1DFzDaaIQlsFSaJapBV+lW8qv+3P7qZtXB+RXRXZ+EYsDCZMdYHiXds1Jij
        6bec0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=nj84T2AgGMFdKx/IlmKijpQnstWkieyPqiag9D9uT
        p8=; b=fynj+e6ZtZwJeMRLHrbIDok9DHXBGYS/zECRCftKW5uyBXjz86s5SKR0f
        D0VZRLfqsTyT5EawJlkAtUqk6l5Jy0P5cmG2SoHrG+SxP0Za1+1hEFn98ESA6SUy
        EhijXDdtMs50ULVbehFwsiBpXVkt0uyxq1/2LMQg7IJT4X9Xe/Ul83N/eVgFqA9G
        1XvThX35XyAMlPtpq52wL1rLlQ8z6dy/X/fvh8In0JoJXOuCdPuoFQWvUPyE8aIW
        /YNjD3n6T3C0qHzQRVHSFNk1SirlOXNofdG1XYYPWyydPiW7v+ZcKLKooK6JFckD
        oaKN3H4nLkwCibx56Hk8SBAjNf4Zw==
X-ME-Sender: <xms:7mLCXjiZ5gsS6XgnuW34cWZZ3MUQlSg-iqFPadSc8ZH-r_6MHtxSew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddthedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddukedrvddtkedrudekiedrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:7mLCXgCpbVYMEPCsKh5X6d_sFM6ZRJP_eGA8WDLNYUJ__D_ZYvy_nw>
    <xmx:7mLCXjFN5xUeQbeEPuJLOtxF3--0sAOywQsj0s3hn0gNtU4T9vBRQg>
    <xmx:7mLCXgRQ5Q7NM50DQKTh65-v6E84rAM-XPZ2py0BsubIl-PcpMB2fg>
    <xmx:72LCXtrXLIDnlyjOpnBaxnX7g7Yu8OGWtOAmKOlvxDAxSbi8q5wBVw>
Received: from mickey.themaw.net (unknown [118.208.186.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F5CF30663EF;
        Mon, 18 May 2020 06:26:52 -0400 (EDT)
Message-ID: <cfc4e94f6667eabee664b63cc23051e9d816456c.camel@themaw.net>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
From:   Ian Kent <raven@themaw.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Date:   Mon, 18 May 2020 18:26:48 +0800
In-Reply-To: <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
References: <20200515072047.31454-1-cgxu519@mykernel.net>
         <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
         <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-05-18 at 08:27 +0300, Amir Goldstein wrote:
> On Mon, May 18, 2020 at 3:53 AM Ian Kent <raven@themaw.net> wrote:
> > On Fri, 2020-05-15 at 15:20 +0800, Chengguang Xu wrote:
> > > This series adds a new lookup flag LOOKUP_DONTCACHE_NEGATIVE
> > > to indicate to drop negative dentry in slow path of lookup.
> > > 
> > > In overlayfs, negative dentries in upper/lower layers are useless
> > > after construction of overlayfs' own dentry, so in order to
> > > effectively reclaim those dentries, specify
> > > LOOKUP_DONTCACHE_NEGATIVE
> > > flag when doing lookup in upper/lower layers.
> > 
> > I've looked at this a couple of times now.
> > 
> > I'm not at all sure of the wisdom of adding a flag to a VFS
> > function
> > that allows circumventing what a file system chooses to do.
> 
> But it is not really a conscious choice is it?

I thought that too until recently when I had the need to ask the
question "how do these negative hashed dentries get into the dcache.

> How exactly does a filesystem express its desire to cache a negative
> dentry? The documentation of lookup() in vfs.rst makes it clear that
> it is not up to the filesystem to make that decision.

That's the question I had too and, somewhat embarrassingly, got
a response that started with "Are you serious ..." for Al when
I made a claim that ext4 doesn't create negative hashed dentries.

What was so bad about that claim is it's really obvious that ext4
does do this in ext4/namei.c:ext4_lookup():

...
inode = NULL;
if (bh) {
...
}
...
return d_splice_alias(inode, dentry);

and inode can be negative here.

Now d_splice_alias() is pretty complicated but, if passed a NULL
dentry it amounts to calling __d_add(dentry, NULL) which produces
a negative hashed dentry, a decision made by ext4 ->lookup() (and
I must say typical of the very few ways such dentries get into
the dcache).

Now on final dput of the walk these dentries should end up with a
reference count of zero which triggers dput() to add them to the
lru list so they can be considered as prune targets and can be
found in subsequent lookups (they are hashed).

This is how using negative hashed detries helps to avoid the
expensive alloc/free (at least) that occurs when looking up paths
that don't exist.

Negative "unhashed" dentries are discarded on final dput() so
don't really come into the picture except that dropping a negative
hashed dentry will cause it to be discarded on final dput().

But nothing is ever quite as simple as a description of how it
appears to (is meant to) work so, by all means, take what I say
with a grain of salt, ;)

> The VFS needs to cache the negative dentry on lookup(), so
> it can turn it positive on create().
> Low level kernel modules that call the VFS lookup() might know
> that caching the negative dentry is counter productive.
> 
> > I also do really see the need for it because only hashed negative
> > dentrys will be retained by the VFS so, if you see a hashed
> > negative
> > dentry then you can cause it to be discarded on release of the last
> > reference by dropping it.
> > 
> > So what's different here, why is adding an argument to do that drop
> > in the VFS itself needed instead of just doing it in overlayfs?
> 
> That was v1 patch. It was dealing with the possible race of
> returned negative dentry becoming positive before dropping it
> in an intrusive manner.

Right, very much something that overlay fs must care about, file
systems not so much.

It might be possible to assume that if the underlying file system
->lookup() call has produced a negative hashed dentry that it will
stay negative. That assumption definitely can't be made for negative
unhashed dentries, of course, since they may still be in the process
of being filled in.

But, unfortunately, I see your point, it's a risky assumption.

> 
> In retrospect, I think this race doesn't matter and there is no
> harm in dropping a positive dentry in a race obviously caused by
> accessing the underlying layer, which as documented results in
> "undefined behavior".

Umm ... I thought we were talking about negative dentries ...

Ian

