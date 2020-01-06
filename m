Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC32130DA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 07:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgAFGlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 01:41:17 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42717 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgAFGlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:41:16 -0500
Received: by mail-io1-f67.google.com with SMTP id n11so40788002iom.9;
        Sun, 05 Jan 2020 22:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4RgkHe4zTXWoSeMr/8tfNK+cQWSST31EnajqbmjDNg=;
        b=TmR96zu9Up4TyH2vEMKBHgxzm7gJHlaCIjSL+YssOk/qfR/hOCCdIPZ/dlRN03byn8
         TdZqVcsFc2CtytvbzM+qxW6bTwP221QHWWJ7ol9pUEqEXLqAWKQ4ZVxjirP2Q3slNybt
         U9x3Y+iT7uBphWIzFZLgCn9hnMR7+sdfpgQUCwwCacnBuCOtVeni67dSLhTzZAqlsd/+
         RRztZn/iiRDzkYhThN8inidUR9kjkr0SisND49JD+WrxqFaKJ9icpIVTScGv3KebeJ7P
         xBgBJEpfKcGGiTRcoExOeOU05tjCmXaARTJ6UmhnidWbYcuPRIPQbg5ri+v/8jstwH1z
         OxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4RgkHe4zTXWoSeMr/8tfNK+cQWSST31EnajqbmjDNg=;
        b=bxtioRSOjJSU67K+N4L1U4MrZ2d3Doe37hwhoboiiY/SszBxnEtfGWAM13aD1YTnH2
         DOynxpsoJZuFWW7fACfWpY7KhYECMHHdrpHJwWSHYGV3luszlusXKhja9W6cYTICivGy
         UOsYBW9j/LkyOW7pLkR3y3khB395Rj6TLlW52LFeeN7x5S0RbHIu5bp3bidXwyou9Pdl
         g8kUUYIYouHjuZXK+8fobktcs1/OiHdVpUp9JN6o8J4tenug4ulP7G+MHTHMgctIN83Z
         TpNGWxp3pr/56pXoynKU//SLcuJOiPAcJ++g9qCkj4Dv/rwkm1JB8gHqiDh3Nu5c5OFG
         OrVQ==
X-Gm-Message-State: APjAAAWCR9iHeZwhCNRiGtGP7wX+Avn+KgpXOALTDLvHeRCinLH7XA+V
        7q+lg3u6PMOfbIw8SO8SCqDdyvON4eOSp19pRiE=
X-Google-Smtp-Source: APXvYqzl+7y0bB2lmWr+dwBwiezfzWk3Q3x5u2qaDWAdDjpnWXKpBk2OTa9cBgPuORHV2T6aoAyCc+YHEZ/n+yV9VCY=
X-Received: by 2002:a02:8817:: with SMTP id r23mr79417470jai.120.1578292875785;
 Sun, 05 Jan 2020 22:41:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578225806.git.chris@chrisdown.name> <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578225806.git.chris@chrisdown.name>
 <4106bf3f-5c99-77a4-717e-10a0ffa6a3fa@huawei.com>
In-Reply-To: <4106bf3f-5c99-77a4-717e-10a0ffa6a3fa@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Jan 2020 08:41:03 +0200
Message-ID: <CAOQ4uxijrY7mRkAW1OEym7Xi=v6+fDjhAVBfucwtWPx6bokr5Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] tmpfs: Add per-superblock i_ino support
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     Chris Down <chris@chrisdown.name>, Linux MM <linux-mm@kvack.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 6, 2020 at 4:04 AM zhengbin (A) <zhengbin13@huawei.com> wrote:
>
>
> On 2020/1/5 20:06, Chris Down wrote:
> > get_next_ino has a number of problems:
> >
> > - It uses and returns a uint, which is susceptible to become overflowed
> >   if a lot of volatile inodes that use get_next_ino are created.
> > - It's global, with no specificity per-sb or even per-filesystem. This
> >   means it's not that difficult to cause inode number wraparounds on a
> >   single device, which can result in having multiple distinct inodes
> >   with the same inode number.
> >
> > This patch adds a per-superblock counter that mitigates the second case.
> > This design also allows us to later have a specific i_ino size
> > per-device, for example, allowing users to choose whether to use 32- or
> > 64-bit inodes for each tmpfs mount. This is implemented in the next
> > commit.
> >
> > Signed-off-by: Chris Down <chris@chrisdown.name>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: kernel-team@fb.com
> > ---
> >  include/linux/shmem_fs.h |  1 +
> >  mm/shmem.c               | 30 +++++++++++++++++++++++++++++-
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> >
> > v5: Nothing in code, just resending with correct linux-mm domain.
> >
> > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > index de8e4b71e3ba..7fac91f490dc 100644
> > --- a/include/linux/shmem_fs.h
> > +++ b/include/linux/shmem_fs.h
> > @@ -35,6 +35,7 @@ struct shmem_sb_info {
> >       unsigned char huge;         /* Whether to try for hugepages */
> >       kuid_t uid;                 /* Mount uid for root directory */
> >       kgid_t gid;                 /* Mount gid for root directory */
> > +     ino_t next_ino;             /* The next per-sb inode number to use */
> >       struct mempolicy *mpol;     /* default memory policy for mappings */
> >       spinlock_t shrinklist_lock;   /* Protects shrinklist */
> >       struct list_head shrinklist;  /* List of shinkable inodes */
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 8793e8cc1a48..9e97ba972225 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2236,6 +2236,12 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> >       return 0;
> >  }
> >
> > +/*
> > + * shmem_get_inode - reserve, allocate, and initialise a new inode
> > + *
> > + * If this tmpfs is from kern_mount we use get_next_ino, which is global, since
> > + * inum churn there is low and this avoids taking locks.
> > + */
> >  static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
> >                                    umode_t mode, dev_t dev, unsigned long flags)
> >  {
> > @@ -2248,7 +2254,28 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
> >
> >       inode = new_inode(sb);
> >       if (inode) {
> > -             inode->i_ino = get_next_ino();
> > +             if (sb->s_flags & SB_KERNMOUNT) {
> > +                     /*
> > +                      * __shmem_file_setup, one of our callers, is lock-free:
> > +                      * it doesn't hold stat_lock in shmem_reserve_inode
> > +                      * since max_inodes is always 0, and is called from
> > +                      * potentially unknown contexts. As such, use the global
> > +                      * allocator which doesn't require the per-sb stat_lock.
> > +                      */
> > +                     inode->i_ino = get_next_ino();
> > +             } else {
> > +                     spin_lock(&sbinfo->stat_lock);
>
> Use spin_lock will affect performance, how about define
>
> unsigned long __percpu *last_ino_number; /* Last inode number */
> atomic64_t shared_last_ino_number; /* Shared last inode number */
> in shmem_sb_info, whose performance will be better?
>

Please take a look at shmem_reserve_inode().
spin lock is already being taken in shmem_get_inode()
so there is nothing to be gained from complicating next_ino counter.

This fact would have been a lot clearer if next_ino was incremented
inside shmem_reserve_inode() and its value returned to be used by
shmem_get_inode(), but I am also fine with code as it is with the
comment above.

Thanks,
Amir.
