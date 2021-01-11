Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636CA2F0EB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 10:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbhAKJDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 04:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbhAKJDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:03:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB20C061786
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 01:03:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b26so36661548lff.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 01:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8jCKWEnzC4QS/w4BLbUBs3ZDf6GIWuL8Cb9Mke4tzM=;
        b=SzjuRO7puKfWPUre3gEuZIkF/4gvUyeATHIhyJNtMgVRodQUdJjZEUC6HRB1eqWV3H
         4/GYNFUjls7P0rXyY0lKdV+7DOJW1vEu9EINerFHAaQXUarbdmnKj/NHYdDdh822OmmU
         aP/71I2cvcA+9FWtlZ7jkgySKMqdwd80CEw9ItXBSHG8F6H4vGlWPQQ213P89vgOIFwH
         Smz44VIgPeMOgh4DvhHneAJsH+CPsaA4duYK9hJkpACsZ68Aur7W4o4cqMc/kKMrEa8r
         x9HG5ipOh+iweGBlQ9ukRRQeQ/g3r7P/Q1FhlDYNwNP31fhATBAS3Fzr7Fz6zSMR3ikp
         Tl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8jCKWEnzC4QS/w4BLbUBs3ZDf6GIWuL8Cb9Mke4tzM=;
        b=Uou7vBmcMvm10UXlKXbb1hAZ6sFary4FUV1WtyZwQevCBOVmG1g0cnQcEpsFMhaTL1
         cCfVVrXwLHr6qJv7jWEKxQLsE0ZtKJ6ZcPeS1/jezg+XQUktzhgIK9PMt0v1yI+1oJTC
         BYR+egRiyeB4lyOXzU5EYWekbz6jvJN3bVWeRuj6rwq5V00e4yTL2TIo0wuygYOcqFh0
         lBnJUGNbjFPVYEK3Z93cksNwlA094P2xZWqqrNlrzppnCUuoaD7Von6Qm8gK7oDZ4RvV
         ufqYjT47gp2ZoI8o2yQP/kzCgXAdJciy98GmLo53o1AVdtGY6JnXKERa03LDzBvLLxks
         MIaw==
X-Gm-Message-State: AOAM531B1j6ICaAIjQNUw+AIm+wn7iz3jdXjOqIvhygQAxBph4nCakMq
        1tkERN4Sdo4E6zhB0z6LZuLQSbai8W1zQgqpJMjyHiv5yYDxJyuU
X-Google-Smtp-Source: ABdhPJxbWJeG2o4zJZXbToh+B4XcU7c0Ra81ZCE+BPxLnLaZSTzXnImFienU0JROQPooC/9Bzl2gsZ3la1PUJyayXC4=
X-Received: by 2002:a19:fc1b:: with SMTP id a27mr6389328lfi.349.1610355778389;
 Mon, 11 Jan 2021 01:02:58 -0800 (PST)
MIME-Version: 1.0
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
 <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
 <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
 <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
 <75de66869bd584903055996fb0e0bab2b57acd68.camel@themaw.net>
 <42efbb86327c2f5a8378d734edc231e3c5a34053.camel@themaw.net>
 <CAC2o3D+W70pzEd0MQ1Osxnin=j2mxwH4KdAYwR1mB67LyLbf5Q@mail.gmail.com> <aa193477213228daf85acdae7c31e1bfff3d694c.camel@themaw.net>
In-Reply-To: <aa193477213228daf85acdae7c31e1bfff3d694c.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 11 Jan 2021 17:02:46 +0800
Message-ID: <CAC2o3D+_Cscy4HyQhigh3DQvth7EJgQFA8PX94=XC5R30fwRwQ@mail.gmail.com>
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

On Mon, Jan 11, 2021 at 4:42 PM Ian Kent <raven@themaw.net> wrote:
>
> On Mon, 2021-01-11 at 15:04 +0800, Fox Chen wrote:
> > On Mon, Jan 11, 2021 at 12:20 PM Ian Kent <raven@themaw.net> wrote:
> > > On Mon, 2021-01-11 at 11:19 +0800, Ian Kent wrote:
> > > > On Wed, 2021-01-06 at 10:38 +0800, Fox Chen wrote:
> > > > > Hi Ian,
> > > > >
> > > > > I am rethinking this problem. Can we simply use a global lock?
> > > > >
> > > > >  In your original patch 5, you have a global mutex attr_mutex
> > > > > to
> > > > > protect attr, if we change it to a rwsem, is it enough to
> > > > > protect
> > > > > both
> > > > > inode and attr while having the concurrent read ability?
> > > > >
> > > > > like this patch I submitted. ( clearly, I missed
> > > > > __kernfs_iattrs
> > > > > part,
> > > > > but just about that idea )
> > > > > https://lore.kernel.org/lkml/20201207084333.179132-1-foxhlchen@gmail.com/
> > > >
> > > > I don't think so.
> > > >
> > > > kernfs_refresh_inode() writes to the inode so taking a read lock
> > > > will allow multiple processes to concurrently update it which is
> > > > what we need to avoid.
> >
> > Oh, got it. I missed the inode part. my bad. :(
> >
> > > > It's possibly even more interesting.
> > > >
> > > > For example, kernfs_iop_rmdir() and kernfs_iop_mkdir() might
> > > > alter
> > > > the inode link count (I don't know if that would be the sort of
> > > > thing
> > > > they would do but kernfs can't possibly know either). Both of
> > > > these
> > > > functions rely on the VFS locking for exclusion but the inode
> > > > link
> > > > count is updated in kernfs_refresh_inode() too.
> > > >
> > > > That's the case now, without any patches.
> > >
> > > So it's not so easy to get the inode from just the kernfs object
> > > so these probably aren't a problem ...
> >
> > IIUC only when dop->revalidate, iop->lookup being called, the result
> > of rmdir/mkdir will be sync with vfs.
>
> Don't quite get what you mean here?
>
> Do you mean something like, VFS objects are created on user access
> to the file system. Given that user access generally means path
> resolution possibly followed by some operation.
>
> I guess those VFS objects will go away some time after the access
> but even thought the code looks like that should happen pretty
> quickly after I've observed that these objects stay around longer
> than expected. There wouldn't be any use in maintaining a least
> recently used list of dentry candidates eligible to discard.

Yes, that is what I meant. I think the duration may depend on the
current ram pressure. though not quite sure, I'm still digging this
part of code.

> >
> > kernfs_node is detached from vfs inode/dentry to save ram.
> >
> > > > I'm not entirely sure what's going on in kernfs_refresh_inode().
> > > >
> > > > It could be as simple as being called with a NULL inode because
> > > > the dentry concerned is negative at that point. I haven't had
> > > > time to look closely at it TBH but I have been thinking about it.
> >
> > um, It shouldn't be called with a NULL inode, right?
> >
> > inode->i_mode = kn->mode;
> >
> > otherwise will crash.
>
> Yes, you're right about that.
>
> >
> > > Certainly this can be called without a struct iattr having been
> > > allocated ... and given it probably needs to remain a pointer
> > > rather than embedded in the node the inode link count update
> > > can't easily be protected from concurrent updates.
> > >
> > > If it was ok to do the allocation at inode creation the problem
> > > becomes much simpler to resolve but I thought there were concerns
> > > about ram consumption (although I don't think that was exactly what
> > > was said?).
> > >
> >
> > you meant iattr to be allocated at inode creation time??
> > yes, I think so. it's due to ram consumption.
>
> I did, yes.
>
> The actual problem is dealing with multiple concurrent updates to
> the inode link count, the rest can work.
>
> Ian
>

fox
