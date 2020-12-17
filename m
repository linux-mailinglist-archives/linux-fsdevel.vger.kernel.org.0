Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870012DCDED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 09:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgLQIzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 03:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLQIzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:55:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8322AC061794;
        Thu, 17 Dec 2020 00:55:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s26so20722833lfc.8;
        Thu, 17 Dec 2020 00:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+janKpHXlQ1Yii05Ylnl1Uzgv9BnKTL34cuiiWwkuyc=;
        b=goHJ2GLZPE4Y/rH+KepckolRiQU8PPI1DoowopfTvcuLHQLDjmmV5AAb+oy8CeEXSU
         ElYCs29jMoALcDeFShGWJFAFfKaUher1Xs4UB7Z58bUXMB7+He6FX2kodWD745EFYPZk
         cFnBM9KcCfhYTiZWWqKPyfqENGHAcMhLVg2JL0/+OcgdcIOeQPMYoaf76cY2a4udcUwG
         u6xN2Q3qT2yZG+xgzwn9bHEd/xQCo5+7lXxyPhkBvJr7NIOvcvrsyBzsBygUioFb2l40
         ciXm0hV6Kh40Tcx3bprcNXjEbXWs3tvT+8x2mdg6cgi856fe2py2wKnsaAsP4qKMnHcg
         GGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+janKpHXlQ1Yii05Ylnl1Uzgv9BnKTL34cuiiWwkuyc=;
        b=gdEWHu9PzrEHjGG5dZe7mx6a1COxINBOw7ixuTurkOs2M21BEWa9jNhJdY3e4uH1e2
         BG3I9+fIgE/a/3UgVGh1jwZWpa+ooOmGKZEQysZ0MvC908Y8gOLe9kd2750tVfR9COFG
         vrcu8WQy9QqkOw69Sl6Nw+eds2FCe29xPejkUXFPZupg+q9jLO5awG7IOb+pM777Ohwj
         tTNcTjMYmvd87SCvV/j9dBoW4bkJMRR1lUfpLVOkht+ro6H8mWATbdYvpo9HNSYRRR7G
         skocuzb3W8iEm3TcWomUonos+xPMKHwRr9O678LcAD9rICafCm1X3chShRktpVA/IbkY
         I/zA==
X-Gm-Message-State: AOAM5300TpTco8SpdrYU6600u6n0m4WbQF35QIpqQ3a703yr4gMSex+8
        TJEtmey9q0xF98CcUPISaRreR8fe595PpvhtLrs=
X-Google-Smtp-Source: ABdhPJwZ9bVIRtdulI/Ye6VYh9w9KWamcV7lZuJLXt2zCILIY6FZr5OEZtYA6Z34br2XMtPtpr0jZdX7VxyDJdPULYk=
X-Received: by 2002:a05:6512:320d:: with SMTP id d13mr13456254lfe.376.1608195305907;
 Thu, 17 Dec 2020 00:55:05 -0800 (PST)
MIME-Version: 1.0
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20201210164423.9084-1-foxhlchen@gmail.com> <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
 <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net>
 <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
 <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
 <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
 <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
 <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net> <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
