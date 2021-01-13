Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A7C2F45A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 09:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbhAMIBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 03:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbhAMIBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:01:09 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A278C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 00:00:29 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u25so1424235lfc.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 00:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrzcV3xXJcQ+C6SMVe+szgCuVaI176cgsyi1odurfxI=;
        b=YQPApFWFEmZmsIgLzz45G1topoChOqn1ZSSez6oNm0VqfZ9xR72XUBvyuGxmu5Rvpc
         pbuocP2NvFfrcG14PMaSHVoDvEIUqApZnEUw6FuA3KTfFMlO1Fp/8YeRkhT1PcZLokae
         1TuaQ4NBk+ss8WRby3Pxw+xAU5NKUsSBDi6hZ1wVNhddJhtuY7iDDHc/SDvWCJpW6T0T
         E/1IwgHvcw+ZT1YWb+J5ctFotaNDQ4J11pSJVI/bR19nyo2HNxxKawvy9LqYCP+shxDN
         +6OGKpKcv3a7mXesLV0md6OogPNQbLUb79GC9aI26Eq06nFxUHazWSXYaQ7irW+UpTPa
         aGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrzcV3xXJcQ+C6SMVe+szgCuVaI176cgsyi1odurfxI=;
        b=Wsp4wRoQmgpgC/DqY0nSeAG5VCM2RiKtUBnYzp99Wtm5gIxMKIGT5kz5gjh0u0+uYA
         Sj5uTKrg4R72/33g/+wMqgAxnCPRQWbQlF+q9iMqXAxwdArBFdUEe1/RcJQS4bqF+JI+
         YuBYVBtbSEuNTf6tWI+HrpyN+mI8SwwmaX6MrKkcTGqyMp4P+gOydceV+q09R9sqdgJg
         NSmEzeTi9ZOfGvSkMjOY/vKOHh9BIzaLSDKhpLBcpJmKP9xAuxkYq+etdGxeYYI7VwGz
         lkq30dm0XyyN/VUO/pOl6iBa7IzEVAxjXOigVGVO5yboHcmS/xaPlL1Da9qE4e7h0OJf
         NYxg==
X-Gm-Message-State: AOAM533PL+74mfCBme8A1yT62Sf3I4zXuCC0+CnxmWV0EuqJXa6yGjjg
        J6eCMl6cD1MlwgMj8klUQgVUUt92CedJfgtZNO0=
X-Google-Smtp-Source: ABdhPJw5z1oVS32/gFbRCxRyLjWKZJbll4Va2O/tcQ+FWgMyDdDE45Ii6pbK5iCjYtgXGHfr0Aeh6A9nrDmjkmdguHs=
X-Received: by 2002:a05:6512:320d:: with SMTP id d13mr321841lfe.376.1610524827777;
 Wed, 13 Jan 2021 00:00:27 -0800 (PST)
MIME-Version: 1.0
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
 <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
 <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
 <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
 <75de66869bd584903055996fb0e0bab2b57acd68.camel@themaw.net>
 <42efbb86327c2f5a8378d734edc231e3c5a34053.camel@themaw.net>
 <CAC2o3D+W70pzEd0MQ1Osxnin=j2mxwH4KdAYwR1mB67LyLbf5Q@mail.gmail.com>
 <aa193477213228daf85acdae7c31e1bfff3d694c.camel@themaw.net>
 <CAC2o3D+_Cscy4HyQhigh3DQvth7EJgQFA8PX94=XC5R30fwRwQ@mail.gmail.com>
 <cc784e7a2b65c562d6e8082e5febec4fa74784b7.camel@themaw.net>
 <CAC2o3D+FYJ0b-bL66-C9Xna=R6PvGaPq0fMCmepNbOqX2o8RzA@mail.gmail.com>
 <6182b818d4298898875e9bd59fa9a1dcb279db62.camel@themaw.net> <9b4d99e7d614810692c2e2e0631e164e3c3de4dd.camel@themaw.net>
