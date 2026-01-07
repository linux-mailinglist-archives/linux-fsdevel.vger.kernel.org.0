Return-Path: <linux-fsdevel+bounces-72567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EF5CFBB83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 03:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D20F30057D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 02:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F563233D9E;
	Wed,  7 Jan 2026 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="chkzJJNI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36D2A1BB
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752911; cv=none; b=MeDVmLUuUPWWukaT/y6kJt6Jwz9RVTmNzfVr5w/TsuYu3itNrH/Laj4iMCnWfVxAx1yWj2jt3az//WZAtS+H+uykvEEV/C4FRvBfq6vSW9zBCkxFCowOWjPNqzSByw+BvTmkGCELdRFMJsU/Y/ShQMJwK+pLrH4b7AXsOmXGznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752911; c=relaxed/simple;
	bh=OXoUj5dJzcDd2ZulgRbd5GvsM2piQ3fzAJ5xxoH/vE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0HsZe+HddGtejykAnFsA5npGd2i4qGT0OosoqivQ308+hG4UBTLSpt/KnD16hJSI/zpFiODceVSCEzVOW8a9ApXpILv1NZLtMxtGSdJ5lzzMrz25L5zd3Um5/sPTt8kd3kSe6x8ICaJCjbMx/O2t+pPMcTuXL010Raa9mo8mJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=chkzJJNI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767752904; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=thB13OYJIGjWB9NfdvWnbGMaaOE7DkpWt/H+L8lMAbI=;
	b=chkzJJNIB+Y7S37uY5zZvPRJbNmIJRW0/UK8yW6V9HBDj7kiWo1ioFdx/HWUBa/KgD5LlRYUmiGlFJuOaTb86No0In8YSwZbH5M9cx+gvA9AzK/Wg4upx8yqn/0mzgkqFJlNk5lzFVNSNrIjnk2w7ATpFDFxC12L+d6725QG5O4=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwX9QZV_1767752903 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 10:28:24 +0800
