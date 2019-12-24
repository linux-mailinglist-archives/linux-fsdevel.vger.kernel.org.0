Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2DF129D4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 05:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLXE2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 23:28:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59408 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLXE2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 23:28:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBO4Nx7q147490;
        Tue, 24 Dec 2019 04:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=wuNV/sP23TRg+8wE//bFnE0AWal9hN1ujH8UEv/Un7I=;
 b=FQBbVDIbZ5TQtWpFRgJi4ka9wO+MEDuxQnU7uWjIHaHk8J4RY+832K8qeS78hdniIpdC
 VeRWJt089ccd0e8iyrmDno+s6YFV+oM9I71ygWDgmjr0d0G6AINR7rvfeiOfxtj/PU++
 JUjAzSfZEkSY8Tr8neHdk620TTg0VvqbF54Ce4VL7hGx9XBnh6flGYYVjTScUHMs3N19
 zv5U5sh5fq1qGSKI5ApmCpPIQ8/L2vKLFLZ2pn9qjm+2WswUrzBgMapz9zaIcx1hpiGF
 4NFOOIF0yrNmD0XLfjYBQVxjULEJoG9RaTtS6nd3vhacbtxibMXqfnY9KPqj2X9tpsuF +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2x1c1qsrat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Dec 2019 04:28:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBO4J8vI168223;
        Tue, 24 Dec 2019 04:26:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2x37tdfqjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Dec 2019 04:26:01 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBO4Q0m3011852;
        Tue, 24 Dec 2019 04:26:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Dec 2019 20:26:00 -0800
