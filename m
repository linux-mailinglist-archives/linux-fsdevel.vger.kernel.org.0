Return-Path: <linux-fsdevel+bounces-42185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C32A3E439
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 19:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB3F7AA76F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 18:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67B1263889;
	Thu, 20 Feb 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiJovzEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4C262D37
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 18:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077438; cv=none; b=VngHghWQjSuWTxGkvCyzVRVCzcfDxGB0ZNnt3uylJFwzmV1x/CKk1E//tUoc/BkHPbghItqkOGZ9aiGV/Y/ZXeS0rH74d4c9n0uWKpGhzc0VlQLfizOFaIy+nafTtLYNUlm5NtWYOsvppv0bbsWXUkEKsf6kbtVPQJkZmhUiVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077438; c=relaxed/simple;
	bh=CfaU/8uFfWBCMNZBjAFj9ds/EzXo7lJmwKT/nfVGcMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFYAWQU0MUirl1YJveoff30Qx7C2FvyeS4rp0X0InBkgx3EiJyEZk9B/MR8GfNIdasms8bgOeXN3s3vlWyP1KxCkolxxbnOSKxQU8DBJHuYwAUJQOMamnvvIXtowzy19AT04oU8tnqFTl/r+ZgJDJWf05RJLZFko9sZkM6AzgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiJovzEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C285C4CED1;
	Thu, 20 Feb 2025 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740077437;
	bh=CfaU/8uFfWBCMNZBjAFj9ds/EzXo7lJmwKT/nfVGcMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiJovzEHVIFdq+LEYlaLfL/NVbhumbye73cXaVcW9tZJfyH4rBSbCscwDTcSOSzWo
	 39VNdvRloT2mpdlIavIGQdNjCSbCOvDmEpm508sqVBG58hbSKa09Iq3iOQ9RpWsGUA
	 yndJoiGD2HHDMKfG0ARnz9mAaLyl6DsEnbMEv+mHdG6c8RtZxGbq8Ua6VUntgx+jql
	 vTxvV1yk6cha4fUuD8Hf2sd3aeNVIFT5HreXrphEA7Y96kgGIziQuqDbVsh71bUQWU
	 fjdprR2dh8i0kmZ+yzROzUicZ6wAz6ZCbaUOARJMg9HTKl/9CHhleoufR0qoPzm6Qa
	 +ewb5zJ0Erl2Q==
Date: Thu, 20 Feb 2025 10:50:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysv: Remove the filesystem
Message-ID: <20250220185036.GB1564284@frogsfrogsfrogs>
References: <20250220163940.10155-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220163940.10155-2-jack@suse.cz>

