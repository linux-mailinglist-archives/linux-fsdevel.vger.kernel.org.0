Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E57225734
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfEUSDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 14:03:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59884 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUSDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 14:03:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LHrl1W062640;
        Tue, 21 May 2019 18:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=tlK7imT9EXSaVc7vSp0ft/Yn+GRbK6epyq+c7Nt4Qdw=;
 b=oYXcks/ZZfv0OD1bTgNPBjgKgp5NRE4IHHKHgDJ9HfRNnDnHQDuBiy0X10t02dZCuico
 icg8rh8Zr2DL9MuRLmAw/AHusJlNJZgj6Oz6xxvNMdq2K8cbktPToQiXj7vfBgVO2jHT
 pCoKbNRSWTq1zZo3iMfCtqxcpz2FJrouJX4h1QDVh1PJkl4ez+j3/P9kMNpYkyJEMPnr
 yAW2xFiVf0H2emLLZzotgKmPXDRIHzFTG2G728hyOHNismZwCNFPYbU2S/BgFrCYDAD2
 pQs8ogreD4OFy6ewO19qFabPFIh4K7//XKoxpu+LMtWUIC0K9OF5D9JLT1buEze3GhFK Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2sjapqf2ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 18:02:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LI1f25088172;
        Tue, 21 May 2019 18:02:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sks1jkf8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 18:02:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LI2W3o011318;
        Tue, 21 May 2019 18:02:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 18:02:32 +0000
Date:   Tue, 21 May 2019 11:02:30 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/18] btrfs: create a mount option for dax
Message-ID: <20190521180230.GG5125@magnolia>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-2-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210110
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210110
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[add Ted to the thread]

On Mon, Apr 29, 2019 at 12:26:32PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This sets S_DAX in inode->i_flags, which can be used with
> IS_DAX().
> 
> The dax option is restricted to non multi-device mounts.
> dax interacts with the device directly instead of using bio, so
> all bio-hooks which we use for multi-device cannot be performed
> here. While regular read/writes could be manipulated with
> RAID0/1, mmap() is still an issue.
> 
> Auto-setting free space tree, because dealing with free space
> inode (specifically readpages) is a nightmare.
> Auto-setting nodatasum because we don't get callback for writing
> checksums after mmap()s.
> Deny compression because it does not go with direct I/O.
> 
> Store the dax_device in fs_info which will be used in iomap code.
> 
> I am aware of the push to directory-based flags for dax. Until, that
> code is in the kernel, we will work with mount flags.

Hmm.  This patchset was sent before LSFMM, and I've heard[1] that the
discussion there yielded some progress on how to move forward with the
user interface.  I've gotten the impression that means no new dax mount
options; a persistent flag that can be inherited by new files; and some
other means for userspace to check if writethrough worked.

However, the LWN article says Ted planned to summarize for fsdevel so
let's table this part until he does that.  Ted? :)

--D