Date:   Mon, 23 Dec 2019 20:25:57 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 1/2] fs: New zonefs file system
Message-ID: <20191224042557.GW7489@magnolia>
References: <20191220065528.317947-1-damien.lemoal@wdc.com>
 <20191220065528.317947-2-damien.lemoal@wdc.com>
 <20191220223624.GC7476@magnolia>
 <BYAPR04MB581661F7C2103E8F35EEDAA0E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB581661F7C2103E8F35EEDAA0E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9480 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912240035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9480 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912240036
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 01:33:30AM +0000, Damien Le Moal wrote:
> On 2019/12/21 7:38, Darrick J. Wong wrote:
> > On Fri, Dec 20, 2019 at 03:55:27PM +0900, Damien Le Moal wrote:
> [...]>> +static int zonefs_inode_setattr(struct dentry *dentry, struct
> iattr *iattr)
> >> +{
> >> +	struct inode *inode = d_inode(dentry);
> >> +	int ret;
> >> +
> >> +	ret = setattr_prepare(dentry, iattr);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if ((iattr->ia_valid & ATTR_UID &&
> >> +	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||
> >> +	    (iattr->ia_valid & ATTR_GID &&
> >> +	     !gid_eq(iattr->ia_gid, inode->i_gid))) {
> >> +		ret = dquot_transfer(inode, iattr);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >> +	if (iattr->ia_valid & ATTR_SIZE) {
> >> +		/* The size of conventional zone files cannot be changed */
> >> +		if (ZONEFS_I(inode)->i_ztype == ZONEFS_ZTYPE_CNV)
> >> +			return -EPERM;
> >> +
> >> +		ret = zonefs_seq_file_truncate(inode, iattr->ia_size);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> > 
> > /me wonders if you need to filter out ATTR_MODE changes here, at least
> > so you can't make the zone file for a readonly zone writable?
> 
> Good point. Will add that to V3.
> 
> > I also wonder, does an O_TRUNC open reset the zone's write pointer to
> > zero?
> 
> Yes, it does. That does not change from a regular FS behavior. This is
> also consistent with the fact that a truncate(0) does exactly the same
> thing.

Ok, good, just checking. :)

> [...]
> >> +static const struct vm_operations_struct zonefs_file_vm_ops = {
> >> +	.fault		= zonefs_filemap_fault,
> >> +	.map_pages	= filemap_map_pages,
> >> +	.page_mkwrite	= zonefs_filemap_page_mkwrite,
> >> +};
> >> +
> >> +static int zonefs_file_mmap(struct file *file, struct vm_area_struct *vma)
> >> +{
> >> +	/*
> >> +	 * Conventional zone files can be mmap-ed READ/WRITE.
> >> +	 * For sequential zone files, only readonly mappings are possible.
> > 
> > Hmm, but the code below looks like it allows private writable mmapings
> > of sequential zones?
> 
> It is my understanding that changes made to pages of a MAP_PRIVATE
> mapping are not written back to the underlying file, so a
> mmap(MAP_WRITE|MAP_PRIVATE) is essentially equivalent to a read only
> mapping for the FS. Am I missing something ?
> 
> Not sure if it make any sense at all to allow private writeable mappings
> though, but if my assumption is correct, I do not see any reason to
> prevent them either.

<nod> You're correct, I was just checking that this is indeed the
correct behavior for zonefs. :)

> [...]
> >> +static const struct iomap_dio_ops zonefs_dio_ops = {
> >> +	.end_io			= zonefs_file_dio_write_end,
> >> +};
> >> +
> >> +static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
> >> +{
> >> +	struct inode *inode = file_inode(iocb->ki_filp);
> >> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> >> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> >> +	size_t count;
> >> +	ssize_t ret;
> >> +
> >> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> >> +		if (!inode_trylock(inode))
> >> +			return -EAGAIN;
> >> +	} else {
> >> +		inode_lock(inode);
> >> +	}
> >> +
> >> +	ret = generic_write_checks(iocb, from);
> >> +	if (ret <= 0)
> >> +		goto out;
> >> +
> >> +	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
> >> +	count = iov_iter_count(from);
> >> +
> >> +	/*
> >> +	 * Direct writes must be aligned to the block size, that is, the device
> >> +	 * physical sector size, to avoid errors when writing sequential zones
> >> +	 * on 512e devices (512B logical sector, 4KB physical sectors).
> >> +	 */
> >> +	if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {
> >> +		ret = -EINVAL;
> >> +		goto out;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Enforce sequential writes (append only) in sequential zones.
> >> +	 */
> > 
> > I wonder, shouldn't zonefs require users to open sequential zones with
> > O_APPEND?  I don't see anything in here that would suggest that it does,
> > though maybe I missed something.
> 
> Yes, I thought about this too but decided against it for several reasons:
> 1) Requiring O_APPEND breaks some shell command like tools such as
> "truncate" which makes scripting (including tests) harder.

Yeah, I realized right after I sent this that you can't usually truncate
an append-only file so O_APPEND really doesn't apply here.

> 2) Without enforcing O_APPEND, an application doing pwrite() or aios to
> an incorrect offset will see an error instead of potential file data
> corruption (due to the application bug, not the FS).
> 3) Since sequential zone file size is updated only on completion of
> direct IOs, O_APPEND would generate an incorrect offset for AIOs at
> queue depth bigger than 1.

ooh, good point. :)

> Thoughts ?

"Heh, that was a silly point to make on my part", or
"Maybe it's good that we have these discussions on the mailing lists" :)