On Thu, Feb 20, 2025 at 05:39:41PM +0100, Jan Kara wrote:
> Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> rwlock") the sysv filesystem was doing IO under a rwlock in its
> get_block() function (yes, a non-sleepable lock hold over a function
> used to read inode metadata for all reads and writes).  Nobody noticed
> until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> Just drop it.
> 
> [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Excellent!  Less code for us all to maintain!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  Documentation/filesystems/index.rst         |   1 -
>  Documentation/filesystems/sysv-fs.rst       | 264 ---------
>  MAINTAINERS                                 |   6 -
>  arch/loongarch/configs/loongson3_defconfig  |   1 -
>  arch/m68k/configs/amiga_defconfig           |   1 -
>  arch/m68k/configs/apollo_defconfig          |   1 -
>  arch/m68k/configs/atari_defconfig           |   1 -
>  arch/m68k/configs/bvme6000_defconfig        |   1 -
>  arch/m68k/configs/hp300_defconfig           |   1 -
>  arch/m68k/configs/mac_defconfig             |   1 -
>  arch/m68k/configs/multi_defconfig           |   1 -
>  arch/m68k/configs/mvme147_defconfig         |   1 -
>  arch/m68k/configs/mvme16x_defconfig         |   1 -
>  arch/m68k/configs/q40_defconfig             |   1 -
>  arch/m68k/configs/sun3_defconfig            |   1 -
>  arch/m68k/configs/sun3x_defconfig           |   1 -
>  arch/mips/configs/malta_defconfig           |   1 -
>  arch/mips/configs/malta_kvm_defconfig       |   1 -
>  arch/mips/configs/maltaup_xpa_defconfig     |   1 -
>  arch/mips/configs/rm200_defconfig           |   1 -
>  arch/parisc/configs/generic-64bit_defconfig |   1 -
>  arch/powerpc/configs/fsl-emb-nonhw.config   |   1 -
>  arch/powerpc/configs/ppc6xx_defconfig       |   1 -
>  fs/Kconfig                                  |   1 -
>  fs/Makefile                                 |   1 -
>  fs/sysv/Kconfig                             |  38 --
>  fs/sysv/Makefile                            |   9 -
>  fs/sysv/balloc.c                            | 240 --------
>  fs/sysv/dir.c                               | 378 ------------
>  fs/sysv/file.c                              |  59 --
>  fs/sysv/ialloc.c                            | 235 --------
>  fs/sysv/inode.c                             | 354 -----------
>  fs/sysv/itree.c                             | 511 ----------------
>  fs/sysv/namei.c                             | 280 ---------
>  fs/sysv/super.c                             | 616 --------------------
>  fs/sysv/sysv.h                              | 245 --------
>  include/linux/sysv_fs.h                     | 214 -------
>  37 files changed, 3472 deletions(-)
>  delete mode 100644 Documentation/filesystems/sysv-fs.rst
>  delete mode 100644 fs/sysv/Kconfig
>  delete mode 100644 fs/sysv/Makefile
>  delete mode 100644 fs/sysv/balloc.c
>  delete mode 100644 fs/sysv/dir.c
>  delete mode 100644 fs/sysv/file.c
>  delete mode 100644 fs/sysv/ialloc.c
>  delete mode 100644 fs/sysv/inode.c
>  delete mode 100644 fs/sysv/itree.c
>  delete mode 100644 fs/sysv/namei.c
>  delete mode 100644 fs/sysv/super.c
>  delete mode 100644 fs/sysv/sysv.h
>  delete mode 100644 include/linux/sysv_fs.h
> 
> Hello Christian!
> 
> Here is sysv removal patch rebased on top of your vfs.all branch. Can you pull
> it into your tree? Or I could carry it in my tree but I guess there's no point.
> Thanks!
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 2636f2a41bd3..a9cf8e950b15 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -118,7 +118,6 @@ Documentation for filesystem implementations.
>     spufs/index
>     squashfs
>     sysfs
> -   sysv-fs
>     tmpfs
>     ubifs
>     ubifs-authentication
> diff --git a/Documentation/filesystems/sysv-fs.rst b/Documentation/filesystems/sysv-fs.rst
> deleted file mode 100644
> index 89e40911ad7c..000000000000
> --- a/Documentation/filesystems/sysv-fs.rst
> +++ /dev/null
> @@ -1,264 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -==================
> -SystemV Filesystem
> -==================
> -
> -It implements all of
> -  - Xenix FS,
> -  - SystemV/386 FS,
> -  - Coherent FS.
> -
> -To install:
> -
> -* Answer the 'System V and Coherent filesystem support' question with 'y'
> -  when configuring the kernel.
> -* To mount a disk or a partition, use::
> -
> -    mount [-r] -t sysv device mountpoint
> -
> -  The file system type names::
> -
> -               -t sysv
> -               -t xenix
> -               -t coherent
> -
> -  may be used interchangeably, but the last two will eventually disappear.
> -
> -Bugs in the present implementation:
> -
> -- Coherent FS:
> -
> -  - The "free list interleave" n:m is currently ignored.
> -  - Only file systems with no filesystem name and no pack name are recognized.
> -    (See Coherent "man mkfs" for a description of these features.)
> -
> -- SystemV Release 2 FS:
> -
> -  The superblock is only searched in the blocks 9, 15, 18, which
> -  corresponds to the beginning of track 1 on floppy disks. No support
> -  for this FS on hard disk yet.
> -
> -
> -These filesystems are rather similar. Here is a comparison with Minix FS:
> -
> -* Linux fdisk reports on partitions
> -
> -  - Minix FS     0x81 Linux/Minix
> -  - Xenix FS     ??
> -  - SystemV FS   ??
> -  - Coherent FS  0x08 AIX bootable
> -
> -* Size of a block or zone (data allocation unit on disk)
> -
> -  - Minix FS     1024
> -  - Xenix FS     1024 (also 512 ??)
> -  - SystemV FS   1024 (also 512 and 2048)
> -  - Coherent FS   512
> -
> -* General layout: all have one boot block, one super block and
> -  separate areas for inodes and for directories/data.
> -  On SystemV Release 2 FS (e.g. Microport) the first track is reserved and
> -  all the block numbers (including the super block) are offset by one track.
> -
> -* Byte ordering of "short" (16 bit entities) on disk:
> -
> -  - Minix FS     little endian  0 1
> -  - Xenix FS     little endian  0 1
> -  - SystemV FS   little endian  0 1
> -  - Coherent FS  little endian  0 1
> -
> -  Of course, this affects only the file system, not the data of files on it!
> -
> -* Byte ordering of "long" (32 bit entities) on disk:
> -
> -  - Minix FS     little endian  0 1 2 3
> -  - Xenix FS     little endian  0 1 2 3
> -  - SystemV FS   little endian  0 1 2 3
> -  - Coherent FS  PDP-11         2 3 0 1
> -
> -  Of course, this affects only the file system, not the data of files on it!
> -
> -* Inode on disk: "short", 0 means non-existent, the root dir ino is:
> -
> -  =================================  ==
> -  Minix FS                            1
> -  Xenix FS, SystemV FS, Coherent FS   2
> -  =================================  ==
> -
> -* Maximum number of hard links to a file:
> -
> -  ===========  =========
> -  Minix FS     250
> -  Xenix FS     ??
> -  SystemV FS   ??
> -  Coherent FS  >=10000
> -  ===========  =========
> -
> -* Free inode management:
> -
> -  - Minix FS
> -      a bitmap
> -  - Xenix FS, SystemV FS, Coherent FS
> -      There is a cache of a certain number of free inodes in the super-block.
> -      When it is exhausted, new free inodes are found using a linear search.
> -
> -* Free block management:
> -
> -  - Minix FS
> -      a bitmap
> -  - Xenix FS, SystemV FS, Coherent FS
> -      Free blocks are organized in a "free list". Maybe a misleading term,
> -      since it is not true that every free block contains a pointer to
> -      the next free block. Rather, the free blocks are organized in chunks
> -      of limited size, and every now and then a free block contains pointers
> -      to the free blocks pertaining to the next chunk; the first of these
> -      contains pointers and so on. The list terminates with a "block number"
> -      0 on Xenix FS and SystemV FS, with a block zeroed out on Coherent FS.
> -
> -* Super-block location:
> -
> -  ===========  ==========================
> -  Minix FS     block 1 = bytes 1024..2047
> -  Xenix FS     block 1 = bytes 1024..2047
> -  SystemV FS   bytes 512..1023
> -  Coherent FS  block 1 = bytes 512..1023
> -  ===========  ==========================
> -
> -* Super-block layout:
> -
> -  - Minix FS::
> -
> -                    unsigned short s_ninodes;
> -                    unsigned short s_nzones;
> -                    unsigned short s_imap_blocks;
> -                    unsigned short s_zmap_blocks;
> -                    unsigned short s_firstdatazone;
> -                    unsigned short s_log_zone_size;
> -                    unsigned long s_max_size;
> -                    unsigned short s_magic;
> -
> -  - Xenix FS, SystemV FS, Coherent FS::
> -
> -                    unsigned short s_firstdatazone;
> -                    unsigned long  s_nzones;
> -                    unsigned short s_fzone_count;
> -                    unsigned long  s_fzones[NICFREE];
> -                    unsigned short s_finode_count;
> -                    unsigned short s_finodes[NICINOD];
> -                    char           s_flock;
> -                    char           s_ilock;
> -                    char           s_modified;
> -                    char           s_rdonly;
> -                    unsigned long  s_time;
> -                    short          s_dinfo[4]; -- SystemV FS only
> -                    unsigned long  s_free_zones;
> -                    unsigned short s_free_inodes;
> -                    short          s_dinfo[4]; -- Xenix FS only
> -                    unsigned short s_interleave_m,s_interleave_n; -- Coherent FS only
> -                    char           s_fname[6];
> -                    char           s_fpack[6];
> -
> -    then they differ considerably:
> -
> -        Xenix FS::
> -
> -                    char           s_clean;
> -                    char           s_fill[371];
> -                    long           s_magic;
> -                    long           s_type;
> -
> -        SystemV FS::
> -
> -                    long           s_fill[12 or 14];
> -                    long           s_state;
> -                    long           s_magic;
> -                    long           s_type;
> -
> -        Coherent FS::
> -
> -                    unsigned long  s_unique;
> -
> -    Note that Coherent FS has no magic.
> -
> -* Inode layout:
> -
> -  - Minix FS::
> -
> -                    unsigned short i_mode;
> -                    unsigned short i_uid;
> -                    unsigned long  i_size;
> -                    unsigned long  i_time;
> -                    unsigned char  i_gid;
> -                    unsigned char  i_nlinks;
> -                    unsigned short i_zone[7+1+1];
> -
> -  - Xenix FS, SystemV FS, Coherent FS::
> -
> -                    unsigned short i_mode;
> -                    unsigned short i_nlink;
> -                    unsigned short i_uid;
> -                    unsigned short i_gid;
> -                    unsigned long  i_size;
> -                    unsigned char  i_zone[3*(10+1+1+1)];
> -                    unsigned long  i_atime;
> -                    unsigned long  i_mtime;
> -                    unsigned long  i_ctime;
> -
> -
> -* Regular file data blocks are organized as
> -
> -  - Minix FS:
> -
> -             - 7 direct blocks
> -	     - 1 indirect block (pointers to blocks)
> -             - 1 double-indirect block (pointer to pointers to blocks)
> -
> -  - Xenix FS, SystemV FS, Coherent FS:
> -
> -             - 10 direct blocks
> -             -  1 indirect block (pointers to blocks)
> -             -  1 double-indirect block (pointer to pointers to blocks)
> -             -  1 triple-indirect block (pointer to pointers to pointers to blocks)
> -
> -
> -  ===========  ==========   ================
> -               Inode size   inodes per block
> -  ===========  ==========   ================
> -  Minix FS        32        32
> -  Xenix FS        64        16
> -  SystemV FS      64        16
> -  Coherent FS     64        8
> -  ===========  ==========   ================
> -
> -* Directory entry on disk
> -
> -  - Minix FS::
> -
> -                    unsigned short inode;
> -                    char name[14/30];
> -
> -  - Xenix FS, SystemV FS, Coherent FS::
> -
> -                    unsigned short inode;
> -                    char name[14];
> -
> -  ===========    ==============    =====================
> -                 Dir entry size    dir entries per block
> -  ===========    ==============    =====================
> -  Minix FS       16/32             64/32
> -  Xenix FS       16                64
> -  SystemV FS     16                64
> -  Coherent FS    16                32
> -  ===========    ==============    =====================
> -
> -* How to implement symbolic links such that the host fsck doesn't scream:
> -
> -  - Minix FS     normal
> -  - Xenix FS     kludge: as regular files with  chmod 1000
> -  - SystemV FS   ??
> -  - Coherent FS  kludge: as regular files with  chmod 1000
> -
> -
> -Notation: We often speak of a "block" but mean a zone (the allocation unit)
> -and not the disk driver's notion of "block".
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e17764cb6ed..58534bc39b2d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23075,12 +23075,6 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/x86/system76_acpi.c
>  
> -SYSV FILESYSTEM
> -S:	Orphan
> -F:	Documentation/filesystems/sysv-fs.rst
> -F:	fs/sysv/
> -F:	include/linux/sysv_fs.h
> -
>  TASKSTATS STATISTICS INTERFACE
>  M:	Balbir Singh <bsingharora@gmail.com>
>  S:	Maintained
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> index 73c77500ac46..3c240afe5aed 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -981,7 +981,6 @@ CONFIG_MINIX_FS=m
>  CONFIG_ROMFS_FS=m
>  CONFIG_PSTORE=m
>  CONFIG_PSTORE_COMPRESS=y
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_EROFS_FS_ZIP_LZMA=y
> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> index dbf2ea561c85..68a2e299ea71 100644
> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -486,7 +486,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
> index b0fd199cc0a4..3696d0c19579 100644
> --- a/arch/m68k/configs/apollo_defconfig
> +++ b/arch/m68k/configs/apollo_defconfig
> @@ -443,7 +443,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
> index bb5b2d3b6c10..dbd4b58b724c 100644
> --- a/arch/m68k/configs/atari_defconfig
> +++ b/arch/m68k/configs/atari_defconfig
> @@ -463,7 +463,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
> index 8315a13bab73..95178e66703f 100644
> --- a/arch/m68k/configs/bvme6000_defconfig
> +++ b/arch/m68k/configs/bvme6000_defconfig
> @@ -435,7 +435,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
> index 350370657e5f..68372a0b05ac 100644
> --- a/arch/m68k/configs/hp300_defconfig
> +++ b/arch/m68k/configs/hp300_defconfig
> @@ -445,7 +445,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
> index f942b4755702..a9beb4ec8a15 100644
> --- a/arch/m68k/configs/mac_defconfig
> +++ b/arch/m68k/configs/mac_defconfig
> @@ -462,7 +462,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
> index b1eaad02efab..45a898e9c1d1 100644
> --- a/arch/m68k/configs/multi_defconfig
> +++ b/arch/m68k/configs/multi_defconfig
> @@ -549,7 +549,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
> index 6309a4442bb3..350dc6d08461 100644
> --- a/arch/m68k/configs/mvme147_defconfig
> +++ b/arch/m68k/configs/mvme147_defconfig
> @@ -435,7 +435,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
> index 3feb0731f814..7ea283ba86b7 100644
> --- a/arch/m68k/configs/mvme16x_defconfig
> +++ b/arch/m68k/configs/mvme16x_defconfig
> @@ -436,7 +436,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
> index ea04b1b0da7d..eb0de405e6a9 100644
> --- a/arch/m68k/configs/q40_defconfig
> +++ b/arch/m68k/configs/q40_defconfig
> @@ -452,7 +452,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
> index f52d9af92153..7026a139ccf8 100644
> --- a/arch/m68k/configs/sun3_defconfig
> +++ b/arch/m68k/configs/sun3_defconfig
> @@ -433,7 +433,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
> index f348447824da..c91abb80b081 100644
> --- a/arch/m68k/configs/sun3x_defconfig
> +++ b/arch/m68k/configs/sun3x_defconfig
> @@ -433,7 +433,6 @@ CONFIG_OMFS_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_QNX6FS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_EROFS_FS=m
>  CONFIG_NFS_FS=y
> diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
> index 4390d30206d9..e308b82c094a 100644
> --- a/arch/mips/configs/malta_defconfig
> +++ b/arch/mips/configs/malta_defconfig
> @@ -347,7 +347,6 @@ CONFIG_CRAMFS=m
>  CONFIG_VXFS_FS=m
>  CONFIG_MINIX_FS=m
>  CONFIG_ROMFS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
> diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
> index d63d8be8cb50..fa5b04063ddb 100644
> --- a/arch/mips/configs/malta_kvm_defconfig
> +++ b/arch/mips/configs/malta_kvm_defconfig
> @@ -354,7 +354,6 @@ CONFIG_CRAMFS=m
>  CONFIG_VXFS_FS=m
>  CONFIG_MINIX_FS=m
>  CONFIG_ROMFS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
> diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
> index 338bb6544a93..40283171af68 100644
> --- a/arch/mips/configs/maltaup_xpa_defconfig
> +++ b/arch/mips/configs/maltaup_xpa_defconfig
> @@ -353,7 +353,6 @@ CONFIG_CRAMFS=m
>  CONFIG_VXFS_FS=m
>  CONFIG_MINIX_FS=m
>  CONFIG_ROMFS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_NFS_FS=y
>  CONFIG_ROOT_NFS=y
> diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
> index 08e1c1f2f4de..3a6d0384b774 100644
> --- a/arch/mips/configs/rm200_defconfig
> +++ b/arch/mips/configs/rm200_defconfig
> @@ -336,7 +336,6 @@ CONFIG_MINIX_FS=m
>  CONFIG_HPFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_ROMFS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_NFS_FS=m
>  CONFIG_NFSD=m
> diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
> index 19a804860ed5..ea623f910748 100644
> --- a/arch/parisc/configs/generic-64bit_defconfig
> +++ b/arch/parisc/configs/generic-64bit_defconfig
> @@ -268,7 +268,6 @@ CONFIG_PROC_KCORE=y
>  CONFIG_TMPFS=y
>  CONFIG_TMPFS_XATTR=y
>  CONFIG_CONFIGFS_FS=y
> -CONFIG_SYSV_FS=y
>  CONFIG_NFS_FS=m
>  CONFIG_NFS_V4=m
>  CONFIG_NFS_V4_1=y
> diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/configs/fsl-emb-nonhw.config
> index 3009b0efaf34..d6d2a458847b 100644
> --- a/arch/powerpc/configs/fsl-emb-nonhw.config
> +++ b/arch/powerpc/configs/fsl-emb-nonhw.config
> @@ -112,7 +112,6 @@ CONFIG_QNX4FS_FS=m
>  CONFIG_RCU_TRACE=y
>  CONFIG_RESET_CONTROLLER=y
>  CONFIG_ROOT_NFS=y
> -CONFIG_SYSV_FS=m
>  CONFIG_SYSVIPC=y
>  CONFIG_TMPFS=y
>  CONFIG_UBIFS_FS=y
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
> index ca0c90e95837..364d1a78bc12 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -986,7 +986,6 @@ CONFIG_MINIX_FS=m
>  CONFIG_OMFS_FS=m
>  CONFIG_QNX4FS_FS=m
>  CONFIG_ROMFS_FS=m
> -CONFIG_SYSV_FS=m
>  CONFIG_UFS_FS=m
>  CONFIG_NFS_FS=m
>  CONFIG_NFS_V3_ACL=y
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 64d420e3c475..afe21866d6b4 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -336,7 +336,6 @@ source "fs/qnx4/Kconfig"
>  source "fs/qnx6/Kconfig"
>  source "fs/romfs/Kconfig"
>  source "fs/pstore/Kconfig"
> -source "fs/sysv/Kconfig"
>  source "fs/ufs/Kconfig"
>  source "fs/erofs/Kconfig"
>  source "fs/vboxsf/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 15df0a923d3a..77fd7f7b5d02 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -87,7 +87,6 @@ obj-$(CONFIG_NFSD)		+= nfsd/
>  obj-$(CONFIG_LOCKD)		+= lockd/
>  obj-$(CONFIG_NLS)		+= nls/
>  obj-y				+= unicode/
> -obj-$(CONFIG_SYSV_FS)		+= sysv/
>  obj-$(CONFIG_SMBFS)		+= smb/
>  obj-$(CONFIG_HPFS_FS)		+= hpfs/
>  obj-$(CONFIG_NTFS3_FS)		+= ntfs3/
> diff --git a/fs/sysv/Kconfig b/fs/sysv/Kconfig
> deleted file mode 100644
> index 67b3f90afbfd..000000000000
> --- a/fs/sysv/Kconfig
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -config SYSV_FS
> -	tristate "System V/Xenix/V7/Coherent file system support"
> -	depends on BLOCK
> -	select BUFFER_HEAD
> -	help
> -	  SCO, Xenix and Coherent are commercial Unix systems for Intel
> -	  machines, and Version 7 was used on the DEC PDP-11. Saying Y
> -	  here would allow you to read from their floppies and hard disk
> -	  partitions.
> -
> -	  If you have floppies or hard disk partitions like that, it is likely
> -	  that they contain binaries from those other Unix systems; in order
> -	  to run these binaries, you will want to install linux-abi which is
> -	  a set of kernel modules that lets you run SCO, Xenix, Wyse,
> -	  UnixWare, Dell Unix and System V programs under Linux.  It is
> -	  available via FTP (user: ftp) from
> -	  <ftp://ftp.openlinux.org/pub/people/hch/linux-abi/>).
> -	  NOTE: that will work only for binaries from Intel-based systems;
> -	  PDP ones will have to wait until somebody ports Linux to -11 ;-)
> -
> -	  If you only intend to mount files from some other Unix over the
> -	  network using NFS, you don't need the System V file system support
> -	  (but you need NFS file system support obviously).
> -
> -	  Note that this option is generally not needed for floppies, since a
> -	  good portable way to transport files and directories between unixes
> -	  (and even other operating systems) is given by the tar program ("man
> -	  tar" or preferably "info tar").  Note also that this option has
> -	  nothing whatsoever to do with the option "System V IPC". Read about
> -	  the System V file system in
> -	  <file:Documentation/filesystems/sysv-fs.rst>.
> -	  Saying Y here will enlarge your kernel by about 27 KB.
> -
> -	  To compile this as a module, choose M here: the module will be called
> -	  sysv.
> -
> -	  If you haven't heard about all of this before, it's safe to say N.
> diff --git a/fs/sysv/Makefile b/fs/sysv/Makefile
> deleted file mode 100644
> index 17d12ba04b18..000000000000
> --- a/fs/sysv/Makefile
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# Makefile for the Linux SystemV/Coherent filesystem routines.
> -#
> -
> -obj-$(CONFIG_SYSV_FS) += sysv.o
> -
> -sysv-objs := ialloc.o balloc.o inode.o itree.o file.o dir.o \
> -	     namei.o super.o
> diff --git a/fs/sysv/balloc.c b/fs/sysv/balloc.c
> deleted file mode 100644
> index 0e69dbdf7277..000000000000
> --- a/fs/sysv/balloc.c
> +++ /dev/null
> @@ -1,240 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/balloc.c
> - *
> - *  minix/bitmap.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  ext/freelists.c
> - *  Copyright (C) 1992  Remy Card (card@masi.ibp.fr)
> - *
> - *  xenix/alloc.c
> - *  Copyright (C) 1992  Doug Evans
> - *
> - *  coh/alloc.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/balloc.c
> - *  Copyright (C) 1993  Bruno Haible
> - *
> - *  This file contains code for allocating/freeing blocks.
> - */
> -
> -#include <linux/buffer_head.h>
> -#include <linux/string.h>
> -#include "sysv.h"
> -
> -/* We don't trust the value of
> -   sb->sv_sbd2->s_tfree = *sb->sv_free_blocks
> -   but we nevertheless keep it up to date. */
> -
> -static inline sysv_zone_t *get_chunk(struct super_block *sb, struct buffer_head *bh)
> -{
> -	char *bh_data = bh->b_data;
> -
> -	if (SYSV_SB(sb)->s_type == FSTYPE_SYSV4)
> -		return (sysv_zone_t*)(bh_data+4);
> -	else
> -		return (sysv_zone_t*)(bh_data+2);
> -}
> -
> -/* NOTE NOTE NOTE: nr is a block number _as_ _stored_ _on_ _disk_ */
> -
> -void sysv_free_block(struct super_block * sb, sysv_zone_t nr)
> -{
> -	struct sysv_sb_info * sbi = SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	sysv_zone_t *blocks = sbi->s_bcache;
> -	unsigned count;
> -	unsigned block = fs32_to_cpu(sbi, nr);
> -
> -	/*
> -	 * This code does not work at all for AFS (it has a bitmap
> -	 * free list).  As AFS is supposed to be read-only no one
> -	 * should call this for an AFS filesystem anyway...
> -	 */
> -	if (sbi->s_type == FSTYPE_AFS)
> -		return;
> -
> -	if (block < sbi->s_firstdatazone || block >= sbi->s_nzones) {
> -		printk("sysv_free_block: trying to free block not in datazone\n");
> -		return;
> -	}
> -
> -	mutex_lock(&sbi->s_lock);
> -	count = fs16_to_cpu(sbi, *sbi->s_bcache_count);
> -
> -	if (count > sbi->s_flc_size) {
> -		printk("sysv_free_block: flc_count > flc_size\n");
> -		mutex_unlock(&sbi->s_lock);
> -		return;
> -	}
> -	/* If the free list head in super-block is full, it is copied
> -	 * into this block being freed, ditto if it's completely empty
> -	 * (applies only on Coherent).
> -	 */
> -	if (count == sbi->s_flc_size || count == 0) {
> -		block += sbi->s_block_base;
> -		bh = sb_getblk(sb, block);
> -		if (!bh) {
> -			printk("sysv_free_block: getblk() failed\n");
> -			mutex_unlock(&sbi->s_lock);
> -			return;
> -		}
> -		memset(bh->b_data, 0, sb->s_blocksize);
> -		*(__fs16*)bh->b_data = cpu_to_fs16(sbi, count);
> -		memcpy(get_chunk(sb,bh), blocks, count * sizeof(sysv_zone_t));
> -		mark_buffer_dirty(bh);
> -		set_buffer_uptodate(bh);
> -		brelse(bh);
> -		count = 0;
> -	}
> -	sbi->s_bcache[count++] = nr;
> -
> -	*sbi->s_bcache_count = cpu_to_fs16(sbi, count);
> -	fs32_add(sbi, sbi->s_free_blocks, 1);
> -	dirty_sb(sb);
> -	mutex_unlock(&sbi->s_lock);
> -}
> -
> -sysv_zone_t sysv_new_block(struct super_block * sb)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	unsigned int block;
> -	sysv_zone_t nr;
> -	struct buffer_head * bh;
> -	unsigned count;
> -
> -	mutex_lock(&sbi->s_lock);
> -	count = fs16_to_cpu(sbi, *sbi->s_bcache_count);
> -
> -	if (count == 0) /* Applies only to Coherent FS */
> -		goto Enospc;
> -	nr = sbi->s_bcache[--count];
> -	if (nr == 0)  /* Applies only to Xenix FS, SystemV FS */
> -		goto Enospc;
> -
> -	block = fs32_to_cpu(sbi, nr);
> -
> -	*sbi->s_bcache_count = cpu_to_fs16(sbi, count);
> -
> -	if (block < sbi->s_firstdatazone || block >= sbi->s_nzones) {
> -		printk("sysv_new_block: new block %d is not in data zone\n",
> -			block);
> -		goto Enospc;
> -	}
> -
> -	if (count == 0) { /* the last block continues the free list */
> -		unsigned count;
> -
> -		block += sbi->s_block_base;
> -		if (!(bh = sb_bread(sb, block))) {
> -			printk("sysv_new_block: cannot read free-list block\n");
> -			/* retry this same block next time */
> -			*sbi->s_bcache_count = cpu_to_fs16(sbi, 1);
> -			goto Enospc;
> -		}
> -		count = fs16_to_cpu(sbi, *(__fs16*)bh->b_data);
> -		if (count > sbi->s_flc_size) {
> -			printk("sysv_new_block: free-list block with >flc_size entries\n");
> -			brelse(bh);
> -			goto Enospc;
> -		}
> -		*sbi->s_bcache_count = cpu_to_fs16(sbi, count);
> -		memcpy(sbi->s_bcache, get_chunk(sb, bh),
> -				count * sizeof(sysv_zone_t));
> -		brelse(bh);
> -	}
> -	/* Now the free list head in the superblock is valid again. */
> -	fs32_add(sbi, sbi->s_free_blocks, -1);
> -	dirty_sb(sb);
> -	mutex_unlock(&sbi->s_lock);
> -	return nr;
> -
> -Enospc:
> -	mutex_unlock(&sbi->s_lock);
> -	return 0;
> -}
> -
> -unsigned long sysv_count_free_blocks(struct super_block * sb)
> -{
> -	struct sysv_sb_info * sbi = SYSV_SB(sb);
> -	int sb_count;
> -	int count;
> -	struct buffer_head * bh = NULL;
> -	sysv_zone_t *blocks;
> -	unsigned block;
> -	int n;
> -
> -	/*
> -	 * This code does not work at all for AFS (it has a bitmap
> -	 * free list).  As AFS is supposed to be read-only we just
> -	 * lie and say it has no free block at all.
> -	 */
> -	if (sbi->s_type == FSTYPE_AFS)
> -		return 0;
> -
> -	mutex_lock(&sbi->s_lock);
> -	sb_count = fs32_to_cpu(sbi, *sbi->s_free_blocks);
> -
> -	if (0)
> -		goto trust_sb;
> -
> -	/* this causes a lot of disk traffic ... */
> -	count = 0;
> -	n = fs16_to_cpu(sbi, *sbi->s_bcache_count);
> -	blocks = sbi->s_bcache;
> -	while (1) {
> -		sysv_zone_t zone;
> -		if (n > sbi->s_flc_size)
> -			goto E2big;
> -		zone = 0;
> -		while (n && (zone = blocks[--n]) != 0)
> -			count++;
> -		if (zone == 0)
> -			break;
> -
> -		block = fs32_to_cpu(sbi, zone);
> -		if (bh)
> -			brelse(bh);
> -
> -		if (block < sbi->s_firstdatazone || block >= sbi->s_nzones)
> -			goto Einval;
> -		block += sbi->s_block_base;
> -		bh = sb_bread(sb, block);
> -		if (!bh)
> -			goto Eio;
> -		n = fs16_to_cpu(sbi, *(__fs16*)bh->b_data);
> -		blocks = get_chunk(sb, bh);
> -	}
> -	if (bh)
> -		brelse(bh);
> -	if (count != sb_count)
> -		goto Ecount;
> -done:
> -	mutex_unlock(&sbi->s_lock);
> -	return count;
> -
> -Einval:
> -	printk("sysv_count_free_blocks: new block %d is not in data zone\n",
> -		block);
> -	goto trust_sb;
> -Eio:
> -	printk("sysv_count_free_blocks: cannot read free-list block\n");
> -	goto trust_sb;
> -E2big:
> -	printk("sysv_count_free_blocks: >flc_size entries in free-list block\n");
> -	if (bh)
> -		brelse(bh);
> -trust_sb:
> -	count = sb_count;
> -	goto done;
> -Ecount:
> -	printk("sysv_count_free_blocks: free block count was %d, "
> -		"correcting to %d\n", sb_count, count);
> -	if (!sb_rdonly(sb)) {
> -		*sbi->s_free_blocks = cpu_to_fs32(sbi, count);
> -		dirty_sb(sb);
> -	}
> -	goto done;
> -}
> diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
> deleted file mode 100644
> index 639307e2ff8c..000000000000
> --- a/fs/sysv/dir.c
> +++ /dev/null
> @@ -1,378 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/dir.c
> - *
> - *  minix/dir.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  coh/dir.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/dir.c
> - *  Copyright (C) 1993  Bruno Haible
> - *
> - *  SystemV/Coherent directory handling functions
> - */
> -
> -#include <linux/pagemap.h>
> -#include <linux/highmem.h>
> -#include <linux/swap.h>
> -#include "sysv.h"
> -
> -static int sysv_readdir(struct file *, struct dir_context *);
> -
> -const struct file_operations sysv_dir_operations = {
> -	.llseek		= generic_file_llseek,
> -	.read		= generic_read_dir,
> -	.iterate_shared	= sysv_readdir,
> -	.fsync		= generic_file_fsync,
> -};
> -
> -static void dir_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
> -{
> -	struct address_space *mapping = folio->mapping;
> -	struct inode *dir = mapping->host;
> -
> -	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
> -	if (pos+len > dir->i_size) {
> -		i_size_write(dir, pos+len);
> -		mark_inode_dirty(dir);
> -	}
> -	folio_unlock(folio);
> -}
> -
> -static int sysv_handle_dirsync(struct inode *dir)
> -{
> -	int err;
> -
> -	err = filemap_write_and_wait(dir->i_mapping);
> -	if (!err)
> -		err = sync_inode_metadata(dir, 1);
> -	return err;
> -}
> -
> -/*
> - * Calls to dir_get_folio()/folio_release_kmap() must be nested according to the
> - * rules documented in mm/highmem.rst.
> - *
> - * NOTE: sysv_find_entry() and sysv_dotdot() act as calls to dir_get_folio()
> - * and must be treated accordingly for nesting purposes.
> - */
> -static void *dir_get_folio(struct inode *dir, unsigned long n,
> -		struct folio **foliop)
> -{
> -	struct folio *folio = read_mapping_folio(dir->i_mapping, n, NULL);
> -
> -	if (IS_ERR(folio))
> -		return ERR_CAST(folio);
> -	*foliop = folio;
> -	return kmap_local_folio(folio, 0);
> -}
> -
> -static int sysv_readdir(struct file *file, struct dir_context *ctx)
> -{
> -	unsigned long pos = ctx->pos;
> -	struct inode *inode = file_inode(file);
> -	struct super_block *sb = inode->i_sb;
> -	unsigned long npages = dir_pages(inode);
> -	unsigned offset;
> -	unsigned long n;
> -
> -	ctx->pos = pos = (pos + SYSV_DIRSIZE-1) & ~(SYSV_DIRSIZE-1);
> -	if (pos >= inode->i_size)
> -		return 0;
> -
> -	offset = pos & ~PAGE_MASK;
> -	n = pos >> PAGE_SHIFT;
> -
> -	for ( ; n < npages; n++, offset = 0) {
> -		char *kaddr, *limit;
> -		struct sysv_dir_entry *de;
> -		struct folio *folio;
> -
> -		kaddr = dir_get_folio(inode, n, &folio);
> -		if (IS_ERR(kaddr))
> -			continue;
> -		de = (struct sysv_dir_entry *)(kaddr+offset);
> -		limit = kaddr + PAGE_SIZE - SYSV_DIRSIZE;
> -		for ( ;(char*)de <= limit; de++, ctx->pos += sizeof(*de)) {
> -			char *name = de->name;
> -
> -			if (!de->inode)
> -				continue;
> -
> -			if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
> -					fs16_to_cpu(SYSV_SB(sb), de->inode),
> -					DT_UNKNOWN)) {
> -				folio_release_kmap(folio, kaddr);
> -				return 0;
> -			}
> -		}
> -		folio_release_kmap(folio, kaddr);
> -	}
> -	return 0;
> -}
> -
> -/* compare strings: name[0..len-1] (not zero-terminated) and
> - * buffer[0..] (filled with zeroes up to buffer[0..maxlen-1])
> - */
> -static inline int namecompare(int len, int maxlen,
> -	const char * name, const char * buffer)
> -{
> -	if (len < maxlen && buffer[len])
> -		return 0;
> -	return !memcmp(name, buffer, len);
> -}
> -
> -/*
> - *	sysv_find_entry()
> - *
> - * finds an entry in the specified directory with the wanted name.
> - * It does NOT read the inode of the
> - * entry - you'll have to do that yourself if you want to.
> - *
> - * On Success folio_release_kmap() should be called on *foliop.
> - *
> - * sysv_find_entry() acts as a call to dir_get_folio() and must be treated
> - * accordingly for nesting purposes.
> - */
> -struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct folio **foliop)
> -{
> -	const char * name = dentry->d_name.name;
> -	int namelen = dentry->d_name.len;
> -	struct inode * dir = d_inode(dentry->d_parent);
> -	unsigned long start, n;
> -	unsigned long npages = dir_pages(dir);
> -	struct sysv_dir_entry *de;
> -
> -	start = SYSV_I(dir)->i_dir_start_lookup;
> -	if (start >= npages)
> -		start = 0;
> -	n = start;
> -
> -	do {
> -		char *kaddr = dir_get_folio(dir, n, foliop);
> -
> -		if (!IS_ERR(kaddr)) {
> -			de = (struct sysv_dir_entry *)kaddr;
> -			kaddr += folio_size(*foliop) - SYSV_DIRSIZE;
> -			for ( ; (char *) de <= kaddr ; de++) {
> -				if (!de->inode)
> -					continue;
> -				if (namecompare(namelen, SYSV_NAMELEN,
> -							name, de->name))
> -					goto found;
> -			}
> -			folio_release_kmap(*foliop, kaddr);
> -		}
> -
> -		if (++n >= npages)
> -			n = 0;
> -	} while (n != start);
> -
> -	return NULL;
> -
> -found:
> -	SYSV_I(dir)->i_dir_start_lookup = n;
> -	return de;
> -}
> -
> -int sysv_add_link(struct dentry *dentry, struct inode *inode)
> -{
> -	struct inode *dir = d_inode(dentry->d_parent);
> -	const char * name = dentry->d_name.name;
> -	int namelen = dentry->d_name.len;
> -	struct folio *folio = NULL;
> -	struct sysv_dir_entry * de;
> -	unsigned long npages = dir_pages(dir);
> -	unsigned long n;
> -	char *kaddr;
> -	loff_t pos;
> -	int err;
> -
> -	/* We take care of directory expansion in the same loop */
> -	for (n = 0; n <= npages; n++) {
> -		kaddr = dir_get_folio(dir, n, &folio);
> -		if (IS_ERR(kaddr))
> -			return PTR_ERR(kaddr);
> -		de = (struct sysv_dir_entry *)kaddr;
> -		kaddr += PAGE_SIZE - SYSV_DIRSIZE;
> -		while ((char *)de <= kaddr) {
> -			if (!de->inode)
> -				goto got_it;
> -			err = -EEXIST;
> -			if (namecompare(namelen, SYSV_NAMELEN, name, de->name)) 
> -				goto out_folio;
> -			de++;
> -		}
> -		folio_release_kmap(folio, kaddr);
> -	}
> -	BUG();
> -	return -EINVAL;
> -
> -got_it:
> -	pos = folio_pos(folio) + offset_in_folio(folio, de);
> -	folio_lock(folio);
> -	err = sysv_prepare_chunk(folio, pos, SYSV_DIRSIZE);
> -	if (err)
> -		goto out_unlock;
> -	memcpy (de->name, name, namelen);
> -	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
> -	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
> -	dir_commit_chunk(folio, pos, SYSV_DIRSIZE);
> -	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> -	mark_inode_dirty(dir);
> -	err = sysv_handle_dirsync(dir);
> -out_folio:
> -	folio_release_kmap(folio, kaddr);
> -	return err;
> -out_unlock:
> -	folio_unlock(folio);
> -	goto out_folio;
> -}
> -
> -int sysv_delete_entry(struct sysv_dir_entry *de, struct folio *folio)
> -{
> -	struct inode *inode = folio->mapping->host;
> -	loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
> -	int err;
> -
> -	folio_lock(folio);
> -	err = sysv_prepare_chunk(folio, pos, SYSV_DIRSIZE);
> -	if (err) {
> -		folio_unlock(folio);
> -		return err;
> -	}
> -	de->inode = 0;
> -	dir_commit_chunk(folio, pos, SYSV_DIRSIZE);
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> -	mark_inode_dirty(inode);
> -	return sysv_handle_dirsync(inode);
> -}
> -
> -int sysv_make_empty(struct inode *inode, struct inode *dir)
> -{
> -	struct folio *folio = filemap_grab_folio(inode->i_mapping, 0);
> -	struct sysv_dir_entry * de;
> -	char *kaddr;
> -	int err;
> -
> -	if (IS_ERR(folio))
> -		return PTR_ERR(folio);
> -	err = sysv_prepare_chunk(folio, 0, 2 * SYSV_DIRSIZE);
> -	if (err) {
> -		folio_unlock(folio);
> -		goto fail;
> -	}
> -	kaddr = kmap_local_folio(folio, 0);
> -	memset(kaddr, 0, folio_size(folio));
> -
> -	de = (struct sysv_dir_entry *)kaddr;
> -	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
> -	strcpy(de->name,".");
> -	de++;
> -	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
> -	strcpy(de->name,"..");
> -
> -	kunmap_local(kaddr);
> -	dir_commit_chunk(folio, 0, 2 * SYSV_DIRSIZE);
> -	err = sysv_handle_dirsync(inode);
> -fail:
> -	folio_put(folio);
> -	return err;
> -}
> -
> -/*
> - * routine to check that the specified directory is empty (for rmdir)
> - */
> -int sysv_empty_dir(struct inode * inode)
> -{
> -	struct super_block *sb = inode->i_sb;
> -	struct folio *folio = NULL;
> -	unsigned long i, npages = dir_pages(inode);
> -	char *kaddr;
> -
> -	for (i = 0; i < npages; i++) {
> -		struct sysv_dir_entry *de;
> -
> -		kaddr = dir_get_folio(inode, i, &folio);
> -		if (IS_ERR(kaddr))
> -			continue;
> -
> -		de = (struct sysv_dir_entry *)kaddr;
> -		kaddr += folio_size(folio) - SYSV_DIRSIZE;
> -
> -		for ( ;(char *)de <= kaddr; de++) {
> -			if (!de->inode)
> -				continue;
> -			/* check for . and .. */
> -			if (de->name[0] != '.')
> -				goto not_empty;
> -			if (!de->name[1]) {
> -				if (de->inode == cpu_to_fs16(SYSV_SB(sb),
> -							inode->i_ino))
> -					continue;
> -				goto not_empty;
> -			}
> -			if (de->name[1] != '.' || de->name[2])
> -				goto not_empty;
> -		}
> -		folio_release_kmap(folio, kaddr);
> -	}
> -	return 1;
> -
> -not_empty:
> -	folio_release_kmap(folio, kaddr);
> -	return 0;
> -}
> -
> -/* Releases the page */
> -int sysv_set_link(struct sysv_dir_entry *de, struct folio *folio,
> -		struct inode *inode)
> -{
> -	struct inode *dir = folio->mapping->host;
> -	loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
> -	int err;
> -
> -	folio_lock(folio);
> -	err = sysv_prepare_chunk(folio, pos, SYSV_DIRSIZE);
> -	if (err) {
> -		folio_unlock(folio);
> -		return err;
> -	}
> -	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
> -	dir_commit_chunk(folio, pos, SYSV_DIRSIZE);
> -	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> -	mark_inode_dirty(dir);
> -	return sysv_handle_dirsync(inode);
> -}
> -
> -/*
> - * Calls to dir_get_folio()/folio_release_kmap() must be nested according to the
> - * rules documented in mm/highmem.rst.
> - *
> - * sysv_dotdot() acts as a call to dir_get_folio() and must be treated
> - * accordingly for nesting purposes.
> - */
> -struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct folio **foliop)
> -{
> -	struct sysv_dir_entry *de = dir_get_folio(dir, 0, foliop);
> -
> -	if (IS_ERR(de))
> -		return NULL;
> -	/* ".." is the second directory entry */
> -	return de + 1;
> -}
> -
> -ino_t sysv_inode_by_name(struct dentry *dentry)
> -{
> -	struct folio *folio;
> -	struct sysv_dir_entry *de = sysv_find_entry (dentry, &folio);
> -	ino_t res = 0;
> -	
> -	if (de) {
> -		res = fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
> -		folio_release_kmap(folio, de);
> -	}
> -	return res;
> -}
> diff --git a/fs/sysv/file.c b/fs/sysv/file.c
> deleted file mode 100644
> index c645f60bdb7f..000000000000
> --- a/fs/sysv/file.c
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/file.c
> - *
> - *  minix/file.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  coh/file.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/file.c
> - *  Copyright (C) 1993  Bruno Haible
> - *
> - *  SystemV/Coherent regular file handling primitives
> - */
> -
> -#include "sysv.h"
> -
> -/*
> - * We have mostly NULLs here: the current defaults are OK for
> - * the coh filesystem.
> - */
> -const struct file_operations sysv_file_operations = {
> -	.llseek		= generic_file_llseek,
> -	.read_iter	= generic_file_read_iter,
> -	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> -	.fsync		= generic_file_fsync,
> -	.splice_read	= filemap_splice_read,
> -};
> -
> -static int sysv_setattr(struct mnt_idmap *idmap,
> -			struct dentry *dentry, struct iattr *attr)
> -{
> -	struct inode *inode = d_inode(dentry);
> -	int error;
> -
> -	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> -	if (error)
> -		return error;
> -
> -	if ((attr->ia_valid & ATTR_SIZE) &&
> -	    attr->ia_size != i_size_read(inode)) {
> -		error = inode_newsize_ok(inode, attr->ia_size);
> -		if (error)
> -			return error;
> -		truncate_setsize(inode, attr->ia_size);
> -		sysv_truncate(inode);
> -	}
> -
> -	setattr_copy(&nop_mnt_idmap, inode, attr);
> -	mark_inode_dirty(inode);
> -	return 0;
> -}
> -
> -const struct inode_operations sysv_file_inode_operations = {
> -	.setattr	= sysv_setattr,
> -	.getattr	= sysv_getattr,
> -};
> diff --git a/fs/sysv/ialloc.c b/fs/sysv/ialloc.c
> deleted file mode 100644
> index 269df6d49815..000000000000
> --- a/fs/sysv/ialloc.c
> +++ /dev/null
> @@ -1,235 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/ialloc.c
> - *
> - *  minix/bitmap.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  ext/freelists.c
> - *  Copyright (C) 1992  Remy Card (card@masi.ibp.fr)
> - *
> - *  xenix/alloc.c
> - *  Copyright (C) 1992  Doug Evans
> - *
> - *  coh/alloc.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/ialloc.c
> - *  Copyright (C) 1993  Bruno Haible
> - *
> - *  This file contains code for allocating/freeing inodes.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/stddef.h>
> -#include <linux/sched.h>
> -#include <linux/stat.h>
> -#include <linux/string.h>
> -#include <linux/buffer_head.h>
> -#include <linux/writeback.h>
> -#include "sysv.h"
> -
> -/* We don't trust the value of
> -   sb->sv_sbd2->s_tinode = *sb->sv_sb_total_free_inodes
> -   but we nevertheless keep it up to date. */
> -
> -/* An inode on disk is considered free if both i_mode == 0 and i_nlink == 0. */
> -
> -/* return &sb->sv_sb_fic_inodes[i] = &sbd->s_inode[i]; */
> -static inline sysv_ino_t *
> -sv_sb_fic_inode(struct super_block * sb, unsigned int i)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -
> -	if (sbi->s_bh1 == sbi->s_bh2)
> -		return &sbi->s_sb_fic_inodes[i];
> -	else {
> -		/* 512 byte Xenix FS */
> -		unsigned int offset = offsetof(struct xenix_super_block, s_inode[i]);
> -		if (offset < 512)
> -			return (sysv_ino_t*)(sbi->s_sbd1 + offset);
> -		else
> -			return (sysv_ino_t*)(sbi->s_sbd2 + offset);
> -	}
> -}
> -
> -struct sysv_inode *
> -sysv_raw_inode(struct super_block *sb, unsigned ino, struct buffer_head **bh)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	struct sysv_inode *res;
> -	int block = sbi->s_firstinodezone + sbi->s_block_base;
> -
> -	block += (ino-1) >> sbi->s_inodes_per_block_bits;
> -	*bh = sb_bread(sb, block);
> -	if (!*bh)
> -		return NULL;
> -	res = (struct sysv_inode *)(*bh)->b_data;
> -	return res + ((ino-1) & sbi->s_inodes_per_block_1);
> -}
> -
> -static int refill_free_cache(struct super_block *sb)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	int i = 0, ino;
> -
> -	ino = SYSV_ROOT_INO+1;
> -	raw_inode = sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode)
> -		goto out;
> -	while (ino <= sbi->s_ninodes) {
> -		if (raw_inode->i_mode == 0 && raw_inode->i_nlink == 0) {
> -			*sv_sb_fic_inode(sb,i++) = cpu_to_fs16(SYSV_SB(sb), ino);
> -			if (i == sbi->s_fic_size)
> -				break;
> -		}
> -		if ((ino++ & sbi->s_inodes_per_block_1) == 0) {
> -			brelse(bh);
> -			raw_inode = sysv_raw_inode(sb, ino, &bh);
> -			if (!raw_inode)
> -				goto out;
> -		} else
> -			raw_inode++;
> -	}
> -	brelse(bh);
> -out:
> -	return i;
> -}
> -
> -void sysv_free_inode(struct inode * inode)
> -{
> -	struct super_block *sb = inode->i_sb;
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	unsigned int ino;
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	unsigned count;
> -
> -	sb = inode->i_sb;
> -	ino = inode->i_ino;
> -	if (ino <= SYSV_ROOT_INO || ino > sbi->s_ninodes) {
> -		printk("sysv_free_inode: inode 0,1,2 or nonexistent inode\n");
> -		return;
> -	}
> -	raw_inode = sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode) {
> -		printk("sysv_free_inode: unable to read inode block on device "
> -		       "%s\n", inode->i_sb->s_id);
> -		return;
> -	}
> -	mutex_lock(&sbi->s_lock);
> -	count = fs16_to_cpu(sbi, *sbi->s_sb_fic_count);
> -	if (count < sbi->s_fic_size) {
> -		*sv_sb_fic_inode(sb,count++) = cpu_to_fs16(sbi, ino);
> -		*sbi->s_sb_fic_count = cpu_to_fs16(sbi, count);
> -	}
> -	fs16_add(sbi, sbi->s_sb_total_free_inodes, 1);
> -	dirty_sb(sb);
> -	memset(raw_inode, 0, sizeof(struct sysv_inode));
> -	mark_buffer_dirty(bh);
> -	mutex_unlock(&sbi->s_lock);
> -	brelse(bh);
> -}
> -
> -struct inode * sysv_new_inode(const struct inode * dir, umode_t mode)
> -{
> -	struct super_block *sb = dir->i_sb;
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	struct inode *inode;
> -	sysv_ino_t ino;
> -	unsigned count;
> -	struct writeback_control wbc = {
> -		.sync_mode = WB_SYNC_NONE
> -	};
> -
> -	inode = new_inode(sb);
> -	if (!inode)
> -		return ERR_PTR(-ENOMEM);
> -
> -	mutex_lock(&sbi->s_lock);
> -	count = fs16_to_cpu(sbi, *sbi->s_sb_fic_count);
> -	if (count == 0 || (*sv_sb_fic_inode(sb,count-1) == 0)) {
> -		count = refill_free_cache(sb);
> -		if (count == 0) {
> -			iput(inode);
> -			mutex_unlock(&sbi->s_lock);
> -			return ERR_PTR(-ENOSPC);
> -		}
> -	}
> -	/* Now count > 0. */
> -	ino = *sv_sb_fic_inode(sb,--count);
> -	*sbi->s_sb_fic_count = cpu_to_fs16(sbi, count);
> -	fs16_add(sbi, sbi->s_sb_total_free_inodes, -1);
> -	dirty_sb(sb);
> -	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
> -	inode->i_ino = fs16_to_cpu(sbi, ino);
> -	simple_inode_init_ts(inode);
> -	inode->i_blocks = 0;
> -	memset(SYSV_I(inode)->i_data, 0, sizeof(SYSV_I(inode)->i_data));
> -	SYSV_I(inode)->i_dir_start_lookup = 0;
> -	insert_inode_hash(inode);
> -	mark_inode_dirty(inode);
> -
> -	sysv_write_inode(inode, &wbc);	/* ensure inode not allocated again */
> -	mark_inode_dirty(inode);	/* cleared by sysv_write_inode() */
> -	/* That's it. */
> -	mutex_unlock(&sbi->s_lock);
> -	return inode;
> -}
> -
> -unsigned long sysv_count_free_inodes(struct super_block * sb)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	int ino, count, sb_count;
> -
> -	mutex_lock(&sbi->s_lock);
> -
> -	sb_count = fs16_to_cpu(sbi, *sbi->s_sb_total_free_inodes);
> -
> -	if (0)
> -		goto trust_sb;
> -
> -	/* this causes a lot of disk traffic ... */
> -	count = 0;
> -	ino = SYSV_ROOT_INO+1;
> -	raw_inode = sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode)
> -		goto Eio;
> -	while (ino <= sbi->s_ninodes) {
> -		if (raw_inode->i_mode == 0 && raw_inode->i_nlink == 0)
> -			count++;
> -		if ((ino++ & sbi->s_inodes_per_block_1) == 0) {
> -			brelse(bh);
> -			raw_inode = sysv_raw_inode(sb, ino, &bh);
> -			if (!raw_inode)
> -				goto Eio;
> -		} else
> -			raw_inode++;
> -	}
> -	brelse(bh);
> -	if (count != sb_count)
> -		goto Einval;
> -out:
> -	mutex_unlock(&sbi->s_lock);
> -	return count;
> -
> -Einval:
> -	printk("sysv_count_free_inodes: "
> -		"free inode count was %d, correcting to %d\n",
> -		sb_count, count);
> -	if (!sb_rdonly(sb)) {
> -		*sbi->s_sb_total_free_inodes = cpu_to_fs16(SYSV_SB(sb), count);
> -		dirty_sb(sb);
> -	}
> -	goto out;
> -
> -Eio:
> -	printk("sysv_count_free_inodes: unable to read inode table\n");
> -trust_sb:
> -	count = sb_count;
> -	goto out;
> -}
> diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
> deleted file mode 100644
> index 76bc2d5e75a9..000000000000
> --- a/fs/sysv/inode.c
> +++ /dev/null
> @@ -1,354 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/inode.c
> - *
> - *  minix/inode.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  xenix/inode.c
> - *  Copyright (C) 1992  Doug Evans
> - *
> - *  coh/inode.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/inode.c
> - *  Copyright (C) 1993  Paul B. Monday
> - *
> - *  sysv/inode.c
> - *  Copyright (C) 1993  Bruno Haible
> - *  Copyright (C) 1997, 1998  Krzysztof G. Baranowski
> - *
> - *  This file contains code for allocating/freeing inodes and for read/writing
> - *  the superblock.
> - */
> -
> -#include <linux/highuid.h>
> -#include <linux/slab.h>
> -#include <linux/init.h>
> -#include <linux/buffer_head.h>
> -#include <linux/vfs.h>
> -#include <linux/writeback.h>
> -#include <linux/namei.h>
> -#include <asm/byteorder.h>
> -#include "sysv.h"
> -
> -static int sysv_sync_fs(struct super_block *sb, int wait)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	u32 time = (u32)ktime_get_real_seconds(), old_time;
> -
> -	mutex_lock(&sbi->s_lock);
> -
> -	/*
> -	 * If we are going to write out the super block,
> -	 * then attach current time stamp.
> -	 * But if the filesystem was marked clean, keep it clean.
> -	 */
> -	old_time = fs32_to_cpu(sbi, *sbi->s_sb_time);
> -	if (sbi->s_type == FSTYPE_SYSV4) {
> -		if (*sbi->s_sb_state == cpu_to_fs32(sbi, 0x7c269d38u - old_time))
> -			*sbi->s_sb_state = cpu_to_fs32(sbi, 0x7c269d38u - time);
> -		*sbi->s_sb_time = cpu_to_fs32(sbi, time);
> -		mark_buffer_dirty(sbi->s_bh2);
> -	}
> -
> -	mutex_unlock(&sbi->s_lock);
> -
> -	return 0;
> -}
> -
> -static int sysv_remount(struct super_block *sb, int *flags, char *data)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -
> -	sync_filesystem(sb);
> -	if (sbi->s_forced_ro)
> -		*flags |= SB_RDONLY;
> -	return 0;
> -}
> -
> -static void sysv_put_super(struct super_block *sb)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -
> -	if (!sb_rdonly(sb)) {
> -		/* XXX ext2 also updates the state here */
> -		mark_buffer_dirty(sbi->s_bh1);
> -		if (sbi->s_bh1 != sbi->s_bh2)
> -			mark_buffer_dirty(sbi->s_bh2);
> -	}
> -
> -	brelse(sbi->s_bh1);
> -	if (sbi->s_bh1 != sbi->s_bh2)
> -		brelse(sbi->s_bh2);
> -
> -	kfree(sbi);
> -}
> -
> -static int sysv_statfs(struct dentry *dentry, struct kstatfs *buf)
> -{
> -	struct super_block *sb = dentry->d_sb;
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
> -
> -	buf->f_type = sb->s_magic;
> -	buf->f_bsize = sb->s_blocksize;
> -	buf->f_blocks = sbi->s_ndatazones;
> -	buf->f_bavail = buf->f_bfree = sysv_count_free_blocks(sb);
> -	buf->f_files = sbi->s_ninodes;
> -	buf->f_ffree = sysv_count_free_inodes(sb);
> -	buf->f_namelen = SYSV_NAMELEN;
> -	buf->f_fsid = u64_to_fsid(id);
> -	return 0;
> -}
> -
> -/* 
> - * NXI <-> N0XI for PDP, XIN <-> XIN0 for le32, NIX <-> 0NIX for be32
> - */
> -static inline void read3byte(struct sysv_sb_info *sbi,
> -	unsigned char * from, unsigned char * to)
> -{
> -	if (sbi->s_bytesex == BYTESEX_PDP) {
> -		to[0] = from[0];
> -		to[1] = 0;
> -		to[2] = from[1];
> -		to[3] = from[2];
> -	} else if (sbi->s_bytesex == BYTESEX_LE) {
> -		to[0] = from[0];
> -		to[1] = from[1];
> -		to[2] = from[2];
> -		to[3] = 0;
> -	} else {
> -		to[0] = 0;
> -		to[1] = from[0];
> -		to[2] = from[1];
> -		to[3] = from[2];
> -	}
> -}
> -
> -static inline void write3byte(struct sysv_sb_info *sbi,
> -	unsigned char * from, unsigned char * to)
> -{
> -	if (sbi->s_bytesex == BYTESEX_PDP) {
> -		to[0] = from[0];
> -		to[1] = from[2];
> -		to[2] = from[3];
> -	} else if (sbi->s_bytesex == BYTESEX_LE) {
> -		to[0] = from[0];
> -		to[1] = from[1];
> -		to[2] = from[2];
> -	} else {
> -		to[0] = from[1];
> -		to[1] = from[2];
> -		to[2] = from[3];
> -	}
> -}
> -
> -static const struct inode_operations sysv_symlink_inode_operations = {
> -	.get_link	= page_get_link,
> -	.getattr	= sysv_getattr,
> -};
> -
> -void sysv_set_inode(struct inode *inode, dev_t rdev)
> -{
> -	if (S_ISREG(inode->i_mode)) {
> -		inode->i_op = &sysv_file_inode_operations;
> -		inode->i_fop = &sysv_file_operations;
> -		inode->i_mapping->a_ops = &sysv_aops;
> -	} else if (S_ISDIR(inode->i_mode)) {
> -		inode->i_op = &sysv_dir_inode_operations;
> -		inode->i_fop = &sysv_dir_operations;
> -		inode->i_mapping->a_ops = &sysv_aops;
> -	} else if (S_ISLNK(inode->i_mode)) {
> -		inode->i_op = &sysv_symlink_inode_operations;
> -		inode_nohighmem(inode);
> -		inode->i_mapping->a_ops = &sysv_aops;
> -	} else
> -		init_special_inode(inode, inode->i_mode, rdev);
> -}
> -
> -struct inode *sysv_iget(struct super_block *sb, unsigned int ino)
> -{
> -	struct sysv_sb_info * sbi = SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	struct sysv_inode_info * si;
> -	struct inode *inode;
> -	unsigned int block;
> -
> -	if (!ino || ino > sbi->s_ninodes) {
> -		printk("Bad inode number on dev %s: %d is out of range\n",
> -		       sb->s_id, ino);
> -		return ERR_PTR(-EIO);
> -	}
> -
> -	inode = iget_locked(sb, ino);
> -	if (!inode)
> -		return ERR_PTR(-ENOMEM);
> -	if (!(inode->i_state & I_NEW))
> -		return inode;
> -
> -	raw_inode = sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode) {
> -		printk("Major problem: unable to read inode from dev %s\n",
> -		       inode->i_sb->s_id);
> -		goto bad_inode;
> -	}
> -	/* SystemV FS: kludge permissions if ino==SYSV_ROOT_INO ?? */
> -	inode->i_mode = fs16_to_cpu(sbi, raw_inode->i_mode);
> -	i_uid_write(inode, (uid_t)fs16_to_cpu(sbi, raw_inode->i_uid));
> -	i_gid_write(inode, (gid_t)fs16_to_cpu(sbi, raw_inode->i_gid));
> -	set_nlink(inode, fs16_to_cpu(sbi, raw_inode->i_nlink));
> -	inode->i_size = fs32_to_cpu(sbi, raw_inode->i_size);
> -	inode_set_atime(inode, fs32_to_cpu(sbi, raw_inode->i_atime), 0);
> -	inode_set_mtime(inode, fs32_to_cpu(sbi, raw_inode->i_mtime), 0);
> -	inode_set_ctime(inode, fs32_to_cpu(sbi, raw_inode->i_ctime), 0);
> -	inode->i_blocks = 0;
> -
> -	si = SYSV_I(inode);
> -	for (block = 0; block < 10+1+1+1; block++)
> -		read3byte(sbi, &raw_inode->i_data[3*block],
> -				(u8 *)&si->i_data[block]);
> -	brelse(bh);
> -	si->i_dir_start_lookup = 0;
> -	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> -		sysv_set_inode(inode,
> -			       old_decode_dev(fs32_to_cpu(sbi, si->i_data[0])));
> -	else
> -		sysv_set_inode(inode, 0);
> -	unlock_new_inode(inode);
> -	return inode;
> -
> -bad_inode:
> -	iget_failed(inode);
> -	return ERR_PTR(-EIO);
> -}
> -
> -static int __sysv_write_inode(struct inode *inode, int wait)
> -{
> -	struct super_block * sb = inode->i_sb;
> -	struct sysv_sb_info * sbi = SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	struct sysv_inode_info * si;
> -	unsigned int ino, block;
> -	int err = 0;
> -
> -	ino = inode->i_ino;
> -	if (!ino || ino > sbi->s_ninodes) {
> -		printk("Bad inode number on dev %s: %d is out of range\n",
> -		       inode->i_sb->s_id, ino);
> -		return -EIO;
> -	}
> -	raw_inode = sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode) {
> -		printk("unable to read i-node block\n");
> -		return -EIO;
> -	}
> -
> -	raw_inode->i_mode = cpu_to_fs16(sbi, inode->i_mode);
> -	raw_inode->i_uid = cpu_to_fs16(sbi, fs_high2lowuid(i_uid_read(inode)));
> -	raw_inode->i_gid = cpu_to_fs16(sbi, fs_high2lowgid(i_gid_read(inode)));
> -	raw_inode->i_nlink = cpu_to_fs16(sbi, inode->i_nlink);
> -	raw_inode->i_size = cpu_to_fs32(sbi, inode->i_size);
> -	raw_inode->i_atime = cpu_to_fs32(sbi, inode_get_atime_sec(inode));
> -	raw_inode->i_mtime = cpu_to_fs32(sbi, inode_get_mtime_sec(inode));
> -	raw_inode->i_ctime = cpu_to_fs32(sbi, inode_get_ctime_sec(inode));
> -
> -	si = SYSV_I(inode);
> -	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> -		si->i_data[0] = cpu_to_fs32(sbi, old_encode_dev(inode->i_rdev));
> -	for (block = 0; block < 10+1+1+1; block++)
> -		write3byte(sbi, (u8 *)&si->i_data[block],
> -			&raw_inode->i_data[3*block]);
> -	mark_buffer_dirty(bh);
> -	if (wait) {
> -                sync_dirty_buffer(bh);
> -                if (buffer_req(bh) && !buffer_uptodate(bh)) {
> -                        printk ("IO error syncing sysv inode [%s:%08x]\n",
> -                                sb->s_id, ino);
> -                        err = -EIO;
> -                }
> -        }
> -	brelse(bh);
> -	return err;
> -}
> -
> -int sysv_write_inode(struct inode *inode, struct writeback_control *wbc)
> -{
> -	return __sysv_write_inode(inode, wbc->sync_mode == WB_SYNC_ALL);
> -}
> -
> -int sysv_sync_inode(struct inode *inode)
> -{
> -	return __sysv_write_inode(inode, 1);
> -}
> -
> -static void sysv_evict_inode(struct inode *inode)
> -{
> -	truncate_inode_pages_final(&inode->i_data);
> -	if (!inode->i_nlink) {
> -		inode->i_size = 0;
> -		sysv_truncate(inode);
> -	}
> -	invalidate_inode_buffers(inode);
> -	clear_inode(inode);
> -	if (!inode->i_nlink)
> -		sysv_free_inode(inode);
> -}
> -
> -static struct kmem_cache *sysv_inode_cachep;
> -
> -static struct inode *sysv_alloc_inode(struct super_block *sb)
> -{
> -	struct sysv_inode_info *si;
> -
> -	si = alloc_inode_sb(sb, sysv_inode_cachep, GFP_KERNEL);
> -	if (!si)
> -		return NULL;
> -	return &si->vfs_inode;
> -}
> -
> -static void sysv_free_in_core_inode(struct inode *inode)
> -{
> -	kmem_cache_free(sysv_inode_cachep, SYSV_I(inode));
> -}
> -
> -static void init_once(void *p)
> -{
> -	struct sysv_inode_info *si = (struct sysv_inode_info *)p;
> -
> -	inode_init_once(&si->vfs_inode);
> -}
> -
> -const struct super_operations sysv_sops = {
> -	.alloc_inode	= sysv_alloc_inode,
> -	.free_inode	= sysv_free_in_core_inode,
> -	.write_inode	= sysv_write_inode,
> -	.evict_inode	= sysv_evict_inode,
> -	.put_super	= sysv_put_super,
> -	.sync_fs	= sysv_sync_fs,
> -	.remount_fs	= sysv_remount,
> -	.statfs		= sysv_statfs,
> -};
> -
> -int __init sysv_init_icache(void)
> -{
> -	sysv_inode_cachep = kmem_cache_create("sysv_inode_cache",
> -			sizeof(struct sysv_inode_info), 0,
> -			SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
> -			init_once);
> -	if (!sysv_inode_cachep)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -void sysv_destroy_icache(void)
> -{
> -	/*
> -	 * Make sure all delayed rcu free inodes are flushed before we
> -	 * destroy cache.
> -	 */
> -	rcu_barrier();
> -	kmem_cache_destroy(sysv_inode_cachep);
> -}
> diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
> deleted file mode 100644
> index 451e95f474fa..000000000000
> --- a/fs/sysv/itree.c
> +++ /dev/null
> @@ -1,511 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/itree.c
> - *
> - *  Handling of indirect blocks' trees.
> - *  AV, Sep--Dec 2000
> - */
> -
> -#include <linux/buffer_head.h>
> -#include <linux/mount.h>
> -#include <linux/mpage.h>
> -#include <linux/string.h>
> -#include "sysv.h"
> -
> -enum {DIRECT = 10, DEPTH = 4};	/* Have triple indirect */
> -
> -static inline void dirty_indirect(struct buffer_head *bh, struct inode *inode)
> -{
> -	mark_buffer_dirty_inode(bh, inode);
> -	if (IS_SYNC(inode))
> -		sync_dirty_buffer(bh);
> -}
> -
> -static int block_to_path(struct inode *inode, long block, int offsets[DEPTH])
> -{
> -	struct super_block *sb = inode->i_sb;
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	int ptrs_bits = sbi->s_ind_per_block_bits;
> -	unsigned long	indirect_blocks = sbi->s_ind_per_block,
> -			double_blocks = sbi->s_ind_per_block_2;
> -	int n = 0;
> -
> -	if (block < 0) {
> -		printk("sysv_block_map: block < 0\n");
> -	} else if (block < DIRECT) {
> -		offsets[n++] = block;
> -	} else if ( (block -= DIRECT) < indirect_blocks) {
> -		offsets[n++] = DIRECT;
> -		offsets[n++] = block;
> -	} else if ((block -= indirect_blocks) < double_blocks) {
> -		offsets[n++] = DIRECT+1;
> -		offsets[n++] = block >> ptrs_bits;
> -		offsets[n++] = block & (indirect_blocks - 1);
> -	} else if (((block -= double_blocks) >> (ptrs_bits * 2)) < indirect_blocks) {
> -		offsets[n++] = DIRECT+2;
> -		offsets[n++] = block >> (ptrs_bits * 2);
> -		offsets[n++] = (block >> ptrs_bits) & (indirect_blocks - 1);
> -		offsets[n++] = block & (indirect_blocks - 1);
> -	} else {
> -		/* nothing */;
> -	}
> -	return n;
> -}
> -
> -static inline int block_to_cpu(struct sysv_sb_info *sbi, sysv_zone_t nr)
> -{
> -	return sbi->s_block_base + fs32_to_cpu(sbi, nr);
> -}
> -
> -typedef struct {
> -	sysv_zone_t     *p;
> -	sysv_zone_t     key;
> -	struct buffer_head *bh;
> -} Indirect;
> -
> -static DEFINE_RWLOCK(pointers_lock);
> -
> -static inline void add_chain(Indirect *p, struct buffer_head *bh, sysv_zone_t *v)
> -{
> -	p->key = *(p->p = v);
> -	p->bh = bh;
> -}
> -
> -static inline int verify_chain(Indirect *from, Indirect *to)
> -{
> -	while (from <= to && from->key == *from->p)
> -		from++;
> -	return (from > to);
> -}
> -
> -static inline sysv_zone_t *block_end(struct buffer_head *bh)
> -{
> -	return (sysv_zone_t*)((char*)bh->b_data + bh->b_size);
> -}
> -
> -static Indirect *get_branch(struct inode *inode,
> -			    int depth,
> -			    int offsets[],
> -			    Indirect chain[],
> -			    int *err)
> -{
> -	struct super_block *sb = inode->i_sb;
> -	Indirect *p = chain;
> -	struct buffer_head *bh;
> -
> -	*err = 0;
> -	add_chain(chain, NULL, SYSV_I(inode)->i_data + *offsets);
> -	if (!p->key)
> -		goto no_block;
> -	while (--depth) {
> -		int block = block_to_cpu(SYSV_SB(sb), p->key);
> -		bh = sb_bread(sb, block);
> -		if (!bh)
> -			goto failure;
> -		read_lock(&pointers_lock);
> -		if (!verify_chain(chain, p))
> -			goto changed;
> -		add_chain(++p, bh, (sysv_zone_t*)bh->b_data + *++offsets);
> -		read_unlock(&pointers_lock);
> -		if (!p->key)
> -			goto no_block;
> -	}
> -	return NULL;
> -
> -changed:
> -	read_unlock(&pointers_lock);
> -	brelse(bh);
> -	*err = -EAGAIN;
> -	goto no_block;
> -failure:
> -	*err = -EIO;
> -no_block:
> -	return p;
> -}
> -
> -static int alloc_branch(struct inode *inode,
> -			int num,
> -			int *offsets,
> -			Indirect *branch)
> -{
> -	int blocksize = inode->i_sb->s_blocksize;
> -	int n = 0;
> -	int i;
> -
> -	branch[0].key = sysv_new_block(inode->i_sb);
> -	if (branch[0].key) for (n = 1; n < num; n++) {
> -		struct buffer_head *bh;
> -		int parent;
> -		/* Allocate the next block */
> -		branch[n].key = sysv_new_block(inode->i_sb);
> -		if (!branch[n].key)
> -			break;
> -		/*
> -		 * Get buffer_head for parent block, zero it out and set 
> -		 * the pointer to new one, then send parent to disk.
> -		 */
> -		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
> -		bh = sb_getblk(inode->i_sb, parent);
> -		if (!bh) {
> -			sysv_free_block(inode->i_sb, branch[n].key);
> -			break;
> -		}
> -		lock_buffer(bh);
> -		memset(bh->b_data, 0, blocksize);
> -		branch[n].bh = bh;
> -		branch[n].p = (sysv_zone_t*) bh->b_data + offsets[n];
> -		*branch[n].p = branch[n].key;
> -		set_buffer_uptodate(bh);
> -		unlock_buffer(bh);
> -		dirty_indirect(bh, inode);
> -	}
> -	if (n == num)
> -		return 0;
> -
> -	/* Allocation failed, free what we already allocated */
> -	for (i = 1; i < n; i++)
> -		bforget(branch[i].bh);
> -	for (i = 0; i < n; i++)
> -		sysv_free_block(inode->i_sb, branch[i].key);
> -	return -ENOSPC;
> -}
> -
> -static inline int splice_branch(struct inode *inode,
> -				Indirect chain[],
> -				Indirect *where,
> -				int num)
> -{
> -	int i;
> -
> -	/* Verify that place we are splicing to is still there and vacant */
> -	write_lock(&pointers_lock);
> -	if (!verify_chain(chain, where-1) || *where->p)
> -		goto changed;
> -	*where->p = where->key;
> -	write_unlock(&pointers_lock);
> -
> -	inode_set_ctime_current(inode);
> -
> -	/* had we spliced it onto indirect block? */
> -	if (where->bh)
> -		dirty_indirect(where->bh, inode);
> -
> -	if (IS_SYNC(inode))
> -		sysv_sync_inode(inode);
> -	else
> -		mark_inode_dirty(inode);
> -	return 0;
> -
> -changed:
> -	write_unlock(&pointers_lock);
> -	for (i = 1; i < num; i++)
> -		bforget(where[i].bh);
> -	for (i = 0; i < num; i++)
> -		sysv_free_block(inode->i_sb, where[i].key);
> -	return -EAGAIN;
> -}
> -
> -static int get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
> -{
> -	int err = -EIO;
> -	int offsets[DEPTH];
> -	Indirect chain[DEPTH];
> -	struct super_block *sb = inode->i_sb;
> -	Indirect *partial;
> -	int left;
> -	int depth = block_to_path(inode, iblock, offsets);
> -
> -	if (depth == 0)
> -		goto out;
> -
> -reread:
> -	partial = get_branch(inode, depth, offsets, chain, &err);
> -
> -	/* Simplest case - block found, no allocation needed */
> -	if (!partial) {
> -got_it:
> -		map_bh(bh_result, sb, block_to_cpu(SYSV_SB(sb),
> -					chain[depth-1].key));
> -		/* Clean up and exit */
> -		partial = chain+depth-1; /* the whole chain */
> -		goto cleanup;
> -	}
> -
> -	/* Next simple case - plain lookup or failed read of indirect block */
> -	if (!create || err == -EIO) {
> -cleanup:
> -		while (partial > chain) {
> -			brelse(partial->bh);
> -			partial--;
> -		}
> -out:
> -		return err;
> -	}
> -
> -	/*
> -	 * Indirect block might be removed by truncate while we were
> -	 * reading it. Handling of that case (forget what we've got and
> -	 * reread) is taken out of the main path.
> -	 */
> -	if (err == -EAGAIN)
> -		goto changed;
> -
> -	left = (chain + depth) - partial;
> -	err = alloc_branch(inode, left, offsets+(partial-chain), partial);
> -	if (err)
> -		goto cleanup;
> -
> -	if (splice_branch(inode, chain, partial, left) < 0)
> -		goto changed;
> -
> -	set_buffer_new(bh_result);
> -	goto got_it;
> -
> -changed:
> -	while (partial > chain) {
> -		brelse(partial->bh);
> -		partial--;
> -	}
> -	goto reread;
> -}
> -
> -static inline int all_zeroes(sysv_zone_t *p, sysv_zone_t *q)
> -{
> -	while (p < q)
> -		if (*p++)
> -			return 0;
> -	return 1;
> -}
> -
> -static Indirect *find_shared(struct inode *inode,
> -				int depth,
> -				int offsets[],
> -				Indirect chain[],
> -				sysv_zone_t *top)
> -{
> -	Indirect *partial, *p;
> -	int k, err;
> -
> -	*top = 0;
> -	for (k = depth; k > 1 && !offsets[k-1]; k--)
> -		;
> -	partial = get_branch(inode, k, offsets, chain, &err);
> -
> -	write_lock(&pointers_lock);
> -	if (!partial)
> -		partial = chain + k-1;
> -	/*
> -	 * If the branch acquired continuation since we've looked at it -
> -	 * fine, it should all survive and (new) top doesn't belong to us.
> -	 */
> -	if (!partial->key && *partial->p) {
> -		write_unlock(&pointers_lock);
> -		goto no_top;
> -	}
> -	for (p=partial; p>chain && all_zeroes((sysv_zone_t*)p->bh->b_data,p->p); p--)
> -		;
> -	/*
> -	 * OK, we've found the last block that must survive. The rest of our
> -	 * branch should be detached before unlocking. However, if that rest
> -	 * of branch is all ours and does not grow immediately from the inode
> -	 * it's easier to cheat and just decrement partial->p.
> -	 */
> -	if (p == chain + k - 1 && p > chain) {
> -		p->p--;
> -	} else {
> -		*top = *p->p;
> -		*p->p = 0;
> -	}
> -	write_unlock(&pointers_lock);
> -
> -	while (partial > p) {
> -		brelse(partial->bh);
> -		partial--;
> -	}
> -no_top:
> -	return partial;
> -}
> -
> -static inline void free_data(struct inode *inode, sysv_zone_t *p, sysv_zone_t *q)
> -{
> -	for ( ; p < q ; p++) {
> -		sysv_zone_t nr = *p;
> -		if (nr) {
> -			*p = 0;
> -			sysv_free_block(inode->i_sb, nr);
> -			mark_inode_dirty(inode);
> -		}
> -	}
> -}
> -
> -static void free_branches(struct inode *inode, sysv_zone_t *p, sysv_zone_t *q, int depth)
> -{
> -	struct buffer_head * bh;
> -	struct super_block *sb = inode->i_sb;
> -
> -	if (depth--) {
> -		for ( ; p < q ; p++) {
> -			int block;
> -			sysv_zone_t nr = *p;
> -			if (!nr)
> -				continue;
> -			*p = 0;
> -			block = block_to_cpu(SYSV_SB(sb), nr);
> -			bh = sb_bread(sb, block);
> -			if (!bh)
> -				continue;
> -			free_branches(inode, (sysv_zone_t*)bh->b_data,
> -					block_end(bh), depth);
> -			bforget(bh);
> -			sysv_free_block(sb, nr);
> -			mark_inode_dirty(inode);
> -		}
> -	} else
> -		free_data(inode, p, q);
> -}
> -
> -void sysv_truncate (struct inode * inode)
> -{
> -	sysv_zone_t *i_data = SYSV_I(inode)->i_data;
> -	int offsets[DEPTH];
> -	Indirect chain[DEPTH];
> -	Indirect *partial;
> -	sysv_zone_t nr = 0;
> -	int n;
> -	long iblock;
> -	unsigned blocksize;
> -
> -	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> -	    S_ISLNK(inode->i_mode)))
> -		return;
> -
> -	blocksize = inode->i_sb->s_blocksize;
> -	iblock = (inode->i_size + blocksize-1)
> -					>> inode->i_sb->s_blocksize_bits;
> -
> -	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
> -
> -	n = block_to_path(inode, iblock, offsets);
> -	if (n == 0)
> -		return;
> -
> -	if (n == 1) {
> -		free_data(inode, i_data+offsets[0], i_data + DIRECT);
> -		goto do_indirects;
> -	}
> -
> -	partial = find_shared(inode, n, offsets, chain, &nr);
> -	/* Kill the top of shared branch (already detached) */
> -	if (nr) {
> -		if (partial == chain)
> -			mark_inode_dirty(inode);
> -		else
> -			dirty_indirect(partial->bh, inode);
> -		free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
> -	}
> -	/* Clear the ends of indirect blocks on the shared branch */
> -	while (partial > chain) {
> -		free_branches(inode, partial->p + 1, block_end(partial->bh),
> -				(chain+n-1) - partial);
> -		dirty_indirect(partial->bh, inode);
> -		brelse (partial->bh);
> -		partial--;
> -	}
> -do_indirects:
> -	/* Kill the remaining (whole) subtrees (== subtrees deeper than...) */
> -	while (n < DEPTH) {
> -		nr = i_data[DIRECT + n - 1];
> -		if (nr) {
> -			i_data[DIRECT + n - 1] = 0;
> -			mark_inode_dirty(inode);
> -			free_branches(inode, &nr, &nr+1, n);
> -		}
> -		n++;
> -	}
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> -	if (IS_SYNC(inode))
> -		sysv_sync_inode (inode);
> -	else
> -		mark_inode_dirty(inode);
> -}
> -
> -static unsigned sysv_nblocks(struct super_block *s, loff_t size)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(s);
> -	int ptrs_bits = sbi->s_ind_per_block_bits;
> -	unsigned blocks, res, direct = DIRECT, i = DEPTH;
> -	blocks = (size + s->s_blocksize - 1) >> s->s_blocksize_bits;
> -	res = blocks;
> -	while (--i && blocks > direct) {
> -		blocks = ((blocks - direct - 1) >> ptrs_bits) + 1;
> -		res += blocks;
> -		direct = 1;
> -	}
> -	return res;
> -}
> -
> -int sysv_getattr(struct mnt_idmap *idmap, const struct path *path,
> -		 struct kstat *stat, u32 request_mask, unsigned int flags)
> -{
> -	struct super_block *s = path->dentry->d_sb;
> -	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(path->dentry),
> -			 stat);
> -	stat->blocks = (s->s_blocksize / 512) * sysv_nblocks(s, stat->size);
> -	stat->blksize = s->s_blocksize;
> -	return 0;
> -}
> -
> -static int sysv_writepages(struct address_space *mapping,
> -		struct writeback_control *wbc)
> -{
> -	return mpage_writepages(mapping, wbc, get_block);
> -}
> -
> -static int sysv_read_folio(struct file *file, struct folio *folio)
> -{
> -	return block_read_full_folio(folio, get_block);
> -}
> -
> -int sysv_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
> -{
> -	return __block_write_begin(folio, pos, len, get_block);
> -}
> -
> -static void sysv_write_failed(struct address_space *mapping, loff_t to)
> -{
> -	struct inode *inode = mapping->host;
> -
> -	if (to > inode->i_size) {
> -		truncate_pagecache(inode, inode->i_size);
> -		sysv_truncate(inode);
> -	}
> -}
> -
> -static int sysv_write_begin(struct file *file, struct address_space *mapping,
> -			loff_t pos, unsigned len,
> -			struct folio **foliop, void **fsdata)
> -{
> -	int ret;
> -
> -	ret = block_write_begin(mapping, pos, len, foliop, get_block);
> -	if (unlikely(ret))
> -		sysv_write_failed(mapping, pos + len);
> -
> -	return ret;
> -}
> -
> -static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
> -{
> -	return generic_block_bmap(mapping,block,get_block);
> -}
> -
> -const struct address_space_operations sysv_aops = {
> -	.dirty_folio = block_dirty_folio,
> -	.invalidate_folio = block_invalidate_folio,
> -	.read_folio = sysv_read_folio,
> -	.writepages = sysv_writepages,
> -	.write_begin = sysv_write_begin,
> -	.write_end = generic_write_end,
> -	.migrate_folio = buffer_migrate_folio,
> -	.bmap = sysv_bmap
> -};
> diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
> deleted file mode 100644
> index fb8bd8437872..000000000000
> --- a/fs/sysv/namei.c
> +++ /dev/null
> @@ -1,280 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/namei.c
> - *
> - *  minix/namei.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  coh/namei.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/namei.c
> - *  Copyright (C) 1993  Bruno Haible
> - *  Copyright (C) 1997, 1998  Krzysztof G. Baranowski
> - */
> -
> -#include <linux/pagemap.h>
> -#include "sysv.h"
> -
> -static int add_nondir(struct dentry *dentry, struct inode *inode)
> -{
> -	int err = sysv_add_link(dentry, inode);
> -	if (!err) {
> -		d_instantiate(dentry, inode);
> -		return 0;
> -	}
> -	inode_dec_link_count(inode);
> -	iput(inode);
> -	return err;
> -}
> -
> -static struct dentry *sysv_lookup(struct inode * dir, struct dentry * dentry, unsigned int flags)
> -{
> -	struct inode * inode = NULL;
> -	ino_t ino;
> -
> -	if (dentry->d_name.len > SYSV_NAMELEN)
> -		return ERR_PTR(-ENAMETOOLONG);
> -	ino = sysv_inode_by_name(dentry);
> -	if (ino)
> -		inode = sysv_iget(dir->i_sb, ino);
> -	return d_splice_alias(inode, dentry);
> -}
> -
> -static int sysv_mknod(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode, dev_t rdev)
> -{
> -	struct inode * inode;
> -	int err;
> -
> -	if (!old_valid_dev(rdev))
> -		return -EINVAL;
> -
> -	inode = sysv_new_inode(dir, mode);
> -	err = PTR_ERR(inode);
> -
> -	if (!IS_ERR(inode)) {
> -		sysv_set_inode(inode, rdev);
> -		mark_inode_dirty(inode);
> -		err = add_nondir(dentry, inode);
> -	}
> -	return err;
> -}
> -
> -static int sysv_create(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode, bool excl)
> -{
> -	return sysv_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
> -}
> -
> -static int sysv_symlink(struct mnt_idmap *idmap, struct inode *dir,
> -			struct dentry *dentry, const char *symname)
> -{
> -	int err = -ENAMETOOLONG;
> -	int l = strlen(symname)+1;
> -	struct inode * inode;
> -
> -	if (l > dir->i_sb->s_blocksize)
> -		goto out;
> -
> -	inode = sysv_new_inode(dir, S_IFLNK|0777);
> -	err = PTR_ERR(inode);
> -	if (IS_ERR(inode))
> -		goto out;
> -	
> -	sysv_set_inode(inode, 0);
> -	err = page_symlink(inode, symname, l);
> -	if (err)
> -		goto out_fail;
> -
> -	mark_inode_dirty(inode);
> -	err = add_nondir(dentry, inode);
> -out:
> -	return err;
> -
> -out_fail:
> -	inode_dec_link_count(inode);
> -	iput(inode);
> -	goto out;
> -}
> -
> -static int sysv_link(struct dentry * old_dentry, struct inode * dir, 
> -	struct dentry * dentry)
> -{
> -	struct inode *inode = d_inode(old_dentry);
> -
> -	inode_set_ctime_current(inode);
> -	inode_inc_link_count(inode);
> -	ihold(inode);
> -
> -	return add_nondir(dentry, inode);
> -}
> -
> -static int sysv_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> -{
> -	struct inode * inode;
> -	int err;
> -
> -	inode_inc_link_count(dir);
> -
> -	inode = sysv_new_inode(dir, S_IFDIR|mode);
> -	err = PTR_ERR(inode);
> -	if (IS_ERR(inode))
> -		goto out_dir;
> -
> -	sysv_set_inode(inode, 0);
> -
> -	inode_inc_link_count(inode);
> -
> -	err = sysv_make_empty(inode, dir);
> -	if (err)
> -		goto out_fail;
> -
> -	err = sysv_add_link(dentry, inode);
> -	if (err)
> -		goto out_fail;
> -
> -        d_instantiate(dentry, inode);
> -out:
> -	return err;
> -
> -out_fail:
> -	inode_dec_link_count(inode);
> -	inode_dec_link_count(inode);
> -	iput(inode);
> -out_dir:
> -	inode_dec_link_count(dir);
> -	goto out;
> -}
> -
> -static int sysv_unlink(struct inode * dir, struct dentry * dentry)
> -{
> -	struct inode * inode = d_inode(dentry);
> -	struct folio *folio;
> -	struct sysv_dir_entry * de;
> -	int err;
> -
> -	de = sysv_find_entry(dentry, &folio);
> -	if (!de)
> -		return -ENOENT;
> -
> -	err = sysv_delete_entry(de, folio);
> -	if (!err) {
> -		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
> -		inode_dec_link_count(inode);
> -	}
> -	folio_release_kmap(folio, de);
> -	return err;
> -}
> -
> -static int sysv_rmdir(struct inode * dir, struct dentry * dentry)
> -{
> -	struct inode *inode = d_inode(dentry);
> -	int err = -ENOTEMPTY;
> -
> -	if (sysv_empty_dir(inode)) {
> -		err = sysv_unlink(dir, dentry);
> -		if (!err) {
> -			inode->i_size = 0;
> -			inode_dec_link_count(inode);
> -			inode_dec_link_count(dir);
> -		}
> -	}
> -	return err;
> -}
> -
> -/*
> - * Anybody can rename anything with this: the permission checks are left to the
> - * higher-level routines.
> - */
> -static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
> -		       struct dentry *old_dentry, struct inode *new_dir,
> -		       struct dentry *new_dentry, unsigned int flags)
> -{
> -	struct inode * old_inode = d_inode(old_dentry);
> -	struct inode * new_inode = d_inode(new_dentry);
> -	struct folio *dir_folio;
> -	struct sysv_dir_entry * dir_de = NULL;
> -	struct folio *old_folio;
> -	struct sysv_dir_entry * old_de;
> -	int err = -ENOENT;
> -
> -	if (flags & ~RENAME_NOREPLACE)
> -		return -EINVAL;
> -
> -	old_de = sysv_find_entry(old_dentry, &old_folio);
> -	if (!old_de)
> -		goto out;
> -
> -	if (S_ISDIR(old_inode->i_mode)) {
> -		err = -EIO;
> -		dir_de = sysv_dotdot(old_inode, &dir_folio);
> -		if (!dir_de)
> -			goto out_old;
> -	}
> -
> -	if (new_inode) {
> -		struct folio *new_folio;
> -		struct sysv_dir_entry * new_de;
> -
> -		err = -ENOTEMPTY;
> -		if (dir_de && !sysv_empty_dir(new_inode))
> -			goto out_dir;
> -
> -		err = -ENOENT;
> -		new_de = sysv_find_entry(new_dentry, &new_folio);
> -		if (!new_de)
> -			goto out_dir;
> -		err = sysv_set_link(new_de, new_folio, old_inode);
> -		folio_release_kmap(new_folio, new_de);
> -		if (err)
> -			goto out_dir;
> -		inode_set_ctime_current(new_inode);
> -		if (dir_de)
> -			drop_nlink(new_inode);
> -		inode_dec_link_count(new_inode);
> -	} else {
> -		err = sysv_add_link(new_dentry, old_inode);
> -		if (err)
> -			goto out_dir;
> -		if (dir_de)
> -			inode_inc_link_count(new_dir);
> -	}
> -
> -	err = sysv_delete_entry(old_de, old_folio);
> -	if (err)
> -		goto out_dir;
> -
> -	mark_inode_dirty(old_inode);
> -
> -	if (dir_de) {
> -		err = sysv_set_link(dir_de, dir_folio, new_dir);
> -		if (!err)
> -			inode_dec_link_count(old_dir);
> -	}
> -
> -out_dir:
> -	if (dir_de)
> -		folio_release_kmap(dir_folio, dir_de);
> -out_old:
> -	folio_release_kmap(old_folio, old_de);
> -out:
> -	return err;
> -}
> -
> -/*
> - * directories can handle most operations...
> - */
> -const struct inode_operations sysv_dir_inode_operations = {
> -	.create		= sysv_create,
> -	.lookup		= sysv_lookup,
> -	.link		= sysv_link,
> -	.unlink		= sysv_unlink,
> -	.symlink	= sysv_symlink,
> -	.mkdir		= sysv_mkdir,
> -	.rmdir		= sysv_rmdir,
> -	.mknod		= sysv_mknod,
> -	.rename		= sysv_rename,
> -	.getattr	= sysv_getattr,
> -};
> diff --git a/fs/sysv/super.c b/fs/sysv/super.c
> deleted file mode 100644
> index 03be9f1b7802..000000000000
> --- a/fs/sysv/super.c
> +++ /dev/null
> @@ -1,616 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/fs/sysv/inode.c
> - *
> - *  minix/inode.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  xenix/inode.c
> - *  Copyright (C) 1992  Doug Evans
> - *
> - *  coh/inode.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/inode.c
> - *  Copyright (C) 1993  Paul B. Monday
> - *
> - *  sysv/inode.c
> - *  Copyright (C) 1993  Bruno Haible
> - *  Copyright (C) 1997, 1998  Krzysztof G. Baranowski
> - *
> - *  This file contains code for read/parsing the superblock.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/slab.h>
> -#include <linux/buffer_head.h>
> -#include <linux/fs_context.h>
> -#include "sysv.h"
> -
> -/*
> - * The following functions try to recognize specific filesystems.
> - *
> - * We recognize:
> - * - Xenix FS by its magic number.
> - * - SystemV FS by its magic number.
> - * - Coherent FS by its funny fname/fpack field.
> - * - SCO AFS by s_nfree == 0xffff
> - * - V7 FS has no distinguishing features.
> - *
> - * We discriminate among SystemV4 and SystemV2 FS by the assumption that
> - * the time stamp is not < 01-01-1980.
> - */
> -
> -enum {
> -	JAN_1_1980 = (10*365 + 2) * 24 * 60 * 60
> -};
> -
> -static void detected_xenix(struct sysv_sb_info *sbi, unsigned *max_links)
> -{
> -	struct buffer_head *bh1 = sbi->s_bh1;
> -	struct buffer_head *bh2 = sbi->s_bh2;
> -	struct xenix_super_block * sbd1;
> -	struct xenix_super_block * sbd2;
> -
> -	if (bh1 != bh2)
> -		sbd1 = sbd2 = (struct xenix_super_block *) bh1->b_data;
> -	else {
> -		/* block size = 512, so bh1 != bh2 */
> -		sbd1 = (struct xenix_super_block *) bh1->b_data;
> -		sbd2 = (struct xenix_super_block *) (bh2->b_data - 512);
> -	}
> -
> -	*max_links = XENIX_LINK_MAX;
> -	sbi->s_fic_size = XENIX_NICINOD;
> -	sbi->s_flc_size = XENIX_NICFREE;
> -	sbi->s_sbd1 = (char *)sbd1;
> -	sbi->s_sbd2 = (char *)sbd2;
> -	sbi->s_sb_fic_count = &sbd1->s_ninode;
> -	sbi->s_sb_fic_inodes = &sbd1->s_inode[0];
> -	sbi->s_sb_total_free_inodes = &sbd2->s_tinode;
> -	sbi->s_bcache_count = &sbd1->s_nfree;
> -	sbi->s_bcache = &sbd1->s_free[0];
> -	sbi->s_free_blocks = &sbd2->s_tfree;
> -	sbi->s_sb_time = &sbd2->s_time;
> -	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd1->s_isize);
> -	sbi->s_nzones = fs32_to_cpu(sbi, sbd1->s_fsize);
> -}
> -
> -static void detected_sysv4(struct sysv_sb_info *sbi, unsigned *max_links)
> -{
> -	struct sysv4_super_block * sbd;
> -	struct buffer_head *bh1 = sbi->s_bh1;
> -	struct buffer_head *bh2 = sbi->s_bh2;
> -
> -	if (bh1 == bh2)
> -		sbd = (struct sysv4_super_block *) (bh1->b_data + BLOCK_SIZE/2);
> -	else
> -		sbd = (struct sysv4_super_block *) bh2->b_data;
> -
> -	*max_links = SYSV_LINK_MAX;
> -	sbi->s_fic_size = SYSV_NICINOD;
> -	sbi->s_flc_size = SYSV_NICFREE;
> -	sbi->s_sbd1 = (char *)sbd;
> -	sbi->s_sbd2 = (char *)sbd;
> -	sbi->s_sb_fic_count = &sbd->s_ninode;
> -	sbi->s_sb_fic_inodes = &sbd->s_inode[0];
> -	sbi->s_sb_total_free_inodes = &sbd->s_tinode;
> -	sbi->s_bcache_count = &sbd->s_nfree;
> -	sbi->s_bcache = &sbd->s_free[0];
> -	sbi->s_free_blocks = &sbd->s_tfree;
> -	sbi->s_sb_time = &sbd->s_time;
> -	sbi->s_sb_state = &sbd->s_state;
> -	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd->s_isize);
> -	sbi->s_nzones = fs32_to_cpu(sbi, sbd->s_fsize);
> -}
> -
> -static void detected_sysv2(struct sysv_sb_info *sbi, unsigned *max_links)
> -{
> -	struct sysv2_super_block *sbd;
> -	struct buffer_head *bh1 = sbi->s_bh1;
> -	struct buffer_head *bh2 = sbi->s_bh2;
> -
> -	if (bh1 == bh2)
> -		sbd = (struct sysv2_super_block *) (bh1->b_data + BLOCK_SIZE/2);
> -	else
> -		sbd = (struct sysv2_super_block *) bh2->b_data;
> -
> -	*max_links = SYSV_LINK_MAX;
> -	sbi->s_fic_size = SYSV_NICINOD;
> -	sbi->s_flc_size = SYSV_NICFREE;
> -	sbi->s_sbd1 = (char *)sbd;
> -	sbi->s_sbd2 = (char *)sbd;
> -	sbi->s_sb_fic_count = &sbd->s_ninode;
> -	sbi->s_sb_fic_inodes = &sbd->s_inode[0];
> -	sbi->s_sb_total_free_inodes = &sbd->s_tinode;
> -	sbi->s_bcache_count = &sbd->s_nfree;
> -	sbi->s_bcache = &sbd->s_free[0];
> -	sbi->s_free_blocks = &sbd->s_tfree;
> -	sbi->s_sb_time = &sbd->s_time;
> -	sbi->s_sb_state = &sbd->s_state;
> -	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd->s_isize);
> -	sbi->s_nzones = fs32_to_cpu(sbi, sbd->s_fsize);
> -}
> -
> -static void detected_coherent(struct sysv_sb_info *sbi, unsigned *max_links)
> -{
> -	struct coh_super_block * sbd;
> -	struct buffer_head *bh1 = sbi->s_bh1;
> -
> -	sbd = (struct coh_super_block *) bh1->b_data;
> -
> -	*max_links = COH_LINK_MAX;
> -	sbi->s_fic_size = COH_NICINOD;
> -	sbi->s_flc_size = COH_NICFREE;
> -	sbi->s_sbd1 = (char *)sbd;
> -	sbi->s_sbd2 = (char *)sbd;
> -	sbi->s_sb_fic_count = &sbd->s_ninode;
> -	sbi->s_sb_fic_inodes = &sbd->s_inode[0];
> -	sbi->s_sb_total_free_inodes = &sbd->s_tinode;
> -	sbi->s_bcache_count = &sbd->s_nfree;
> -	sbi->s_bcache = &sbd->s_free[0];
> -	sbi->s_free_blocks = &sbd->s_tfree;
> -	sbi->s_sb_time = &sbd->s_time;
> -	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd->s_isize);
> -	sbi->s_nzones = fs32_to_cpu(sbi, sbd->s_fsize);
> -}
> -
> -static void detected_v7(struct sysv_sb_info *sbi, unsigned *max_links)
> -{
> -	struct buffer_head *bh2 = sbi->s_bh2;
> -	struct v7_super_block *sbd = (struct v7_super_block *)bh2->b_data;
> -
> -	*max_links = V7_LINK_MAX;
> -	sbi->s_fic_size = V7_NICINOD;
> -	sbi->s_flc_size = V7_NICFREE;
> -	sbi->s_sbd1 = (char *)sbd;
> -	sbi->s_sbd2 = (char *)sbd;
> -	sbi->s_sb_fic_count = &sbd->s_ninode;
> -	sbi->s_sb_fic_inodes = &sbd->s_inode[0];
> -	sbi->s_sb_total_free_inodes = &sbd->s_tinode;
> -	sbi->s_bcache_count = &sbd->s_nfree;
> -	sbi->s_bcache = &sbd->s_free[0];
> -	sbi->s_free_blocks = &sbd->s_tfree;
> -	sbi->s_sb_time = &sbd->s_time;
> -	sbi->s_firstdatazone = fs16_to_cpu(sbi, sbd->s_isize);
> -	sbi->s_nzones = fs32_to_cpu(sbi, sbd->s_fsize);
> -}
> -
> -static int detect_xenix(struct sysv_sb_info *sbi, struct buffer_head *bh)
> -{
> -	struct xenix_super_block *sbd = (struct xenix_super_block *)bh->b_data;
> -	if (*(__le32 *)&sbd->s_magic == cpu_to_le32(0x2b5544))
> -		sbi->s_bytesex = BYTESEX_LE;
> -	else if (*(__be32 *)&sbd->s_magic == cpu_to_be32(0x2b5544))
> -		sbi->s_bytesex = BYTESEX_BE;
> -	else
> -		return 0;
> -	switch (fs32_to_cpu(sbi, sbd->s_type)) {
> -	case 1:
> -		sbi->s_type = FSTYPE_XENIX;
> -		return 1;
> -	case 2:
> -		sbi->s_type = FSTYPE_XENIX;
> -		return 2;
> -	default:
> -		return 0;
> -	}
> -}
> -
> -static int detect_sysv(struct sysv_sb_info *sbi, struct buffer_head *bh)
> -{
> -	struct super_block *sb = sbi->s_sb;
> -	/* All relevant fields are at the same offsets in R2 and R4 */
> -	struct sysv4_super_block * sbd;
> -	u32 type;
> -
> -	sbd = (struct sysv4_super_block *) (bh->b_data + BLOCK_SIZE/2);
> -	if (*(__le32 *)&sbd->s_magic == cpu_to_le32(0xfd187e20))
> -		sbi->s_bytesex = BYTESEX_LE;
> -	else if (*(__be32 *)&sbd->s_magic == cpu_to_be32(0xfd187e20))
> -		sbi->s_bytesex = BYTESEX_BE;
> -	else
> -		return 0;
> -
> -	type = fs32_to_cpu(sbi, sbd->s_type);
> - 
> - 	if (fs16_to_cpu(sbi, sbd->s_nfree) == 0xffff) {
> - 		sbi->s_type = FSTYPE_AFS;
> -		sbi->s_forced_ro = 1;
> - 		if (!sb_rdonly(sb)) {
> - 			printk("SysV FS: SCO EAFS on %s detected, " 
> - 				"forcing read-only mode.\n", 
> - 				sb->s_id);
> - 		}
> - 		return type;
> - 	}
> - 
> -	if (fs32_to_cpu(sbi, sbd->s_time) < JAN_1_1980) {
> -		/* this is likely to happen on SystemV2 FS */
> -		if (type > 3 || type < 1)
> -			return 0;
> -		sbi->s_type = FSTYPE_SYSV2;
> -		return type;
> -	}
> -	if ((type > 3 || type < 1) && (type > 0x30 || type < 0x10))
> -		return 0;
> -
> -	/* On Interactive Unix (ISC) Version 4.0/3.x s_type field = 0x10,
> -	   0x20 or 0x30 indicates that symbolic links and the 14-character
> -	   filename limit is gone. Due to lack of information about this
> -           feature read-only mode seems to be a reasonable approach... -KGB */
> -
> -	if (type >= 0x10) {
> -		printk("SysV FS: can't handle long file names on %s, "
> -		       "forcing read-only mode.\n", sb->s_id);
> -		sbi->s_forced_ro = 1;
> -	}
> -
> -	sbi->s_type = FSTYPE_SYSV4;
> -	return type >= 0x10 ? type >> 4 : type;
> -}
> -
> -static int detect_coherent(struct sysv_sb_info *sbi, struct buffer_head *bh)
> -{
> -	struct coh_super_block * sbd;
> -
> -	sbd = (struct coh_super_block *) (bh->b_data + BLOCK_SIZE/2);
> -	if ((memcmp(sbd->s_fname,"noname",6) && memcmp(sbd->s_fname,"xxxxx ",6))
> -	    || (memcmp(sbd->s_fpack,"nopack",6) && memcmp(sbd->s_fpack,"xxxxx\n",6)))
> -		return 0;
> -	sbi->s_bytesex = BYTESEX_PDP;
> -	sbi->s_type = FSTYPE_COH;
> -	return 1;
> -}
> -
> -static int detect_sysv_odd(struct sysv_sb_info *sbi, struct buffer_head *bh)
> -{
> -	int size = detect_sysv(sbi, bh);
> -
> -	return size>2 ? 0 : size;
> -}
> -
> -static struct {
> -	int block;
> -	int (*test)(struct sysv_sb_info *, struct buffer_head *);
> -} flavours[] = {
> -	{1, detect_xenix},
> -	{0, detect_sysv},
> -	{0, detect_coherent},
> -	{9, detect_sysv_odd},
> -	{15,detect_sysv_odd},
> -	{18,detect_sysv},
> -};
> -
> -static char *flavour_names[] = {
> -	[FSTYPE_XENIX]	= "Xenix",
> -	[FSTYPE_SYSV4]	= "SystemV",
> -	[FSTYPE_SYSV2]	= "SystemV Release 2",
> -	[FSTYPE_COH]	= "Coherent",
> -	[FSTYPE_V7]	= "V7",
> -	[FSTYPE_AFS]	= "AFS",
> -};
> -
> -static void (*flavour_setup[])(struct sysv_sb_info *, unsigned *) = {
> -	[FSTYPE_XENIX]	= detected_xenix,
> -	[FSTYPE_SYSV4]	= detected_sysv4,
> -	[FSTYPE_SYSV2]	= detected_sysv2,
> -	[FSTYPE_COH]	= detected_coherent,
> -	[FSTYPE_V7]	= detected_v7,
> -	[FSTYPE_AFS]	= detected_sysv4,
> -};
> -
> -static int complete_read_super(struct super_block *sb, int silent, int size)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -	struct inode *root_inode;
> -	char *found = flavour_names[sbi->s_type];
> -	u_char n_bits = size+8;
> -	int bsize = 1 << n_bits;
> -	int bsize_4 = bsize >> 2;
> -
> -	sbi->s_firstinodezone = 2;
> -
> -	flavour_setup[sbi->s_type](sbi, &sb->s_max_links);
> -	if (sbi->s_firstdatazone < sbi->s_firstinodezone)
> -		return 0;
> -
> -	sbi->s_ndatazones = sbi->s_nzones - sbi->s_firstdatazone;
> -	sbi->s_inodes_per_block = bsize >> 6;
> -	sbi->s_inodes_per_block_1 = (bsize >> 6)-1;
> -	sbi->s_inodes_per_block_bits = n_bits-6;
> -	sbi->s_ind_per_block = bsize_4;
> -	sbi->s_ind_per_block_2 = bsize_4*bsize_4;
> -	sbi->s_toobig_block = 10 + bsize_4 * (1 + bsize_4 * (1 + bsize_4));
> -	sbi->s_ind_per_block_bits = n_bits-2;
> -
> -	sbi->s_ninodes = (sbi->s_firstdatazone - sbi->s_firstinodezone)
> -		<< sbi->s_inodes_per_block_bits;
> -
> -	if (!silent)
> -		printk("VFS: Found a %s FS (block size = %ld) on device %s\n",
> -		       found, sb->s_blocksize, sb->s_id);
> -
> -	sb->s_magic = SYSV_MAGIC_BASE + sbi->s_type;
> -	/* set up enough so that it can read an inode */
> -	sb->s_op = &sysv_sops;
> -	if (sbi->s_forced_ro)
> -		sb->s_flags |= SB_RDONLY;
> -	root_inode = sysv_iget(sb, SYSV_ROOT_INO);
> -	if (IS_ERR(root_inode)) {
> -		printk("SysV FS: get root inode failed\n");
> -		return 0;
> -	}
> -	sb->s_root = d_make_root(root_inode);
> -	if (!sb->s_root) {
> -		printk("SysV FS: get root dentry failed\n");
> -		return 0;
> -	}
> -	return 1;
> -}
> -
> -static int sysv_fill_super(struct super_block *sb, struct fs_context *fc)
> -{
> -	struct buffer_head *bh1, *bh = NULL;
> -	struct sysv_sb_info *sbi;
> -	unsigned long blocknr;
> -	int size = 0, i;
> -	int silent = fc->sb_flags & SB_SILENT;
> -	
> -	BUILD_BUG_ON(1024 != sizeof (struct xenix_super_block));
> -	BUILD_BUG_ON(512 != sizeof (struct sysv4_super_block));
> -	BUILD_BUG_ON(512 != sizeof (struct sysv2_super_block));
> -	BUILD_BUG_ON(500 != sizeof (struct coh_super_block));
> -	BUILD_BUG_ON(64 != sizeof (struct sysv_inode));
> -
> -	sbi = kzalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> -
> -	sbi->s_sb = sb;
> -	sbi->s_block_base = 0;
> -	mutex_init(&sbi->s_lock);
> -	sb->s_fs_info = sbi;
> -	sb->s_time_min = 0;
> -	sb->s_time_max = U32_MAX;
> -	sb_set_blocksize(sb, BLOCK_SIZE);
> -
> -	for (i = 0; i < ARRAY_SIZE(flavours) && !size; i++) {
> -		brelse(bh);
> -		bh = sb_bread(sb, flavours[i].block);
> -		if (!bh)
> -			continue;
> -		size = flavours[i].test(SYSV_SB(sb), bh);
> -	}
> -
> -	if (!size)
> -		goto Eunknown;
> -
> -	switch (size) {
> -		case 1:
> -			blocknr = bh->b_blocknr << 1;
> -			brelse(bh);
> -			sb_set_blocksize(sb, 512);
> -			bh1 = sb_bread(sb, blocknr);
> -			bh = sb_bread(sb, blocknr + 1);
> -			break;
> -		case 2:
> -			bh1 = bh;
> -			break;
> -		case 3:
> -			blocknr = bh->b_blocknr >> 1;
> -			brelse(bh);
> -			sb_set_blocksize(sb, 2048);
> -			bh1 = bh = sb_bread(sb, blocknr);
> -			break;
> -		default:
> -			goto Ebadsize;
> -	}
> -
> -	if (bh && bh1) {
> -		sbi->s_bh1 = bh1;
> -		sbi->s_bh2 = bh;
> -		if (complete_read_super(sb, silent, size))
> -			return 0;
> -	}
> -
> -	brelse(bh1);
> -	brelse(bh);
> -	sb_set_blocksize(sb, BLOCK_SIZE);
> -	printk("oldfs: cannot read superblock\n");
> -failed:
> -	kfree(sbi);
> -	return -EINVAL;
> -
> -Eunknown:
> -	brelse(bh);
> -	if (!silent)
> -		printk("VFS: unable to find oldfs superblock on device %s\n",
> -			sb->s_id);
> -	goto failed;
> -Ebadsize:
> -	brelse(bh);
> -	if (!silent)
> -		printk("VFS: oldfs: unsupported block size (%dKb)\n",
> -			1<<(size-2));
> -	goto failed;
> -}
> -
> -static int v7_sanity_check(struct super_block *sb, struct buffer_head *bh)
> -{
> -	struct v7_super_block *v7sb;
> -	struct sysv_inode *v7i;
> -	struct buffer_head *bh2;
> -	struct sysv_sb_info *sbi;
> -
> -	sbi = sb->s_fs_info;
> -
> -	/* plausibility check on superblock */
> -	v7sb = (struct v7_super_block *) bh->b_data;
> -	if (fs16_to_cpu(sbi, v7sb->s_nfree) > V7_NICFREE ||
> -	    fs16_to_cpu(sbi, v7sb->s_ninode) > V7_NICINOD ||
> -	    fs32_to_cpu(sbi, v7sb->s_fsize) > V7_MAXSIZE)
> -		return 0;
> -
> -	/* plausibility check on root inode: it is a directory,
> -	   with a nonzero size that is a multiple of 16 */
> -	bh2 = sb_bread(sb, 2);
> -	if (bh2 == NULL)
> -		return 0;
> -
> -	v7i = (struct sysv_inode *)(bh2->b_data + 64);
> -	if ((fs16_to_cpu(sbi, v7i->i_mode) & ~0777) != S_IFDIR ||
> -	    (fs32_to_cpu(sbi, v7i->i_size) == 0) ||
> -	    (fs32_to_cpu(sbi, v7i->i_size) & 017) ||
> -	    (fs32_to_cpu(sbi, v7i->i_size) > V7_NFILES *
> -	     sizeof(struct sysv_dir_entry))) {
> -		brelse(bh2);
> -		return 0;
> -	}
> -
> -	brelse(bh2);
> -	return 1;
> -}
> -
> -static int v7_fill_super(struct super_block *sb, struct fs_context *fc)
> -{
> -	struct sysv_sb_info *sbi;
> -	struct buffer_head *bh;
> -	int silent = fc->sb_flags & SB_SILENT;
> -
> -	BUILD_BUG_ON(sizeof(struct v7_super_block) != 440);
> -	BUILD_BUG_ON(sizeof(struct sysv_inode) != 64);
> -
> -	sbi = kzalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> -
> -	sbi->s_sb = sb;
> -	sbi->s_block_base = 0;
> -	sbi->s_type = FSTYPE_V7;
> -	mutex_init(&sbi->s_lock);
> -	sb->s_fs_info = sbi;
> -	sb->s_time_min = 0;
> -	sb->s_time_max = U32_MAX;
> -	
> -	sb_set_blocksize(sb, 512);
> -
> -	if ((bh = sb_bread(sb, 1)) == NULL) {
> -		if (!silent)
> -			printk("VFS: unable to read V7 FS superblock on "
> -			       "device %s.\n", sb->s_id);
> -		goto failed;
> -	}
> -
> -	/* Try PDP-11 UNIX */
> -	sbi->s_bytesex = BYTESEX_PDP;
> -	if (v7_sanity_check(sb, bh))
> -		goto detected;
> -
> -	/* Try PC/IX, v7/x86 */
> -	sbi->s_bytesex = BYTESEX_LE;
> -	if (v7_sanity_check(sb, bh))
> -		goto detected;
> -
> -	goto failed;
> -
> -detected:
> -	sbi->s_bh1 = bh;
> -	sbi->s_bh2 = bh;
> -	if (complete_read_super(sb, silent, 1))
> -		return 0;
> -
> -failed:
> -	printk(KERN_ERR "VFS: could not find a valid V7 on %s.\n",
> -		sb->s_id);
> -	brelse(bh);
> -	kfree(sbi);
> -	return -EINVAL;
> -}
> -
> -/* Every kernel module contains stuff like this. */
> -
> -static int sysv_get_tree(struct fs_context *fc)
> -{
> -	return get_tree_bdev(fc, sysv_fill_super);
> -}
> -
> -static int v7_get_tree(struct fs_context *fc)
> -{
> -	return get_tree_bdev(fc, v7_fill_super);
> -}
> -
> -static const struct fs_context_operations sysv_context_ops = {
> -	.get_tree	= sysv_get_tree,
> -};
> -
> -static const struct fs_context_operations v7_context_ops = {
> -	.get_tree	= v7_get_tree,
> -};
> -
> -static int sysv_init_fs_context(struct fs_context *fc)
> -{
> -	fc->ops = &sysv_context_ops;
> -	return 0;
> -}
> -
> -static int v7_init_fs_context(struct fs_context *fc)
> -{
> -	fc->ops = &v7_context_ops;
> -	return 0;
> -}
> -
> -static struct file_system_type sysv_fs_type = {
> -	.owner			= THIS_MODULE,
> -	.name			= "sysv",
> -	.kill_sb		= kill_block_super,
> -	.fs_flags		= FS_REQUIRES_DEV,
> -	.init_fs_context	= sysv_init_fs_context,
> -};
> -MODULE_ALIAS_FS("sysv");
> -
> -static struct file_system_type v7_fs_type = {
> -	.owner			= THIS_MODULE,
> -	.name			= "v7",
> -	.kill_sb		= kill_block_super,
> -	.fs_flags		= FS_REQUIRES_DEV,
> -	.init_fs_context	= v7_init_fs_context,
> -};
> -MODULE_ALIAS_FS("v7");
> -MODULE_ALIAS("v7");
> -
> -static int __init init_sysv_fs(void)
> -{
> -	int error;
> -
> -	error = sysv_init_icache();
> -	if (error)
> -		goto out;
> -	error = register_filesystem(&sysv_fs_type);
> -	if (error)
> -		goto destroy_icache;
> -	error = register_filesystem(&v7_fs_type);
> -	if (error)
> -		goto unregister;
> -	return 0;
> -
> -unregister:
> -	unregister_filesystem(&sysv_fs_type);
> -destroy_icache:
> -	sysv_destroy_icache();
> -out:
> -	return error;
> -}
> -
> -static void __exit exit_sysv_fs(void)
> -{
> -	unregister_filesystem(&sysv_fs_type);
> -	unregister_filesystem(&v7_fs_type);
> -	sysv_destroy_icache();
> -}
> -
> -module_init(init_sysv_fs)
> -module_exit(exit_sysv_fs)
> -MODULE_DESCRIPTION("SystemV Filesystem");
> -MODULE_LICENSE("GPL");
> diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
> deleted file mode 100644
> index 0a48b2e7edb1..000000000000
> --- a/fs/sysv/sysv.h
> +++ /dev/null
> @@ -1,245 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _SYSV_H
> -#define _SYSV_H
> -
> -#include <linux/buffer_head.h>
> -
> -typedef __u16 __bitwise __fs16;
> -typedef __u32 __bitwise __fs32;
> -
> -#include <linux/sysv_fs.h>
> -
> -/*
> - * SystemV/V7/Coherent super-block data in memory
> - *
> - * The SystemV/V7/Coherent superblock contains dynamic data (it gets modified
> - * while the system is running). This is in contrast to the Minix and Berkeley
> - * filesystems (where the superblock is never modified). This affects the
> - * sync() operation: we must keep the superblock in a disk buffer and use this
> - * one as our "working copy".
> - */
> -
> -struct sysv_sb_info {
> -	struct super_block *s_sb;	/* VFS superblock */
> -	int	       s_type;		/* file system type: FSTYPE_{XENIX|SYSV|COH} */
> -	char	       s_bytesex;	/* bytesex (le/be/pdp) */
> -	unsigned int   s_inodes_per_block;	/* number of inodes per block */
> -	unsigned int   s_inodes_per_block_1;	/* inodes_per_block - 1 */
> -	unsigned int   s_inodes_per_block_bits;	/* log2(inodes_per_block) */
> -	unsigned int   s_ind_per_block;		/* number of indirections per block */
> -	unsigned int   s_ind_per_block_bits;	/* log2(ind_per_block) */
> -	unsigned int   s_ind_per_block_2;	/* ind_per_block ^ 2 */
> -	unsigned int   s_toobig_block;		/* 10 + ipb + ipb^2 + ipb^3 */
> -	unsigned int   s_block_base;	/* physical block number of block 0 */
> -	unsigned short s_fic_size;	/* free inode cache size, NICINOD */
> -	unsigned short s_flc_size;	/* free block list chunk size, NICFREE */
> -	/* The superblock is kept in one or two disk buffers: */
> -	struct buffer_head *s_bh1;
> -	struct buffer_head *s_bh2;
> -	/* These are pointers into the disk buffer, to compensate for
> -	   different superblock layout. */
> -	char *         s_sbd1;		/* entire superblock data, for part 1 */
> -	char *         s_sbd2;		/* entire superblock data, for part 2 */
> -	__fs16         *s_sb_fic_count;	/* pointer to s_sbd->s_ninode */
> -        sysv_ino_t     *s_sb_fic_inodes; /* pointer to s_sbd->s_inode */
> -	__fs16         *s_sb_total_free_inodes; /* pointer to s_sbd->s_tinode */
> -	__fs16         *s_bcache_count;	/* pointer to s_sbd->s_nfree */
> -	sysv_zone_t    *s_bcache;	/* pointer to s_sbd->s_free */
> -	__fs32         *s_free_blocks;	/* pointer to s_sbd->s_tfree */
> -	__fs32         *s_sb_time;	/* pointer to s_sbd->s_time */
> -	__fs32         *s_sb_state;	/* pointer to s_sbd->s_state, only FSTYPE_SYSV */
> -	/* We keep those superblock entities that don't change here;
> -	   this saves us an indirection and perhaps a conversion. */
> -	u32            s_firstinodezone; /* index of first inode zone */
> -	u32            s_firstdatazone;	/* same as s_sbd->s_isize */
> -	u32            s_ninodes;	/* total number of inodes */
> -	u32            s_ndatazones;	/* total number of data zones */
> -	u32            s_nzones;	/* same as s_sbd->s_fsize */
> -	u16	       s_namelen;       /* max length of dir entry */
> -	int	       s_forced_ro;
> -	struct mutex s_lock;
> -};
> -
> -/*
> - * SystemV/V7/Coherent FS inode data in memory
> - */
> -struct sysv_inode_info {
> -	__fs32		i_data[13];
> -	u32		i_dir_start_lookup;
> -	struct inode	vfs_inode;
> -};
> -
> -
> -static inline struct sysv_inode_info *SYSV_I(struct inode *inode)
> -{
> -	return container_of(inode, struct sysv_inode_info, vfs_inode);
> -}
> -
> -static inline struct sysv_sb_info *SYSV_SB(struct super_block *sb)
> -{
> -	return sb->s_fs_info;
> -}
> -
> -
> -/* identify the FS in memory */
> -enum {
> -	FSTYPE_NONE = 0,
> -	FSTYPE_XENIX,
> -	FSTYPE_SYSV4,
> -	FSTYPE_SYSV2,
> -	FSTYPE_COH,
> -	FSTYPE_V7,
> -	FSTYPE_AFS,
> -	FSTYPE_END,
> -};
> -
> -#define SYSV_MAGIC_BASE		0x012FF7B3
> -
> -#define XENIX_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_XENIX)
> -#define SYSV4_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_SYSV4)
> -#define SYSV2_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_SYSV2)
> -#define COH_SUPER_MAGIC		(SYSV_MAGIC_BASE+FSTYPE_COH)
> -
> -
> -/* Admissible values for i_nlink: 0.._LINK_MAX */
> -enum {
> -	XENIX_LINK_MAX	=	126,	/* ?? */
> -	SYSV_LINK_MAX	=	126,	/* 127? 251? */
> -	V7_LINK_MAX     =	126,	/* ?? */
> -	COH_LINK_MAX	=	10000,
> -};
> -
> -
> -static inline void dirty_sb(struct super_block *sb)
> -{
> -	struct sysv_sb_info *sbi = SYSV_SB(sb);
> -
> -	mark_buffer_dirty(sbi->s_bh1);
> -	if (sbi->s_bh1 != sbi->s_bh2)
> -		mark_buffer_dirty(sbi->s_bh2);
> -}
> -
> -
> -/* ialloc.c */
> -extern struct sysv_inode *sysv_raw_inode(struct super_block *, unsigned,
> -			struct buffer_head **);
> -extern struct inode * sysv_new_inode(const struct inode *, umode_t);
> -extern void sysv_free_inode(struct inode *);
> -extern unsigned long sysv_count_free_inodes(struct super_block *);
> -
> -/* balloc.c */
> -extern sysv_zone_t sysv_new_block(struct super_block *);
> -extern void sysv_free_block(struct super_block *, sysv_zone_t);
> -extern unsigned long sysv_count_free_blocks(struct super_block *);
> -
> -/* itree.c */
> -void sysv_truncate(struct inode *);
> -int sysv_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
> -
> -/* inode.c */
> -extern struct inode *sysv_iget(struct super_block *, unsigned int);
> -extern int sysv_write_inode(struct inode *, struct writeback_control *wbc);
> -extern int sysv_sync_inode(struct inode *);
> -extern void sysv_set_inode(struct inode *, dev_t);
> -extern int sysv_getattr(struct mnt_idmap *, const struct path *,
> -			struct kstat *, u32, unsigned int);
> -extern int sysv_init_icache(void);
> -extern void sysv_destroy_icache(void);
> -
> -
> -/* dir.c */
> -struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct folio **);
> -int sysv_add_link(struct dentry *, struct inode *);
> -int sysv_delete_entry(struct sysv_dir_entry *, struct folio *);
> -int sysv_make_empty(struct inode *, struct inode *);
> -int sysv_empty_dir(struct inode *);
> -int sysv_set_link(struct sysv_dir_entry *, struct folio *,
> -			struct inode *);
> -struct sysv_dir_entry *sysv_dotdot(struct inode *, struct folio **);
> -ino_t sysv_inode_by_name(struct dentry *);
> -
> -
> -extern const struct inode_operations sysv_file_inode_operations;
> -extern const struct inode_operations sysv_dir_inode_operations;
> -extern const struct file_operations sysv_file_operations;
> -extern const struct file_operations sysv_dir_operations;
> -extern const struct address_space_operations sysv_aops;
> -extern const struct super_operations sysv_sops;
> -
> -
> -enum {
> -	BYTESEX_LE,
> -	BYTESEX_PDP,
> -	BYTESEX_BE,
> -};
> -
> -static inline u32 PDP_swab(u32 x)
> -{
> -#ifdef __LITTLE_ENDIAN
> -	return ((x & 0xffff) << 16) | ((x & 0xffff0000) >> 16);
> -#else
> -#ifdef __BIG_ENDIAN
> -	return ((x & 0xff00ff) << 8) | ((x & 0xff00ff00) >> 8);
> -#else
> -#error BYTESEX
> -#endif
> -#endif
> -}
> -
> -static inline __u32 fs32_to_cpu(struct sysv_sb_info *sbi, __fs32 n)
> -{
> -	if (sbi->s_bytesex == BYTESEX_PDP)
> -		return PDP_swab((__force __u32)n);
> -	else if (sbi->s_bytesex == BYTESEX_LE)
> -		return le32_to_cpu((__force __le32)n);
> -	else
> -		return be32_to_cpu((__force __be32)n);
> -}
> -
> -static inline __fs32 cpu_to_fs32(struct sysv_sb_info *sbi, __u32 n)
> -{
> -	if (sbi->s_bytesex == BYTESEX_PDP)
> -		return (__force __fs32)PDP_swab(n);
> -	else if (sbi->s_bytesex == BYTESEX_LE)
> -		return (__force __fs32)cpu_to_le32(n);
> -	else
> -		return (__force __fs32)cpu_to_be32(n);
> -}
> -
> -static inline __fs32 fs32_add(struct sysv_sb_info *sbi, __fs32 *n, int d)
> -{
> -	if (sbi->s_bytesex == BYTESEX_PDP)
> -		*(__u32*)n = PDP_swab(PDP_swab(*(__u32*)n)+d);
> -	else if (sbi->s_bytesex == BYTESEX_LE)
> -		le32_add_cpu((__le32 *)n, d);
> -	else
> -		be32_add_cpu((__be32 *)n, d);
> -	return *n;
> -}
> -
> -static inline __u16 fs16_to_cpu(struct sysv_sb_info *sbi, __fs16 n)
> -{
> -	if (sbi->s_bytesex != BYTESEX_BE)
> -		return le16_to_cpu((__force __le16)n);
> -	else
> -		return be16_to_cpu((__force __be16)n);
> -}
> -
> -static inline __fs16 cpu_to_fs16(struct sysv_sb_info *sbi, __u16 n)
> -{
> -	if (sbi->s_bytesex != BYTESEX_BE)
> -		return (__force __fs16)cpu_to_le16(n);
> -	else
> -		return (__force __fs16)cpu_to_be16(n);
> -}
> -
> -static inline __fs16 fs16_add(struct sysv_sb_info *sbi, __fs16 *n, int d)
> -{
> -	if (sbi->s_bytesex != BYTESEX_BE)
> -		le16_add_cpu((__le16 *)n, d);
> -	else
> -		be16_add_cpu((__be16 *)n, d);
> -	return *n;
> -}
> -
> -#endif /* _SYSV_H */
> diff --git a/include/linux/sysv_fs.h b/include/linux/sysv_fs.h
> deleted file mode 100644
> index 5cf77dbb8d86..000000000000
> --- a/include/linux/sysv_fs.h
> +++ /dev/null
> @@ -1,214 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_SYSV_FS_H
> -#define _LINUX_SYSV_FS_H
> -
> -#define __packed2__	__attribute__((packed, aligned(2)))
> -
> -
> -#ifndef __KERNEL__
> -typedef u16 __fs16;
> -typedef u32 __fs16;
> -#endif
> -
> -/* inode numbers are 16 bit */
> -typedef __fs16 sysv_ino_t;
> -
> -/* Block numbers are 24 bit, sometimes stored in 32 bit.
> -   On Coherent FS, they are always stored in PDP-11 manner: the least
> -   significant 16 bits come last. */
> -typedef __fs32 sysv_zone_t;
> -
> -/* 0 is non-existent */
> -#define SYSV_BADBL_INO	1	/* inode of bad blocks file */
> -#define SYSV_ROOT_INO	2	/* inode of root directory */
> -
> -
> -/* Xenix super-block data on disk */
> -#define XENIX_NICINOD	100	/* number of inode cache entries */
> -#define XENIX_NICFREE	100	/* number of free block list chunk entries */
> -struct xenix_super_block {
> -	__fs16		s_isize; /* index of first data zone */
> -	__fs32		s_fsize __packed2__; /* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16		s_nfree;	/* number of free blocks in s_free, <= XENIX_NICFREE */
> -	sysv_zone_t	s_free[XENIX_NICFREE]; /* first free block list chunk */
> -	/* the cache of free inodes: */
> -	__fs16		s_ninode; /* number of free inodes in s_inode, <= XENIX_NICINOD */
> -	sysv_ino_t	s_inode[XENIX_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux: */
> -	char		s_flock;	/* lock during free block list manipulation */
> -	char		s_ilock;	/* lock during inode cache manipulation */
> -	char		s_fmod;		/* super-block modified flag */
> -	char		s_ronly;	/* flag whether fs is mounted read-only */
> -	__fs32		s_time __packed2__; /* time of last super block update */
> -	__fs32		s_tfree __packed2__; /* total number of free zones */
> -	__fs16		s_tinode;	/* total number of free inodes */
> -	__fs16		s_dinfo[4];	/* device information ?? */
> -	char		s_fname[6];	/* file system volume name */
> -	char		s_fpack[6];	/* file system pack name */
> -	char		s_clean;	/* set to 0x46 when filesystem is properly unmounted */
> -	char		s_fill[371];
> -	s32		s_magic;	/* version of file system */
> -	__fs32		s_type;		/* type of file system: 1 for 512 byte blocks
> -								2 for 1024 byte blocks
> -								3 for 2048 byte blocks */
> -								
> -};
> -
> -/*
> - * SystemV FS comes in two variants:
> - * sysv2: System V Release 2 (e.g. Microport), structure elements aligned(2).
> - * sysv4: System V Release 4 (e.g. Consensys), structure elements aligned(4).
> - */
> -#define SYSV_NICINOD	100	/* number of inode cache entries */
> -#define SYSV_NICFREE	50	/* number of free block list chunk entries */
> -
> -/* SystemV4 super-block data on disk */
> -struct sysv4_super_block {
> -	__fs16	s_isize;	/* index of first data zone */
> -	u16	s_pad0;
> -	__fs32	s_fsize;	/* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16	s_nfree;	/* number of free blocks in s_free, <= SYSV_NICFREE */
> -	u16	s_pad1;
> -	sysv_zone_t	s_free[SYSV_NICFREE]; /* first free block list chunk */
> -	/* the cache of free inodes: */
> -	__fs16	s_ninode;	/* number of free inodes in s_inode, <= SYSV_NICINOD */
> -	u16	s_pad2;
> -	sysv_ino_t     s_inode[SYSV_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux: */
> -	char	s_flock;	/* lock during free block list manipulation */
> -	char	s_ilock;	/* lock during inode cache manipulation */
> -	char	s_fmod;		/* super-block modified flag */
> -	char	s_ronly;	/* flag whether fs is mounted read-only */
> -	__fs32	s_time;		/* time of last super block update */
> -	__fs16	s_dinfo[4];	/* device information ?? */
> -	__fs32	s_tfree;	/* total number of free zones */
> -	__fs16	s_tinode;	/* total number of free inodes */
> -	u16	s_pad3;
> -	char	s_fname[6];	/* file system volume name */
> -	char	s_fpack[6];	/* file system pack name */
> -	s32	s_fill[12];
> -	__fs32	s_state;	/* file system state: 0x7c269d38-s_time means clean */
> -	s32	s_magic;	/* version of file system */
> -	__fs32	s_type;		/* type of file system: 1 for 512 byte blocks
> -								2 for 1024 byte blocks */
> -};
> -
> -/* SystemV2 super-block data on disk */
> -struct sysv2_super_block {
> -	__fs16	s_isize; 		/* index of first data zone */
> -	__fs32	s_fsize __packed2__;	/* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16	s_nfree;		/* number of free blocks in s_free, <= SYSV_NICFREE */
> -	sysv_zone_t s_free[SYSV_NICFREE];	/* first free block list chunk */
> -	/* the cache of free inodes: */
> -	__fs16	s_ninode;		/* number of free inodes in s_inode, <= SYSV_NICINOD */
> -	sysv_ino_t     s_inode[SYSV_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux: */
> -	char	s_flock;		/* lock during free block list manipulation */
> -	char	s_ilock;		/* lock during inode cache manipulation */
> -	char	s_fmod;			/* super-block modified flag */
> -	char	s_ronly;		/* flag whether fs is mounted read-only */
> -	__fs32	s_time __packed2__;	/* time of last super block update */
> -	__fs16	s_dinfo[4];		/* device information ?? */
> -	__fs32	s_tfree __packed2__;	/* total number of free zones */
> -	__fs16	s_tinode;		/* total number of free inodes */
> -	char	s_fname[6];		/* file system volume name */
> -	char	s_fpack[6];		/* file system pack name */
> -	s32	s_fill[14];
> -	__fs32	s_state;		/* file system state: 0xcb096f43 means clean */
> -	s32	s_magic;		/* version of file system */
> -	__fs32	s_type;			/* type of file system: 1 for 512 byte blocks
> -								2 for 1024 byte blocks */
> -};
> -
> -/* V7 super-block data on disk */
> -#define V7_NICINOD     100     /* number of inode cache entries */
> -#define V7_NICFREE     50      /* number of free block list chunk entries */
> -struct v7_super_block {
> -	__fs16 s_isize;        /* index of first data zone */
> -	__fs32 s_fsize __packed2__; /* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16 s_nfree;        /* number of free blocks in s_free, <= V7_NICFREE */
> -	sysv_zone_t s_free[V7_NICFREE]; /* first free block list chunk */
> -	/* the cache of free inodes: */
> -	__fs16 s_ninode;       /* number of free inodes in s_inode, <= V7_NICINOD */
> -	sysv_ino_t      s_inode[V7_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux or V7: */
> -	char    s_flock;        /* lock during free block list manipulation */
> -	char    s_ilock;        /* lock during inode cache manipulation */
> -	char    s_fmod;         /* super-block modified flag */
> -	char    s_ronly;        /* flag whether fs is mounted read-only */
> -	__fs32  s_time __packed2__; /* time of last super block update */
> -	/* the following fields are not maintained by V7: */
> -	__fs32  s_tfree __packed2__; /* total number of free zones */
> -	__fs16  s_tinode;       /* total number of free inodes */
> -	__fs16  s_m;            /* interleave factor */
> -	__fs16  s_n;            /* interleave factor */
> -	char    s_fname[6];     /* file system name */
> -	char    s_fpack[6];     /* file system pack name */
> -};
> -/* Constants to aid sanity checking */
> -/* This is not a hard limit, nor enforced by v7 kernel. It's actually just
> - * the limit used by Seventh Edition's ls, though is high enough to assume
> - * that no reasonable file system would have that much entries in root
> - * directory. Thus, if we see anything higher, we just probably got the
> - * endiannes wrong. */
> -#define V7_NFILES	1024
> -/* The disk addresses are three-byte (despite direct block addresses being
> - * aligned word-wise in inode). If the most significant byte is non-zero,
> - * something is most likely wrong (not a filesystem, bad bytesex). */
> -#define V7_MAXSIZE	0x00ffffff
> -
> -/* Coherent super-block data on disk */
> -#define COH_NICINOD	100	/* number of inode cache entries */
> -#define COH_NICFREE	64	/* number of free block list chunk entries */
> -struct coh_super_block {
> -	__fs16		s_isize;	/* index of first data zone */
> -	__fs32		s_fsize __packed2__; /* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16 s_nfree;	/* number of free blocks in s_free, <= COH_NICFREE */
> -	sysv_zone_t	s_free[COH_NICFREE] __packed2__; /* first free block list chunk */
> -	/* the cache of free inodes: */
> -	__fs16		s_ninode;	/* number of free inodes in s_inode, <= COH_NICINOD */
> -	sysv_ino_t	s_inode[COH_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux: */
> -	char		s_flock;	/* lock during free block list manipulation */
> -	char		s_ilock;	/* lock during inode cache manipulation */
> -	char		s_fmod;		/* super-block modified flag */
> -	char		s_ronly;	/* flag whether fs is mounted read-only */
> -	__fs32		s_time __packed2__; /* time of last super block update */
> -	__fs32		s_tfree __packed2__; /* total number of free zones */
> -	__fs16		s_tinode;	/* total number of free inodes */
> -	__fs16		s_interleave_m;	/* interleave factor */
> -	__fs16		s_interleave_n;
> -	char		s_fname[6];	/* file system volume name */
> -	char		s_fpack[6];	/* file system pack name */
> -	__fs32		s_unique;	/* zero, not used */
> -};
> -
> -/* SystemV/Coherent inode data on disk */
> -struct sysv_inode {
> -	__fs16 i_mode;
> -	__fs16 i_nlink;
> -	__fs16 i_uid;
> -	__fs16 i_gid;
> -	__fs32 i_size;
> -	u8  i_data[3*(10+1+1+1)];
> -	u8  i_gen;
> -	__fs32 i_atime;	/* time of last access */
> -	__fs32 i_mtime;	/* time of last modification */
> -	__fs32 i_ctime;	/* time of creation */
> -};
> -
> -/* SystemV/Coherent directory entry on disk */
> -#define SYSV_NAMELEN	14	/* max size of name in struct sysv_dir_entry */
> -struct sysv_dir_entry {
> -	sysv_ino_t inode;
> -	char name[SYSV_NAMELEN]; /* up to 14 characters, the rest are zeroes */
> -};
> -
> -#define SYSV_DIRSIZE	sizeof(struct sysv_dir_entry)	/* size of every directory entry */
> -
> -#endif /* _LINUX_SYSV_FS_H */
> -- 
> 2.43.0
> 
> 

