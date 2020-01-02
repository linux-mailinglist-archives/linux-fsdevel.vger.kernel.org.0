Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF5312EAA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgABTtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 14:49:06 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43348 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgABTtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:49:06 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so37756057ioo.10;
        Thu, 02 Jan 2020 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2dfuwRo3ioD6kNRXxkmWkiZroxsl+9K4VPPFQAZcBU=;
        b=qRZENP/0G/t/SyW3Zsd8dU2RDoZQG+Ki7pGBC3Rbc83qNVr8XLQpQ815CbR8Fj0wnF
         E72dcamwAxAi8iMoebk5zpJIah+MEIzLswj3aaoRJt1feafz9IspAGODkemxQIGWrqtk
         MfUq6WppUcsyVtRPqYtQqkfr7/r6FHY4uykiUEDW1keoMf2XB3Hh8PYFcKFvr61Wxl/7
         gDfHly+l1otYXdiOcbzZd93GnNNs66vOCXqTVh5BViuY9eSUJdBKDijsmvEposdbTKd+
         8HG+uIksPpTYwLJ1ErOqG1GyTtJot5dB5HIs96xRVfss5nh12pJalm4/aRlKTze8BOjk
         qIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2dfuwRo3ioD6kNRXxkmWkiZroxsl+9K4VPPFQAZcBU=;
        b=DHJ/oQJFQXM7eGovQms/qFUEhGQm3d/TizmPT5RsTsuXsAklk6eiNMZNj86cZte0yx
         lkMxEjQhfoWFoB4ryihWFv3f+8tx+CCmIy8XDPwpdDA/nIMEogS+t6E7ixeAe0TI7M3x
         QCMBSG3tU/+DWjrjttLIQ6IhwH8CR4Fz8GLYFEZCTOgEeWZQBLSWfgmoxpQVS+uY78tc
         pHK2MgWUlm4GHwM2Tb76wIsfyk1qIqP6sKhdOyzsYMPQgP7c8jOQrx5bl3TbH1PH74h2
         djLeht9zs1tcXoD+45AKxAPkT5p5OvxHq7LjxB8q0dcsRvHu/Z3T8XqXekG7LJ7scLHN
         Ue+g==
X-Gm-Message-State: APjAAAVifrxvRzELIFh/EK5z/B72ttWZq0OuXnnEIJ1RUS+86gFYMu3T
        cCa+gDvR4U73BA5IjSs8uAC2RLXPf5S8ZUf8X+ywQHRH
X-Google-Smtp-Source: APXvYqzkUjErvyA0V6arg0ZS5k2LOLh5Z7ZctjCsCXlc9byeZ/USwxFzh8XszkIBKDTAx0Zn/CeCrXScNMpYDgCl9KI=
X-Received: by 2002:a5e:9907:: with SMTP id t7mr56396437ioj.72.1577994545138;
 Thu, 02 Jan 2020 11:49:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577990599.git.chris@chrisdown.name> <738b3d565fe7c65f41c38e439fe3cbfa14f87465.1577990599.git.chris@chrisdown.name>