[1] https://lwn.net/SubscriberLink/787973/ad85537bf8747e90/

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h   |  2 ++
>  fs/btrfs/disk-io.c |  4 ++++
>  fs/btrfs/ioctl.c   |  5 ++++-
>  fs/btrfs/super.c   | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b3642367a595..8ca1c0d120f4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1067,6 +1067,7 @@ struct btrfs_fs_info {
>  	u32 metadata_ratio;
>  
>  	void *bdev_holder;
> +	struct dax_device *dax_dev;
>  
>  	/* private scrub information */
>  	struct mutex scrub_lock;
> @@ -1442,6 +1443,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
>  #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
> +#define BTRFS_MOUNT_DAX			(1 << 29)
>  
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6fe9197f6ee4..2bbb63b2fcff 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -16,6 +16,7 @@
>  #include <linux/uuid.h>
>  #include <linux/semaphore.h>
>  #include <linux/error-injection.h>
> +#include <linux/dax.h>
>  #include <linux/crc32c.h>
>  #include <linux/sched/mm.h>
>  #include <asm/unaligned.h>
> @@ -2805,6 +2806,8 @@ int open_ctree(struct super_block *sb,
>  		goto fail_alloc;
>  	}
>  
> +	fs_info->dax_dev = fs_dax_get_by_bdev(fs_devices->latest_bdev);
> +
>  	/*
>  	 * We want to check superblock checksum, the type is stored inside.
>  	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
> @@ -4043,6 +4046,7 @@ void close_ctree(struct btrfs_fs_info *fs_info)
>  #endif
>  
>  	btrfs_close_devices(fs_info->fs_devices);
> +	fs_put_dax(fs_info->dax_dev);
>  	btrfs_mapping_tree_free(&fs_info->mapping_tree);
>  
>  	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index cd4e693406a0..0138119cd9a3 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -149,8 +149,11 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
>  	if (binode->flags & BTRFS_INODE_DIRSYNC)
>  		new_fl |= S_DIRSYNC;
>  
> +	if ((btrfs_test_opt(btrfs_sb(inode->i_sb), DAX)) && S_ISREG(inode->i_mode))
> +		new_fl |= S_DAX;
> +
>  	set_mask_bits(&inode->i_flags,
> -		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC,
> +		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC | S_DAX,
>  		      new_fl);
>  }
>  
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 120e4340792a..3b85e61e5182 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -326,6 +326,7 @@ enum {
>  	Opt_treelog, Opt_notreelog,
>  	Opt_usebackuproot,
>  	Opt_user_subvol_rm_allowed,
> +	Opt_dax,
>  
>  	/* Deprecated options */
>  	Opt_alloc_start,
> @@ -393,6 +394,7 @@ static const match_table_t tokens = {
>  	{Opt_notreelog, "notreelog"},
>  	{Opt_usebackuproot, "usebackuproot"},
>  	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
> +	{Opt_dax, "dax"},
>  
>  	/* Deprecated options */
>  	{Opt_alloc_start, "alloc_start=%s"},
> @@ -745,6 +747,32 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  		case Opt_user_subvol_rm_allowed:
>  			btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
>  			break;
> +		case Opt_dax:
> +#ifdef CONFIG_FS_DAX
> +			if (btrfs_super_num_devices(info->super_copy) > 1) {
> +				btrfs_info(info,
> +					   "dax not supported for multi-device btrfs partition\n");
> +				ret = -EOPNOTSUPP;
> +				goto out;
> +			}
> +			btrfs_set_opt(info->mount_opt, DAX);
> +			btrfs_warn(info, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk\n");
> +			btrfs_set_and_info(info, NODATASUM,
> +					   "auto-setting nodatasum (dax)");
> +			btrfs_clear_opt(info->mount_opt, SPACE_CACHE);
> +			btrfs_set_and_info(info, FREE_SPACE_TREE,
> +					"auto-setting free space tree (dax)");
> +			if (btrfs_test_opt(info, COMPRESS)) {
> +				btrfs_info(info, "disabling compress (dax)");
> +				btrfs_clear_opt(info->mount_opt, COMPRESS);
> +			}
> +			break;
> +#else
> +			btrfs_err(info,
> +				  "DAX option not supported\n");
> +			ret = -EINVAL;
> +			goto out;
> +#endif
>  		case Opt_enospc_debug:
>  			btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
>  			break;
> @@ -1335,6 +1363,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>  		seq_puts(seq, ",clear_cache");
>  	if (btrfs_test_opt(info, USER_SUBVOL_RM_ALLOWED))
>  		seq_puts(seq, ",user_subvol_rm_allowed");
> +	if (btrfs_test_opt(info, DAX))
> +		seq_puts(seq, ",dax");
>  	if (btrfs_test_opt(info, ENOSPC_DEBUG))
>  		seq_puts(seq, ",enospc_debug");
>  	if (btrfs_test_opt(info, AUTO_DEFRAG))
> -- 
> 2.16.4
> 
