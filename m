Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7967928F64F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbgJOQCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389309AbgJOQCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:02:54 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC686C061755;
        Thu, 15 Oct 2020 09:02:54 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p9so4837642ilr.1;
        Thu, 15 Oct 2020 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DM2lBD2pNpB4Q0Kp4IxbFqX7ZHeMRzFn+ruY8ZA7ojU=;
        b=QTiJcoM406WCDfwKT5+kA89NIYC6xsiw3HwzrcES/8eHDx3YXLreh6K1yU2mcSYkCP
         mw9dMALsMvZUwZHWp7UXUReH3us/Z1saYcHJghTrAM+U8lPwLIAU1dBpmVPrIlFFo/Ea
         PWpYyu10T2cBlH402SsjHCW0JB6Lr6rtv4WqkKKqIKsM0iDefPg8/OHeJCtxqOCvjjVj
         t+5T/MVhYLiDAws+qOIL7kCQTR9AEnsRZEMFDa3aZy8ZkEG3s6J/y028shpox4xfIywu
         7mV7uDPqSRWVNI2g4NoTzCzKFtjXciyxNROiR+0RSd9Xv0o5gx041gX+hmMQd8DUSA+z
         Om/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DM2lBD2pNpB4Q0Kp4IxbFqX7ZHeMRzFn+ruY8ZA7ojU=;
        b=piGueT2tn/BqOXgRkHFxCDHvQw9/gmu4YFSD0RLozM2l9UcxOakDZIMbuyTLraeHQJ
         zLElgDPwjOUkvRypfl7DJ/NGZQS9tCESswoMccQ1e+Zo1iP73CXwIDeyElIwOm0ur+cV
         gg/2pOe11Y1AKYJ4Bmyt6TzwfUpdRwfXTBPCpbzTa7PF3cXrkjq0rzwOXW8kcip4iJ1T
         TpFHZO/PQX7ATCmO94H6aFc0H8dnnSwBOZV8dHz/dY3LFC9pZiM4YLpQA0YFvDv4o0qB
         QE1AyWe+iTL7E2kd+EYcr2iwxDbBMRJziiB0Q+gIoSKT/pyzvZ+Wg+YwRd0GdusRKRnW
         Z2HA==
X-Gm-Message-State: AOAM530m//4R8gmVMjoCx0xkkSWlft7rmTVNDxzEUx3Pn5ekSiPy4o/o
        d7WrigAUnEe+0q/zdkYJHIO16BpyEp9f1hgFfr9dgURqefA=
X-Google-Smtp-Source: ABdhPJysVz9XLfIc2ft1G9BtZSCRIAR3x4P1CUKmj5DBFLzz3BJ01lIo2bvTgWWaJc5KdvhxgwD16AsO60DRSsvya9I=
X-Received: by 2002:a92:b707:: with SMTP id k7mr3766344ili.250.1602777773712;
 Thu, 15 Oct 2020 09:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201010142355.741645-1-cgxu519@mykernel.net> <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201014161538.GA27613@quack2.suse.cz> <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
 <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com>
 <1752c05cbe5.fd554a7a44272.2744418978249296745@mykernel.net>
 <CAOQ4uxhEA=ggONsJrUzGfHOGHob+81-UHk1Wo9ejj=CziAjtTQ@mail.gmail.com> <1752c652963.113ee3fbc44343.6282793280578516240@mykernel.net>
In-Reply-To: <1752c652963.113ee3fbc44343.6282793280578516240@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 15 Oct 2020 19:02:42 +0300
Message-ID: <CAOQ4uxhujP_pzguq+FJ87Mx4GBNzEWQs-izuXK1qhWu3EmLpJA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  > >  > When an inode is writably mapped via ovarlayfs, you can flag the
>  > >  > overlay inode with "maybe-writably-mapped" and then remove
>  > >  > it from the maybe dirty list when the underlying inode is not dirty
>  > >  > AND its i_writecount is 0 (checked on write_inode() and release()).
>  > >  >
>  > >  > Actually, there is no reason to treat writably mapped inodes and
>  > >  > other dirty inodes differently - insert to suspect list on open for
>  > >  > write, remove from suspect list on last release() or write_inode()
>  > >  > when inode is no longer dirty and writable.
>
> I have to say inserting to suspect list cannot prevent dropping,
> thinking of the problem of previous approach that we write dirty upper
> inode with current->flags & PF_MEMALLOC while evicting clean overlay inode.
>

