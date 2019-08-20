Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD8D96450
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfHTP0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 11:26:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfHTP0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:26:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7KF8mmH032107;
        Tue, 20 Aug 2019 15:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=CXn6S0crVvBpLh5v+hQmCUXGeFv4P8NNsmY00AqcMaY=;
 b=C0OnXS35U7hPduV4kOqrjkFIIkYg2ejKj3tZLglGD7bkIRt+S21LGCWoMpV91x+TYO9H
 RRxE3Aiv+Dce3nSZOBIv0Uv+B82EBnvpJv6vwIcoQo3B2VUc1EfBzbzGnsmewxB/9aCi
 OWfbnLlP6krJ3MSm+pZKzKE2X7Gsx0IvkMQNLZ2v2hXv7RD3y6CvjXpFRBpkNlYRe8Wk
 scvktIBJQxNZup7q5ZwL92p+OCMl850XnwsE7KhYGy8cVh9BMWtsLfZlIQ7iPZZgFJ6J
 ZXau4G19pFdUg697EcvAiSkyBc71B1wgCzExxHl/ERvGGyx3Bg1PRXjBXdWJEp3Tpd/U Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ue90tf8mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 15:26:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7KF9AZ8132420;
        Tue, 20 Aug 2019 15:26:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ug1g9dbc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 15:26:41 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7KFQeEv003749;
        Tue, 20 Aug 2019 15:26:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Aug 2019 08:26:39 -0700
Date:   Tue, 20 Aug 2019 08:26:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH V2] fs: New zonefs file system
Message-ID: <20190820152638.GA1037422@magnolia>
References: <20190820081249.27353-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820081249.27353-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908200147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908200147
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:12:49PM +0900, Damien Le Moal wrote:
> zonefs is a very simple file system exposing each zone of a zoned
> block device as a file. zonefs is in fact closer to a raw block device
> access interface than to a full feature POSIX file system.

/me cuts out a lot of stuff...

> +/*
> + * When a write error occurs in a sequenial zone, the zone write pointer

"sequential"

> + * position must be refreshed to correct the file size and zonefs inode
> + * write pointer offset.
> + */
> +static int zonefs_seq_file_write_failed(struct inode *inode, int error)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	sector_t sector = zi->i_zsector;
> +	unsigned int nofs_flag;
> +	struct blk_zone zone;
> +	int n = 1, ret;
> +	loff_t pos;

<snip again>

> +/*
> + * Read super block information from the device.
> + */
> +static int zonefs_read_super(struct super_block *sb)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct zonefs_super *super;
> +	struct bio bio;
> +	struct bio_vec bio_vec;
> +	struct page *page;
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
> +	ret = -EINVAL;
> +	super = page_address(page);
> +	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
> +		goto out;
> +	sbi->s_features = le64_to_cpu(super->s_features);
> +	if (zonefs_has_feature(sbi, ZONEFS_F_UID)) {
> +		sbi->s_uid = make_kuid(current_user_ns(),
> +				       le32_to_cpu(super->s_uid));
> +		if (!uid_valid(sbi->s_uid))
> +			goto out;
> +	}
> +	if (zonefs_has_feature(sbi, ZONEFS_F_GID)) {
> +		sbi->s_gid = make_kgid(current_user_ns(),
> +				       le32_to_cpu(super->s_gid));
> +		if (!gid_valid(sbi->s_gid))
> +			goto out;
> +	}
> +	if (zonefs_has_feature(sbi, ZONEFS_F_PERM))
> +		sbi->s_perm = le32_to_cpu(super->s_perm);

Unknown feature bits are silently ignored.  Is that intentional?  Will
all features be compat features?  I would find it a little annoying to
format (for example) a F_UID filesystem only to have some old kernel
driver ignore it.

> +
> +	uuid_copy(&sbi->s_uuid, &super->s_uuid);
> +	ret = 0;
> +
> +out:
> +	__free_page(page);
> +
> +	return ret;
> +}

<snip>

> +/*
> + * On-disk super block (block 0).
> + */
> +struct zonefs_super {
> +
> +	/* Magic number */
> +	__le32		s_magic;
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
> +	/* Padding to 4K */
> +	__u8		s_reserved[4056];

Hmm, I noticed that fill_super doesn't check that s_reserved is actually
zero (or any specific value).  You might consider enforcing that so that
future you can add fields beyond s_perm without having to burn a
s_features bit every time you do it.

Also a little surprised there's no checksum field here to detect bit
flips and such. ;)

--D

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
