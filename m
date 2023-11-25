Return-Path: <linux-fsdevel+bounces-3796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1357F89B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B0EB21509
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D52CA4E;
	Sat, 25 Nov 2023 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A449C10D2;
	Sat, 25 Nov 2023 01:39:47 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Scmz21B18z4f3lwR;
	Sat, 25 Nov 2023 17:39:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DB8B71A0391;
	Sat, 25 Nov 2023 17:39:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA7bwGFldwaOBw--.23278S4;
	Sat, 25 Nov 2023 17:39:43 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@infradead.org,
	ming.lei@redhat.com,
	axboe@kernel.dk,
	roger.pau@citrix.com,
	colyli@suse.de,
	kent.overstreet@gmail.com,
	joern@lazybastard.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	sth@linux.ibm.com,
	hoeppner@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	nico@fluxnic.net,
	xiang@kernel.org,
	chao@kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	agruenba@redhat.com,
	jack@suse.com,
	konishi.ryusuke@gmail.com,
	dchinner@redhat.com,
	linux@weissschuh.net,
	gregkh@linuxfoundation.org,
	min15.li@samsung.com,
	dlemoal@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	p.raghav@samsung.com,
	hare@suse.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next] block: remove field 'bd_inode' from block_device
Date: Sat, 25 Nov 2023 17:39:12 +0800
Message-Id: <20231125093912.141486-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA7bwGFldwaOBw--.23278S4
X-Coremail-Antispam: 1UD129KBjvAXoWfurWDGr4kuw47KryDKr4kJFb_yoW5Cr1fZo
	W3Jr13Wr1kJry3J397G3s2ya4UX39rCws3CFs8CFn0va4F9w1jk347Ga15AF1fuw1rKF1f
	A34xAa1rXFWUAayrn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYI7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjfUojjgUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

block_devcie is allocated from bdev_alloc() by bdev_alloc_inode(), and
currently block_device contains a pointer that point to the address of
inode, while such inode is allocated together:

bdev_alloc
 inode = new_inode()
  // inode is &bdev_inode->vfs_inode
 bdev = I_BDEV(inode)
  // bdev is &bdev_inode->bdev
 bdev->inode = inode

Add a new helper to get address of inode from bdev by add operation
instead of memory access, which is more efficiency. Also prepare to
add a new field 'bd_flags' in the first cacheline(64 bytes).

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c                       | 39 +++++++++++++++++-------------
 block/blk-zoned.c                  |  4 +--
 block/fops.c                       |  4 +--
 block/genhd.c                      |  8 +++---
 block/ioctl.c                      |  8 +++---
 block/partitions/core.c            |  9 ++++---
 drivers/block/xen-blkback/xenbus.c |  2 +-
 drivers/md/bcache/super.c          |  2 +-
 drivers/mtd/devices/block2mtd.c    | 12 ++++-----
 drivers/s390/block/dasd_ioctl.c    |  2 +-
 drivers/scsi/scsicam.c             |  2 +-
 fs/bcachefs/util.h                 |  2 +-
 fs/btrfs/disk-io.c                 |  6 ++---
 fs/btrfs/volumes.c                 |  4 +--
 fs/btrfs/zoned.c                   |  2 +-
 fs/buffer.c                        |  8 +++---
 fs/cramfs/inode.c                  |  2 +-
 fs/erofs/data.c                    |  2 +-
 fs/ext4/dir.c                      |  2 +-
 fs/ext4/ext4_jbd2.c                |  2 +-
 fs/ext4/super.c                    |  8 +++---
 fs/gfs2/glock.c                    |  2 +-
 fs/gfs2/ops_fstype.c               |  2 +-
 fs/jbd2/journal.c                  |  3 ++-
 fs/jbd2/recovery.c                 |  2 +-
 fs/nilfs2/segment.c                |  2 +-
 include/linux/blk_types.h          | 10 ++++++--
 include/linux/blkdev.h             |  4 +--
 include/linux/buffer_head.h        |  4 +--
 29 files changed, 86 insertions(+), 73 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index e4cfb7adb645..f27eb5588332 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -48,7 +48,7 @@ EXPORT_SYMBOL(I_BDEV);
 
 static void bdev_write_inode(struct block_device *bdev)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int ret;
 
 	spin_lock(&inode->i_lock);
