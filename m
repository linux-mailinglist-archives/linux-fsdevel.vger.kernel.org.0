Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D0812B596
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 16:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfL0P0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 10:26:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44506 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0P0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 10:26:13 -0500
Received: by mail-io1-f67.google.com with SMTP id b10so26023953iof.11;
        Fri, 27 Dec 2019 07:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJIL0YuYUVfYInJerjR4DnOY3gJEBdFdGJr7DtfENCk=;
        b=vOlXzXldgFwU0+9OFb7ycmcB9VbQHATiAAG/oazy3ynoeEtzCxvGd/G2cgvH+0UZRg
         wWHNtIT63p/zqBsNQGWk8Mq5TayBoKW+2HInSi0yFFEaeUT3WvsiODbhiq8+k+ZNqOOI
         kqVcRDOuX+EtT7Og2kRtguw9JyUDaBc4uTWNVNs//y2yv1ml5WNNZ8yZNgj5d6cJNd1Q
         iyXodDPZnI+OPQ02Szc+9wpDNYtLGmC+2QooaE4d8HMQWQ4uW5MqLPmFYEtbENAp8t7U
         Gk8H5rudXDkFtn3NKdBOjrPtehoCYRI9rviwEaNbNy4YgX01e2eZQKnHUKqOi4yaeDOc
         z5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJIL0YuYUVfYInJerjR4DnOY3gJEBdFdGJr7DtfENCk=;
        b=dK4sS/VhzIo6jURLNVXUwdMdYAs/t/KkLmnsAZTwDEdwlS+ytzzsmrOP9R3+ZyLX0r
         CnSx6BtADz0k3dEEvQ7Q30KjzHcWB6mlMSJ39oHnDOMcRUPeSDr2j8jLvxMbfwi0pOWJ
         IFkKN7/kp52B3i2yD2LdVm6GedoaxvSXHZV00JjxW2gm+87PIuy8MjBFI04wMmJbYFXP
         yeg7pBxSdJ1z7Mvq5sq4OsfuRPC8m0dqO8MfzLueJ4AzlOegoQGpTilz4KvjvtDmgV+D
         hzawdqhqps/bffiJmcLDd5vKtUnyFEmQRekfHEsaAmEpzaxoJgtqcg9G3IYt/5IUgE1J
         GAIQ==
X-Gm-Message-State: APjAAAWgalVn7vWnM5G+XMAzW9OGmZdmgLaTLzaYjMZRKXAzOV6aUgki
        r2Tt6ojjCk3S2f9NMT/7QxW12pSojWHBvMcMlLs=
X-Google-Smtp-Source: APXvYqxhPQ7t0bmrcZI2M0kZqxw6arIpX2tLY8urCN6CUDvQ7wvOApfGrSooDSdqHV8U5l4R/M0Vd06J5Hk+6eLQwVE=
X-Received: by 2002:a02:cdd9:: with SMTP id m25mr40797051jap.123.1577460372276;
 Fri, 27 Dec 2019 07:26:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577456898.git.chris@chrisdown.name> <533d188802d292fa9f7c9e66f26068000346d6c1.1577456898.git.chris@chrisdown.name>
In-Reply-To: <533d188802d292fa9f7c9e66f26068000346d6c1.1577456898.git.chris@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Dec 2019 17:26:01 +0200
Message-ID: <CAOQ4uxhaMjn2Kusv6o6mJ36RhF7PAdmgW3kncgfov5uys=6VHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] shmem: Add support for using full width of ino_t
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

On Fri, Dec 27, 2019 at 4:30 PM Chris Down <chris@chrisdown.name> wrote:
>
> The new inode64 option now uses get_next_ino_full, which always uses the
> full width of ino_t (as opposed to get_next_ino, which always uses
> unsigned int).
>
> Using inode64 makes inode number wraparound significantly less likely,
> at the cost of making some features that rely on the underlying
> filesystem not setting any of the highest 32 bits (eg. overlayfs' xino)
> not usable.

That's not an accurate statement. overlayfs xino just needs some high
bits available. Therefore I never had any objection to having tmpfs use
64bit ino values (from overlayfs perspective). My only objection is to
use the same pool "irresponsibly" instead of per-sb pool for the heavy
users.

>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Reported-by: Phyllipe Medeiros <phyllipe@fb.com>
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
>  mm/shmem.c               | 41 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index de8e4b71e3ba..d7727d0d687f 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -35,6 +35,7 @@ struct shmem_sb_info {
>         unsigned char huge;         /* Whether to try for hugepages */
>         kuid_t uid;                 /* Mount uid for root directory */
>         kgid_t gid;                 /* Mount gid for root directory */
> +       bool small_inums;           /* i_ino width unsigned int or ino_t */
>         struct mempolicy *mpol;     /* default memory policy for mappings */
>         spinlock_t shrinklist_lock;   /* Protects shrinklist */
>         struct list_head shrinklist;  /* List of shinkable inodes */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ff041cb15550..56cf581ec66d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -115,11 +115,13 @@ struct shmem_options {
>         kuid_t uid;
>         kgid_t gid;
>         umode_t mode;
> +       bool small_inums;
>         int huge;
>         int seen;
>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
> +#define SHMEM_SEEN_INUMS 8
>  };
>
>  #ifdef CONFIG_TMPFS
> @@ -2248,8 +2250,12 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>         inode = new_inode(sb);
>         if (inode) {
>                 /* Recycle to avoid 32-bit wraparound where possible */
> -               if (!inode->i_ino)
> -                       inode->i_ino = get_next_ino();
> +               if (!inode->i_ino) {
> +                       if (sbinfo->small_inums)
> +                               inode->i_ino = get_next_ino();
> +                       else
> +                               inode->i_ino = get_next_ino_full();
> +               }

Ouch! You set yourself a trap in patch #1 and stepped into it here.
shmem driver has a single shmem_inode_cachep serving all tmpfs
instances. You cannot use different ino allocators and recycle ino
numbers from the same inode cache pool.
Sorry I did not see it coming...

I'm afraid that the recycling method cannot work along side a per-sb
ino allocator :/ (unless get_next_ino() was a truncated version of the
same counter as get_next_ino_full()).

You could still apply the recycling method if shmem inode cache was
never tainted by any other ino allocator, but that will lead to
unpredictable results for users and quite hard to document behavior.

IOW, I don't see a decent way out besides making shmem ino
allocator per-sb proper and always *before* adding the per-sb mount
option inode64.

And because of this, I think the global get_next_ino_full() API is
a mistake.

Thanks,
Amir.
