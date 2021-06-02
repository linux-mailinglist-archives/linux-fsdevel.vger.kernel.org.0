Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68679398777
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 12:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhFBLAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 07:00:00 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55835 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230257AbhFBK7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:59:04 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 881EA580848;
        Wed,  2 Jun 2021 06:57:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 02 Jun 2021 06:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        hicz7SF3oGEqmbc00AwySe4ddZzZcswVvfWIu4CzVnk=; b=SnKT/O+Z5heYCfrt
        Tx0VoD5AVLmZ0gXtXuqCTgTJDBb8DN2aPVn5CI/s9MoGtJoT+oBG5YoiMcwmuJSZ
        t6tmqmJQjVhIBmQTlH50LGS9u326oZnoNWZuTxMjigZQRtEfWxNSs4legmSakaK0
        RN2cWLl6m5C/q45Tn5m3mXCwPlojxnVl4dFVxLfiv1RmDuTDgEQzNvuBMTi614ZT
        fX3zilBaai5VRDd0kUr4AqbIszkbqHBGZuxZveu41BJTBUQqe0GujD3v2CTID3iG
        8RwQCeXVgayuCQ5WBQRtzABtNgr1xYAADpnW//qm9GeMUYogWcrznhCL5NuXnnZz
        3OCM6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=hicz7SF3oGEqmbc00AwySe4ddZzZcswVvfWIu4CzV
        nk=; b=WLk6P9DnxFXIO5eCVZG/ZvpUjQNdk0XG1LdHpN7RbmhRA8SosrtkyvxQX
        1iecKLu/pyYOnYL5rOR+slQyBIXAXe/KrFQBteP780467vkEtkRgm59Qvq6zousv
        Eh3rCPh5msm676vouIsqknn5wv9hRxqCionG/eiJZLdhZz8apCYTC/aaZhseUwJP
        FXK+gdAjOfoczFhKnw3wwo+p1qt2qb4BJlv4w30GDMqiCy0PBZzCrRGF+ma1ulyW
        lqKxHmLwQIUMj5Pk0LuviwxzD1/py537Lc92DhHddZf1KLb0qMhbWsS+p/JRLu6t
        ndwGXe2LogTuSNHBUXpre/hqakLRw==
X-ME-Sender: <xms:D2S3YIr9Q5Bh8-VI5rYWDGOlAKH8A1oOhXX1SiqrA34e4Muq4ej-nA>
    <xme:D2S3YOoL6zHIea76kNkZGFYnyC8vErgXzofR8KwrlSAoZ3sng6O0vDKdJiEm0g0oE
    9VNhRBUlPGv>
X-ME-Received: <xmr:D2S3YNOm4EyiwnVHdlKCYuSh_s5GCvvXJojZPZ8yeXSWbrpISWXA7ZlHeKeBKPz9-UtXP7S9SFb7kPxGb3SFHqedSzgSkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeljedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:D2S3YP4F8JpgzfhC64V3FPFG91fxsFliKD5iD4iybthZm8galllFSQ>
    <xmx:D2S3YH6FAKTZX8uuRJnPy4GWTsjy7NomF4wnbFAGJzKdDY7GKvt6nw>
    <xmx:D2S3YPimNiG5JGzVxtPWCtxaSBY7TFXj2XX6Btci8MypYponF17gpA>
    <xmx:EWS3YEGiKkt6CrGa_sFxkiryNuouZkN5ATKj-6ZFMHUYx-EGbCPoDA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jun 2021 06:57:15 -0400 (EDT)
Message-ID: <08388e183b17e70a3383eb38af469125f8643a07.camel@themaw.net>
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
Date:   Wed, 02 Jun 2021 18:57:11 +0800
In-Reply-To: <CAJfpegsLqowjMPCAgsFe6eQK_CeixrevUPyA04V2hdYvc0HpLQ@mail.gmail.com>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
         <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
         <CAJfpeguUj5WKtKZsn_tZZNpiL17ggAPcPBXdpA03aAnjaexWug@mail.gmail.com>
         <972701826ebb1b3b3e00b12cde821b85eebc9749.camel@themaw.net>
         <CAJfpegsLqowjMPCAgsFe6eQK_CeixrevUPyA04V2hdYvc0HpLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-06-02 at 10:58 +0200, Miklos Szeredi wrote:
> On Wed, 2 Jun 2021 at 05:44, Ian Kent <raven@themaw.net> wrote:
> > 
> > On Tue, 2021-06-01 at 14:41 +0200, Miklos Szeredi wrote:
> > > On Fri, 28 May 2021 at 08:34, Ian Kent <raven@themaw.net> wrote:
> > > > 
> > > > If there are many lookups for non-existent paths these negative
> > > > lookups
> > > > can lead to a lot of overhead during path walks.
> > > > 
> > > > The VFS allows dentries to be created as negative and hashed,
> > > > and
> > > > caches
> > > > them so they can be used to reduce the fairly high overhead
> > > > alloc/free
> > > > cycle that occurs during these lookups.
> > > 
> > > Obviously there's a cost associated with negative caching too. 
> > > For
> > > normal filesystems it's trivially worth that cost, but in case of
> > > kernfs, not sure...
> > > 
> > > Can "fairly high" be somewhat substantiated with a microbenchmark
> > > for
> > > negative lookups?
> > 
> > Well, maybe, but anything we do for a benchmark would be totally
> > artificial.
> > 
> > The reason I added this is because I saw appreciable contention
> > on the dentry alloc path in one case I saw.
> 
> If multiple tasks are trying to look up the same negative dentry in
> parallel, then there will be contention on the parent inode lock.
> Was this the issue?   This could easily be reproduced with an
> artificial benchmark.

Not that I remember, I'll need to dig up the sysrq dumps to have a
look and get back to you.

> 
> > > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > > > index 4c69e2af82dac..5151c712f06f5 100644
> > > > --- a/fs/kernfs/dir.c
> > > > +++ b/fs/kernfs/dir.c
> > > > @@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct
> > > > dentry *dentry, unsigned int flags)
> > > >         if (flags & LOOKUP_RCU)
> > > >                 return -ECHILD;
> > > > 
> > > > -       /* Always perform fresh lookup for negatives */
> > > > -       if (d_really_is_negative(dentry))
> > > > -               goto out_bad_unlocked;
> > > > +       mutex_lock(&kernfs_mutex);
> > > > 
> > > >         kn = kernfs_dentry_node(dentry);
> > > > -       mutex_lock(&kernfs_mutex);
> > > > +
> > > > +       /* Negative hashed dentry? */
> > > > +       if (!kn) {
> > > > +               struct kernfs_node *parent;
> > > > +
> > > > +               /* If the kernfs node can be found this is a
> > > > stale
> > > > negative
> > > > +                * hashed dentry so it must be discarded and
> > > > the
> > > > lookup redone.
> > > > +                */
> > > > +               parent = kernfs_dentry_node(dentry->d_parent);
> > > 
> > > This doesn't look safe WRT a racing sys_rename().  In this case
> > > d_move() is called only with parent inode locked, but not with
> > > kernfs_mutex while ->d_revalidate() may not have parent inode
> > > locked.
> > > After d_move() the old parent dentry can be freed, resulting in
> > > use
> > > after free.  Easily fixed by dget_parent().
> > 
> > Umm ... I'll need some more explanation here ...
> > 
> > We are in ref-walk mode so the parent dentry isn't going away.
> 
> The parent that was used to lookup the dentry in __d_lookup() isn't
> going away.  But it's not necessarily equal to dentry->d_parent
> anymore.
> 
> > And this is a negative dentry so rename is going to bail out
> > with ENOENT way early.
> 
> You are right.  But note that negative dentry in question could be
> the
> target of a rename.  Current implementation doesn't switch the
> target's parent or name, but this wasn't always the case (commit
> 076515fc9267 ("make non-exchanging __d_move() copy ->d_parent rather
> than swap them")), so a backport of this patch could become incorrect
> on old enough kernels.

Right, that __lookup_hash() will find the negative target.

> 
> So I still think using dget_parent() is the correct way to do this.

The rename code does my head in, ;)

The dget_parent() would ensure we had an up to date parent so
yes, that would be the right thing to do regardless.

But now I'm not sure that will be sufficient for kernfs. I'm still
thinking about it.

I'm wondering if there's a missing check in there to account for
what happens with revalidate after ->rename() but before move.
There's already a kernfs node check in there so it's probably ok
...
 
> 
> > > 
> > > > +               if (parent) {
> > > > +                       const void *ns = NULL;
> > > > +
> > > > +                       if (kernfs_ns_enabled(parent))
> > > > +                               ns = kernfs_info(dentry->d_sb)-
> > > > >ns;
> > > > +                       kn = kernfs_find_ns(parent, dentry-
> > > > > d_name.name, ns);
> > > 
> > > Same thing with d_name.  There's
> > > take_dentry_name_snapshot()/release_dentry_name_snapshot() to
> > > properly
> > > take care of that.
> > 
> > I don't see that problem either, due to the dentry being negative,
> > but please explain what your seeing here.
> 
> Yeah.  Negative dentries' names weren't always stable, but that was a
> long time ago (commit 8d85b4845a66 ("Allow sharing external names
> after __d_move()")).

Right, I'll make that change too.

> 
> Thanks,
> Miklos