@@ -67,7 +67,7 @@ static void bdev_write_inode(struct block_device *bdev)
 /* Kill _all_ buffers and pagecache , dirty or not.. */
 static void kill_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 
 	if (mapping_empty(mapping))
 		return;
@@ -79,7 +79,7 @@ static void kill_bdev(struct block_device *bdev)
 /* Invalidate clean unused buffers and pagecache. */
 void invalidate_bdev(struct block_device *bdev)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 
 	if (mapping->nrpages) {
 		invalidate_bh_lrus();
@@ -107,7 +107,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 			goto invalidate;
 	}
 
-	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
+	truncate_inode_pages_range(bdev_inode(bdev)->i_mapping, lstart, lend);
 	if (!(mode & BLK_OPEN_EXCL))
 		bd_abort_claiming(bdev, truncate_bdev_range);
 	return 0;
@@ -117,7 +117,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 	 * Someone else has handle exclusively open. Try invalidating instead.
 	 * The 'end' argument is inclusive so the rounding is safe.
 	 */
-	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
+	return invalidate_inode_pages2_range(bdev_inode(bdev)->i_mapping,
 					     lstart >> PAGE_SHIFT,
 					     lend >> PAGE_SHIFT);
 }
@@ -125,18 +125,21 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 static void set_init_blocksize(struct block_device *bdev)
 {
 	unsigned int bsize = bdev_logical_block_size(bdev);
-	loff_t size = i_size_read(bdev->bd_inode);
+	struct inode *inode = bdev_inode(bdev);
+	loff_t size = i_size_read(inode);
 
 	while (bsize < PAGE_SIZE) {
 		if (size & bsize)
 			break;
 		bsize <<= 1;
 	}
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	inode->i_blkbits = blksize_bits(bsize);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
 {
+	struct inode *inode;
+
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */
 	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
 		return -EINVAL;
@@ -146,9 +149,10 @@ int set_blocksize(struct block_device *bdev, int size)
 		return -EINVAL;
 
 	/* Don't change the size if it is same as current */
-	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
+	inode = bdev_inode(bdev);
+	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
-		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		inode->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
 	}
 	return 0;
@@ -183,7 +187,7 @@ int sync_blockdev_nowait(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_flush(bdev->bd_inode->i_mapping);
+	return filemap_flush(bdev_inode(bdev)->i_mapping);
 }
 EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
 
@@ -195,13 +199,13 @@ int sync_blockdev(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return filemap_write_and_wait(bdev->bd_inode->i_mapping);
+	return filemap_write_and_wait(bdev_inode(bdev)->i_mapping);
 }
 EXPORT_SYMBOL(sync_blockdev);
 
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
 {
-	return filemap_write_and_wait_range(bdev->bd_inode->i_mapping,
+	return filemap_write_and_wait_range(bdev_inode(bdev)->i_mapping,
 			lstart, lend);
 }
 EXPORT_SYMBOL(sync_blockdev_range);
@@ -400,7 +404,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
 	bdev->bd_partno = partno;
-	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
 	if (partno)
 		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
@@ -418,17 +421,19 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
 	spin_lock(&bdev->bd_size_lock);
-	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
+	i_size_write(bdev_inode(bdev), (loff_t)sectors << SECTOR_SHIFT);
 	bdev->bd_nr_sectors = sectors;
 	spin_unlock(&bdev->bd_size_lock);
 }
 
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
+	struct inode *inode = bdev_inode(bdev);
+
 	bdev->bd_dev = dev;
-	bdev->bd_inode->i_rdev = dev;
-	bdev->bd_inode->i_ino = dev;
-	insert_inode_hash(bdev->bd_inode);
+	inode->i_rdev = dev;
+	inode->i_ino = dev;
+	insert_inode_hash(inode);
 }
 
 long nr_blockdev_pages(void)
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 619ee41a51cc..6b91f6d45590 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -401,7 +401,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
-		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_lock(bdev_inode(bdev)->i_mapping);
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
 			goto fail;
@@ -424,7 +424,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 fail:
 	if (cmd == BLKRESETZONE)
-		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+		filemap_invalidate_unlock(bdev_inode(bdev)->i_mapping);
 
 	return ret;
 }
diff --git a/block/fops.c b/block/fops.c
index 0abaac705daf..45ee180448ed 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -605,7 +605,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (bdev_nowait(handle->bdev))
 		filp->f_mode |= FMODE_NOWAIT;
 
