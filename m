Return-Path: <linux-fsdevel+bounces-2793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE867E9F13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 15:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF7FB209ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958221116;
	Mon, 13 Nov 2023 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YO7yF/v0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0D1F612
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 14:45:41 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA00019A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 06:45:24 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a55302e0so6276181e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 06:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1699886723; x=1700491523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf9oZ0IMA671aFIU6Oh6DX1SxDKURyvY5+rda6WLvBU=;
        b=YO7yF/v051NI3J1tMVY41s0RUQFf13e0d64J7k1MxCCk/Rt+vanBDw4y9GdG4Nomv+
         GBSHxLFqB1Ia88uxfdKGi3BTR9hKYNa1D54jZ8Ft1tLNoqGkj08+2Aq/13XGLnFUn56O
         0OA1W8yps8IuTX9nSWIYVYTS073LaDpxMHl9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699886723; x=1700491523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kf9oZ0IMA671aFIU6Oh6DX1SxDKURyvY5+rda6WLvBU=;
        b=H51oBj2TfZ7CZ9S02FXYI2/VPDYBqS9rrkLHFqpWWx2O4BRTa4jBmVTVHZL2oFi4vy
         MPAHbpKSF7iw2GznW9dgrKfsihLH/1HhwTRn5q37w1z+ZUx3MTCyrq7SmfRxYUUZW8do
         ECy6dEHok3Npp4RWQS9vmTd72gKOX+OLz1jLCzfJ4OBmMENLPu0/i9+LpHU3IvsAAgFh
         KLfD/8m5S0zGfmDHq7cHboxCLMxPpoq5OdbUK9FfpAsTBYqE0bX49noFeOp9EitQz8z5
         MiZcN5/uTWZFx9w+K/kdP81Ro/gvF1Cqm15NmKUJMg0SMb4CSZgLwRvru4wB83G00DpD
         AacQ==
X-Gm-Message-State: AOJu0YwBBo6+8mEXfKcm3okHWiKRvQsTqmd9/Cs07Zudgdv/dSg3y7C0
	UpSnH2sOh4GM0bl0amvlAXr57vqwdNGMGBnbCE/j/A==
X-Google-Smtp-Source: AGHT+IFXCmu2Vbgao5SqtQb6Bcb9p1EYeEFsJern+LpIQiBXqTUgY9oQrhRsCrymPLzT9HQeLRHV9CCJQbtCg7t3aOo=
X-Received: by 2002:a19:710e:0:b0:508:11f5:8953 with SMTP id
 m14-20020a19710e000000b0050811f58953mr4234206lfc.26.1699886722529; Mon, 13
 Nov 2023 06:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105063608.68114-1-obuil.liubo@gmail.com>
In-Reply-To: <20231105063608.68114-1-obuil.liubo@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 13 Nov 2023 15:45:11 +0100
Message-ID: <CAJfpegsqwWKcpcJCpOQ_EmfuX5k9RXgPSz0q6d6+9DVfEAsLVw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix stale data issue of virtiofs with dax
To: obuil.liubo@gmail.com
Cc: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	Vivek Goyal <vgoyal@redhat.com>, virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[adding Vivek Goyal and virtio-fs list]

On Sun, 5 Nov 2023 at 07:36, <obuil.liubo@gmail.com> wrote:
>
> From: Liu Bo <bo.liu@linux.alibaba.com>
>
> In open(O_TRUNC), it doesn't cleanup the corresponding dax mapping of
> an inode, which could expose stale data to users, which can be easily
> reproduced by accessing overlayfs through virtiofs with dax.
>
> The reproducer is,
> 0. mkdir /home/test/lower /home/test/upper /home/test/work
> 1. echo "aaaaaa" > /home/test/lower/foobar
> 2. sudo mount -t overlay overlay -olowerdir=/home/test/lower,upperdir=/home/test/upper,workdir=/home/test/work /mnt/ovl
> 3. start a guest VM configured with virtiofs passthrough(_dax_ enabled and cache policy is always)
>    and use /mnt/ovl as the source directory.
> 4. ssh into the guest VM
> 5. mount virtiofs onto /mnt/test
> 5. cat /mnt/test/foobar
> aaaaaa
> 6. echo "xxxx" > /mnt/test/foobar
> 7. cat /mnt/test/foobar
>
> w/o this patch, step 7 shows "aaaa" rather than "xxxx".

This is generally unsupported.  See Documentation/filesystems/overlayfs.rst:

"Changes to underlying filesystems
---------------------------------

Changes to the underlying filesystems while part of a mounted overlay
filesystem are not allowed.  If the underlying filesystem is changed,
the behavior of the overlay is undefined, though it will not result in
a crash or deadlock.

..."

Thanks,
Miklos


>
> Step 5 reads the content of file 'foobar' by setting up a dax mapping, and the
> mapping eventually maps /home/test/lower/foobar because there is no copy up
> at this moment.
>
> In step 6, 'foobar' is opened with O_TRUNC and the viriofs daemon on host side
> triggers a copy-up, "xxxx" is eventually written to /home/test/upper/foobar.
> Since 'foobar' is truncated to size 0 when writting, writes go with non-dax io
> path and update the file size in guest VM accordingly.
>
> However, dax mapping still refers to the /home/test/lower/foobar, so what step
> 7 reads is /home/test/lower/foobar but with the new size, which shows "aaaa"
> rather "xxxx".
>
> Reported-by: Cameron <cameron@northflank.com>
> Tested-by: Cameron <cameron@northflank.com>
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c    | 9 +++++++++
>  fs/fuse/dir.c    | 5 +++++
>  fs/fuse/fuse_i.h | 1 +
>  3 files changed, 15 insertions(+)
>
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 8e74f278a3f6..d7f9ec7f4597 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -385,6 +385,15 @@ void fuse_dax_inode_cleanup(struct inode *inode)
>         WARN_ON(fi->dax->nr);
>  }
>
> +/* Callers need to make sure fi->i_mmap_sem is held. */
> +void fuse_dax_inode_cleanup_range(struct inode *inode, loff_t start)
> +{
> +       struct fuse_conn *fc = get_fuse_conn(inode);
> +       struct fuse_inode *fi = get_fuse_inode(inode);
> +
> +       inode_reclaim_dmap_range(fc->dax, inode, start, -1);
> +}
> +
>  static void fuse_fill_iomap_hole(struct iomap *iomap, loff_t length)
>  {
>         iomap->addr = IOMAP_NULL_ADDR;
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f67bef9d83c4..be7892e052b5 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1788,6 +1788,9 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>                          */
>                         i_size_write(inode, 0);
>                         truncate_pagecache(inode, 0);
> +                       if (fault_blocked && FUSE_IS_DAX(inode))
> +                               fuse_dax_inode_cleanup(inode);
> +
>                         goto out;
>                 }
>                 file = NULL;
> @@ -1883,6 +1886,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>             S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
>                 truncate_pagecache(inode, outarg.attr.size);
>                 invalidate_inode_pages2(mapping);
> +               if (fault_blocked && FUSE_IS_DAX(inode))
> +                       fuse_dax_inode_cleanup_range(inode, outarg.attr.size);
>         }
>
>         clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 9b7fc7d3c7f1..02fa7aa2bd56 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1305,6 +1305,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc);
>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>  void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
>  void fuse_dax_inode_cleanup(struct inode *inode);
> +void fuse_dax_inode_cleanup_range(struct inode *inode, loff_t start);
>  void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
>  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
>  void fuse_dax_cancel_work(struct fuse_conn *fc);
> --
> 2.32.1 (Apple Git-133)
>

