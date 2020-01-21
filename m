Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49A14425E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAUQoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 11:44:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37730 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:44:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LGN4Y5072597;
        Tue, 21 Jan 2020 16:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=IeoPjBnpbfAV3hUoF6EXKiZpM8ps8yZwN/aKG3qehfY=;
 b=g0KlC0AQBFRONvJQY5NFI+YqWwPkldQDVXYwMrVn7vbX5gfZbkRgZ35GrjIFl/pzBB4W
 ImpVRdCAXftonNls8WEqw0dVFku7anOgUJLSkrwjjXiY+AorLsE0OF8U9rIay+fAz6/+
 BE3WQUYv8qnKgd7ujEQmn85AZzM0aN+6k+CMGQviVMByiF1drF9v9jOfEz6vnJgyVdSC
 C9U/pvidzZ9tNY3tN4NgNv2oUfxYljKeGxvwqWdxAQOojDLsK1iJdDfhPNelrJ/YckSB
 VNU4EFQmlPmpcCKgAjV6E+ZPQ4DSo+hF9CsPNtEmMijoohIXaICdj/tLR1TNBRnmy3EK Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xktnr64ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 16:44:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LGO0vW114614;
        Tue, 21 Jan 2020 16:44:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xnpeet3f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 16:44:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00LGi8GA000913;
        Tue, 21 Jan 2020 16:44:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jan 2020 08:44:07 -0800
Date:   Tue, 21 Jan 2020 08:44:07 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v8 1/2] fs: New zonefs file system
Message-ID: <20200121164407.GA8247@magnolia>
References: <20200121065846.216538-1-damien.lemoal@wdc.com>
 <20200121065846.216538-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121065846.216538-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 03:58:45PM +0900, Damien Le Moal wrote:
> zonefs is a very simple file system exposing each zone of a zoned block
> device as a file. Unlike a regular file system with zoned block device

(Still) looks good to me, so with the below typo fix, you can apply:
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

I think it's time to scoop up whatever acks and rvbs you get for this v8
series and send v9 as a pull request for 5.6.