> [...]
> >> +static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >> +{
> >> +	struct inode *inode = file_inode(iocb->ki_filp);
> >> +
> >> +	/*
> >> +	 * Check that the write operation does not go beyond the zone size.
> >> +	 */
> >> +	if (iocb->ki_pos >= ZONEFS_I(inode)->i_max_size)
> >> +		return -EFBIG;
> >> +
> >> +	if (iocb->ki_flags & IOCB_DIRECT)
> >> +		return zonefs_file_dio_write(iocb, from);
> >> +
> >> +	return zonefs_file_buffered_write(iocb, from);
> >> +}
> >> +
> >> +static const struct file_operations zonefs_file_operations = {
> >> +	.open		= generic_file_open,
> > 
> > Hmm, ok, so there isn't any explicit O_APPEND requirement, even though
> > it looks like the filesystem enforces one.
> 
> Yes, in purpose. See above for the reasons.
> 
> [...]
> >> +static void zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone)
> >> +{
> >> +	struct super_block *sb = inode->i_sb;
> >> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> >> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> >> +	umode_t	perm = sbi->s_perm;
> >> +
> >> +	zi->i_ztype = zonefs_zone_type(zone);
> >> +	zi->i_zsector = zone->start;
> >> +
> >> +	switch (zone->cond) {
> >> +	case BLK_ZONE_COND_OFFLINE:
> >> +		/*
> >> +		 * Disable all accesses and set the file size to 0 for
> >> +		 * offline zones.
> >> +		 */
> >> +		zi->i_wpoffset = 0;
> >> +		zi->i_max_size = 0;
> >> +		perm = 0;
> >> +		break;
> >> +	case BLK_ZONE_COND_READONLY:
> >> +		/* Do not allow writes in read-only zones*/
> >> +		perm &= ~(0222); /* S_IWUGO */
> >> +		/* Fallthrough */
> > 
> > You might want to set S_IMMUTABLE in i_flags here, since (I assume)
> > readonly zones are never, ever, going to be modifable in any way?
> 
> Good point. Will do.
> 
> > In which case, zonefs probably shouldn't let people run 'chmod a+w' on a
> > readonly zone.  Either that or disallow mode changes via
> > zonefs_inode_setattr.
> 
> Yes, will do.
> 
> [...]
> >> +static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
> >> +				enum zonefs_ztype type)
> >> +{
> >> +	struct super_block *sb = zd->sb;
> >> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> >> +	struct blk_zone *zone, *next, *end;
> >> +	char name[ZONEFS_NAME_MAX];
> >> +	struct dentry *dir;
> >> +	unsigned int n = 0;
> >> +
> >> +	/* If the group is empty, there is nothing to do */
> >> +	if (!zd->nr_zones[type])
> >> +		return 0;
> >> +
> >> +	dir = zonefs_create_inode(sb->s_root, zgroups_name[type], NULL);
> >> +	if (!dir)
> >> +		return -ENOMEM;
> >> +
> >> +	/*
> >> +	 * The first zone contains the super block: skip it.
> >> +	 */
> >> +	end = zd->zones + blkdev_nr_zones(sb->s_bdev->bd_disk);
> >> +	for (zone = &zd->zones[1]; zone < end; zone = next) {
> >> +
> >> +		next = zone + 1;
> >> +		if (zonefs_zone_type(zone) != type)
> >> +			continue;
> >> +
> >> +		/*
> >> +		 * For conventional zones, contiguous zones can be aggregated
> >> +		 * together to form larger files.
> >> +		 * Note that this overwrites the length of the first zone of
> >> +		 * the set of contiguous zones aggregated together.
> >> +		 * Only zones with the same condition can be agreggated so that
> >> +		 * offline zones are excluded and readonly zones are aggregated
> >> +		 * together into a read only file.
> >> +		 */
> >> +		if (type == ZONEFS_ZTYPE_CNV &&
> >> +		    sbi->s_features & ZONEFS_F_AGGRCNV) {
> > 
> > This probably needs parentheses around the flag check, e.g.
> > 
> > 		if (type == ZONEFS_ZTYPE_CNV &&
> > 		    (sbi->s_features & ZONEFS_F_AGGRCNV)) {
> 
> gcc does not complain but I agree. It is cleaner and older gcc versions
> will also probably be happier :)
> 
> [...]
> >> +
> >> +static int zonefs_get_zone_info(struct zonefs_zone_data *zd)
> >> +{
> >> +	struct block_device *bdev = zd->sb->s_bdev;
> >> +	int ret;
> >> +
> >> +	zd->zones = kvcalloc(blkdev_nr_zones(bdev->bd_disk),
> >> +			     sizeof(struct blk_zone), GFP_KERNEL);
> > 
> > Hmm, so one 64-byte blk_zone structure for each zone on the disk?
> > 
> > I have a 14TB SMR disk with ~459,000x 32M zones on it.  That's going to
> > require a contiguous 30MB memory allocation to hold all the zone
> > information.  Even your 15T drive from the commit message will need a
> > contiguous 3.8MB memory allocation for all the zone info.
> > 
> > I wonder if each zone should really be allocated separately and then
> > indexed with an xarray or something like that to reduce the chance of
> > failure when memory is fragmented or tight.
> > 
> > That could be subsequent work though, since in the meantime that just
> > makes zonefs mounts more likely to run out of memory and fail.  I
> > suppose you don't hang on to the huge allocation for very long.
> 
> No, this memory allocation is only for mount. It is dropped as soon as
> all the zone file inodes are created. Furthermore, this allocation is a
> kvalloc, not a kmalloc. So there is no memory continuity requirement.
> This is only an array of structures and that is not used to do IOs for
> the report zone itself.
> 
> I debated trying to optimize (I mean reducing the mount temporary memory
> use) by processing mount in small chunks of zones instead of all zones
> in one go. I kept simple, but rather brutal, approach to keep the code
> simple. This can be rewritten and optimized at any time if we see
> problems appearing.

<nod> vmalloc space is quite limited on 32-bit platforms, so that's the
most likely place you'll get complaints.

> > 
> >> +	if (!zd->zones)
> >> +		return -ENOMEM;
> >> +
> >> +	/* Get zones information */
> >> +	ret = blkdev_report_zones(bdev, 0, BLK_ALL_ZONES,
> >> +				  zonefs_get_zone_info_cb, zd);
> >> +	if (ret < 0) {
> >> +		zonefs_err(zd->sb, "Zone report failed %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	if (ret != blkdev_nr_zones(bdev->bd_disk)) {
> >> +		zonefs_err(zd->sb, "Invalid zone report (%d/%u zones)\n",
> >> +			   ret, blkdev_nr_zones(bdev->bd_disk));
> >> +		return -EIO;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static inline void zonefs_cleanup_zone_info(struct zonefs_zone_data *zd)
> >> +{
> >> +	kvfree(zd->zones);
> >> +}
> >> +
> >> +/*
> >> + * Read super block information from the device.
> >> + */
> >> +static int zonefs_read_super(struct super_block *sb)
> >> +{
> >> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> >> +	struct zonefs_super *super;
> >> +	u32 crc, stored_crc;
> >> +	struct page *page;
> >> +	struct bio_vec bio_vec;
> >> +	struct bio bio;
> >> +	int ret;
> >> +
> >> +	page = alloc_page(GFP_KERNEL);
> >> +	if (!page)
> >> +		return -ENOMEM;
> >> +
> >> +	bio_init(&bio, &bio_vec, 1);
> >> +	bio.bi_iter.bi_sector = 0;
> >> +	bio_set_dev(&bio, sb->s_bdev);
> >> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> >> +	bio_add_page(&bio, page, PAGE_SIZE, 0);
> >> +
> >> +	ret = submit_bio_wait(&bio);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	super = page_address(page);
> >> +
> >> +	stored_crc = super->s_crc;
> >> +	super->s_crc = 0;
> >> +	crc = crc32_le(ZONEFS_MAGIC, (unsigned char *)super,
> >> +		       sizeof(struct zonefs_super));
> > 
> > Unusual; usually crc32 computations are seeded with ~0U, but <shrug>.
> 
> No strong opinion on this one. I will change to ~0U to follow the
> general convention.

Ok.

> > Anyway, this looks to be in decent shape now, modulo other comments.
> 
> Thank you for your comments. Sending a V3.

Ok, I'll flip over to that thread now.

--D

> 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