In-Reply-To: <9b4d99e7d614810692c2e2e0631e164e3c3de4dd.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Wed, 13 Jan 2021 16:00:15 +0800
Message-ID: <CAC2o3DLNtm-JkENOuxP51C91PjieUwXegPkPbs=bLQXKhjykRA@mail.gmail.com>
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

On Wed, Jan 13, 2021 at 3:51 PM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2021-01-13 at 15:47 +0800, Ian Kent wrote:
> > On Wed, 2021-01-13 at 15:00 +0800, Fox Chen wrote:
> > > On Wed, Jan 13, 2021 at 1:17 PM Ian Kent <raven@themaw.net> wrote:
> > > > On Mon, 2021-01-11 at 17:02 +0800, Fox Chen wrote:
> > > > > On Mon, Jan 11, 2021 at 4:42 PM Ian Kent <raven@themaw.net>
> > > > > wrote:
> > > > > > On Mon, 2021-01-11 at 15:04 +0800, Fox Chen wrote:
> > > > > > > On Mon, Jan 11, 2021 at 12:20 PM Ian Kent <raven@themaw.net
> > > > > > > >
> > > > > > > wrote:
> > > > > > > > On Mon, 2021-01-11 at 11:19 +0800, Ian Kent wrote:
> > > > > > > > > On Wed, 2021-01-06 at 10:38 +0800, Fox Chen wrote:
> > > > > > > > > > Hi Ian,
> > > > > > > > > >
> > > > > > > > > > I am rethinking this problem. Can we simply use a
> > > > > > > > > > global
> > > > > > > > > > lock?
> > > > > > > > > >
> > > > > > > > > >  In your original patch 5, you have a global mutex
> > > > > > > > > > attr_mutex
> > > > > > > > > > to
> > > > > > > > > > protect attr, if we change it to a rwsem, is it
> > > > > > > > > > enough
> > > > > > > > > > to
> > > > > > > > > > protect
> > > > > > > > > > both
> > > > > > > > > > inode and attr while having the concurrent read
> > > > > > > > > > ability?
> > > > > > > > > >
> > > > > > > > > > like this patch I submitted. ( clearly, I missed
> > > > > > > > > > __kernfs_iattrs
> > > > > > > > > > part,
> > > > > > > > > > but just about that idea )
> > > > > > > > > > https://lore.kernel.org/lkml/20201207084333.179132-1-foxhlchen@gmail.com/
> > > > > > > > >
> > > > > > > > > I don't think so.
> > > > > > > > >
> > > > > > > > > kernfs_refresh_inode() writes to the inode so taking a
> > > > > > > > > read
> > > > > > > > > lock
> > > > > > > > > will allow multiple processes to concurrently update it
> > > > > > > > > which
> > > > > > > > > is
> > > > > > > > > what we need to avoid.
> > > > > > >
> > > > > > > Oh, got it. I missed the inode part. my bad. :(
> > > > > > >
> > > > > > > > > It's possibly even more interesting.
> > > > > > > > >
> > > > > > > > > For example, kernfs_iop_rmdir() and kernfs_iop_mkdir()
> > > > > > > > > might
> > > > > > > > > alter
> > > > > > > > > the inode link count (I don't know if that would be the
> > > > > > > > > sort
> > > > > > > > > of
> > > > > > > > > thing
> > > > > > > > > they would do but kernfs can't possibly know either).
> > > > > > > > > Both of
> > > > > > > > > these
> > > > > > > > > functions rely on the VFS locking for exclusion but the
> > > > > > > > > inode
> > > > > > > > > link
> > > > > > > > > count is updated in kernfs_refresh_inode() too.
> > > > > > > > >
> > > > > > > > > That's the case now, without any patches.
> > > > > > > >
> > > > > > > > So it's not so easy to get the inode from just the kernfs
> > > > > > > > object
> > > > > > > > so these probably aren't a problem ...
> > > > > > >
> > > > > > > IIUC only when dop->revalidate, iop->lookup being called,
> > > > > > > the
> > > > > > > result
> > > > > > > of rmdir/mkdir will be sync with vfs.
> > > > > >
> > > > > > Don't quite get what you mean here?
> > > > > >
> > > > > > Do you mean something like, VFS objects are created on user
> > > > > > access
> > > > > > to the file system. Given that user access generally means
> > > > > > path
> > > > > > resolution possibly followed by some operation.
> > > > > >
> > > > > > I guess those VFS objects will go away some time after the
> > > > > > access
> > > > > > but even thought the code looks like that should happen
> > > > > > pretty
> > > > > > quickly after I've observed that these objects stay around
> > > > > > longer
> > > > > > than expected. There wouldn't be any use in maintaining a
> > > > > > least
> > > > > > recently used list of dentry candidates eligible to discard.
> > > > >
> > > > > Yes, that is what I meant. I think the duration may depend on
> > > > > the
> > > > > current ram pressure. though not quite sure, I'm still digging
> > > > > this
> > > > > part of code.
> > > > >
> > > > > > > kernfs_node is detached from vfs inode/dentry to save ram.
> > > > > > >
> > > > > > > > > I'm not entirely sure what's going on in
> > > > > > > > > kernfs_refresh_inode().
> > > > > > > > >
> > > > > > > > > It could be as simple as being called with a NULL inode
> > > > > > > > > because
> > > > > > > > > the dentry concerned is negative at that point. I
> > > > > > > > > haven't
> > > > > > > > > had
> > > > > > > > > time to look closely at it TBH but I have been thinking
> > > > > > > > > about
> > > > > > > > > it.
> > > > > > >
> > > > > > > um, It shouldn't be called with a NULL inode, right?
> > > > > > >
> > > > > > > inode->i_mode = kn->mode;
> > > > > > >
> > > > > > > otherwise will crash.
> > > > > >
> > > > > > Yes, you're right about that.
> > > > > >
> > > > > > > > Certainly this can be called without a struct iattr
> > > > > > > > having
> > > > > > > > been
> > > > > > > > allocated ... and given it probably needs to remain a
> > > > > > > > pointer
> > > > > > > > rather than embedded in the node the inode link count
> > > > > > > > update
> > > > > > > > can't easily be protected from concurrent updates.
> > > > > > > >
> > > > > > > > If it was ok to do the allocation at inode creation the
> > > > > > > > problem
> > > > > > > > becomes much simpler to resolve but I thought there were
> > > > > > > > concerns
> > > > > > > > about ram consumption (although I don't think that was
> > > > > > > > exactly
> > > > > > > > what
> > > > > > > > was said?).
> > > > > > > >
> > > > > > >
> > > > > > > you meant iattr to be allocated at inode creation time??
> > > > > > > yes, I think so. it's due to ram consumption.
> > > > > >
> > > > > > I did, yes.
> > > > > >
> > > > > > The actual problem is dealing with multiple concurrent
> > > > > > updates
> > > > > > to
> > > > > > the inode link count, the rest can work.
> > > >
> > > > Umm ... maybe I've been trying to do this in the wrong place all
> > > > along.
> > > >
> > > > You know the inode i_lock looks like the sensible thing to use to
> > > > protect these updates.
> > > >
> > > > Something like this for that last patch should work:
> > > >
> > > > kernfs: use i_lock to protect concurrent inode updates
> > > >
> > > > From: Ian Kent <raven@themaw.net>
> > > >
> > > > The inode operations .permission() and .getattr() use the kernfs
> > > > node
> > > > write lock but all that's needed is to keep the rb tree stable
> > > > while
> > > > updating the inode attributes as well as protecting the update
> > > > itself
> > > > against concurrent changes.
> > > >
> > > > And .permission() is called frequently during path walks and can
> > > > cause
> > > > quite a bit of contention between kernfs node opertations and
> > > > path
> > > > walks when the number of concurrant walks is high.
> > > >
> > > > To change kernfs_iop_getattr() and kernfs_iop_permission() to
> > > > take
> > > > the rw sem read lock instead of the write lock an addtional lock
> > > > is
> > > > needed to protect against multiple processes concurrently
> > > > updating
> > > > the inode attributes and link count in kernfs_refresh_inode().
> > > >
> > > > The inode i_lock seems like the sensible thing to use to protect
> > > > these
> > > > inode attribute updates so use it in kernfs_refresh_inode().
> > > >
> > > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > > ---
> > > >  fs/kernfs/inode.c |   10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > > > index ddaf18198935..e26fa5115821 100644
> > > > --- a/fs/kernfs/inode.c
> > > > +++ b/fs/kernfs/inode.c
> > > > @@ -171,6 +171,7 @@ static void kernfs_refresh_inode(struct
> > > > kernfs_node *kn, struct inode *inode)
> > > >  {
> > > >         struct kernfs_iattrs *attrs = kn->iattr;
> > > >
> > > > +       spin_lock(inode->i_lock);
> > > >         inode->i_mode = kn->mode;
> > > >         if (attrs)
> > > >                 /*
> > > > @@ -181,6 +182,7 @@ static void kernfs_refresh_inode(struct
> > > > kernfs_node *kn, struct inode *inode)
> > > >
> > > >         if (kernfs_type(kn) == KERNFS_DIR)
> > > >                 set_nlink(inode, kn->dir.subdirs + 2);
> > > > +       spin_unlock(inode->i_lock);
> > > >  }
> > > >
> > > >  int kernfs_iop_getattr(const struct path *path, struct kstat
> > > > *stat,
> > > > @@ -189,9 +191,9 @@ int kernfs_iop_getattr(const struct path
> > > > *path,
> > > > struct kstat *stat,
> > > >         struct inode *inode = d_inode(path->dentry);
> > > >         struct kernfs_node *kn = inode->i_private;
> > > >
> > > > -       down_write(&kernfs_rwsem);
> > > > +       down_read(&kernfs_rwsem);
> > > >         kernfs_refresh_inode(kn, inode);
> > > > -       up_write(&kernfs_rwsem);
> > > > +       up_read(&kernfs_rwsem);
> > > >
> > > >         generic_fillattr(inode, stat);
> > > >         return 0;
> > > > @@ -281,9 +283,9 @@ int kernfs_iop_permission(struct inode
> > > > *inode,
> > > > int mask)
> > > >
> > > >         kn = inode->i_private;
> > > >
> > > > -       down_write(&kernfs_rwsem);
> > > > +       down_read(&kernfs_rwsem);
> > > >         kernfs_refresh_inode(kn, inode);
> > > > -       up_write(&kernfs_rwsem);
> > > > +       up_read(&kernfs_rwsem);
> > > >
> > > >         return generic_permission(inode, mask);
> > > >  }
> > > >
> > >
> > > It looks good on my local machine, let me test my benchmark on a
> > > big
> > > machine. :)
> > >
> > > Also, I wonder why i_lock?? what if I use a local spin_lock, will
> > > there be any difference???
> >
> > I think that amounts to using a global lock (ie. static) not a
> > per-object lock which is needed to reduce contention.
>
> And this lock is used for similar purposes in quite a few other
> places so it seems like sensible, consistent usage.

Oh, yes, that's awesome. And it would never be used to protect iop
operations on VFS side as i_rwsem does. Sounds great!

> >
> > > static void kernfs_refresh_inode(struct kernfs_node *kn, struct
> > > inode
> > > *inode)
> > > {
> > >         struct kernfs_iattrs *attrs = kn->iattr;
> > >         static DEFINE_SPINLOCK(inode_lock);
> > >
> > >         spin_lock(&inode_lock);
> > >         inode->i_mode = kn->mode;
> > >         if (attrs)
> > >                 /*
> > >                  * kernfs_node has non-default attributes get them
> > > from
> > >                  * persistent copy in kernfs_node.
> > >                  */
> > >                 set_inode_attr(inode, attrs);
> > >
> > >         if (kernfs_type(kn) == KERNFS_DIR)
> > >                 set_nlink(inode, kn->dir.subdirs + 2);
> > >         spin_unlock(&inode_lock);
> > > }
> > >
> > >
> > >
> > > thanks,
> > > fox
>