-	filp->f_mapping = handle->bdev->bd_inode->i_mapping;
+	filp->f_mapping = bdev_inode(handle->bdev)->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
 	filp->private_data = handle;
 	return 0;
@@ -657,7 +657,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(file->f_mapping->host);
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_inode(bdev);
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
 	ssize_t ret;
diff --git a/block/genhd.c b/block/genhd.c
index c9d06f72c587..643936a47547 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -653,7 +653,7 @@ void del_gendisk(struct gendisk *disk)
 	 */
 	mutex_lock(&disk->open_mutex);
 	xa_for_each(&disk->part_tbl, idx, part)
-		remove_inode_hash(part->bd_inode);
+		remove_inode_hash(bdev_inode(part));
 	mutex_unlock(&disk->open_mutex);
 
 	/*
@@ -742,7 +742,7 @@ void invalidate_disk(struct gendisk *disk)
 	struct block_device *bdev = disk->part0;
 
 	invalidate_bdev(bdev);
-	bdev->bd_inode->i_mapping->wb_err = 0;
+	bdev_inode(bdev)->i_mapping->wb_err = 0;
 	set_capacity(disk, 0);
 }
 EXPORT_SYMBOL(invalidate_disk);
@@ -1188,7 +1188,7 @@ static void disk_release(struct device *dev)
 	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
 		disk->fops->free_disk(disk);
 
-	iput(disk->part0->bd_inode);	/* frees the disk */
+	iput(bdev_inode(disk->part0));	/* frees the disk */
 }
 
 static int block_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -1378,7 +1378,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
 	disk->part0->bd_disk = NULL;
-	iput(disk->part0->bd_inode);
+	iput(bdev_inode(disk->part0));
 out_free_bdi:
 	bdi_put(disk->bdi);
 out_free_bioset:
diff --git a/block/ioctl.c b/block/ioctl.c
index 4160f4e6bd5b..185336f3d4f2 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -89,7 +89,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, len;
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -143,12 +143,12 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
-	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_lock(bdev_inode(bdev)->i_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
-	filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+	filemap_invalidate_unlock(bdev_inode(bdev)->i_mapping);
 	return err;
 }
 
