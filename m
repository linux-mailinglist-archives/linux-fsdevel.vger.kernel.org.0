Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7031797DDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfHUO7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 10:59:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56616 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfHUO7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:59:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEx7j8106114;
        Wed, 21 Aug 2019 14:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=H0099HF4UjtQJ4k3TRSa38RwyxQuTuF2Rx44TZPp8BI=;
 b=Qd4QauPsZrN3+/35+jWTRSH1eO2Z9H6iPzm/CHytLNCltMSsuSMe9QHaBuRpyvpJZrdd
 narrso/N+NXGAdDT1apNaVUJaQVvrEg+9jgx38s/4zQ4r2YI+mIakxkBIvqil8UCXfbQ
 e2h1p33gHqK910gTYHRTylZSU63WZ592AoxrSvTvpIxQQ8RlcgQD9qosY/KI74xRKmzl
 hRihSCWRxT/xpymqvr5MVVmDlgIRbDO/toirpVuOsY+pjMbY+2yb8b2D95NR+Awiedat
 eUykuVS1NohWjcl9zrOF7Bt2gndk+zhx+GdhmqRBf/+ZhllGKXdIzVLl8iE3pA2oiPAY Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ue90tpbvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:59:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LExLgY126494;
        Wed, 21 Aug 2019 14:59:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2uh2q4m8mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:59:36 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LEwu7c024988;
        Wed, 21 Aug 2019 14:58:56 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:58:55 -0700
Date:   Wed, 21 Aug 2019 07:58:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH V3] fs: New zonefs file system
Message-ID: <20190821145854.GE1037350@magnolia>
References: <20190821070308.28665-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821070308.28665-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210160
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 04:03:08PM +0900, Damien Le Moal wrote:
> zonefs is a very simple file system exposing each zone of a zoned
> block device as a file. zonefs is in fact closer to a raw block device
> access interface than to a full feature POSIX file system.

<skipping to the good part>