In-Reply-To: <738b3d565fe7c65f41c38e439fe3cbfa14f87465.1577990599.git.chris@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 Jan 2020 21:48:54 +0200
Message-ID: <CAOQ4uxi0v4WL30gpedUbex-TD5wN8p8kCop_3VDYV0UBJGB21w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tmpfs: Add per-superblock i_ino support
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 2, 2020 at 8:49 PM Chris Down <chris@chrisdown.name> wrote:
>
> get_next_ino has a number of problems:
>
> - It uses and returns a uint, which is susceptible to become overflowed
>   if a lot of volatile inodes that use get_next_ino are created.
> - It's global, with no specificity per-sb or even per-filesystem. This
>   means it's not that difficult to cause inode number wraparounds on a
>   single device, which can result in having multiple distinct inodes
>   with the same inode number.
>
> This patch adds a per-superblock counter that mitigates the second case.
> This design also allows us to later have a specific i_ino size
> per-device, for example, allowing users to choose whether to use 32- or
> 64-bit inodes for each tmpfs mount. This is implemented in the next
> commit.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com
> ---
>  include/linux/shmem_fs.h |  1 +
>  mm/shmem.c               | 55 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 48 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index de8e4b71e3ba..dec4353cf3b7 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -35,6 +35,7 @@ struct shmem_sb_info {
>         unsigned char huge;         /* Whether to try for hugepages */
>         kuid_t uid;                 /* Mount uid for root directory */
>         kgid_t gid;                 /* Mount gid for root directory */
> +       ino_t last_ino;             /* The last used per-sb inode number */
>         struct mempolicy *mpol;     /* default memory policy for mappings */
>         spinlock_t shrinklist_lock;   /* Protects shrinklist */
>         struct list_head shrinklist;  /* List of shinkable inodes */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 165fa6332993..8af9fb922a96 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2235,8 +2235,18 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>         return 0;
>  }
>
> +/*
> + * shmem_get_inode - reserve, allocate, and initialise a new inode
> + *
> + * If usb_sb_ino is true, we use the per-sb inode allocator to avoid wraparound.
> + * Otherwise, we use get_next_ino, which is global.
> + *
> + * If use_sb_ino is true or max_inodes is greater than 0, we may have to grab
> + * the per-sb stat_lock.

Wouldn't it be easier to check max_inodes instead of passing this
use_sb_ino arg?
Is there any case where they *need* to differ?

> + */
>  static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
> -                                    umode_t mode, dev_t dev, unsigned long flags)
> +                                    umode_t mode, dev_t dev,
> +                                    unsigned long flags, bool use_sb_ino)
>  {
>         struct inode *inode;
>         struct shmem_inode_info *info;
> @@ -2247,7 +2257,30 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>
>         inode = new_inode(sb);
>         if (inode) {
> -               inode->i_ino = get_next_ino();
> +               if (use_sb_ino) {
> +                       spin_lock(&sbinfo->stat_lock);
> +                       inode->i_ino = sbinfo->last_ino++;
> +                       if (unlikely(inode->i_ino >= UINT_MAX)) {
> +                               /*
> +                                * Emulate get_next_ino uint wraparound for
> +                                * compatibility
> +                                */
> +                               pr_warn("%s: inode number overflow on device %d, consider using inode64 mount option\n",
> +                                       __func__, MINOR(sb->s_dev));
> +                               inode->i_ino = sbinfo->last_ino = 1;
> +                       }
> +                       spin_unlock(&sbinfo->stat_lock);
> +               } else {
> +                       /*
> +                        * __shmem_file_setup, one of our callers, is lock-free:
> +                        * it doesn't hold stat_lock in shmem_reserve_inode
> +                        * since max_inodes is always 0, and is called from
> +                        * potentially unknown contexts. As such, use the global
> +                        * allocator which doesn't require the per-sb stat_lock.
> +                        */
> +                       inode->i_ino = get_next_ino();
> +               }
> +
>                 inode_init_owner(inode, dir, mode);
>                 inode->i_blocks = 0;
>                 inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> @@ -2881,7 +2914,7 @@ shmem_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
>         struct inode *inode;
>         int error = -ENOSPC;
>
> -       inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE);
> +       inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE, true);
>         if (inode) {
>                 error = simple_acl_create(dir, inode);
>                 if (error)
> @@ -2910,7 +2943,7 @@ shmem_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
>         struct inode *inode;
>         int error = -ENOSPC;
>
> -       inode = shmem_get_inode(dir->i_sb, dir, mode, 0, VM_NORESERVE);
> +       inode = shmem_get_inode(dir->i_sb, dir, mode, 0, VM_NORESERVE, true);
>         if (inode) {
>                 error = security_inode_init_security(inode, dir,
>                                                      NULL,
> @@ -3106,7 +3139,7 @@ static int shmem_symlink(struct inode *dir, struct dentry *dentry, const char *s
>                 return -ENAMETOOLONG;
>
>         inode = shmem_get_inode(dir->i_sb, dir, S_IFLNK | 0777, 0,
> -                               VM_NORESERVE);
> +                               VM_NORESERVE, true);
>         if (!inode)
>                 return -ENOSPC;
>
> @@ -3378,6 +3411,8 @@ enum shmem_param {
>         Opt_nr_inodes,
>         Opt_size,
>         Opt_uid,
> +       Opt_inode32,
> +       Opt_inode64,

Does not belong to this patch..

>  };
>
>  static const struct fs_parameter_spec shmem_param_specs[] = {
> @@ -3389,6 +3424,8 @@ static const struct fs_parameter_spec shmem_param_specs[] = {
>         fsparam_string("nr_inodes",     Opt_nr_inodes),
>         fsparam_string("size",          Opt_size),
>         fsparam_u32   ("uid",           Opt_uid),
> +       fsparam_flag  ("inode32",       Opt_inode32),
> +       fsparam_flag  ("inode64",       Opt_inode64),

Ditto

>         {}
>  };
>
> @@ -3690,7 +3727,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  #endif
>         uuid_gen(&sb->s_uuid);
>
> -       inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
> +       inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0,
> +                               VM_NORESERVE, true);

Should usb_sb_ino be true for the kern_mount??
In any case, it wouldn't matter if it was false, hence no need to pass
an argument
and can either check for sbinfo->max_inodes or the SB_KERNMOUNT flag in
shmem_get_inode().

Thanks,
Amir.