In-Reply-To: <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Thu, 17 Dec 2020 16:54:54 +0800
Message-ID: <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency improvement
To:     Ian Kent <raven@themaw.net>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, Tejun Heo <tj@kernel.org>,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 12:46 PM Ian Kent <raven@themaw.net> wrote:
>
> On Tue, 2020-12-15 at 20:59 +0800, Ian Kent wrote:
> > On Tue, 2020-12-15 at 16:33 +0800, Fox Chen wrote:
> > > On Mon, Dec 14, 2020 at 9:30 PM Ian Kent <raven@themaw.net> wrote:
> > > > On Mon, 2020-12-14 at 14:14 +0800, Fox Chen wrote:
> > > > > On Sun, Dec 13, 2020 at 11:46 AM Ian Kent <raven@themaw.net>
> > > > > wrote:
> > > > > > On Fri, 2020-12-11 at 10:17 +0800, Ian Kent wrote:
> > > > > > > On Fri, 2020-12-11 at 10:01 +0800, Ian Kent wrote:
> > > > > > > > > For the patches, there is a mutex_lock in kn-
> > > > > > > > > >attr_mutex,
> > > > > > > > > as
> > > > > > > > > Tejun
> > > > > > > > > mentioned here
> > > > > > > > > (
> > > > > > > > > https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/
> > > > > > > > > ),
> > > > > > > > > maybe a global
> > > > > > > > > rwsem for kn->iattr will be better??
> > > > > > > >
> > > > > > > > I wasn't sure about that, IIRC a spin lock could be used
> > > > > > > > around
> > > > > > > > the
> > > > > > > > initial check and checked again at the end which would
> > > > > > > > probably
> > > > > > > > have
> > > > > > > > been much faster but much less conservative and a bit
> > > > > > > > more
> > > > > > > > ugly
> > > > > > > > so
> > > > > > > > I just went the conservative path since there was so much
> > > > > > > > change
> > > > > > > > already.
> > > > > > >
> > > > > > > Sorry, I hadn't looked at Tejun's reply yet and TBH didn't
> > > > > > > remember
> > > > > > > it.
> > > > > > >
> > > > > > > Based on what Tejun said it sounds like that needs work.
> > > > > >
> > > > > > Those attribute handling patches were meant to allow taking
> > > > > > the
> > > > > > rw
> > > > > > sem read lock instead of the write lock for
> > > > > > kernfs_refresh_inode()
> > > > > > updates, with the added locking to protect the inode
> > > > > > attributes
> > > > > > update since it's called from the VFS both with and without
> > > > > > the
> > > > > > inode lock.
> > > > >
> > > > > Oh, understood. I was asking also because lock on kn-
> > > > > >attr_mutex
> > > > > drags
> > > > > concurrent performance.
> > > > >
> > > > > > Looking around it looks like kernfs_iattrs() is called from
> > > > > > multiple
> > > > > > places without a node database lock at all.
> > > > > >
> > > > > > I'm thinking that, to keep my proposed change straight
> > > > > > forward
> > > > > > and on topic, I should just leave kernfs_refresh_inode()
> > > > > > taking
> > > > > > the node db write lock for now and consider the attributes
> > > > > > handling
> > > > > > as a separate change. Once that's done we could reconsider
> > > > > > what's
> > > > > > needed to use the node db read lock in
> > > > > > kernfs_refresh_inode().
> > > > >
> > > > > You meant taking write lock of kernfs_rwsem for
> > > > > kernfs_refresh_inode()??
> > > > > It may be a lot slower in my benchmark, let me test it.
> > > >
> > > > Yes, but make sure the write lock of kernfs_rwsem is being taken
> > > > not the read lock.
> > > >
> > > > That's a mistake I had initially?
> > > >
> > > > Still, that attributes handling is, I think, sufficient to
> > > > warrant
> > > > a separate change since it looks like it might need work, the
> > > > kernfs
> > > > node db probably should be kept stable for those attribute
> > > > updates
> > > > but equally the existence of an instantiated dentry might
> > > > mitigate
> > > > the it.
> > > >
> > > > Some people might just know whether it's ok or not but I would
> > > > like
> > > > to check the callers to work out what's going on.
> > > >
> > > > In any case it's academic if GCH isn't willing to consider the
> > > > series
> > > > for review and possible merge.
> > > >
> > > Hi Ian
> > >
> > > I removed kn->attr_mutex and changed read lock to write lock for
> > > kernfs_refresh_inode
> > >
> > > down_write(&kernfs_rwsem);
> > > kernfs_refresh_inode(kn, inode);
> > > up_write(&kernfs_rwsem);
> > >
> > >
> > > Unfortunate, changes in this way make things worse,  my benchmark
> > > runs
> > > 100% slower than upstream sysfs.  :(
> > > open+read+close a sysfs file concurrently took 1000us. (Currently,
> > > sysfs with a big mutex kernfs_mutex only takes ~500us
> > > for one open+read+close operation concurrently)
> >
> > Right, so it does need attention nowish.
> >
> > I'll have a look at it in a while, I really need to get a new autofs
> > release out, and there are quite a few changes, and testing is seeing
> > a number of errors, some old, some newly introduced. It's proving
> > difficult.
>
> I've taken a breather for the autofs testing and had a look at this.

Thanks. :)

