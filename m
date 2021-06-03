Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0939AEEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 01:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFCX7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 19:59:40 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:49251 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFCX7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:59:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 994A3E14;
        Thu,  3 Jun 2021 19:57:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Jun 2021 19:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        dmiAczoWlOvQnmmC04pzx+Xz0r8ekAJSbv8Td3zeOlg=; b=OcozWK6buUWWRUVP
        GmtfIcDT0rFj6FHJBmkR1k2sCTfORlynbfT0E6n9N7p4yKjkJZPFM9NG6JGeWIyh
        foXbIIIaAP8Wqh/xRCrB13UdYqH15uyY6b6Dbmlbw+8bR/nmZOQR6S+IjkcaJHPz
        UIkCKUI0NSYpEmDjCkxMoGlAJgguUNAIGRGGtpK0DgvkoARpr+AjJzdEbdFTJKkD
        XoGEKkvR7LTom7Ms/4bJRsWypppN15MVeNFMYnEqBO5tmNIanVY5V+KUrpInKZ4i
        kBecRagA4r1euS4XZ3W+K3nxeJPoeesrGFK61+Pv9orWx7ZVaAkkp2zIpa+m8pB7
        iBs5+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=dmiAczoWlOvQnmmC04pzx+Xz0r8ekAJSbv8Td3zeO
        lg=; b=Y+p8e1mxu3USMyihm3MvVe9Pt120bFTx5XtCPAC6MqANAU2ZhVhonjv4r
        UgAyvIPaTs/I20JvsLwXDtdm5mDy81utiS7DxmkOYQcykAFagMTZ+pJDkhNE+vgd
        kdFr3TnYdojhFgIZrbYfI1aYSf8t+w0qdti3F9uSW1wsLeX8Ulz1RfItmnN+hJ0g
        72vO+U1W4yqj0A+A7L6gJSLvPHwltPJCtzD/sh5/3KtWJ9+FQMMkAfNNtsWaOD9p
        HzZNUC44fG4+bEilGOPbXcGCeiBEPUIQB0KZ5jlkkfIv+zVe8yYIkOnZqLuHCXnj
        oGfa2R5e/QKO8P0Ke0A+EU3kT5MjQ==
X-ME-Sender: <xms:gGy5YM5F6D1jmWFDEKs8Xe94UqWieL6ZSbHNJIJxjSUhlyR0KIrQZQ>
    <xme:gGy5YN7oelA8aAbTXEkhp6MSQeFtGuhM5r42QP-_H2P8P5MDR1I27ZKtqc0lc56K7
    ShZ2JBfx6-Y>
X-ME-Received: <xmr:gGy5YLfylNkJAR3c5e5XhGCuqCwRakHxSLHJ1ukcelhCbSc0LK55i9h8g9sEHQsnWP_bo_0G6vBKTq6K7EWBMxSifOxFovy9q3fkUSMuT_ZArWVSHNmEHQp2iFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedttddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:gGy5YBIuEy4iByeelGuc3pKiOxt_lsjLBPZeOpEi4z6uX7KcKwuvew>
    <xmx:gGy5YAKOaip2temNzSPFpbHMlu17J4gbzZxsrlEqpNPjKX9qyUP59Q>
    <xmx:gGy5YCzfsvGCmyzBPseWPgNAFJ5LJAggxBvQPuSaJX6SArsmHKIahQ>
    <xmx:gWy5YFX3d5a9-zFRYjNo_pyz4-3Io3an58iPzxK_oRddwjyXjA7HOyC6wI4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jun 2021 19:57:47 -0400 (EDT)
