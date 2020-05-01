Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2833D1C213D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 01:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgEAXXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 19:23:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbgEAXXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 19:23:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041N1tFr059319;
        Fri, 1 May 2020 19:23:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r829730m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:23:29 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 041NMKOV099554;
        Fri, 1 May 2020 19:23:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r8297306-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 19:23:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041NI5An010125;
        Fri, 1 May 2020 23:23:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu75m6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 23:23:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041NNOZ661538458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 23:23:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D7FBAE045;
        Fri,  1 May 2020 23:23:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9073AAE04D;
        Fri,  1 May 2020 23:23:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 23:23:22 +0000 (GMT)
Subject: Re: [PATCH 06/11] fs: move the fiemap definitions out of fs.h
To:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-7-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 2 May 2020 04:53:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427181957.1606257-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200501232322.9073AAE04D@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_17:2020-05-01,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/27/20 11:49 PM, Christoph Hellwig wrote:
> No need to pull the fiemap definitions into almost every file in the
> kernel build.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice,
Feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/bad_inode.c              |  1 +
>   fs/btrfs/extent_io.h        |  1 +
>   fs/cifs/inode.c             |  1 +
>   fs/cifs/smb2ops.c           |  1 +
>   fs/ext2/inode.c             |  1 +
>   fs/ext4/ext4.h              |  1 +
>   fs/f2fs/data.c              |  1 +
>   fs/f2fs/inline.c            |  1 +
>   fs/gfs2/inode.c             |  1 +
>   fs/hpfs/file.c              |  1 +
>   fs/ioctl.c                  |  1 +
>   fs/iomap/fiemap.c           |  1 +
>   fs/nilfs2/inode.c           |  1 +
>   fs/overlayfs/inode.c        |  1 +
>   fs/xfs/xfs_iops.c           |  1 +
>   include/linux/fiemap.h      | 24 ++++++++++++++++++++++++
>   include/linux/fs.h          | 19 +------------------
>   include/uapi/linux/fiemap.h |  6 +++---
>   18 files changed, 43 insertions(+), 21 deletions(-)
>   create mode 100644 include/linux/fiemap.h
> 
> diff --git a/fs/bad_inode.c b/fs/bad_inode.c
> index 8035d2a445617..54f0ce4442720 100644
> --- a/fs/bad_inode.c
> +++ b/fs/bad_inode.c
> @@ -15,6 +15,7 @@
>   #include <linux/time.h>
>   #include <linux/namei.h>
>   #include <linux/poll.h>
> +#include <linux/fiemap.h>
>   
>   static int bad_file_open(struct inode *inode, struct file *filp)
>   {
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 2ed65bd0760ea..817698bc06693 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -5,6 +5,7 @@
>   
>   #include <linux/rbtree.h>
>   #include <linux/refcount.h>
> +#include <linux/fiemap.h>
>   #include "ulist.h"
>   
>   /*
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 390d2b15ef6ef..3f276eb8ca68d 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -25,6 +25,7 @@
>   #include <linux/freezer.h>
>   #include <linux/sched/signal.h>
>   #include <linux/wait_bit.h>
> +#include <linux/fiemap.h>
>   
>   #include <asm/div64.h>
>   #include "cifsfs.h"
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index f829f4165d38c..09047f1ddfb66 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -12,6 +12,7 @@
>   #include <linux/uuid.h>
>   #include <linux/sort.h>
>   #include <crypto/aead.h>
> +#include <linux/fiemap.h>
>   #include "cifsfs.h"
>   #include "cifsglob.h"
>   #include "smb2pdu.h"
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index c885cf7d724b4..0f12a0e8a8d97 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -36,6 +36,7 @@
>   #include <linux/iomap.h>
>   #include <linux/namei.h>
>   #include <linux/uio.h>
> +#include <linux/fiemap.h>
>   #include "ext2.h"
>   #include "acl.h"
>   #include "xattr.h"
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index ad2dbf6e49245..06f97a3a943f6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -36,6 +36,7 @@
>   #include <crypto/hash.h>
>   #include <linux/falloc.h>
>   #include <linux/percpu-rwsem.h>
> +#include <linux/fiemap.h>
>   #ifdef __KERNEL__
>   #include <linux/compat.h>
>   #endif
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index cdf2f626bea7a..25abbbb65ba09 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -19,6 +19,7 @@
>   #include <linux/uio.h>
>   #include <linux/cleancache.h>
>   #include <linux/sched/signal.h>
> +#include <linux/fiemap.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 4167e54081518..9686ffea177e7 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/fs.h>
>   #include <linux/f2fs_fs.h>
> +#include <linux/fiemap.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 70b2d3a1e8668..4842f313a8084 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -17,6 +17,7 @@
>   #include <linux/crc32.h>
>   #include <linux/iomap.h>
>   #include <linux/security.h>
> +#include <linux/fiemap.h>
>   #include <linux/uaccess.h>
>   
>   #include "gfs2.h"
> diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
> index b36abf9cb345a..62959a8e43ad8 100644
> --- a/fs/hpfs/file.c
> +++ b/fs/hpfs/file.c
> @@ -9,6 +9,7 @@
>   
>   #include "hpfs_fn.h"
>   #include <linux/mpage.h>
> +#include <linux/fiemap.h>
>   
>   #define BLOCKS(size) (((size) + 511) >> 9)
>   
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index f55f53c7824bb..cbc84e23d00bd 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -18,6 +18,7 @@
>   #include <linux/buffer_head.h>
>   #include <linux/falloc.h>
>   #include <linux/sched/signal.h>
> +#include <linux/fiemap.h>
>   
>   #include "internal.h"
>   
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index bccf305ea9ce2..fca3dfb9d964a 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -6,6 +6,7 @@
>   #include <linux/compiler.h>
>   #include <linux/fs.h>
>   #include <linux/iomap.h>
> +#include <linux/fiemap.h>
>   
>   struct fiemap_ctx {
>   	struct fiemap_extent_info *fi;
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 671085512e0fd..6e1aca38931f3 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -14,6 +14,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/writeback.h>
>   #include <linux/uio.h>
> +#include <linux/fiemap.h>
>   #include "nilfs.h"
>   #include "btnode.h"
>   #include "segment.h"
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index b0d42ece4d7cc..b5fec34105569 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -10,6 +10,7 @@
>   #include <linux/xattr.h>
>   #include <linux/posix_acl.h>
>   #include <linux/ratelimit.h>
> +#include <linux/fiemap.h>
>   #include "overlayfs.h"
>   
>   
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index f7a99b3bbcf7a..44c353998ac5c 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -25,6 +25,7 @@
>   #include <linux/posix_acl.h>
>   #include <linux/security.h>
>   #include <linux/iversion.h>
> +#include <linux/fiemap.h>
>   
>   /*
>    * Directories have different lock order w.r.t. mmap_sem compared to regular
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
>   #include <linux/capability.h>
>   #include <linux/semaphore.h>
>   #include <linux/fcntl.h>
> -#include <linux/fiemap.h>
>   #include <linux/rculist_bl.h>
>   #include <linux/atomic.h>
>   #include <linux/shrinker.h>
> @@ -48,6 +47,7 @@ struct backing_dev_info;
>   struct bdi_writeback;
>   struct bio;
>   struct export_operations;
> +struct fiemap_extent_info;
>   struct hd_geometry;
>   struct iovec;
>   struct kiocb;
> @@ -1745,19 +1745,6 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
>   extern void inode_init_owner(struct inode *inode, const struct inode *dir,
>   			umode_t mode);
>   extern bool may_open_dev(const struct path *path);
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
>   /*
>    * This is the "filldir" function type, used by readdir() to let
> @@ -3299,10 +3286,6 @@ static inline int vfs_fstat(int fd, struct kstat *stat)
>   extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
>   extern int vfs_readlink(struct dentry *, char __user *, int);
>   
> -extern int generic_block_fiemap(struct inode *inode,
> -				struct fiemap_extent_info *fieinfo, u64 start,
> -				u64 len, get_block_t *get_block);
> -
>   extern struct file_system_type *get_filesystem(struct file_system_type *fs);
>   extern void put_filesystem(struct file_system_type *fs);
>   extern struct file_system_type *get_fs_type(const char *name);
> diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
> index 7a900b2377b60..24ca0c00cae36 100644
> --- a/include/uapi/linux/fiemap.h
> +++ b/include/uapi/linux/fiemap.h
> @@ -9,8 +9,8 @@
>    *          Andreas Dilger <adilger@sun.com>
>    */
>   
> -#ifndef _LINUX_FIEMAP_H
> -#define _LINUX_FIEMAP_H
> +#ifndef _UAPI_LINUX_FIEMAP_H
> +#define _UAPI_LINUX_FIEMAP_H
>   
>   #include <linux/types.h>
>   
> @@ -67,4 +67,4 @@ struct fiemap {
>   #define FIEMAP_EXTENT_SHARED		0x00002000 /* Space shared with other
>   						    * files. */
>   
> -#endif /* _LINUX_FIEMAP_H */
> +#endif /* _UAPI_LINUX_FIEMAP_H */
> 