> +/*
> + * Read super block information from the device.
> + */
> +static int zonefs_read_super(struct super_block *sb)
> +{
> +	const void *zero_page = (const void *) __va(page_to_phys(ZERO_PAGE(0)));
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct zonefs_super *super;
> +	struct bio bio;
> +	struct bio_vec bio_vec;
> +	struct page *page;
> +	u32 crc, stored_crc;
> +	int ret;
> +
> +	page = alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio.bi_iter.bi_sector = 0;
> +	bio_set_dev(&bio, sb->s_bdev);
> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> +	bio_add_page(&bio, page, PAGE_SIZE, 0);
> +
> +	ret = submit_bio_wait(&bio);
> +	if (ret)
> +		goto out;
> +
> +	super = page_address(page);
> +
> +	stored_crc = super->s_crc;
> +	super->s_crc = 0;
> +	crc = crc32_le(ZONEFS_MAGIC, (unsigned char *)super,
> +		       sizeof(struct zonefs_super));
> +	if (crc != stored_crc) {
> +		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
> +			   crc, stored_crc);
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	ret = -EINVAL;
> +	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
> +		goto out;
> +
> +	sbi->s_features = le64_to_cpu(super->s_features);
> +	if (sbi->s_features & ~((1ULL << ZONEFS_F_NUM) - 1)) {

Most other filesystems would do:

#define ZONEFS_F_ALL_FEATURES (ZONEFS_F_UID | ZONEFS_F_GID ...)

and then this becomes:

if (sbi->s_features & ~ZONEFS_F_ALL_FEATURES)

> +		zonefs_err(sb, "Unknown features set\n");

Also it might help to print out the invalid s_features values so that
when you get help questions you can distinguish between a corrupted
superblock and a new fs on an old kernel.

> +		goto out;
> +	}
> +
> +
> +	if (zonefs_has_feature(sbi, ZONEFS_F_UID)) {
> +		sbi->s_uid = make_kuid(current_user_ns(),
> +				       le32_to_cpu(super->s_uid));
> +		if (!uid_valid(sbi->s_uid)) {
> +			zonefs_err(sb, "Invalid UID feature\n");
> +			goto out;
> +		}
> +	}
> +	if (zonefs_has_feature(sbi, ZONEFS_F_GID)) {
> +		sbi->s_gid = make_kgid(current_user_ns(),
> +				       le32_to_cpu(super->s_gid));
> +		if (!gid_valid(sbi->s_gid)) {
> +			zonefs_err(sb, "Invalid GID feature\n");
> +			goto out;
> +		}
> +	}
> +
> +	if (zonefs_has_feature(sbi, ZONEFS_F_PERM))
> +		sbi->s_perm = le32_to_cpu(super->s_perm);
> +
> +	if (memcmp(super->s_reserved, zero_page, sizeof(super->s_reserved))) {

Er... memchr_inv?

Otherwise looks reasonable enough.  How do you test zonedfs?

--D

> +		zonefs_err(sb, "Reserved area is being used\n");
> +		goto out;
> +	}
> +
> +	uuid_copy(&sbi->s_uuid, &super->s_uuid);
> +	ret = 0;
> +
> +out:
> +	__free_page(page);
> +
> +	return ret;
> +}
> +
> +/*
> + * Check that the device is zoned. If it is, get the list of zones and create
> + * sub-directories and files according to the device zone configuration.
> + */
> +static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
> +{
> +	struct zonefs_sb_info *sbi;
> +	struct blk_zone *zones;
> +	struct inode *inode;
> +	enum zonefs_ztype t;
> +	int ret;
> +
> +	/* Check device type */
> +	if (!bdev_is_zoned(sb->s_bdev)) {
> +		zonefs_err(sb, "Not a zoned block device\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize super block information */
> +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> +	if (!sbi)
> +		return -ENOMEM;
> +
> +	sb->s_fs_info = sbi;
> +	sb->s_magic = ZONEFS_MAGIC;
> +	sb->s_maxbytes = MAX_LFS_FILESIZE;
> +	sb->s_op = &zonefs_sops;
> +	sb->s_time_gran	= 1;
> +
> +	/*
> +	 * The block size is always equal to the device physical sector size to
> +	 * ensure that writes on 512e disks (512B logical block and 4KB
> +	 * physical block) are always aligned.
> +	 */
> +	sb_set_blocksize(sb, bdev_physical_block_size(sb->s_bdev));
> +	sbi->s_blocksize_mask = sb->s_blocksize - 1;
> +
> +	sbi->s_uid = GLOBAL_ROOT_UID;
> +	sbi->s_gid = GLOBAL_ROOT_GID;
> +	sbi->s_perm = 0640; /* S_IRUSR | S_IWUSR | S_IRGRP */
> +
> +	ret = zonefs_read_super(sb);
> +	if (ret)
> +		return ret;
> +
> +	zones = zonefs_get_zone_info(sb);
> +	if (IS_ERR(zones))
> +		return PTR_ERR(zones);
> +
> +	pr_info("zonefs: Mounting %s, %u zones",
> +		sb->s_id, blkdev_nr_zones(sb->s_bdev));
> +
> +	/* Create root directory inode */
> +	ret = -ENOMEM;
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto out;
> +
> +	inode->i_ino = get_next_ino();
> +	inode->i_mode = S_IFDIR | 0755;
> +	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
> +	inode->i_op = &simple_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	inode->i_size = sizeof(struct dentry) * 2;
> +	set_nlink(inode, 2);
> +
> +	sb->s_root = d_make_root(inode);
> +	if (!sb->s_root)
> +		goto out;
> +
> +	/* Create and populate zone groups */
> +	for (t = ZONEFS_ZTYPE_CNV; t < ZONEFS_ZTYPE_MAX; t++) {
> +		ret = zonefs_create_zgroup(sb, zones, t);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	kvfree(zones);
> +
> +	return ret;
> +}
> +
> +static struct dentry *zonefs_mount(struct file_system_type *fs_type,
> +				 int flags, const char *dev_name, void *data)
> +{
> +	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);
> +}
> +
> +static void zonefs_kill_super(struct super_block *sb)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +
> +	kfree(sbi);
> +	if (sb->s_root)
> +		d_genocide(sb->s_root);
> +	kill_block_super(sb);
> +}
> +
> +/*
> + * File system definition and registration.
> + */
> +static struct file_system_type zonefs_type = {
> +	.owner		= THIS_MODULE,
> +	.name		= "zonefs",
> +	.mount		= zonefs_mount,
> +	.kill_sb	= zonefs_kill_super,
> +	.fs_flags	= FS_REQUIRES_DEV,
> +};
> +
> +static int __init zonefs_init_inodecache(void)
> +{
> +	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
> +			sizeof(struct zonefs_inode_info), 0,
> +			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
> +			NULL);
> +	if (zonefs_inode_cachep == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static void zonefs_destroy_inodecache(void)
> +{
> +	/*
> +	 * Make sure all delayed rcu free inodes are flushed before we
> +	 * destroy the inode cache.
> +	 */
> +	rcu_barrier();
> +	kmem_cache_destroy(zonefs_inode_cachep);
> +}
> +
> +static int __init zonefs_init(void)
> +{
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct zonefs_super) != ZONEFS_SUPER_SIZE);
> +
> +	ret = zonefs_init_inodecache();
> +	if (ret)
> +		return ret;
> +
> +	ret = register_filesystem(&zonefs_type);
> +	if (ret) {
> +		zonefs_destroy_inodecache();
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit zonefs_exit(void)
> +{
> +	zonefs_destroy_inodecache();
> +	unregister_filesystem(&zonefs_type);
> +}
> +
> +MODULE_AUTHOR("Damien Le Moal");
> +MODULE_DESCRIPTION("Zone file system for zoned block devices");
> +MODULE_LICENSE("GPL");
> +module_init(zonefs_init);
> +module_exit(zonefs_exit);
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> new file mode 100644
> index 000000000000..aae59f797ee2
> --- /dev/null
> +++ b/fs/zonefs/zonefs.h
> @@ -0,0 +1,177 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Simple zone file system for zoned block devices.
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + */
> +#ifndef __ZONEFS_H__
> +#define __ZONEFS_H__
> +
> +#include <linux/fs.h>
> +#include <linux/magic.h>
> +#include <linux/uuid.h>
> +#include <linux/mutex.h>
> +#include <linux/rwsem.h>
> +
> +/*
> + * Maximum length of file names: this only needs to be large enough to fit
> + * the zone group directory names and a decimal value of the start sector of
> + * the zones for file names. 16 characters is plenty.
> + */
> +#define ZONEFS_NAME_MAX		16
> +
> +/*
> + * Zone types: ZONEFS_ZTYPE_SEQ is used for all sequential zone types
> + * defined in linux/blkzoned.h, that is, BLK_ZONE_TYPE_SEQWRITE_REQ and
> + * BLK_ZONE_TYPE_SEQWRITE_PREF.
> + */
> +enum zonefs_ztype {
> +	ZONEFS_ZTYPE_CNV,
> +	ZONEFS_ZTYPE_SEQ,
> +	ZONEFS_ZTYPE_MAX,
> +};
> +
> +static inline enum zonefs_ztype zonefs_zone_type(struct blk_zone *zone)
> +{
> +	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> +		return ZONEFS_ZTYPE_CNV;
> +	return ZONEFS_ZTYPE_SEQ;
> +}
> +
> +/*
> + * Inode private data.
> + */
> +struct zonefs_inode_info {
> +	struct inode		i_vnode;
> +	enum zonefs_ztype	i_ztype;
> +	sector_t		i_zsector;
> +	loff_t			i_wpoffset;
> +	loff_t			i_max_size;
> +	struct mutex		i_truncate_mutex;
> +	struct rw_semaphore	i_mmap_sem;
> +};
> +
> +static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)
> +{
> +	return container_of(inode, struct zonefs_inode_info, i_vnode);
> +}
> +
> +static inline bool zonefs_file_is_conv(struct inode *inode)
> +{
> +	return ZONEFS_I(inode)->i_ztype == ZONEFS_ZTYPE_CNV;
> +}
> +
> +static inline bool zonefs_file_is_seq(struct inode *inode)
> +{
> +	return ZONEFS_I(inode)->i_ztype == ZONEFS_ZTYPE_SEQ;
> +}
> +
> +/*
> + * Start sector on disk of a file zone.
> + */
> +static inline loff_t zonefs_file_start_sector(struct inode *inode)
> +{
> +	return ZONEFS_I(inode)->i_zsector;
> +}
> +
> +/*
> + * Maximum possible size of a file (i.e. the zone size).
> + */
> +static inline loff_t zonefs_file_max_size(struct inode *inode)
> +{
> +	return ZONEFS_I(inode)->i_max_size;
> +}
> +
> +/*
> + * On-disk super block (block 0).
> + */
> +#define ZONEFS_SUPER_SIZE	4096
> +struct zonefs_super {
> +
> +	/* Magic number */
> +	__le32		s_magic;
> +
> +	/* Checksum */
> +	__le32		s_crc;
> +
> +	/* Features */
> +	__le64		s_features;
> +
> +	/* 128-bit uuid */
> +	uuid_t		s_uuid;
> +
> +	/* UID/GID to use for files */
> +	__le32		s_uid;
> +	__le32		s_gid;
> +
> +	/* File permissions */
> +	__le32		s_perm;
> +
> +	/* Padding to ZONEFS_SUPER_SIZE bytes */
> +	__u8		s_reserved[4052];
> +
> +} __packed;
> +
> +/*
> + * Feature flags: used on disk in the s_features field of struct zonefs_super
> + * and in-memory in the s_feartures field of struct zonefs_sb_info.
> + */
> +enum zonefs_features {
> +	/*
> +	 * Use a zone start sector value as file name.
> +	 */
> +	ZONEFS_F_STARTSECT_NAME,
> +	/*
> +	 * Aggregate contiguous conventional zones into a single file.
> +	 */
> +	ZONEFS_F_AGRCNV,
> +	/*
> +	 * Use super block specified UID for files instead of default.
> +	 */
> +	ZONEFS_F_UID,
> +	/*
> +	 * Use super block specified GID for files instead of default.
> +	 */
> +	ZONEFS_F_GID,
> +	/*
> +	 * Use super block specified file permissions instead of default 640.
> +	 */
> +	ZONEFS_F_PERM,
> +
> +	ZONEFS_F_NUM,
> +};
> +
> +/*
> + * In-memory Super block information.
> + */
> +struct zonefs_sb_info {
> +
> +	unsigned long long	s_features;
> +	kuid_t			s_uid;		/* File owner UID */
> +	kgid_t			s_gid;		/* File owner GID */
> +	umode_t			s_perm;		/* File permissions */
> +	uuid_t			s_uuid;
> +
> +	loff_t			s_blocksize_mask;
> +	unsigned int		s_nr_zones[ZONEFS_ZTYPE_MAX];
> +};
> +
> +static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
> +{
> +	return sb->s_fs_info;
> +}
> +
> +static inline bool zonefs_has_feature(struct zonefs_sb_info *sbi,
> +				      enum zonefs_features f)
> +{
> +	return sbi->s_features & (1ULL << f);
> +}
> +
> +#define zonefs_info(sb, format, args...)	\
> +	pr_info("zonefs (%s): " format, sb->s_id, ## args)
> +#define zonefs_err(sb, format, args...)	\
> +	pr_err("zonefs (%s) ERROR: " format, sb->s_id, ## args)
> +#define zonefs_warn(sb, format, args...)	\
> +	pr_warn("zonefs (%s) WARN: " format, sb->s_id, ## args)
> +
> +#endif
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 1274c692e59c..3be20c774142 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -86,6 +86,7 @@
>  #define NSFS_MAGIC		0x6e736673
>  #define BPF_FS_MAGIC		0xcafe4a11
>  #define AAFS_MAGIC		0x5a3c69f0
> +#define ZONEFS_MAGIC		0x5a4f4653
>  
>  /* Since UDF 2.01 is ISO 13346 based... */
>  #define UDF_SUPER_MAGIC		0x15013346
> -- 
> 2.21.0
> 