Sorry, I don't understand what that means.

>
>  > >  >
>  > >  > Did I miss anything?
>  > >  >
>  > >
>  > > If we dirty overlay inode that means we have launched writeback mechanism,
>  > > so in this case, re-dirty overlay inode in time becomes important.
>  > >
>  >
>  > My idea was to use the first call to ovl_sync_fs() with 'wait' false
>  > to iterate the
>  > maybe-dirty list and re-dirty overlay inodes whose upper is dirty.
>  >
>
> I'm curious how we prevent dropping of clean overlay inode with dirty upper?
> Hold another reference during iput_final operation? in the drop_inode() or something
> else?

No, just return 0 from ovl_drop_inode() and iput_final() will not evict().

>
>
>  > Then in the second call to __sync_filesystem, sync_inodes_sb() will take
>  > care of calling ovl_write_inode() for all the re-dirty inodes.
>  >
>  > In current code we sync ALL dirty upper fs inodes and we do not overlay
>  > inodes with no reference in cache.
>  >
>  > The best code would sync only upper fs inodes dirtied by this overlay
>  > and will be able to evict overlay inodes whose upper inodes are clean.
>  >
>  > The compromise code would sync only upper fs inodes dirtied by this overlay,
>  > and would not evict overlay inodes as long as upper inodes are "open for write".
>  > I think its a fine compromise considering the alternatives.
>  >
>  > Is this workable?
>  >
>
> In your approach, the key point is how to prevent dropping overlay inode that has
> dirty upper and no reference but I don't understand well how to achieve it from
> your descriptions.
>
>

Very well, I will try to explain with code:

int ovl_inode_is_open_for_write(struct inode *inode)
{
       struct inode *upper_inode = ovl_inode_upper(inode);

       return upper_inode && inode_is_open_for_write(upper_inode);
}

void ovl_maybe_mark_inode_dirty(struct inode *inode)
{
       struct inode *upper_inode = ovl_inode_upper(inode);

       if (upper_inode && upper_inode->i_state & I_DIRTY_ALL)
                mark_inode_dirty(inode);
}

int ovl_open(struct inode *inode, struct file *file)
{
...
       if (ovl_inode_is_open_for_write(file_inode(file)))
               ovl_add_inode_to_suspect_list(inode);

        file->private_data = realfile;

        return 0;
}

int ovl_release(struct inode *inode, struct file *file)
{
       struct inode *inode = file_inode(file);

       if (ovl_inode_is_open_for_write(inode)) {
               ovl_maybe_mark_inode_dirty(inode);
               ovl_remove_inode_from_suspect_list(inode);
       }

        fput(file->private_data);

        return 0;
}

int ovl_drop_inode(struct inode *inode)
{
       struct inode *upper_inode = ovl_inode_upper(inode);

       if (!upper_inode)
               return 1;
       if (upper_inode->i_state & I_DIRTY_ALL)
               return 0;

       return !inode_is_open_for_write(upper_inode);
}

static int ovl_sync_fs(struct super_block *sb, int wait)
{
        struct ovl_fs *ofs = sb->s_fs_info;
        struct super_block *upper_sb;
        int ret;

        if (!ovl_upper_mnt(ofs))
                return 0;

        /*
         * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
         * All the super blocks will be iterated, including upper_sb.
         *
         * If this is a syncfs(2) call, then we do need to call
         * sync_filesystem() on upper_sb, but enough if we do it when being
         * called with wait == 1.
         */
        if (!wait) {
                /* mark inodes on the suspect list dirty if thier
upper inode is dirty */
                ovl_mark_suspect_list_inodes_dirty();
                return 0;
        }
...


The races are avoided because inode is added/removed from suspect
list while overlay inode has a reference (from file) and because upper inode
cannot be dirtied by overlayfs when overlay inode is not on the suspect list.

Unless I am missing something.

Thanks,
Amir.