> +static int zonefs_file_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	/*
> +	 * Since conventional zones accept random writes, conventioanl zone

"conventional" at the end.

(or shorten the sentence to "Conventional zones accept random writes, so
their zone files can support shared writable mappings.")

--D

> +	 * files can support shared writeable mappings. For sequential zone
> +	 * files, only readonly mappings are possible since there no gurantees
> +	 * for write ordering due to msync() and page cache writeback.
> +	 */
> +	if (ZONEFS_I(file_inode(file))->i_ztype == ZONEFS_ZTYPE_SEQ &&
> +	    (vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
> +		return -EINVAL;
> +
> +	file_accessed(file);
> +	vma->vm_ops = &zonefs_file_vm_ops;
> +
> +	return 0;
> +}
> +
> +static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	loff_t isize = i_size_read(file_inode(file));
> +
> +	/*
> +	 * Seeks are limited to below the zone size for conventional zones
> +	 * and below the zone write pointer for sequential zones. In both
> +	 * cases, this limit is the inode size.
> +	 */
> +	return generic_file_llseek_size(file, offset, whence, isize, isize);
> +}
> +
> +static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	loff_t max_pos;
> +	size_t count;
> +	ssize_t ret;
> +
> +	if (iocb->ki_pos >= zi->i_max_size)
> +		return 0;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock_shared(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock_shared(inode);
> +	}
> +
> +	mutex_lock(&zi->i_truncate_mutex);
> +
> +	/*
> +	 * Limit read operations to written data.
> +	 */
> +	max_pos = i_size_read(inode);
> +	if (iocb->ki_pos >= max_pos) {
> +		mutex_unlock(&zi->i_truncate_mutex);
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	iov_iter_truncate(to, max_pos - iocb->ki_pos);
> +
> +	mutex_unlock(&zi->i_truncate_mutex);
> +
> +	count = iov_iter_count(to);
> +
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		file_accessed(iocb->ki_filp);
> +		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops, NULL,
> +				   is_sync_kiocb(iocb));
> +	} else {
> +		ret = generic_file_read_iter(iocb, to);
> +	}
> +
> +out:
> +	inode_unlock_shared(inode);
> +
> +	return ret;
> +}
> +
> +static int zonefs_report_zones_err_cb(struct blk_zone *zone, unsigned int idx,
> +				      void *data)
> +{
> +	struct inode *inode = data;
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	loff_t pos;
> +
> +	/*
> +	 * The condition of the zone may have change. Check it and adjust the
> +	 * inode information as needed, similarly to zonefs_init_file_inode().
> +	 */
> +	if (zone->cond == BLK_ZONE_COND_OFFLINE) {
> +		inode->i_flags |= S_IMMUTABLE;
> +		inode->i_mode &= ~0777;
> +		zone->wp = zone->start;
> +	} else if (zone->cond == BLK_ZONE_COND_READONLY) {
> +		inode->i_flags |= S_IMMUTABLE;
> +		inode->i_mode &= ~0222;
> +	}
> +
> +	pos = (zone->wp - zone->start) << SECTOR_SHIFT;
> +	zi->i_wpoffset = pos;
> +	if (i_size_read(inode) != pos) {
> +		zonefs_update_stats(inode, pos);
> +		i_size_write(inode, pos);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * When a write error occurs in a sequential zone, the zone write pointer
> + * position must be refreshed to correct the file size and zonefs inode
> + * write pointer offset.
> + */
> +static int zonefs_seq_file_write_failed(struct inode *inode, int error)
> +{
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	struct super_block *sb = inode->i_sb;
> +	sector_t sector = zi->i_zsector;
> +	unsigned int nofs_flag;
> +	int ret;
> +
> +	zonefs_warn(sb, "Updating inode zone %llu info\n", sector);
> +
> +	/*
> +	 * blkdev_report_zones() uses GFP_KERNEL by default. Force execution as
> +	 * if GFP_NOFS was specified so that it will not end up recursing into
> +	 * the FS on memory allocation.
> +	 */
> +	nofs_flag = memalloc_nofs_save();
> +	ret = blkdev_report_zones(sb->s_bdev, sector, 1,
> +				  zonefs_report_zones_err_cb, inode);
> +	memalloc_nofs_restore(nofs_flag);
> +
> +	if (ret != 1) {
> +		if (!ret)
> +			ret = -EIO;
> +		zonefs_err(sb, "Get zone %llu report failed %d\n",
> +			   sector, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zonefs_file_dio_write_end(struct kiocb *iocb, ssize_t size, int ret,
> +				     unsigned int flags)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Conventional zone file size is fixed to the zone size so there
> +	 * is no need to do anything.
> +	 */
> +	if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
> +		return 0;
> +
> +	mutex_lock(&zi->i_truncate_mutex);
> +
> +	if (size < 0) {
> +		ret = zonefs_seq_file_write_failed(inode, size);
> +	} else if (i_size_read(inode) < iocb->ki_pos + size) {
> +		zonefs_update_stats(inode, iocb->ki_pos + size);
> +		i_size_write(inode, iocb->ki_pos + size);
> +	}
> +
> +	mutex_unlock(&zi->i_truncate_mutex);
> +
> +	return ret;
> +}
> +
> +static const struct iomap_dio_ops zonefs_dio_ops = {
> +	.end_io			= zonefs_file_dio_write_end,
> +};
> +
> +static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	size_t count;
> +	ssize_t ret;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock(inode);
> +	}
> +
> +	ret = generic_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto out;
> +
> +	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
> +	count = iov_iter_count(from);
> +
> +	/*
> +	 * Direct writes must be aligned to the block size, that is, the device
> +	 * physical sector size, to avoid errors when writing sequential zones
> +	 * on 512e devices (512B logical sector, 4KB physical sectors).
> +	 */
> +	if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Enforce sequential writes (append only) in sequential zones.
> +	 */
> +	mutex_lock(&zi->i_truncate_mutex);
> +	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
> +	    iocb->ki_pos != zi->i_wpoffset) {
> +		zonefs_err(inode->i_sb,
> +			   "Unaligned write at %llu + %zu (wp %llu)\n",
> +			   iocb->ki_pos, count,
> +			   zi->i_wpoffset);
> +		mutex_unlock(&zi->i_truncate_mutex);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	mutex_unlock(&zi->i_truncate_mutex);
> +
> +	ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops, &zonefs_dio_ops,
> +			   is_sync_kiocb(iocb));
> +	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
> +	    (ret > 0 || ret == -EIOCBQUEUED)) {
> +		if (ret > 0)
> +			count = ret;
> +		mutex_lock(&zi->i_truncate_mutex);
> +		zi->i_wpoffset += count;
> +		mutex_unlock(&zi->i_truncate_mutex);
> +	}
> +
> +out:
> +	inode_unlock(inode);
> +
> +	return ret;
> +}
> +
> +static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
> +					  struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	ssize_t ret;
> +
> +	/*
> +	 * Direct IO writes are mandatory for sequential zones so that the
> +	 * write IO order is preserved.
> +	 */
> +	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ)
> +		return -EIO;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock(inode);
> +	}
> +
> +	ret = generic_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto out;
> +
> +	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
> +
> +	ret = iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);
> +	if (ret > 0)
> +		iocb->ki_pos += ret;
> +
> +out:
> +	inode_unlock(inode);
> +	if (ret > 0)
> +		ret = generic_write_sync(iocb, ret);
> +
> +	return ret;
> +}
> +
> +static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	/*
> +	 * Check that the write operation does not go beyond the zone size.
> +	 */
> +	if (iocb->ki_pos >= ZONEFS_I(inode)->i_max_size)
> +		return -EFBIG;
> +
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return zonefs_file_dio_write(iocb, from);
> +
> +	return zonefs_file_buffered_write(iocb, from);
> +}
> +
> +static const struct file_operations zonefs_file_operations = {
> +	.open		= generic_file_open,
> +	.fsync		= zonefs_file_fsync,
> +	.mmap		= zonefs_file_mmap,
> +	.llseek		= zonefs_file_llseek,
> +	.read_iter	= zonefs_file_read_iter,
> +	.write_iter	= zonefs_file_write_iter,
> +	.splice_read	= generic_file_splice_read,
> +	.splice_write	= iter_file_splice_write,
> +	.iopoll		= iomap_dio_iopoll,
> +};
> +
> +static struct kmem_cache *zonefs_inode_cachep;
> +
> +static struct inode *zonefs_alloc_inode(struct super_block *sb)
> +{
> +	struct zonefs_inode_info *zi;
> +
> +	zi = kmem_cache_alloc(zonefs_inode_cachep, GFP_KERNEL);
> +	if (!zi)
> +		return NULL;
> +
> +	inode_init_once(&zi->i_vnode);
> +	mutex_init(&zi->i_truncate_mutex);
> +	init_rwsem(&zi->i_mmap_sem);
> +
> +	return &zi->i_vnode;
> +}
> +
> +static void zonefs_free_inode(struct inode *inode)
> +{
> +	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));
> +}
> +
> +/*
> + * File system stat.
> + */
> +static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
> +{
> +	struct super_block *sb = dentry->d_sb;
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	enum zonefs_ztype t;
> +	u64 fsid;
> +
> +	buf->f_type = ZONEFS_MAGIC;
> +	buf->f_bsize = sb->s_blocksize;
> +	buf->f_namelen = ZONEFS_NAME_MAX;
> +
> +	spin_lock(&sbi->s_lock);
> +
> +	buf->f_blocks = sbi->s_blocks;
> +	if (WARN_ON(sbi->s_used_blocks > sbi->s_blocks))
> +		buf->f_bfree = 0;
> +	else
> +		buf->f_bfree = buf->f_blocks - sbi->s_used_blocks;
> +	buf->f_bavail = buf->f_bfree;
> +
> +	for (t = 0; t < ZONEFS_ZTYPE_MAX; t++) {
> +		if (sbi->s_nr_files[t])
> +			buf->f_files += sbi->s_nr_files[t] + 1;
> +	}
> +	buf->f_ffree = 0;
> +
> +	spin_unlock(&sbi->s_lock);
> +
> +	fsid = le64_to_cpup((void *)sbi->s_uuid.b) ^
> +		le64_to_cpup((void *)sbi->s_uuid.b + sizeof(u64));
> +	buf->f_fsid.val[0] = (u32)fsid;
> +	buf->f_fsid.val[1] = (u32)(fsid >> 32);
> +
> +	return 0;
> +}
> +
> +static const struct super_operations zonefs_sops = {
> +	.alloc_inode	= zonefs_alloc_inode,
> +	.free_inode	= zonefs_free_inode,
> +	.statfs		= zonefs_statfs,
> +};
> +
> +static const struct inode_operations zonefs_dir_inode_operations = {
> +	.lookup		= simple_lookup,
> +	.setattr	= zonefs_inode_setattr,
> +};
> +
> +static void zonefs_init_dir_inode(struct inode *parent, struct inode *inode)
> +{
> +	inode_init_owner(inode, parent, S_IFDIR | 0555);
> +	inode->i_op = &zonefs_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	set_nlink(inode, 2);
> +	inc_nlink(parent);
> +}
> +
> +static void zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	umode_t	perm = sbi->s_perm;
> +
> +	if (zone->cond == BLK_ZONE_COND_OFFLINE) {
> +		/*
> +		 * Dead zone: make the inode immutable, disable all accesses
> +		 * and set the file size to 0.
> +		 */
> +		inode->i_flags |= S_IMMUTABLE;
> +		zone->wp = zone->start;
> +		perm &= ~0777;
> +	} else if (zone->cond == BLK_ZONE_COND_READONLY) {
> +		/* Do not allow writes in read-only zones */
> +		inode->i_flags |= S_IMMUTABLE;
> +		perm &= ~0222;
> +	}
> +
> +	zi->i_ztype = zonefs_zone_type(zone);
> +	zi->i_zsector = zone->start;
> +	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
> +			       zone->len << SECTOR_SHIFT);
> +	if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
> +		zi->i_wpoffset = zi->i_max_size;
> +	else
> +		zi->i_wpoffset = (zone->wp - zone->start) << SECTOR_SHIFT;
> +
> +	inode->i_mode = S_IFREG | perm;
> +	inode->i_uid = sbi->s_uid;
> +	inode->i_gid = sbi->s_gid;
> +	inode->i_size = zi->i_wpoffset;
> +	inode->i_blocks = zone->len;
> +
> +	inode->i_op = &zonefs_file_inode_operations;
> +	inode->i_fop = &zonefs_file_operations;
> +	inode->i_mapping->a_ops = &zonefs_file_aops;
> +
> +	sb->s_maxbytes = max(zi->i_max_size, sb->s_maxbytes);
> +	sbi->s_blocks += zi->i_max_size >> sb->s_blocksize_bits;
> +	sbi->s_used_blocks += zi->i_wpoffset >> sb->s_blocksize_bits;
> +}
> +
> +static struct dentry *zonefs_create_inode(struct dentry *parent,
> +					const char *name, struct blk_zone *zone)
> +{
> +	struct inode *dir = d_inode(parent);
> +	struct dentry *dentry;
> +	struct inode *inode;
> +
> +	dentry = d_alloc_name(parent, name);
> +	if (!dentry)
> +		return NULL;
> +
> +	inode = new_inode(parent->d_sb);
> +	if (!inode)
> +		goto out;
> +
> +	inode->i_ino = get_next_ino();
> +	inode->i_ctime = inode->i_mtime = inode->i_atime = dir->i_ctime;
> +	if (zone)
> +		zonefs_init_file_inode(inode, zone);
> +	else
> +		zonefs_init_dir_inode(dir, inode);
> +	d_add(dentry, inode);
> +	dir->i_size++;
> +
> +	return dentry;
> +
> +out:
> +	dput(dentry);
> +
> +	return NULL;
> +}
> +
> +static char *zgroups_name[ZONEFS_ZTYPE_MAX] = { "cnv", "seq" };
> +
> +struct zonefs_zone_data {
> +	struct super_block *sb;
> +	unsigned int nr_zones[ZONEFS_ZTYPE_MAX];
> +	struct blk_zone *zones;
> +};
> +
> +/*
> + * Create a zone group and populate it with zone files.
> + */
> +static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
> +				enum zonefs_ztype type)
> +{
> +	struct super_block *sb = zd->sb;
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct blk_zone *zone, *next, *end;
> +	char name[ZONEFS_NAME_MAX];
> +	struct dentry *dir;
> +	unsigned int n = 0;
> +
> +	/* If the group is empty, there is nothing to do */
> +	if (!zd->nr_zones[type])
> +		return 0;
> +
> +	dir = zonefs_create_inode(sb->s_root, zgroups_name[type], NULL);
> +	if (!dir)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The first zone contains the super block: skip it.
> +	 */
> +	end = zd->zones + blkdev_nr_zones(sb->s_bdev->bd_disk);
> +	for (zone = &zd->zones[1]; zone < end; zone = next) {
> +
> +		next = zone + 1;
> +		if (zonefs_zone_type(zone) != type)
> +			continue;
> +
> +		/*
> +		 * For conventional zones, contiguous zones can be aggregated
> +		 * together to form larger files.
> +		 * Note that this overwrites the length of the first zone of
> +		 * the set of contiguous zones aggregated together.
> +		 * Only zones with the same condition can be agreggated so that
> +		 * offline zones are excluded and readonly zones are aggregated
> +		 * together into a read only file.
> +		 */
> +		if (type == ZONEFS_ZTYPE_CNV &&
> +		    (sbi->s_features & ZONEFS_F_AGGRCNV)) {
> +			for (; next < end; next++) {
> +				if (zonefs_zone_type(next) != type ||
> +				    next->cond != zone->cond)
> +					break;
> +				zone->len += next->len;
> +			}
> +		}
> +
> +		/*
> +		 * Use the file number within its group as file name.
> +		 */
> +		snprintf(name, ZONEFS_NAME_MAX - 1, "%u", n);
> +		if (!zonefs_create_inode(dir, name, zone))
> +			return -ENOMEM;
> +
> +		n++;
> +	}
> +
> +	zonefs_info(sb, "Zone group \"%s\" has %u file%s\n",
> +		    zgroups_name[type], n, n > 1 ? "s" : "");
> +
> +	sbi->s_nr_files[type] = n;
> +
> +	return 0;
> +}
> +
> +static int zonefs_get_zone_info_cb(struct blk_zone *zone, unsigned int idx,
> +				   void *data)
> +{
> +	struct zonefs_zone_data *zd = data;
> +
> +	/*
> +	 * Count the number of usable zones: the first zone at index 0 contains
> +	 * the super block and is ignored.
> +	 */
> +	switch (zone->type) {
> +	case BLK_ZONE_TYPE_CONVENTIONAL:
> +		zone->wp = zone->start + zone->len;
> +		if (idx)
> +			zd->nr_zones[ZONEFS_ZTYPE_CNV]++;
> +		break;
> +	case BLK_ZONE_TYPE_SEQWRITE_REQ:
> +	case BLK_ZONE_TYPE_SEQWRITE_PREF:
> +		if (idx)
> +			zd->nr_zones[ZONEFS_ZTYPE_SEQ]++;
> +		break;
> +	default:
> +		zonefs_err(zd->sb, "Unsupported zone type 0x%x\n",
> +			   zone->type);
> +		return -EIO;
> +	}
> +
> +	memcpy(&zd->zones[idx], zone, sizeof(struct blk_zone));
> +
> +	return 0;
> +}
> +
> +static int zonefs_get_zone_info(struct zonefs_zone_data *zd)
> +{
> +	struct block_device *bdev = zd->sb->s_bdev;
> +	int ret;
> +
> +	zd->zones = kvcalloc(blkdev_nr_zones(bdev->bd_disk),
> +			     sizeof(struct blk_zone), GFP_KERNEL);
> +	if (!zd->zones)
> +		return -ENOMEM;
> +
> +	/* Get zones information */
> +	ret = blkdev_report_zones(bdev, 0, BLK_ALL_ZONES,
> +				  zonefs_get_zone_info_cb, zd);
> +	if (ret < 0) {
> +		zonefs_err(zd->sb, "Zone report failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ret != blkdev_nr_zones(bdev->bd_disk)) {
> +		zonefs_err(zd->sb, "Invalid zone report (%d/%u zones)\n",
> +			   ret, blkdev_nr_zones(bdev->bd_disk));
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void zonefs_cleanup_zone_info(struct zonefs_zone_data *zd)
> +{
> +	kvfree(zd->zones);
> +}
> +
> +/*
> + * Read super block information from the device.
> + */
> +static int zonefs_read_super(struct super_block *sb)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct zonefs_super *super;
> +	u32 crc, stored_crc;
> +	struct page *page;
> +	struct bio_vec bio_vec;
> +	struct bio bio;
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
> +	stored_crc = le32_to_cpu(super->s_crc);
> +	super->s_crc = 0;
> +	crc = crc32(~0U, (unsigned char *)super, sizeof(struct zonefs_super));
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
> +	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
> +		zonefs_err(sb, "Unknown features set 0x%llx\n",
> +			   sbi->s_features);
> +		goto out;
> +	}
> +
> +	if (sbi->s_features & ZONEFS_F_UID) {
> +		sbi->s_uid = make_kuid(current_user_ns(),
> +				       le32_to_cpu(super->s_uid));
> +		if (!uid_valid(sbi->s_uid)) {
> +			zonefs_err(sb, "Invalid UID feature\n");
> +			goto out;
> +		}
> +	}
> +
> +	if (sbi->s_features & ZONEFS_F_GID) {
> +		sbi->s_gid = make_kgid(current_user_ns(),
> +				       le32_to_cpu(super->s_gid));
> +		if (!gid_valid(sbi->s_gid)) {
> +			zonefs_err(sb, "Invalid GID feature\n");
> +			goto out;
> +		}
> +	}
> +
> +	if (sbi->s_features & ZONEFS_F_PERM)
> +		sbi->s_perm = le32_to_cpu(super->s_perm);
> +
> +	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
> +		zonefs_err(sb, "Reserved area is being used\n");
> +		goto out;
> +	}
> +
> +	uuid_copy(&sbi->s_uuid, (uuid_t *)super->s_uuid);
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
> + * sub-directories and files according to the device zone configuration and
> + * format options.
> + */
> +static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
> +{
> +	struct zonefs_zone_data zd;
> +	struct zonefs_sb_info *sbi;
> +	struct inode *inode;
> +	enum zonefs_ztype t;
> +	int ret;
> +
> +	if (!bdev_is_zoned(sb->s_bdev)) {
> +		zonefs_err(sb, "Not a zoned block device\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Initialize super block information: the maximum file size is updated
> +	 * when the zone files are created so that the format option
> +	 * ZONEFS_F_AGGRCNV which increases the maximum file size of a file
> +	 * beyond the zone size is taken into account.
> +	 */
> +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> +	if (!sbi)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&sbi->s_lock);
> +	sb->s_fs_info = sbi;
> +	sb->s_magic = ZONEFS_MAGIC;
> +	sb->s_maxbytes = 0;
> +	sb->s_op = &zonefs_sops;
> +	sb->s_time_gran	= 1;
> +
> +	/*
> +	 * The block size is always equal to the device physical sector size to
> +	 * ensure that writes on 512e devices (512B logical block and 4KB
> +	 * physical block) are always aligned to the device physical blocks
> +	 * (as required for writes to sequential zones on ZBC/ZAC disks).
> +	 */
> +	sb_set_blocksize(sb, bdev_physical_block_size(sb->s_bdev));
> +	sbi->s_blocksize_mask = sb->s_blocksize - 1;
> +	sbi->s_uid = GLOBAL_ROOT_UID;
> +	sbi->s_gid = GLOBAL_ROOT_GID;
> +	sbi->s_perm = 0640;
> +
> +	ret = zonefs_read_super(sb);
> +	if (ret)
> +		return ret;
> +
> +	memset(&zd, 0, sizeof(struct zonefs_zone_data));
> +	zd.sb = sb;
> +	ret = zonefs_get_zone_info(&zd);
> +	if (ret)
> +		goto out;
> +
> +	zonefs_info(sb, "Mounting %u zones",
> +		    blkdev_nr_zones(sb->s_bdev->bd_disk));
> +
> +	/* Create root directory inode */
> +	ret = -ENOMEM;
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto out;
> +
> +	inode->i_ino = get_next_ino();
> +	inode->i_mode = S_IFDIR | 0555;
> +	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
> +	inode->i_op = &zonefs_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	set_nlink(inode, 2);
> +
> +	sb->s_root = d_make_root(inode);
> +	if (!sb->s_root)
> +		goto out;
> +
> +	/* Create and populate files in zone groups directories */
> +	for (t = 0; t < ZONEFS_ZTYPE_MAX; t++) {
> +		ret = zonefs_create_zgroup(&zd, t);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	zonefs_cleanup_zone_info(&zd);
> +
> +	return ret;
> +}
> +
> +static struct dentry *zonefs_mount(struct file_system_type *fs_type,
> +				   int flags, const char *dev_name, void *data)
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
> index 000000000000..5862e17573ba
> --- /dev/null
> +++ b/fs/zonefs/zonefs.h
> @@ -0,0 +1,175 @@
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
> + * the zone group directory names and a decimal zone number for file names.
> + * 16 characters is plenty.
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
> + * In-memory inode data.
> + */
> +struct zonefs_inode_info {
> +	struct inode		i_vnode;
> +
> +	/* File zone type */
> +	enum zonefs_ztype	i_ztype;
> +
> +	/* File zone start sector (512B unit) */
> +	sector_t		i_zsector;
> +
> +	/* File zone write pointer position (sequential zones only) */
> +	loff_t			i_wpoffset;
> +
> +	/* File maximum size */
> +	loff_t			i_max_size;
> +
> +	/*
> +	 * To serialise fully against both syscall and mmap based IO and
> +	 * sequential file truncation, two locks are used. For serializing
> +	 * zonefs_seq_file_truncate() against zonefs_iomap_begin(), that is,
> +	 * file truncate operations against block mapping, i_truncate_mutex is
> +	 * used. i_truncate_mutex also protects against concurrent accesses
> +	 * and changes to the inode private data, and in particular changes to
> +	 * a sequential file size on completion of direct IO writes.
> +	 * Serialization of mmap read IOs with truncate and syscall IO
> +	 * operations is done with i_mmap_sem in addition to i_truncate_mutex.
> +	 * Only zonefs_seq_file_truncate() takes both lock (i_mmap_sem first,
> +	 * i_truncate_mutex second).
> +	 */
> +	struct mutex		i_truncate_mutex;
> +	struct rw_semaphore	i_mmap_sem;
> +};
> +
> +static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)
> +{
> +	return container_of(inode, struct zonefs_inode_info, i_vnode);
> +}
> +
> +/*
> + * On-disk super block (block 0).
> + */
> +#define ZONEFS_LABEL_LEN	64
> +#define ZONEFS_UUID_SIZE	16
> +#define ZONEFS_SUPER_SIZE	4096
> +
> +struct zonefs_super {
> +
> +	/* Magic number */
> +	__le32		s_magic;
> +
> +	/* Checksum */
> +	__le32		s_crc;
> +
> +	/* Volume label */
> +	char		s_label[ZONEFS_LABEL_LEN];
> +
> +	/* 128-bit uuid */
> +	__u8		s_uuid[ZONEFS_UUID_SIZE];
> +
> +	/* Features */
> +	__le64		s_features;
> +
> +	/* UID/GID to use for files */
> +	__le32		s_uid;
> +	__le32		s_gid;
> +
> +	/* File permissions */
> +	__le32		s_perm;
> +
> +	/* Padding to ZONEFS_SUPER_SIZE bytes */
> +	__u8		s_reserved[3988];
> +
> +} __packed;
> +
> +/*
> + * Feature flags: used on disk in the s_features field of struct zonefs_super
> + * and in-memory in the s_feartures field of struct zonefs_sb_info.
> + */
> +enum zonefs_features {
> +	/*
> +	 * Aggregate contiguous conventional zones into a single file.
> +	 */
> +	ZONEFS_F_AGGRCNV = 1ULL << 0,
> +	/*
> +	 * Use super block specified UID for files instead of default.
> +	 */
> +	ZONEFS_F_UID = 1ULL << 1,
> +	/*
> +	 * Use super block specified GID for files instead of default.
> +	 */
> +	ZONEFS_F_GID = 1ULL << 2,
> +	/*
> +	 * Use super block specified file permissions instead of default 640.
> +	 */
> +	ZONEFS_F_PERM = 1ULL << 3,
> +};
> +
> +#define ZONEFS_F_DEFINED_FEATURES \
> +	(ZONEFS_F_AGGRCNV | ZONEFS_F_UID | ZONEFS_F_GID | ZONEFS_F_PERM)
> +
> +/*
> + * In-memory Super block information.
> + */
> +struct zonefs_sb_info {
> +
> +	spinlock_t		s_lock;
> +
> +	unsigned long long	s_features;
> +	kuid_t			s_uid;
> +	kgid_t			s_gid;
> +	umode_t			s_perm;
> +	uuid_t			s_uuid;
> +	loff_t			s_blocksize_mask;
> +
> +	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
> +
> +	loff_t			s_blocks;
> +	loff_t			s_used_blocks;
> +};
> +
> +static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
> +{
> +	return sb->s_fs_info;
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
> index 3ac436376d79..d78064007b17 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -87,6 +87,7 @@
>  #define NSFS_MAGIC		0x6e736673
>  #define BPF_FS_MAGIC		0xcafe4a11
>  #define AAFS_MAGIC		0x5a3c69f0
> +#define ZONEFS_MAGIC		0x5a4f4653
>  
>  /* Since UDF 2.01 is ISO 13346 based... */
>  #define UDF_SUPER_MAGIC		0x15013346
> -- 
> 2.24.1
> 