Message-ID: <d4554297b41148c7cc5eba1c9c16c5aa4a93d7e3.camel@themaw.net>
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Jun 2021 07:57:43 +0800
In-Reply-To: <32069e28a520c29773ebc24e248823d45ebb50b3.camel@themaw.net>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
         <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
         <CAJfpeguUj5WKtKZsn_tZZNpiL17ggAPcPBXdpA03aAnjaexWug@mail.gmail.com>
         <972701826ebb1b3b3e00b12cde821b85eebc9749.camel@themaw.net>
         <CAJfpegsLqowjMPCAgsFe6eQK_CeixrevUPyA04V2hdYvc0HpLQ@mail.gmail.com>
         <08388e183b17e70a3383eb38af469125f8643a07.camel@themaw.net>
         <32069e28a520c29773ebc24e248823d45ebb50b3.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-06-03 at 10:15 +0800, Ian Kent wrote:
> On Wed, 2021-06-02 at 18:57 +0800, Ian Kent wrote:
> > On Wed, 2021-06-02 at 10:58 +0200, Miklos Szeredi wrote:
> > > On Wed, 2 Jun 2021 at 05:44, Ian Kent <raven@themaw.net> wrote:
> > > > 
> > > > On Tue, 2021-06-01 at 14:41 +0200, Miklos Szeredi wrote:
> > > > > On Fri, 28 May 2021 at 08:34, Ian Kent <raven@themaw.net>
> > > > > wrote:
> > > > > > 
> > > > > > If there are many lookups for non-existent paths these
> > > > > > negative
> > > > > > lookups
> > > > > > can lead to a lot of overhead during path walks.
> > > > > > 
> > > > > > The VFS allows dentries to be created as negative and
> > > > > > hashed,
> > > > > > and
> > > > > > caches
> > > > > > them so they can be used to reduce the fairly high overhead
> > > > > > alloc/free
> > > > > > cycle that occurs during these lookups.
> > > > > 
> > > > > Obviously there's a cost associated with negative caching
> > > > > too. 
> > > > > For
> > > > > normal filesystems it's trivially worth that cost, but in
> > > > > case
> > > > > of
> > > > > kernfs, not sure...
> > > > > 
> > > > > Can "fairly high" be somewhat substantiated with a
> > > > > microbenchmark
> > > > > for
> > > > > negative lookups?
> > > > 
> > > > Well, maybe, but anything we do for a benchmark would be
> > > > totally
> > > > artificial.
> > > > 
> > > > The reason I added this is because I saw appreciable contention
> > > > on the dentry alloc path in one case I saw.
> > > 
> > > If multiple tasks are trying to look up the same negative dentry
> > > in
> > > parallel, then there will be contention on the parent inode lock.
> > > Was this the issue?   This could easily be reproduced with an
> > > artificial benchmark.
> > 
> > Not that I remember, I'll need to dig up the sysrq dumps to have a
> > look and get back to you.
> 
> After doing that though I could grab Fox Chen's reproducer and give
> it varying sysfs paths as well as some percentage of non-existent
> sysfs paths and see what I get ...
> 
> That should give it a more realistic usage profile and, if I can
> get the percentage of non-existent paths right, demonstrate that
> case as well ... but nothing is easy, so we'll have to wait and
> see, ;)

Ok, so I grabbed Fox's benckmark repo. and used a non-existent path
to check the negative dentry contention.

I've taken the baseline readings and the contention is see is the
same as I originally saw. It's with d_alloc_parallel() on lockref.

While I haven't run the patched check I'm pretty sure that using
dget_parent() and taking a snapshot will move the contention to
that. So if I do retain the negative dentry caching change I would
need to use the dentry seq lock for it to be useful.

Thoughts Miklos, anyone?