Message-ID: <f6bef901-b9a6-4882-83d1-9c5c34402351@linux.alibaba.com>
Date: Wed, 7 Jan 2026 10:28:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Lennart Poettering <lennart@poettering.net>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 Josef Bacik <josef@toxicpanda.com>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/2 22:36, Christian Brauner wrote:
> Currently pivot_root() doesnt't work on the real rootfs because it
> cannot be unmounted. Userspace has to do a recursive removal of the
> initramfs contents manually before continuing the boot.
> 
> Really all we want from the real rootfs is to serve as the parent mount
> for anything that is actually useful such as the tmpfs or ramfs for
> initramfs unpacking or the rootfs itself. There's no need for the real
> rootfs to actually be anything meaningful or useful. Add a immutable
> rootfs that can be selected via the "immutable_rootfs" kernel command
> line option.
> 
> The kernel will mount a tmpfs/ramfs on top of it, unpack the initramfs
> and fire up userspace which mounts the rootfs and can then just do:
> 
>    chdir(rootfs);
>    pivot_root(".", ".");
>    umount2(".", MNT_DETACH);
> 
> and be done with it. (Ofc, userspace can also choose to retain the
> initramfs contents by using something like pivot_root(".", "/initramfs")
> without unmounting it.)
> 
> Technically this also means that the rootfs mount in unprivileged
> namespaces doesn't need to become MNT_LOCKED anymore as it's guaranteed
> that the immutable rootfs remains permanently empty so there cannot be
> anything revealed by unmounting the covering mount.
> 
> In the future this will also allow us to create completely empty mount
> namespaces without risking to leak anything.
> 
> systemd already handles this all correctly as it tries to pivot_root()
> first and falls back to MS_MOVE only when that fails.
> 
> This goes back to various discussion in previous years and a LPC 2024
> presentation about this very topic.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   fs/Makefile                |  2 +-
>   fs/mount.h                 |  1 +
>   fs/namespace.c             | 78 ++++++++++++++++++++++++++++++++++++++++------
>   fs/rootfs.c                | 65 ++++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/magic.h |  1 +
>   init/do_mounts.c           | 13 ++++++--
>   init/do_mounts.h           |  1 +
>   7 files changed, 149 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/Makefile b/fs/Makefile
> index a04274a3c854..d31b56b7c4d5 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
>   		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
>   		fs_dirent.o fs_context.o fs_parser.o fsopen.o init.o \
>   		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
> -		file_attr.o
> +		file_attr.o rootfs.o
>   
>   obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
>   obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
> diff --git a/fs/mount.h b/fs/mount.h
> index 2d28ef2a3aed..c3e0d9dbfaa4 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -5,6 +5,7 @@
>   #include <linux/ns_common.h>
>   #include <linux/fs_pin.h>
>   
> +extern struct file_system_type immutable_rootfs_fs_type;
>   extern struct list_head notify_list;
>   
>   struct mnt_namespace {
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 9261f56ccc81..30597f4610fd 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -75,6 +75,17 @@ static int __init initramfs_options_setup(char *str)
>   
>   __setup("initramfs_options=", initramfs_options_setup);
>   
> +bool immutable_rootfs = false;
> +
> +static int __init immutable_rootfs_setup(char *str)
> +{
> +	if (*str)
> +		return 0;
> +	immutable_rootfs = true;
> +	return 1;
> +}
> +__setup("immutable_rootfs", immutable_rootfs_setup);
> +
>   static u64 event;
>   static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>   static DEFINE_IDA(mnt_group_ida);
> @@ -5976,24 +5987,73 @@ struct mnt_namespace init_mnt_ns = {
>   
>   static void __init init_mount_tree(void)
>   {
> -	struct vfsmount *mnt;
> -	struct mount *m;
> +	struct vfsmount *mnt, *immutable_mnt;
> +	struct mount *mnt_root;
>   	struct path root;
>   
> +	/*
> +	 * When the immutable rootfs is used, we create two mounts:
> +	 *
> +	 * (1) immutable rootfs with mount id 1
> +	 * (2) mutable rootfs with mount id 2
> +	 *
> +	 * with (2) mounted on top of (1).
> +	 */
> +	if (immutable_rootfs) {
> +		immutable_mnt = vfs_kern_mount(&immutable_rootfs_fs_type, 0,
> +					       "rootfs", NULL);
> +		if (IS_ERR(immutable_mnt))
> +			panic("VFS: Failed to create immutable rootfs");
> +	}
> +
>   	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", initramfs_options);
>   	if (IS_ERR(mnt))
>   		panic("Can't create rootfs");
>   
> -	m = real_mount(mnt);
> -	init_mnt_ns.root = m;
> -	init_mnt_ns.nr_mounts = 1;
> -	mnt_add_to_ns(&init_mnt_ns, m);
> +	if (immutable_rootfs) {
> +		VFS_WARN_ON_ONCE(real_mount(immutable_mnt)->mnt_id != 1);
> +		VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id != 2);
> +
> +		/* The namespace root is the immutable rootfs. */
> +		mnt_root		= real_mount(immutable_mnt);
> +		init_mnt_ns.root	= mnt_root;
> +
> +		/* Mount mutable rootfs on top of the immutable rootfs. */
> +		root.mnt		= immutable_mnt;
> +		root.dentry		= immutable_mnt->mnt_root;
> +
> +		LOCK_MOUNT_EXACT(mp, &root);
> +		if (unlikely(IS_ERR(mp.parent)))
> +			panic("VFS: Failed to setup immutable rootfs");
> +		scoped_guard(mount_writer)
> +			attach_mnt(real_mount(mnt), mp.parent, mp.mp);
> +
> +		pr_info("VFS: Finished setting up immutable rootfs\n");
> +	} else {
> +		VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id != 1);
> +
> +		/* The namespace root is the mutable rootfs. */
> +		mnt_root		= real_mount(mnt);
> +		init_mnt_ns.root	= mnt_root;
> +	}
> +
> +	/*
> +	 * We've dropped all locks here but that's fine. Not just are we
> +	 * the only task that's running, there's no other mount
> +	 * namespace in existence and the initial mount namespace is
> +	 * completely empty until we add the mounts we just created.
> +	 */
> +	for (struct mount *p = mnt_root; p; p = next_mnt(p, mnt_root)) {
> +		mnt_add_to_ns(&init_mnt_ns, p);
> +		init_mnt_ns.nr_mounts++;
> +	}
> +
>   	init_task.nsproxy->mnt_ns = &init_mnt_ns;
>   	get_mnt_ns(&init_mnt_ns);
>   
> -	root.mnt = mnt;
> -	root.dentry = mnt->mnt_root;
> -
> +	/* The root and pwd always point to the mutable rootfs. */
> +	root.mnt	= mnt;
> +	root.dentry	= mnt->mnt_root;
>   	set_fs_pwd(current->fs, &root);
>   	set_fs_root(current->fs, &root);
>   
> diff --git a/fs/rootfs.c b/fs/rootfs.c
> new file mode 100644
> index 000000000000..b82b73bb8bb2
> --- /dev/null
> +++ b/fs/rootfs.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> +#include <linux/fs/super_types.h>
> +#include <linux/fs_context.h>
> +#include <linux/magic.h>
> +
> +static const struct super_operations rootfs_super_operations = {
> +	.statfs	= simple_statfs,
> +};
> +
> +static int rootfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
> +{
> +	struct inode *inode;
> +
> +	s->s_maxbytes		= MAX_LFS_FILESIZE;
> +	s->s_blocksize		= PAGE_SIZE;
> +	s->s_blocksize_bits	= PAGE_SHIFT;
> +	s->s_magic		= ROOT_FS_MAGIC;

Just one random suggestion.  Regardless of Al's comments,
if we really would like to expose a new visible type to
userspace,   how about giving it a meaningful name like
emptyfs or nullfs (I know it could have other meanings
in other OSes) from its tree hierarchy to avoid the
ambiguous "rootfs" naming, especially if it may be
considered for mounting by users in future potential use
cases?

Thanks,
Gao Xiang

