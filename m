Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD3C1BC241
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgD1PHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 11:07:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35020 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgD1PHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:07:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SF2kMq186063;
        Tue, 28 Apr 2020 15:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=84gfNSylWftbCKrw7hDRYsPqyy86dVKQn6el5XoIiK0=;
 b=kIvWjAxzGmeRwxJwfjS63/fCigxYA0tEabVKStK7hemsgYiRlz1BYx/TVS4MkR2dJ2ma
 muSlicmFBoxIl2RqOKK8Y6gXLnIg/zZr2r31VBO6h69Q6XGczh4hpUVsHRp9lGsUDW2G
 E6egTuLJdQlR+M3TUnDt0M2NIO3O7nWEbWSTINebvWRI7F6tAZkH0A72NiuQbOXbd86R
 D+3XjIF5cdlVwe7J3cuJhXvN/TiBL8XWWL3s5Jid0kmteuIjzCMoHtn3/pmKlFYo0ujS
 XlS+xpV4GInR+1V3g11Lw2FJLvdEyAGydQJp6iIJVR5646qPyvd7BgxlfGVUIh6hlHlv Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30nucg0hxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:07:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SF6e8L051246;
        Tue, 28 Apr 2020 15:07:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30mxpg7ynj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:07:32 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SF7U9P012726;
        Tue, 28 Apr 2020 15:07:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:07:30 -0700