@@ -158,7 +158,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, end, len;
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index f47ffcfdfcec..ac678c340e19 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -243,7 +243,7 @@ static const struct attribute_group *part_attr_groups[] = {
 static void part_release(struct device *dev)
 {
 	put_disk(dev_to_bdev(dev)->bd_disk);
-	iput(dev_to_bdev(dev)->bd_inode);
+	iput(bdev_inode(dev_to_bdev(dev)));
 }
 
 static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
@@ -483,7 +483,7 @@ int bdev_del_partition(struct gendisk *disk, int partno)
 	 * Just delete the partition and invalidate it.
 	 */
 
-	remove_inode_hash(part->bd_inode);
+	remove_inode_hash(bdev_inode(part));
 	invalidate_bdev(part);
 	drop_partition(part);
 	ret = 0;
@@ -669,7 +669,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		 * it cannot be looked up any more even when openers
 		 * still hold references.
 		 */
-		remove_inode_hash(part->bd_inode);
+		remove_inode_hash(bdev_inode(part));
 
 		/*
 		 * If @disk->open_partitions isn't elevated but there's
@@ -718,7 +718,8 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
-	struct address_space *mapping = state->disk->part0->bd_inode->i_mapping;
+	struct address_space *mapping =
+			bdev_inode(state->disk->part0)->i_mapping;
 	struct folio *folio;
 
 	if (n >= get_capacity(state->disk)) {
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index e34219ea2b05..e11f8123d213 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -105,7 +105,7 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
 		return;
 	}
 	invalidate_inode_pages2(
-			blkif->vbd.bdev_handle->bdev->bd_inode->i_mapping);
+			bdev_inode(blkif->vbd.bdev_handle->bdev)->i_mapping);
 
 	for (i = 0; i < blkif->nr_rings; i++) {
 		ring = &blkif->rings[i];
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index bfe1685dbae5..3ab8bae049ee 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -171,7 +171,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 	struct page *page;
 	unsigned int i;
 
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping,
+	page = read_cache_page_gfp(bdev_inode(bdev)->i_mapping,
 				   SB_OFFSET >> PAGE_SHIFT, GFP_KERNEL);
 	if (IS_ERR(page))
 		return "IO error";
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index aa44a23ec045..d4f7a4339a70 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -56,7 +56,7 @@ static struct page *page_read(struct address_space *mapping, pgoff_t index)
 static int _block2mtd_erase(struct block2mtd_dev *dev, loff_t to, size_t len)
 {
 	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+				bdev_inode(dev->bdev_handle->bdev)->i_mapping;
 	struct page *page;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int pages = len >> PAGE_SHIFT;
@@ -107,7 +107,7 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 {
 	struct block2mtd_dev *dev = mtd->priv;
 	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+				bdev_inode(dev->bdev_handle->bdev)->i_mapping;
 	struct page *page;
 	pgoff_t index = from >> PAGE_SHIFT;
 	int offset = from & (PAGE_SIZE-1);
@@ -143,7 +143,7 @@ static int _block2mtd_write(struct block2mtd_dev *dev, const u_char *buf,
 {
 	struct page *page;
 	struct address_space *mapping =
-				dev->bdev_handle->bdev->bd_inode->i_mapping;
+				bdev_inode(dev->bdev_handle->bdev)->i_mapping;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int offset = to & ~PAGE_MASK;	// page offset
 	int cpylen;
@@ -212,7 +212,7 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 
 	if (dev->bdev_handle) {
 		invalidate_mapping_pages(
-			dev->bdev_handle->bdev->bd_inode->i_mapping, 0, -1);
+			bdev_inode(dev->bdev_handle->bdev)->i_mapping, 0, -1);
 		bdev_release(dev->bdev_handle);
 	}
 
@@ -295,7 +295,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		goto err_free_block2mtd;
 	}
 
-	if ((long)bdev->bd_inode->i_size % erase_size) {
+	if ((long)bdev_inode(bdev)->i_size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
@@ -313,7 +313,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 
 	dev->mtd.name = name;
 
-	dev->mtd.size = bdev->bd_inode->i_size & PAGE_MASK;
+	dev->mtd.size = bdev_inode(bdev)->i_size & PAGE_MASK;
 	dev->mtd.erasesize = erase_size;
 	dev->mtd.writesize = 1;
 	dev->mtd.writebufsize = PAGE_SIZE;
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 61b9675e2a67..a34554ace310 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -221,7 +221,7 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
 	 * enabling the device later.
 	 */
 	if (fdata->start_unit == 0) {
-		block->gdp->part0->bd_inode->i_blkbits =
+		bdev_inode(block->gdp->part0)->i_blkbits =
 			blksize_bits(fdata->blksize);
 	}
 
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index e2c7d8ef205f..de40a5ef7d96 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -32,7 +32,7 @@
  */
 unsigned char *scsi_bios_ptable(struct block_device *dev)
 {
-	struct address_space *mapping = bdev_whole(dev)->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev_whole(dev))->i_mapping;
 	unsigned char *res = NULL;
 	struct folio *folio;
 
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index 2984b57b2958..fe7ccb3a3517 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -518,7 +518,7 @@ int bch2_bio_alloc_pages(struct bio *, size_t, gfp_t);
 
 static inline sector_t bdev_sectors(struct block_device *bdev)
 {
-	return bdev->bd_inode->i_size >> 9;
+	return bdev_inode(bdev)->i_size >> 9;
 }
 
 #define closure_bio_submit(bio, cl)					\
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 401ea09ae4b8..88b20cd4d046 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3653,7 +3653,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 	struct btrfs_super_block *super;
 	struct page *page;
 	u64 bytenr, bytenr_orig;
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 	int ret;
 
 	bytenr_orig = btrfs_sb_offset(copy_num);
@@ -3740,7 +3740,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(device->bdev)->i_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3857,7 +3857,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
+		page = find_get_page(bdev_inode(device->bdev)->i_mapping,
 				     bytenr >> PAGE_SHIFT);
 		if (!page) {
 			errors++;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6f16625af51..bbf157cedab7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1257,8 +1257,8 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 		return ERR_PTR(-EINVAL);
 
 	/* pull in the page with our super */
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index, GFP_KERNEL);
-
+	page = read_cache_page_gfp(bdev_inode(bdev)->i_mapping, index,
+				   GFP_KERNEL);
 	if (IS_ERR(page))
 		return ERR_CAST(page);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 188378ca19c7..a5f7f1458edf 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -120,7 +120,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		return -ENOENT;
 	} else if (full[0] && full[1]) {
 		/* Compare two super blocks */
-		struct address_space *mapping = bdev->bd_inode->i_mapping;
+		struct address_space *mapping = bdev_inode(bdev)->i_mapping;
 		struct page *page[BTRFS_NR_SB_LOG_ZONES];
 		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
 		int i;
diff --git a/fs/buffer.c b/fs/buffer.c
index 967f34b70aa8..bf993198f881 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -189,7 +189,7 @@ EXPORT_SYMBOL(end_buffer_write_sync);
 static struct buffer_head *
 __find_get_block_slow(struct block_device *bdev, sector_t block)
 {
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_inode(bdev);
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct buffer_head *ret = NULL;
 	pgoff_t index;
@@ -1032,7 +1032,7 @@ static int
 grow_dev_page(struct block_device *bdev, sector_t block,
 	      pgoff_t index, int size, int sizebits, gfp_t gfp)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct inode *inode = bdev_inode(bdev);
 	struct folio *folio;
 	struct buffer_head *bh;
 	sector_t end_block;
@@ -1463,7 +1463,7 @@ __bread_gfp(struct block_device *bdev, sector_t block,
 {
 	struct buffer_head *bh;
 
-	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp |= mapping_gfp_constraint(bdev_inode(bdev)->i_mapping, ~__GFP_FS);
 
 	/*
 	 * Prefer looping in the allocator rather than here, at least that
@@ -1696,7 +1696,7 @@ EXPORT_SYMBOL(create_empty_buffers);
  */
 void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
 {
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_inode(bdev);
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct folio_batch fbatch;
 	pgoff_t index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 60dbfa0f8805..e9ed1e24c9e4 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -183,7 +183,7 @@ static int next_buffer;
 static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 				unsigned int len)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(sb->s_bdev)->i_mapping;
 	struct file_ra_state ra = {};
 	struct page *pages[BLKS_PER_BUF];
 	unsigned i, blocknr, buffer;
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 029c761670bf..85d490b3b53d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -70,7 +70,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 	if (erofs_is_fscache_mode(sb))
 		buf->inode = EROFS_SB(sb)->s_fscache->inode;
 	else
-		buf->inode = sb->s_bdev->bd_inode;
+		buf->inode = bdev_inode(sb->s_bdev);
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3985f8c33f95..6e9fe408642b 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -192,7 +192,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					(PAGE_SHIFT - inode->i_blkbits);
 			if (!ra_has_index(&file->f_ra, index))
 				page_cache_sync_readahead(
-					sb->s_bdev->bd_inode->i_mapping,
+					bdev_inode(sb->s_bdev)->i_mapping,
 					&file->f_ra, file,
 					index, 1);
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d1a2e6624401..e0e7f71d022d 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -206,7 +206,7 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
 
 static void ext4_check_bdev_write_error(struct super_block *sb)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct address_space *mapping = bdev_inode(sb->s_bdev)->i_mapping;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int err;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..da6af2205e55 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -244,7 +244,7 @@ static struct buffer_head *__ext4_sb_bread_gfp(struct super_block *sb,
 struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 				   blk_opf_t op_flags)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(bdev_inode(sb->s_bdev)->i_mapping,
 			~__GFP_FS) | __GFP_MOVABLE;
 
 	return __ext4_sb_bread_gfp(sb, block, op_flags, gfp);
@@ -253,7 +253,7 @@ struct buffer_head *ext4_sb_bread(struct super_block *sb, sector_t block,
 struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 					    sector_t block)
 {
-	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_inode->i_mapping,
+	gfp_t gfp = mapping_gfp_constraint(bdev_inode(sb->s_bdev)->i_mapping,
 			~__GFP_FS);
 
 	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
@@ -502,7 +502,7 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
  */
 static int block_device_ejected(struct super_block *sb)
 {
-	struct inode *bd_inode = sb->s_bdev->bd_inode;
+	struct inode *bd_inode = bdev_inode(sb->s_bdev);
 	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
 
 	return bdi->dev == NULL;
@@ -5585,7 +5585,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * used to detect the metadata async write error.
 	 */
 	spin_lock_init(&sbi->s_bdev_wb_lock);
-	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+	errseq_check_and_advance(&bdev_inode(sb->s_bdev)->i_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d6bf1f8c25dc..ec6394544ebb 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1210,7 +1210,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	mapping = gfs2_glock2aspace(gl);
 	if (mapping) {
                 mapping->a_ops = &gfs2_meta_aops;
-		mapping->host = s->s_bdev->bd_inode;
+		mapping->host = bdev_inode(s->s_bdev);
 		mapping->flags = 0;
 		mapping_set_gfp_mask(mapping, GFP_NOFS);
 		mapping->private_data = NULL;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index b108c5d26839..dfc4735cfd54 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -114,7 +114,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 
 	address_space_init_once(mapping);
 	mapping->a_ops = &gfs2_rgrp_aops;
-	mapping->host = sb->s_bdev->bd_inode;
+	mapping->host = bdev_inode(sb->s_bdev);
 	mapping->flags = 0;
 	mapping_set_gfp_mask(mapping, GFP_NOFS);
 	mapping->private_data = NULL;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index ed53188472f9..e2d034cc9dc0 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2003,7 +2003,8 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 		byte_count = (block_stop - block_start + 1) *
 				journal->j_blocksize;
 
-		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
+		truncate_inode_pages_range(
+				bdev_inode(journal->j_dev)->i_mapping,
 				byte_start, byte_stop);
 
 		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 01f744cb97a4..7774efe872e8 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -309,7 +309,7 @@ int jbd2_journal_recover(journal_t *journal)
 	}
 
 	wb_err = 0;
-	mapping = journal->j_fs_dev->bd_inode->i_mapping;
+	mapping = bdev_inode(journal->j_fs_dev)->i_mapping;
 	errseq_check_and_advance(&mapping->wb_err, &wb_err);
 	err = do_one_pass(journal, &info, PASS_SCAN);
 	if (!err)
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 55e31cc903d1..d346f5c1aad7 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2823,7 +2823,7 @@ int nilfs_attach_log_writer(struct super_block *sb, struct nilfs_root *root)
 	if (!nilfs->ns_writer)
 		return -ENOMEM;
 
-	inode_attach_wb(nilfs->ns_bdev->bd_inode, NULL);
+	inode_attach_wb(bdev_inode(nilfs->ns_bdev), NULL);
 
 	err = nilfs_segctor_start_thread(nilfs->ns_writer);
 	if (unlikely(err))
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd2..db7c2b2179c7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -50,8 +50,7 @@ struct block_device {
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
 	atomic_t		bd_openers;
-	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
-	struct inode *		bd_inode;	/* will die */
+	spinlock_t		bd_size_lock; /* for inode i_size updates */
 	void *			bd_claiming;
 	void *			bd_holder;
 	const struct blk_holder_ops *bd_holder_ops;
@@ -85,6 +84,13 @@ struct block_device {
 #define bdev_kobj(_bdev) \
 	(&((_bdev)->bd_device.kobj))
 
+static inline struct inode *bdev_inode(struct block_device *bdev)
+{
+	void *inode = bdev + 1;
+
+	return inode;
+}
+
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..ef625ebefc7d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -211,7 +211,7 @@ struct gendisk {
 
 static inline bool disk_live(struct gendisk *disk)
 {
-	return !inode_unhashed(disk->part0->bd_inode);
+	return !inode_unhashed(bdev_inode(disk->part0));
 }
 
 /**
@@ -1339,7 +1339,7 @@ static inline unsigned int blksize_bits(unsigned int size)
 
 static inline unsigned int block_size(struct block_device *bdev)
 {
-	return 1 << bdev->bd_inode->i_blkbits;
+	return 1 << bdev_inode(bdev)->i_blkbits;
 }
 
 int kblockd_schedule_work(struct work_struct *work);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 5f23ee599889..da9ee62e3aa9 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -341,7 +341,7 @@ static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
 {
 	gfp_t gfp;
 
-	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp = mapping_gfp_constraint(bdev_inode(bdev)->i_mapping, ~__GFP_FS);
 	gfp |= __GFP_NOFAIL;
 
 	return bdev_getblk(bdev, block, size, gfp);
@@ -352,7 +352,7 @@ static inline struct buffer_head *__getblk(struct block_device *bdev,
 {
 	gfp_t gfp;
 
-	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp = mapping_gfp_constraint(bdev_inode(bdev)->i_mapping, ~__GFP_FS);
 	gfp |= __GFP_MOVABLE | __GFP_NOFAIL;
 
 	return bdev_getblk(bdev, block, size, gfp);
-- 
2.39.2


