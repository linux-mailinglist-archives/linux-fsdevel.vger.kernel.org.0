Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956E92F0D16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 08:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbhAKHFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 02:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKHFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:05:49 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96EC061794
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jan 2021 23:05:08 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id v67so8001734lfa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jan 2021 23:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyi+O+wUtlLRO3GiFbuD9yEyboiNtXQgdb9/hYVdZQo=;
        b=Lf/VSmW3yFb7z1fC2csd35zND/aWz0Wv5wxbR/wavrTbgVXxENVEUY7q12TDnGX+bO
         ctD/vOxpL5ssJwhpz3MQnqDAldR9Z5GYo8RgRT2mXQvfRzWUpz/6elSINfzBABNlpODj
         ft8F47+5+5z73gOFCjBirmEUJwKztaS7b8CBBWK7bAU29fAX9onJGExLRPW/6jRsKd59
         8O+GbU7x1I0isWyPgOJr9FkyTU++IH8YVbYCx1CTh91H7lQYDJkY+ztye8CCvNFd5iDy
         qTuHvIJyUmiMWbv4UQ6dShtvTBmD4UTbTaB1AQAUMOqkpnvJMMsB8lHlTTZYl3MnnbHq
         Kjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyi+O+wUtlLRO3GiFbuD9yEyboiNtXQgdb9/hYVdZQo=;
        b=Y96Pcx8mje1+n/LZVyCh7ZYbCpnpPQ2aqDWGoKFwpTjqB2zzlpDGglKUbgi1xI5etx
         7Y5yUApAWF1C+0BFmNQtbmDn9S/cVzZyK/sMObjaWYtbncuhURTAOV9nyERKbkeEVXxM
         HpaeKWVUsWcbYgqFaW9FpD0GS5PmX5iSq6bMIzp8YdgR6+HjmIy/vtWQ0B3MRgshMgbj
         kmkm8F5AoTGdUS+/FMDdagmQoX5gaZQknu7+fYZCi7xIlbjeHbN3VpY5Ygro9uEBoJGd
         wA87urAOZ4w825IxUdKb3x3VjVrhAuytszDaHsA1A3S+DeLIBgC/2SLa1IX5YotvpwKg
         KhPw==
X-Gm-Message-State: AOAM533gcmWliRlcZYU1Kzs4Nng8qYdUABWHNn6fFlm/TtkUz30lQeP1
        HqBkVFO9xnDqYv8kfnLmQDr/0VK3AePUAzJpPpA=
X-Google-Smtp-Source: ABdhPJz1+TbmyC74yhDZjZeJJHJSEup31GnS95TmrxXrSKlkdGqGFGcIVeDP+eSAQS+FXrzNQ7BF0/RzmkIPwaNzrpM=
X-Received: by 2002:a19:fc1b:: with SMTP id a27mr6226633lfi.349.1610348706823;
 Sun, 10 Jan 2021 23:05:06 -0800 (PST)
MIME-Version: 1.0
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
 <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
 <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
 <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
 <75de66869bd584903055996fb0e0bab2b57acd68.camel@themaw.net> <42efbb86327c2f5a8378d734edc231e3c5a34053.camel@themaw.net>
In-Reply-To: <42efbb86327c2f5a8378d734edc231e3c5a34053.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 11 Jan 2021 15:04:55 +0800
Message-ID: <CAC2o3D+W70pzEd0MQ1Osxnin=j2mxwH4KdAYwR1mB67LyLbf5Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] kernfs: proposed locking and concurrency improvement
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:20 PM Ian Kent <raven@themaw.net> wrote:
>
> On Mon, 2021-01-11 at 11:19 +0800, Ian Kent wrote:
> > On Wed, 2021-01-06 at 10:38 +0800, Fox Chen wrote:
> > > Hi Ian,
> > >
> > > I am rethinking this problem. Can we simply use a global lock?
> > >
> > >  In your original patch 5, you have a global mutex attr_mutex to
> > > protect attr, if we change it to a rwsem, is it enough to protect
> > > both
> > > inode and attr while having the concurrent read ability?
> > >
> > > like this patch I submitted. ( clearly, I missed __kernfs_iattrs
> > > part,
> > > but just about that idea )
> > > https://lore.kernel.org/lkml/20201207084333.179132-1-foxhlchen@gmail.com/
> >
> > I don't think so.
> >
> > kernfs_refresh_inode() writes to the inode so taking a read lock
> > will allow multiple processes to concurrently update it which is
> > what we need to avoid.

Oh, got it. I missed the inode part. my bad. :(

> > It's possibly even more interesting.
> >
> > For example, kernfs_iop_rmdir() and kernfs_iop_mkdir() might alter
> > the inode link count (I don't know if that would be the sort of thing
> > they would do but kernfs can't possibly know either). Both of these
> > functions rely on the VFS locking for exclusion but the inode link
> > count is updated in kernfs_refresh_inode() too.
> >
> > That's the case now, without any patches.
>
> So it's not so easy to get the inode from just the kernfs object
> so these probably aren't a problem ...

IIUC only when dop->revalidate, iop->lookup being called, the result
of rmdir/mkdir will be sync with vfs.

kernfs_node is detached from vfs inode/dentry to save ram.

> >
> > I'm not entirely sure what's going on in kernfs_refresh_inode().
> >
> > It could be as simple as being called with a NULL inode because
> > the dentry concerned is negative at that point. I haven't had
> > time to look closely at it TBH but I have been thinking about it.

um, It shouldn't be called with a NULL inode, right?

inode->i_mode = kn->mode;

otherwise will crash.

> Certainly this can be called without a struct iattr having been
> allocated ... and given it probably needs to remain a pointer
> rather than embedded in the node the inode link count update
> can't easily be protected from concurrent updates.
>
> If it was ok to do the allocation at inode creation the problem
> becomes much simpler to resolve but I thought there were concerns
> about ram consumption (although I don't think that was exactly what
> was said?).
>

you meant iattr to be allocated at inode creation time??
yes, I think so. it's due to ram consumption.



thanks,
fox
