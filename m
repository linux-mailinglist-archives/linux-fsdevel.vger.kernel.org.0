Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6052EA078
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 00:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbhADXK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 18:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbhADXK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 18:10:57 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24022C061574;
        Mon,  4 Jan 2021 15:10:17 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n142so25050497qkn.2;
        Mon, 04 Jan 2021 15:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HL0eCLf7qTv1houjKh867Gt3xurobs5TgCxsQf6phbg=;
        b=jpvBOutmrw5mDNF8d3ZAf9D+WAnrrNmHv00AwztR99DISuFQqiNqV08dPNavz/S6jz
         M2EDGzn2dXF27myxFxxdQcuvx1ReCplZ/mqMni2Jh8zu7yEKp/HcUM86U1H8GDsDAaMi
         LUeZHe7Jmmk+Gd4j9n3sWPYcUaZ3n5MChuP/v6+MxVGiC0Dn/Nyojm2eqnap8rsjE84U
         O8UNS1c2PicsU7VWpcML7EGMyC0ghWcrvyPMexpRxJnnn3jIfuu+/Krpmy0bwZRR6q5T
         aJUrQ/Ims7PL+Mqom3Bc1Enuo28tzZx6j70HORt6quynp1P56+PRRk3GzaIaYmHvl4B2
         5uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HL0eCLf7qTv1houjKh867Gt3xurobs5TgCxsQf6phbg=;
        b=F24PvFbmtYovz7M7u29XyoYkvVW/8mu/hGmVh8vxaMZ27RvOxzxE7xPh+qGZv4NdZ2
         mP2o3MGZHUDknQu9qtktSVHgB+XiKSKbmsy4xzJBl3Fevrmm3gKCLxNjZ+dNBQHj1IjT
         td3ClHyEz6cZb7s2oeo1tIh3LFUGO0EyowXmjUGUg0oS57ATjG71UXdBkWheR2LTD27x
         vERPRVO3wH+QnbKptzCisfwQ7nEZvtGMucfOlBpUcp3glVnWu1RKpWUK+kprfGWgczVy
         OcmhGOwM3DEEokSqIgR5aNzR5bdKilNSOiwj3aCGCfagewcJnUo6YUdQK6fOGENtmQ//
         Ccrw==
X-Gm-Message-State: AOAM533x4XjYlQPkO/Lx91/MoC0w//vxHniZ2e5JYzVY26mLWQRLEang
        VMPYmvjNlScF+Ie98X0A6hV3J9vo+94xxZ2xtiqsi5DuP1Q=
X-Google-Smtp-Source: ABdhPJy0S030vDk8swA8GdoscglpHp7fnEMw5TUkjEcEJLNVHQr3z1gfijr1f4np/zh99Bdeq7ViVumgzXHeqMfb7xw=
X-Received: by 2002:a02:b607:: with SMTP id h7mr65117661jam.120.1609796583311;
 Mon, 04 Jan 2021 13:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20201221195055.35295-4-vgoyal@redhat.com> <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org> <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org> <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org> <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20210104151424.GA63879@redhat.com> <CAOQ4uxgiC5Wm+QqD+vbmzkFvEqG6yvKYe_4sR7ZUVfu-=Ys9oQ@mail.gmail.com>
 <20210104154015.GA73873@redhat.com>
In-Reply-To: <20210104154015.GA73873@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 4 Jan 2021 23:42:51 +0200
Message-ID: <CAOQ4uxhYXeUt2iggM3oubdgr91QPNhUg2PdN128gRvR3rQoy1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 4, 2021 at 5:40 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Jan 04, 2021 at 05:22:07PM +0200, Amir Goldstein wrote:
> > > > Since Jeff's patch is minimal, I think that it should be the fix applied
> > > > first and proposed for stable (with adaptations for non-volatile overlay).
> > >
> > > Does stable fix has to be same as mainline fix. IOW, I think atleast in
> > > mainline we should first fix it the right way and then think how to fix
> > > it for stable. If fixes taken in mainline are not realistic for stable,
> > > can we push a different small fix just for stable?
> >
> > We can do a lot of things.
> > But if we are able to create a series with minimal (and most critical) fixes
> > followed by other fixes, it would be easier for everyone involved.
>
> I am not sure this is really critical. writeback error reporting for
> overlayfs are broken since the beginning for regular mounts. There is no
> notion of these errors being reported to user space. If that did not
> create a major issue, then why suddenly volatile mounts make it
> a critical issue.
>

Volatile mounts didn't make this a critical issue.
But this discussion made us notice a mildly serious issue.
It is not surprising to me that users did not report this issue.
Do you know what it takes for a user to notice that writeback had failed,
but an application did fsync and error did not get reported?
Filesystem durability guaranties are hard to prove especially with so
many subsystem layers and with fsync that does return an error correctly.
I once found a durability bug in fsync of xfs that existed for 12 years.
That fact does not at all make it any less critical.

> To me we should fix the issue properly which is easy to maintain
> down the line and then worry about doing a stable fix if need be.
>
> >
> > >
> > > IOW, because we have to push a fix in stable, should not determine
> > > what should be problem solution for mainline, IMHO.
> > >
> >
> > I find in this case there is a correlation between the simplest fix and the
> > most relevant fix for stable.
> >
> > > The porblem I have with Jeff's fix is that its only works for volatile
> > > mounts. While I prefer a solution where syncfs() is fixed both for
> > > volatile as well as non-volatile mount and then there is less confusion.
> > >
> >
> > I proposed a variation on Jeff's patch that covers both cases.
> > Sargun is going to work on it.
>
> What's the problem with my patches which fixes syncfs() error reporting
> for overlayfs both for volatile and non-volatile mount?
>

- mount 1000 overlays
- 1 writeback error recorded in upper sb
- syncfs (new fd) inside each of the 1000 containers

With your patch 3/3 only one syncfs will report an error for
both volatile and non-volatile cases. Right?

What I would rather see is:
- Non-volatile: first syncfs in every container gets an error (nice to have)
- Volatile: every syncfs and every fsync in every container gets an error
  (important IMO)

This is why I prefer to sample upper sb error on mount and propagate
new errors to overlayfs sb (Jeff's patch).

I am very much in favor of your patch 1/3 and I am not against the concept
of patches 2-3/3. Just think that ovl_errseq_check_advance() is not the
implementation that gives the most desirable result.

If people do accept my point of view that proxying the stacked error check
is preferred over "passthrough" to upper sb error check, then as a by-product,
the new ->check_error() method is not going to make much of a difference for
overlayfs. Maybe it can be used to fine tune some corner cases.
I am not sure.
If we do agree on the propagate error concept then IMO all other use
cases for not consuming the unseen error from upper fs are nice-to-have.

Before we continue to debate on the implementation, let's first try
to agree on the desired behavior, what is a must vs. what is nice to have.
Without consensus on this, it will be quite hard to converge.

Another thing, to help everyone, I think it is best that any patch on ovl_syncfs
"solutions" will include detailed description of the use cases it solves and
the use cases that it leaves unsolved.

Thanks,
Amir.
