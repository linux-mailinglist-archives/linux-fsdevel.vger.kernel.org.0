Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737369BB05
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 17:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBRQkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 11:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBRQkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 11:40:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC016307;
        Sat, 18 Feb 2023 08:40:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o14so787087wms.5;
        Sat, 18 Feb 2023 08:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cVHs32k8IjvULNoLm1VTam7npKNp4bgtGCjKmHtXav0=;
        b=Vfu4/sdxR0jnZ/gF8gpxrLQrSXcUshvXYPMcvNFuT676Ou5rAckww+9r2yPh9rWZzc
         vofau+K0QzvtLgB9gKvfKrGz/dOTSh92ymQWYSdn5/xczVQPIKVB2vyQfTQes4TOKbv5
         ckF0Rf1Hzr3q2FGzBINB3PRFFN55HCpFUQHfYr65Iyj9lJIgf2g+IQsOc6ucIup0c3J5
         WQtKfQ8kucn49xcf/eSo37F/6C7iJ1fwLtj5mmKUY/Sbto9QjA3VcyiG6Q0wpPf9nr3l
         2tFzXYing1TTPBGm+HNyFST3YHdwl/oN9OGwrWrRbHSZ4WjscD9RS5uCHeIq6UGTe3YI
         ZkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVHs32k8IjvULNoLm1VTam7npKNp4bgtGCjKmHtXav0=;
        b=Hkrbflmtq3Yrp4nvhNHCjcR0X9TMHb0tWSX0+vXlUzebYWfsFWWUSfMCWbYTPwYK+X
         tk8KU1tDJ//65KG0yLVbUVQdAKVTQranmHot75l/R9idZS1g5rDXPv6jzoh8f5AOSyzM
         OexM2FCRrVGn8nLpHJgBUC1Q/UmtmcVIrN2nEN1LVfRNxXFNZ8MEN1oUlJ7New2Isy4K
         gN3qv5lefk1RHo596YmZeME0N3rgzgeq/ySW4fvD36zXwt3gk4zL8cAP21n7eeBs31Dy
         TncC35VaBPQ5UgA9Ds8HAr/ieQBcG5GIz2TmzIW7NYI1G7qFJDEAW4tQz9WcBpl8jplK
         lV3A==
X-Gm-Message-State: AO0yUKU/vyrDbjRWW+zAU+DvWIlyFXUcNtdgqX7awsKwe4HMvBFKHf2J
        Wnt3LromG3OvzQBDu/UbgB6A/KvnpVbqxfVXvr8=
X-Google-Smtp-Source: AK7set+yQdIVH0cHSncPi7Sj3/PjKAFWk+ad0j4DM9PamwAyLlpiQ6JFbMtooxFCXnkxbWwLxTu5HG2sNHIB/U7qgNA=
X-Received: by 2002:a05:600c:198e:b0:3d9:fd0c:e576 with SMTP id
 t14-20020a05600c198e00b003d9fd0ce576mr58451wmq.6.1676738438869; Sat, 18 Feb
 2023 08:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20230124023834.106339-1-ericvh@kernel.org> <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-11-ericvh@kernel.org> <Y/Ch8o/6HVS8Iyeh@codewreck.org>
 <Y/DBZSaAsRiNR2WV@codewreck.org>
In-Reply-To: <Y/DBZSaAsRiNR2WV@codewreck.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sat, 18 Feb 2023 10:40:27 -0600
Message-ID: <CAFkjPTk=GOU+2D3hORsGntwYc-OLkyMH4YMSY_ERfBXdkq2_hg@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] fs/9p: writeback mode fixes
To:     asmadeus@codewreck.org
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is stupidity on my part, but can you send me your setup for
fscache so I can test the way you are testing it?  It is the one thing
I still haven't incorporated into my test matrix so definitely a blind
spot I appreciate you exposing.

     -eric