> 
> > 
> > > 
> > > > > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > > > > > index 4c69e2af82dac..5151c712f06f5 100644
> > > > > > --- a/fs/kernfs/dir.c
> > > > > > +++ b/fs/kernfs/dir.c
> > > > > > @@ -1037,12 +1037,33 @@ static int
> > > > > > kernfs_dop_revalidate(struct
> > > > > > dentry *dentry, unsigned int flags)
> > > > > >         if (flags & LOOKUP_RCU)
> > > > > >                 return -ECHILD;
> > > > > > 
> > > > > > -       /* Always perform fresh lookup for negatives */
> > > > > > -       if (d_really_is_negative(dentry))
> > > > > > -               goto out_bad_unlocked;
> > > > > > +       mutex_lock(&kernfs_mutex);
> > > > > > 
> > > > > >         kn = kernfs_dentry_node(dentry);
> > > > > > -       mutex_lock(&kernfs_mutex);
> > > > > > +
> > > > > > +       /* Negative hashed dentry? */
> > > > > > +       if (!kn) {
> > > > > > +               struct kernfs_node *parent;
> > > > > > +
> > > > > > +               /* If the kernfs node can be found this is
> > > > > > a
> > > > > > stale
> > > > > > negative
> > > > > > +                * hashed dentry so it must be discarded
> > > > > > and
> > > > > > the
> > > > > > lookup redone.
> > > > > > +                */
> > > > > > +               parent = kernfs_dentry_node(dentry-
> > > > > > > d_parent);
> > > > > 
> > > > > This doesn't look safe WRT a racing sys_rename().  In this
> > > > > case
> > > > > d_move() is called only with parent inode locked, but not
> > > > > with
> > > > > kernfs_mutex while ->d_revalidate() may not have parent inode
> > > > > locked.
> > > > > After d_move() the old parent dentry can be freed, resulting
> > > > > in
> > > > > use
> > > > > after free.  Easily fixed by dget_parent().
> > > > 
> > > > Umm ... I'll need some more explanation here ...
> > > > 
> > > > We are in ref-walk mode so the parent dentry isn't going away.
> > > 
> > > The parent that was used to lookup the dentry in __d_lookup()
> > > isn't
> > > going away.  But it's not necessarily equal to dentry->d_parent
> > > anymore.
> > > 
> > > > And this is a negative dentry so rename is going to bail out
> > > > with ENOENT way early.
> > > 
> > > You are right.  But note that negative dentry in question could
> > > be
> > > the
> > > target of a rename.  Current implementation doesn't switch the
> > > target's parent or name, but this wasn't always the case (commit
> > > 076515fc9267 ("make non-exchanging __d_move() copy ->d_parent
> > > rather
> > > than swap them")), so a backport of this patch could become
> > > incorrect
> > > on old enough kernels.
> > 
> > Right, that __lookup_hash() will find the negative target.
> > 
> > > 
> > > So I still think using dget_parent() is the correct way to do
> > > this.
> > 
> > The rename code does my head in, ;)
> > 
> > The dget_parent() would ensure we had an up to date parent so
> > yes, that would be the right thing to do regardless.
> > 
> > But now I'm not sure that will be sufficient for kernfs. I'm still
> > thinking about it.
> > 
> > I'm wondering if there's a missing check in there to account for
> > what happens with revalidate after ->rename() but before move.
> > There's already a kernfs node check in there so it's probably ok
> > ...
> >  
> > > 
> > > > > 
> > > > > > +               if (parent) {
> > > > > > +                       const void *ns = NULL;
> > > > > > +
> > > > > > +                       if (kernfs_ns_enabled(parent))
> > > > > > +                               ns = kernfs_info(dentry-
> > > > > > > d_sb)-
> > > > > > > ns;
> > > > > > +                       kn = kernfs_find_ns(parent, dentry-
> > > > > > > d_name.name, ns);
> > > > > 
> > > > > Same thing with d_name.  There's
> > > > > take_dentry_name_snapshot()/release_dentry_name_snapshot() to
> > > > > properly
> > > > > take care of that.
> > > > 
> > > > I don't see that problem either, due to the dentry being
> > > > negative,
> > > > but please explain what your seeing here.
> > > 
> > > Yeah.  Negative dentries' names weren't always stable, but that
> > > was
> > > a
> > > long time ago (commit 8d85b4845a66 ("Allow sharing external names
> > > after __d_move()")).
> > 
> > Right, I'll make that change too.
> > 
> > > 
> > > Thanks,
> > > Miklos
> > 
> 