> I think my original analysis of this was wrong.
>
> Could you try this patch please.
> I'm not sure how much difference it will make but, in principle,
> it's much the same as the previous approach except it doesn't
> increase the kernfs node struct size or mess with the other
> attribute handling code.
>
> Note, this is not even compile tested.

I failed to apply this patch. So based on the original six patches, I
manually removed kn->attr_mutex, and added
inode_lock/inode_unlock to those two functions, they were like:

int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
                       u32 request_mask, unsigned int query_flags)
{
        struct inode *inode = d_inode(path->dentry);
        struct kernfs_node *kn = inode->i_private;

        inode_lock(inode);
        down_read(&kernfs_rwsem);
        kernfs_refresh_inode(kn, inode);
        up_read(&kernfs_rwsem);
        inode_unlock(inode);

        generic_fillattr(inode, stat);
        return 0;
}

int kernfs_iop_permission(struct inode *inode, int mask)
{
        struct kernfs_node *kn;

        if (mask & MAY_NOT_BLOCK)
                return -ECHILD;

        kn = inode->i_private;

        inode_lock(inode);
        down_read(&kernfs_rwsem);
        kernfs_refresh_inode(kn, inode);
        up_read(&kernfs_rwsem);
        inode_unlock(inode);

        return generic_permission(inode, mask);
}

But I couldn't boot the kernel and there was no error on the screen.
I guess it was deadlocked on /sys creation?? :D

> kernfs: use kernfs read lock in .getattr() and .permission()
>
> From: Ian Kent <raven@themaw.net>
>
> From Documenation/filesystems.rst and (slightly outdated) comments
> in fs/attr.c the inode i_rwsem is used for attribute handling.
>
> This lock satisfies the requirememnts needed to reduce lock contention,
> namely a per-object lock needs to be used rather than a file system
> global lock with the kernfs node db held stable for read operations.
>
> In particular it should reduce lock contention seen when calling the
> kernfs .permission() method.
>
> The inode methods .getattr() and .permission() do not hold the inode
> i_rwsem lock when called as they are usually read operations. Also
> the .permission() method checks for rcu-walk mode and returns -ECHILD
> to the VFS if it is set. So the i_rwsem lock can be used in
> kernfs_iop_getattr() and kernfs_iop_permission() to protect the inode
> update done by kernfs_refresh_inode(). Using this lock allows the
> kernfs node db write lock in these functions to be changed to a read
> lock.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/inode.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index ddaf18198935..568037e9efe9 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -189,9 +189,11 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
>         struct inode *inode = d_inode(path->dentry);
>         struct kernfs_node *kn = inode->i_private;
>
> -       down_write(&kernfs_rwsem);
> +       inode_lock(inode);
> +       down_read(&kernfs_rwsem);
>         kernfs_refresh_inode(kn, inode);
> -       up_write(&kernfs_rwsem);
> +       up_read(&kernfs_rwsem);
> +       inode_unlock(inode);
>
>         generic_fillattr(inode, stat);
>         return 0;
> @@ -281,9 +283,11 @@ int kernfs_iop_permission(struct inode *inode, int mask)
>
>         kn = inode->i_private;
>
> -       down_write(&kernfs_rwsem);
> +       inode_lock(inode);
> +       down_read(&kernfs_rwsem);
>         kernfs_refresh_inode(kn, inode);
> -       up_write(&kernfs_rwsem);
> +       up_read(&kernfs_rwsem);
> +       inode_unlock(inode);
>
>         return generic_permission(inode, mask);
>  }
>


thanks,
fox