On Sat, Feb 18, 2023 at 6:16 AM <asmadeus@codewreck.org> wrote:
>
> asmadeus@codewreck.org wrote on Sat, Feb 18, 2023 at 07:01:22PM +0900:
> > > diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> > > index 5fc6a945bfff..797f717e1a91 100644
> > > --- a/fs/9p/vfs_super.c
> > > +++ b/fs/9p/vfs_super.c
> >
> > > @@ -323,16 +327,17 @@ static int v9fs_write_inode_dotl(struct inode *inode,
> > >      */
> > >     v9inode = V9FS_I(inode);
> > >     p9_debug(P9_DEBUG_VFS, "%s: inode %p, writeback_fid %p\n",
> > > -            __func__, inode, v9inode->writeback_fid);
> > > -   if (!v9inode->writeback_fid)
> > > -           return 0;
> > > +            __func__, inode, fid);
> > > +   if (!fid)
> > > +           return -EINVAL;
> >
> > Hmm, what happens if we return EINVAL here?
> > Might want a WARN_ONCE or something?
>
> Answering myself on this: No idea what happens, but it's fairly
> common...
> (I saw it from wb_writeback which considers any non-zero return value as
> 'progress', so the error is progress as well... Might make more sense to
> return 0 here actually? need more thorough checking, didn't take time to
> dig through this either...)
>
> That aside I ran with my comments addressed and cache=fscache, and
> things blew up during ./configure of coreutils-9.1 in qemu:
> (I ran it as root without setting the env var so it failed, that much is
> expected -- the evict_inode blowing up isn't)
> -------
> checking whether mknod can create fifo without root privileges... configure: error: in `/mnt/coreutils-9.1':
> configure: error: you should not run configure as root (set FORCE_UNSAFE_CONFIGURE=1 in environment to bypass this check)
> See `config.log' for more details
> FS-Cache:
> FS-Cache: Assertion failed
> FS-Cache: 2 == 0 is false
> ------------[ cut here ]------------
> kernel BUG at fs/fscache/cookie.c:985!
> invalid opcode: 0000 [#3] SMP PTI
> CPU: 0 PID: 9707 Comm: rm Tainted: G      D            6.2.0-rc2+ #37
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> RIP: 0010:__fscache_relinquish_cookie.cold+0x5a/0x8f
> Code: 48 c7 c7 21 5e b8 81 e8 34 87 ff ff 48 c7 c7 2f 5e b8 81 e8 28 87 ff ff 48 63 73 04 31 d2 48 c7 c7 00 61 b8 81 e8 16 87 ff ff <0f> 0b 44 8b 47 04 8b 4f 0c 45 0f b8
> RSP: 0018:ffffc90002697e08 EFLAGS: 00010286
> RAX: 0000000000000019 RBX: ffff8880077de210 RCX: 00000000ffffefff
> RDX: 00000000ffffffea RSI: 00000000ffffefff RDI: 0000000000000001
> RBP: ffffc90002697e18 R08: 0000000000004ffb R09: 00000000ffffefff
> R10: ffffffff8264ea20 R11: ffffffff8264ea20 R12: 0000000000000000
> R13: ffffffffc00870e0 R14: ffff88800308cd20 R15: ffff8880046a0020
> FS:  00007fec5aa33000(0000) GS:ffff88807cc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000009af4d8 CR3: 0000000007490000 CR4: 00000000000006b0
> Call Trace:
>  <TASK>
>  v9fs_evict_inode+0x78/0x90 [9p]
>  evict+0xc0/0x160
>  iput+0x171/0x220
>  do_unlinkat+0x197/0x280
>  __x64_sys_unlinkat+0x37/0x60
>  do_syscall_64+0x3c/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fec5ab33fdb
> Code: 73 01 c3 48 8b 0d 55 9e 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 08
> RSP: 002b:00007ffd460b1858 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
> RAX: ffffffffffffffda RBX: 00000000009af830 RCX: 00007fec5ab33fdb
> RDX: 0000000000000000 RSI: 00000000009ae3d0 RDI: 00000000ffffff9c
> RBP: 00000000009ae340 R08: 0000000000000003 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd460b1a40 R14: 0000000000000000 R15: 00000000009af830
>  </TASK>
> Modules linked in: 9pnet_virtio 9p 9pnet siw ib_core
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__fscache_relinquish_cookie.cold+0x5a/0x8f
> Code: 48 c7 c7 21 5e b8 81 e8 34 87 ff ff 48 c7 c7 2f 5e b8 81 e8 28 87 ff ff 48 63 73 04 31 d2 48 c7 c7 00 61 b8 81 e8 16 87 ff ff <0f> 0b 44 8b 47 04 8b 4f 0c 45 0f b8
> RSP: 0018:ffffc90002237e08 EFLAGS: 00010286
> RAX: 0000000000000019 RBX: ffff8880077de9a0 RCX: 00000000ffffefff
> RDX: 00000000ffffffea RSI: 00000000ffffefff RDI: 0000000000000001
> RBP: ffffc90002237e18 R08: 0000000000004ffb R09: 00000000ffffefff
> R10: ffffffff8264ea20 R11: ffffffff8264ea20 R12: 0000000000000000
> R13: ffffffffc00870e0 R14: ffff888003a6b500 R15: ffff8880046a0020
> FS:  00007fec5aa33000(0000) GS:ffff88807cc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000009af4d8 CR3: 0000000007490000 CR4: 00000000000006b0
> ./configure: line 88:  9707 Segmentation fault      exit $1
> -----------
>
> I don't have time to investigate but I'm afraid this needs a bit more
> time as well, sorry :/
>
>
>
>
>
>
>
>
>
>
> For reference, here's how I addressed my comments. I don't think that's
> related to the problem at hand but can retry later without it if you
> think something's fishy:
> ---------
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index 44918c60357f..c16c39ba55d6 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -215,7 +215,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
>         p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
>                  inode, filp, fid ? fid->fid : -1);
>         if (fid) {
> -               if ((fid->qid.type == P9_QTFILE) && (filp->f_mode & FMODE_WRITE))
> +               if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
>                         v9fs_flush_inode_writeback(inode);
>
>                 spin_lock(&inode->i_lock);
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 936daff9f948..e322d4196be6 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -60,7 +60,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
>                         return PTR_ERR(fid);
>
>                 if ((v9ses->cache >= CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
> -                       int writeback_omode = (omode & !P9_OWRITE) | P9_ORDWR;
> +                       int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
>
>                         p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try opening O_RDWR\n");
>                         err = p9_client_open(fid, writeback_omode);
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index d53475e1ba27..062c34524b1f 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -230,22 +230,7 @@ v9fs_blank_wstat(struct p9_wstat *wstat)
>
>  int v9fs_flush_inode_writeback(struct inode *inode)
>  {
> -       struct writeback_control wbc = {
> -               .nr_to_write = LONG_MAX,
> -               .sync_mode = WB_SYNC_ALL,
> -               .range_start = 0,
> -               .range_end = -1,
> -       };
> -
> -       int retval = filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
> -
> -       if (retval != 0) {
> -               p9_debug(P9_DEBUG_ERROR,
> -                       "trying to flush inode %p failed with error code %d\n",
> -                       inode, retval);
> -       }
> -
> -       return retval;
> +       return filemap_write_and_wait(inode->i_mapping);
>  }
>
>  /**
> ------
> --
> Dominique