Date:   Tue, 28 Apr 2020 08:07:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 06/11] fs: move the fiemap definitions out of fs.h
Message-ID: <20200428150728.GH6741@magnolia>
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427181957.1606257-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280118
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:19:52PM +0200, Christoph Hellwig wrote:
> No need to pull the fiemap definitions into almost every file in the
> kernel build.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hooray, I hate the overloaded mess that fs.h has become...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/bad_inode.c              |  1 +
>  fs/btrfs/extent_io.h        |  1 +
>  fs/cifs/inode.c             |  1 +
>  fs/cifs/smb2ops.c           |  1 +
>  fs/ext2/inode.c             |  1 +
>  fs/ext4/ext4.h              |  1 +
>  fs/f2fs/data.c              |  1 +
>  fs/f2fs/inline.c            |  1 +
>  fs/gfs2/inode.c             |  1 +
>  fs/hpfs/file.c              |  1 +
>  fs/ioctl.c                  |  1 +
>  fs/iomap/fiemap.c           |  1 +
>  fs/nilfs2/inode.c           |  1 +
>  fs/overlayfs/inode.c        |  1 +
>  fs/xfs/xfs_iops.c           |  1 +
>  include/linux/fiemap.h      | 24 ++++++++++++++++++++++++
>  include/linux/fs.h          | 19 +------------------
>  include/uapi/linux/fiemap.h |  6 +++---
>  18 files changed, 43 insertions(+), 21 deletions(-)
>  create mode 100644 include/linux/fiemap.h
> 
> diff --git a/fs/bad_inode.c b/fs/bad_inode.c
> index 8035d2a445617..54f0ce4442720 100644
> --- a/fs/bad_inode.c
> +++ b/fs/bad_inode.c
> @@ -15,6 +15,7 @@
>  #include <linux/time.h>
>  #include <linux/namei.h>
>  #include <linux/poll.h>
> +#include <linux/fiemap.h>
>  
>  static int bad_file_open(struct inode *inode, struct file *filp)
>  {
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 2ed65bd0760ea..817698bc06693 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -5,6 +5,7 @@
>  
>  #include <linux/rbtree.h>
>  #include <linux/refcount.h>
> +#include <linux/fiemap.h>
>  #include "ulist.h"
>  
>  /*
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 390d2b15ef6ef..3f276eb8ca68d 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -25,6 +25,7 @@
>  #include <linux/freezer.h>
>  #include <linux/sched/signal.h>
>  #include <linux/wait_bit.h>
> +#include <linux/fiemap.h>
>  
>  #include <asm/div64.h>
>  #include "cifsfs.h"
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index f829f4165d38c..09047f1ddfb66 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -12,6 +12,7 @@
>  #include <linux/uuid.h>
>  #include <linux/sort.h>
>  #include <crypto/aead.h>
> +#include <linux/fiemap.h>
>  #include "cifsfs.h"
>  #include "cifsglob.h"
>  #include "smb2pdu.h"
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index c885cf7d724b4..0f12a0e8a8d97 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -36,6 +36,7 @@
>  #include <linux/iomap.h>
>  #include <linux/namei.h>
>  #include <linux/uio.h>
> +#include <linux/fiemap.h>
>  #include "ext2.h"
>  #include "acl.h"
>  #include "xattr.h"
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index ad2dbf6e49245..06f97a3a943f6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -36,6 +36,7 @@
>  #include <crypto/hash.h>
>  #include <linux/falloc.h>
>  #include <linux/percpu-rwsem.h>
> +#include <linux/fiemap.h>
>  #ifdef __KERNEL__
>  #include <linux/compat.h>
>  #endif
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index cdf2f626bea7a..25abbbb65ba09 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -19,6 +19,7 @@
>  #include <linux/uio.h>
>  #include <linux/cleancache.h>
>  #include <linux/sched/signal.h>
> +#include <linux/fiemap.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 4167e54081518..9686ffea177e7 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/fs.h>
>  #include <linux/f2fs_fs.h>
> +#include <linux/fiemap.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 70b2d3a1e8668..4842f313a8084 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -17,6 +17,7 @@
>  #include <linux/crc32.h>
>  #include <linux/iomap.h>
>  #include <linux/security.h>
> +#include <linux/fiemap.h>
>  #include <linux/uaccess.h>
>  
>  #include "gfs2.h"
> diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
> index b36abf9cb345a..62959a8e43ad8 100644
> --- a/fs/hpfs/file.c
> +++ b/fs/hpfs/file.c
> @@ -9,6 +9,7 @@
>  
>  #include "hpfs_fn.h"
>  #include <linux/mpage.h>
> +#include <linux/fiemap.h>
>  
>  #define BLOCKS(size) (((size) + 511) >> 9)
>  
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index f55f53c7824bb..cbc84e23d00bd 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -18,6 +18,7 @@
>  #include <linux/buffer_head.h>
>  #include <linux/falloc.h>
>  #include <linux/sched/signal.h>
> +#include <linux/fiemap.h>
>  
>  #include "internal.h"
>  
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index bccf305ea9ce2..fca3dfb9d964a 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -6,6 +6,7 @@
>  #include <linux/compiler.h>
>  #include <linux/fs.h>
>  #include <linux/iomap.h>
> +#include <linux/fiemap.h>
>  
>  struct fiemap_ctx {
>  	struct fiemap_extent_info *fi;
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 671085512e0fd..6e1aca38931f3 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -14,6 +14,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/writeback.h>
>  #include <linux/uio.h>
> +#include <linux/fiemap.h>
>  #include "nilfs.h"
>  #include "btnode.h"
>  #include "segment.h"
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index b0d42ece4d7cc..b5fec34105569 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -10,6 +10,7 @@
>  #include <linux/xattr.h>
>  #include <linux/posix_acl.h>
>  #include <linux/ratelimit.h>
> +#include <linux/fiemap.h>
>  #include "overlayfs.h"
>  
>  
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index f7a99b3bbcf7a..44c353998ac5c 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -25,6 +25,7 @@
>  #include <linux/posix_acl.h>
>  #include <linux/security.h>
>  #include <linux/iversion.h>
> +#include <linux/fiemap.h>
>  
>  /*
>   * Directories have different lock order w.r.t. mmap_sem compared to regular
> diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
> new file mode 100644
> index 0000000000000..240d4f7d9116a
> --- /dev/null
> +++ b/include/linux/fiemap.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_FIEMAP_H
> +#define _LINUX_FIEMAP_H 1
> +
> +#include <uapi/linux/fiemap.h>
> +#include <linux/fs.h>
> +
> +struct fiemap_extent_info {
> +	unsigned int fi_flags;		/* Flags as passed from user */
> +	unsigned int fi_extents_mapped;	/* Number of mapped extents */
> +	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
> +	struct fiemap_extent __user *fi_extents_start; /* Start of
> +							fiemap_extent array */
> +};
> +
> +int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
> +			    u64 phys, u64 len, u32 flags);
> +int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
> +
> +int generic_block_fiemap(struct inode *inode,
> +		struct fiemap_extent_info *fieinfo, u64 start, u64 len,
> +		get_block_t *get_block);
> +
> +#endif /* _LINUX_FIEMAP_H 1 */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3104c6f7527b5..09bcd329c0628 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -24,7 +24,6 @@
>  #include <linux/capability.h>
>  #include <linux/semaphore.h>
>  #include <linux/fcntl.h>
> -#include <linux/fiemap.h>
>  #include <linux/rculist_bl.h>
>  #include <linux/atomic.h>
>  #include <linux/shrinker.h>
> @@ -48,6 +47,7 @@ struct backing_dev_info;
>  struct bdi_writeback;
>  struct bio;
>  struct export_operations;
> +struct fiemap_extent_info;
>  struct hd_geometry;
>  struct iovec;
>  struct kiocb;
> @@ -1745,19 +1745,6 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
>  extern void inode_init_owner(struct inode *inode, const struct inode *dir,
>  			umode_t mode);
>  extern bool may_open_dev(const struct path *path);
> -/*
> - * VFS FS_IOC_FIEMAP helper definitions.
> - */
> -struct fiemap_extent_info {
> -	unsigned int fi_flags;		/* Flags as passed from user */
> -	unsigned int fi_extents_mapped;	/* Number of mapped extents */
> -	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
> -	struct fiemap_extent __user *fi_extents_start; /* Start of
> -							fiemap_extent array */
> -};
> -int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
> -			    u64 phys, u64 len, u32 flags);
> -int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
>  
>  /*
>   * This is the "filldir" function type, used by readdir() to let
> @@ -3299,10 +3286,6 @@ static inline int vfs_fstat(int fd, struct kstat *stat)
>  extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
>  extern int vfs_readlink(struct dentry *, char __user *, int);
>  
> -extern int generic_block_fiemap(struct inode *inode,
> -				struct fiemap_extent_info *fieinfo, u64 start,
> -				u64 len, get_block_t *get_block);
> -
>  extern struct file_system_type *get_filesystem(struct file_system_type *fs);
>  extern void put_filesystem(struct file_system_type *fs);
>  extern struct file_system_type *get_fs_type(const char *name);
> diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
> index 7a900b2377b60..24ca0c00cae36 100644
> --- a/include/uapi/linux/fiemap.h
> +++ b/include/uapi/linux/fiemap.h
> @@ -9,8 +9,8 @@
>   *          Andreas Dilger <adilger@sun.com>
>   */
>  
> -#ifndef _LINUX_FIEMAP_H
> -#define _LINUX_FIEMAP_H
> +#ifndef _UAPI_LINUX_FIEMAP_H
> +#define _UAPI_LINUX_FIEMAP_H
>  
>  #include <linux/types.h>
>  
> @@ -67,4 +67,4 @@ struct fiemap {
>  #define FIEMAP_EXTENT_SHARED		0x00002000 /* Space shared with other
>  						    * files. */
>  
> -#endif /* _LINUX_FIEMAP_H */
> +#endif /* _UAPI_LINUX_FIEMAP_H */
> -- 
> 2.26.1
> 
