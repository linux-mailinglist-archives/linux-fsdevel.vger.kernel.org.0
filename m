Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53E39AF5E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFDBJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:09:40 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:42241 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229835AbhFDBJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:09:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 8283DE0E;
        Thu,  3 Jun 2021 21:07:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 03 Jun 2021 21:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        RnP+G0MOC4BWQShW/S2PpVCbkxxTo6DAXcKcg8vNLGY=; b=QsFXzOjoHSCGnBWl
        WAgc5dJIicU/sjq1+RqZzaTTfY01RFW7/eOfjCFF44PRIReW4tr1MJDdXla4YtbH
        My+4ZHZGXZYhTzxupavTzm1sbPfe1lCoK2svFyD1pFWxgTGvJ9ZJDr1JEEDVddaY
        dt8Qe84Z09JVlrTR8RQPM1UNcaSqHx0KzOz3A4yDvPEbuOgW6u1lrH+Gtuygx0ue
        lzLnYiqw1vaPzQ8+nu6iCag33tcR2uc6UL0ZkXC7toNVOAEtrJKZnF344MTkCsZN
        0tjK7aJkywnHnqptNpcvVqPU4KjrbRLGPK6Tg9Hr1ucztjdVu6KC0Z7xXP5S+Bk0
        O3Sk8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=RnP+G0MOC4BWQShW/S2PpVCbkxxTo6DAXcKcg8vNL
        GY=; b=UN9WmFV1EaW1T+i8+Dx49590PsXiCISPMCU6mQklL3mNP853q0ztJeTVv
        g3hu3vCErLFSOrgO61soeIIlKVeYgscRdGgn1rpwbzSzTlEe3JGMkxnwJtU1E21M
        vYarmb1zg2J/GkORol+eYmVAH7/IgcgOQ0eElWf+L6zuhCqEC/Ix+fjpgm4Xcd5j
        ImJrjUQRyASx/7XrYCtwDTJctC7cg6tMnklyxxZduxv+1rig0Ca92SMlxARxLgDI
        mojRvWEeqFiFaIandgB9wUk3auMb1GpC4xGpl8PUZkpnwBPgwdMLMCRaYs5RXW3n
        Zi1UHcINXXvXT964Meno2aKCuf1vw==
X-ME-Sender: <xms:6Hy5YEIgAUh0R9b8qoz0CwScG_XNezhv5nZHwU3FMXJ7Xpny_7FCog>
    <xme:6Hy5YEIkROzbZCKaZIN6l5LZs0O6jW0IzJAlp3ULYfu_yfmJdGf6CFoT3vYk1QtHD
    dgUKJOpJiQZ>
X-ME-Received: <xmr:6Hy5YEsUz3EgobeaDv2P1waUA7nvJP-doKPT6R8bDqtn9oeCYxp5Towaw2OdJHk8rD-6LkG0GQ-b08U4dXoOdoHsxX0siJF3LHqXws-HW80QNvpVxZZ9DBoV8xc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedttddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:6Hy5YBZyboUQEHXV8r1fFqa3MziuyKnebb7t66pMXWasSfHnCJMnfw>
    <xmx:6Hy5YLYbEoc0g-nOR0Tl4_WbQBMH1TUug3cAGpGxLAD21holtTik7g>
    <xmx:6Hy5YNDsSaiG4DFbfIkerRp_FBpqNNaBfmEj9x76dh-bm-jxYcP4Gg>
    <xmx:6Xy5YFlE_Mxwoni4coqQN_8FJN0LOIF7LUUncic0gof3_OqzLg8Il0sZlDs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jun 2021 21:07:47 -0400 (EDT)
Message-ID: <922c747c22b05a80a8350ac87b839eed0c79581f.camel@themaw.net>
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
Date:   Fri, 04 Jun 2021 09:07:43 +0800
In-Reply-To: <d4554297b41148c7cc5eba1c9c16c5aa4a93d7e3.camel@themaw.net>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
         <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
         <CAJfpeguUj5WKtKZsn_tZZNpiL17ggAPcPBXdpA03aAnjaexWug@mail.gmail.com>
         <972701826ebb1b3b3e00b12cde821b85eebc9749.camel@themaw.net>
         <CAJfpegsLqowjMPCAgsFe6eQK_CeixrevUPyA04V2hdYvc0HpLQ@mail.gmail.com>
         <08388e183b17e70a3383eb38af469125f8643a07.camel@themaw.net>
         <32069e28a520c29773ebc24e248823d45ebb50b3.camel@themaw.net>
         <d4554297b41148c7cc5eba1c9c16c5aa4a93d7e3.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-06-04 at 07:57 +0800, Ian Kent wrote:
> On Thu, 2021-06-03 at 10:15 +0800, Ian Kent wrote:
> > On Wed, 2021-06-02 at 18:57 +0800, Ian Kent wrote:
> > > On Wed, 2021-06-02 at 10:58 +0200, Miklos Szeredi wrote:
> > > > On Wed, 2 Jun 2021 at 05:44, Ian Kent <raven@themaw.net> wrote:
> > > > > 
> > > > > On Tue, 2021-06-01 at 14:41 +0200, Miklos Szeredi wrote:
> > > > > > On Fri, 28 May 2021 at 08:34, Ian Kent <raven@themaw.net>
> > > > > > wrote:
> > > > > > > 
> > > > > > > If there are many lookups for non-existent paths these
> > > > > > > negative
> > > > > > > lookups
> > > > > > > can lead to a lot of overhead during path walks.
> > > > > > > 
> > > > > > > The VFS allows dentries to be created as negative and
> > > > > > > hashed,
> > > > > > > and
> > > > > > > caches
> > > > > > > them so they can be used to reduce the fairly high
> > > > > > > overhead
> > > > > > > alloc/free
> > > > > > > cycle that occurs during these lookups.
> > > > > > 
> > > > > > Obviously there's a cost associated with negative caching
> > > > > > too. 
> > > > > > For
> > > > > > normal filesystems it's trivially worth that cost, but in
> > > > > > case
> > > > > > of
> > > > > > kernfs, not sure...
> > > > > > 
> > > > > > Can "fairly high" be somewhat substantiated with a
> > > > > > microbenchmark
> > > > > > for
> > > > > > negative lookups?
> > > > > 
> > > > > Well, maybe, but anything we do for a benchmark would be
> > > > > totally
> > > > > artificial.
> > > > > 
> > > > > The reason I added this is because I saw appreciable
> > > > > contention
> > > > > on the dentry alloc path in one case I saw.
> > > > 
> > > > If multiple tasks are trying to look up the same negative
> > > > dentry
> > > > in
> > > > parallel, then there will be contention on the parent inode
> > > > lock.
> > > > Was this the issue?   This could easily be reproduced with an
> > > > artificial benchmark.
> > > 
> > > Not that I remember, I'll need to dig up the sysrq dumps to have
> > > a
> > > look and get back to you.
> > 
> > After doing that though I could grab Fox Chen's reproducer and give
> > it varying sysfs paths as well as some percentage of non-existent
> > sysfs paths and see what I get ...
> > 
> > That should give it a more realistic usage profile and, if I can
> > get the percentage of non-existent paths right, demonstrate that
> > case as well ... but nothing is easy, so we'll have to wait and
> > see, ;)
> 
> Ok, so I grabbed Fox's benckmark repo. and used a non-existent path
> to check the negative dentry contention.
> 
> I've taken the baseline readings and the contention is see is the
> same as I originally saw. It's with d_alloc_parallel() on lockref.
> 
> While I haven't run the patched check I'm pretty sure that using
> dget_parent() and taking a snapshot will move the contention to
> that. So if I do retain the negative dentry caching change I would
> need to use the dentry seq lock for it to be useful.
> 
> Thoughts Miklos, anyone?

Mmm ... never mind, I'd still need to take a snapshot anyway and
dget_parent() looks lightweight if there's no conflict. I will
need to test it.

> 
> > 
> > > 
> > > > 
> > > > > > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > > > > > > index 4c69e2af82dac..5151c712f06f5 100644
> > > > > > > --- a/fs/kernfs/dir.c
> > > > > > > +++ b/fs/kernfs/dir.c
> > > > > > > @@ -1037,12 +1037,33 @@ static int
> > > > > > > kernfs_dop_revalidate(struct
> > > > > > > dentry *dentry, unsigned int flags)
> > > > > > >         if (flags & LOOKUP_RCU)
> > > > > > >                 return -ECHILD;
> > > > > > > 
> > > > > > > -       /* Always perform fresh lookup for negatives */
> > > > > > > -       if (d_really_is_negative(dentry))
> > > > > > > -               goto out_bad_unlocked;
> > > > > > > +       mutex_lock(&kernfs_mutex);
> > > > > > > 
> > > > > > >         kn = kernfs_dentry_node(dentry);
> > > > > > > -       mutex_lock(&kernfs_mutex);
> > > > > > > +
> > > > > > > +       /* Negative hashed dentry? */
> > > > > > > +       if (!kn) {
> > > > > > > +               struct kernfs_node *parent;
> > > > > > > +
> > > > > > > +               /* If the kernfs node can be found this
> > > > > > > is
> > > > > > > a
> > > > > > > stale
> > > > > > > negative
> > > > > > > +                * hashed dentry so it must be discarded
> > > > > > > and
> > > > > > > the
> > > > > > > lookup redone.
> > > > > > > +                */
> > > > > > > +               parent = kernfs_dentry_node(dentry-
> > > > > > > > d_parent);
> > > > > > 
> > > > > > This doesn't look safe WRT a racing sys_rename().  In this
> > > > > > case
> > > > > > d_move() is called only with parent inode locked, but not
> > > > > > with
> > > > > > kernfs_mutex while ->d_revalidate() may not have parent
> > > > > > inode
> > > > > > locked.
> > > > > > After d_move() the old parent dentry can be freed,
> > > > > > resulting
> > > > > > in
> > > > > > use
> > > > > > after free.  Easily fixed by dget_parent().
> > > > > 
> > > > > Umm ... I'll need some more explanation here ...
> > > > > 
> > > > > We are in ref-walk mode so the parent dentry isn't going
> > > > > away.
> > > > 
> > > > The parent that was used to lookup the dentry in __d_lookup()
> > > > isn't
> > > > going away.  But it's not necessarily equal to dentry->d_parent
> > > > anymore.
> > > > 
> > > > > And this is a negative dentry so rename is going to bail out
> > > > > with ENOENT way early.
> > > > 
> > > > You are right.  But note that negative dentry in question could
> > > > be
> > > > the
> > > > target of a rename.  Current implementation doesn't switch the
> > > > target's parent or name, but this wasn't always the case
> > > > (commit
> > > > 076515fc9267 ("make non-exchanging __d_move() copy ->d_parent
> > > > rather
> > > > than swap them")), so a backport of this patch could become
> > > > incorrect
> > > > on old enough kernels.
> > > 
> > > Right, that __lookup_hash() will find the negative target.
> > > 
> > > > 
> > > > So I still think using dget_parent() is the correct way to do
> > > > this.
> > > 
> > > The rename code does my head in, ;)
> > > 
> > > The dget_parent() would ensure we had an up to date parent so
> > > yes, that would be the right thing to do regardless.
> > > 
> > > But now I'm not sure that will be sufficient for kernfs. I'm
> > > still
> > > thinking about it.
> > > 
> > > I'm wondering if there's a missing check in there to account for
> > > what happens with revalidate after ->rename() but before move.
> > > There's already a kernfs node check in there so it's probably ok
> > > ...
> > >  
> > > > 
> > > > > > 
> > > > > > > +               if (parent) {
> > > > > > > +                       const void *ns = NULL;
> > > > > > > +
> > > > > > > +                       if (kernfs_ns_enabled(parent))
> > > > > > > +                               ns = kernfs_info(dentry-
> > > > > > > > d_sb)-
> > > > > > > > ns;
> > > > > > > +                       kn = kernfs_find_ns(parent,
> > > > > > > dentry-
> > > > > > > > d_name.name, ns);
> > > > > > 
> > > > > > Same thing with d_name.  There's
> > > > > > take_dentry_name_snapshot()/release_dentry_name_snapshot()
> > > > > > to
> > > > > > properly
> > > > > > take care of that.
> > > > > 
> > > > > I don't see that problem either, due to the dentry being
> > > > > negative,
> > > > > but please explain what your seeing here.
> > > > 
> > > > Yeah.  Negative dentries' names weren't always stable, but that
> > > > was
> > > > a
> > > > long time ago (commit 8d85b4845a66 ("Allow sharing external
> > > > names
> > > > after __d_move()")).
> > > 
> > > Right, I'll make that change too.
> > > 
> > > > 
> > > > Thanks,
> > > > Miklos
> > > 
> > 
> 


