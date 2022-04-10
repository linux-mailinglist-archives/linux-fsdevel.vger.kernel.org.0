Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783D34FAEAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Apr 2022 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiDJQL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 12:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiDJQLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:11:25 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6899911A07;
        Sun, 10 Apr 2022 09:09:12 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AF2Qp5qnEhQ57urrVlalR/2jo5gzqJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2BWxzdNWjjXa6mCZTTyKYx3PomyoUJUuJ/Tnd4ySQtk+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCLk7ZHInxSWG5fr67A0ZK0sBqUU8/h2DUl?=
 =?us-ascii?q?A7/sdLyoHbwzFjOWzqJq7QelEh8ItNsDnMYoT/HZ6wlnxAf8gB5KFXKTO4d5R2?=
 =?us-ascii?q?SwYh8ZSEPKYbM0cARJjbgvHZRJnOVoNDp862uCyiRHXdzxetULQoK8f4Hbaxw8?=
 =?us-ascii?q?316LiWPLTZNCLQMB9mkeDunmA+2X/HwFcONGBoRKH+3ShwOTPgAv8QosZELD+/?=
 =?us-ascii?q?flv6HWXx2oOGFgYTle2v/S9olCxVsgZKEEO/Ccq668o+ySDStj7Qg39o3OeuBM?=
 =?us-ascii?q?Yc8RfHvd86wyXzKfQpQGDCQAsSj9HdcxjpMEtbSIl20XPnN7zAzFr9rqPRhqgG?=
 =?us-ascii?q?h28xd+pEXFNazZcOmlfFk1Yi+QPabob1nrnJuuP2obu5jEtJQzN/g=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AfUoj8qz/6FbRIfuTxbALKrPwyL1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SKKlfqeV7ZImPH7P+U8ssR4b+exoVJPtfZqYz+8R3WBzB8bEYOCFgh?=
 =?us-ascii?q?rKEGgK1+KLqFeMJ8S9zJ846U4KSclD4bPLYmSS9fyKgjVQDexQveWvweS5g/vE?=
 =?us-ascii?q?1XdxQUVPY6Fk1Q1wDQGWCSRNNXJ7LKt8BJyB/dBGujblXXwWa/6wDn4DU/OGiM?=
 =?us-ascii?q?bMkPvdEGQ7Li9i+A+Tlimp9bK/NxCZ2y0VWzRJzaxn0UWtqX2A2pme?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123453818"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Apr 2022 00:09:08 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 8EEE34D17163;
        Mon, 11 Apr 2022 00:09:06 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 11 Apr 2022 00:09:05 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 11 Apr 2022 00:09:05 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v12 1/7] dax: Introduce holder for dax_device
Date:   Mon, 11 Apr 2022 00:08:58 +0800
Message-ID: <20220410160904.3758789-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410160904.3758789-1-ruansy.fnst@fujitsu.com>
References: <20220410160904.3758789-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8EEE34D17163.A40B1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To easily track filesystem from a pmem device, we introduce a holder for
dax_device structure, and also its operation.  This holder is used to
remember who is using this dax_device:
 - When it is the backend of a filesystem, the holder will be the
   instance of this filesystem.
 - When this pmem device is one of the targets in a mapped device, the
   holder will be this mapped device.  In this case, the mapped device
   has its own dax_device and it will follow the first rule.  So that we
   can finally track to the filesystem we needed.

The holder and holder_ops will be set when filesystem is being mounted,
or an target device is being activated.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c | 66 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/md/dm.c     |  2 +-
 fs/erofs/super.c    | 10 ++++---
 fs/ext2/super.c     |  7 ++---
 fs/ext4/super.c     |  9 ++++---
 fs/xfs/xfs_buf.c    |  5 ++--
 include/linux/dax.h | 33 +++++++++++++++++------
 7 files changed, 109 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0211e6f7b47a..619a05615497 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -22,6 +22,8 @@
  * @private: dax driver private data
  * @flags: state and boolean properties
  * @ops: operations for this device
+ * @holder_data: holder of a dax_device: could be filesystem or mapped device
+ * @holder_ops: operations for the inner holder
  */
 struct dax_device {
 	struct inode inode;
@@ -29,6 +31,8 @@ struct dax_device {
 	void *private;
 	unsigned long flags;
 	const struct dax_operations *ops;
+	void *holder_data;
+	const struct dax_holder_operations *holder_ops;
 };
 
 static dev_t dax_devt;
@@ -71,8 +75,11 @@ EXPORT_SYMBOL_GPL(dax_remove_host);
  * fs_dax_get_by_bdev() - temporary lookup mechanism for filesystem-dax
  * @bdev: block device to find a dax_device for
  * @start_off: returns the byte offset into the dax_device that @bdev starts
+ * @holder: filesystem or mapped device inside the dax_device
+ * @ops: operations for the inner holder
  */
-struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
+struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off,
+		void *holder, const struct dax_holder_operations *ops)
 {
 	struct dax_device *dax_dev;
 	u64 part_size;
@@ -92,11 +99,25 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
 	dax_dev = xa_load(&dax_hosts, (unsigned long)bdev->bd_disk);
 	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
 		dax_dev = NULL;
+	else if (holder) {
+		if (!cmpxchg(&dax_dev->holder_data, NULL, holder))
+			dax_dev->holder_ops = ops;
+		else
+			dax_dev = NULL;
+	}
 	dax_read_unlock(id);
 
 	return dax_dev;
 }
 EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
+
+void fs_put_dax(struct dax_device *dax_dev, void *holder)
+{
+	if (holder && cmpxchg(&dax_dev->holder_data, holder, NULL) == holder)
+		dax_dev->holder_ops = NULL;
+	put_dax(dax_dev);
+}
+EXPORT_SYMBOL_GPL(fs_put_dax);
 #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
 enum dax_device_flags {
@@ -194,6 +215,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
+			      u64 len, int mf_flags)
+{
+	int rc, id;
+
+	id = dax_read_lock();
+	if (!dax_alive(dax_dev)) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (!dax_dev->holder_ops) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
+	rc = dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
+out:
+	dax_read_unlock(id);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
@@ -267,8 +311,15 @@ void kill_dax(struct dax_device *dax_dev)
 	if (!dax_dev)
 		return;
 
+	if (dax_dev->holder_data != NULL)
+		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
+
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
 	synchronize_srcu(&dax_srcu);
+
+	/* clear holder data */
+	dax_dev->holder_ops = NULL;
+	dax_dev->holder_data = NULL;
 }
 EXPORT_SYMBOL_GPL(kill_dax);
 
@@ -410,6 +461,19 @@ void put_dax(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(put_dax);
 
+/**
+ * dax_holder() - obtain the holder of a dax device
+ * @dax_dev: a dax_device instance
+
+ * Return: the holder's data which represents the holder if registered,
+ * otherwize NULL.
+ */
+void *dax_holder(struct dax_device *dax_dev)
+{
+	return dax_dev->holder_data;
+}
+EXPORT_SYMBOL_GPL(dax_holder);
+
 /**
  * inode_dax: convert a public inode into its dax_dev
  * @inode: An inode with i_cdev pointing to a dax_dev
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8200a7498baf..d165ab828b04 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -729,7 +729,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
 	}
 
 	td->dm_dev.bdev = bdev;
-	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);
+	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off, NULL, NULL);
 	return 0;
 }
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0c4b41130c2f..d0eab646ef94 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -267,7 +267,8 @@ static int erofs_init_devices(struct super_block *sb,
 			break;
 		}
 		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
+		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off,
+						  NULL, NULL);
 		dif->blocks = le32_to_cpu(dis->blocks);
 		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
 		sbi->total_blocks += dif->blocks;
@@ -597,7 +598,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
-	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
+	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off,
+					  NULL, NULL);
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
@@ -687,7 +689,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 {
 	struct erofs_device_info *dif = ptr;
 
-	fs_put_dax(dif->dax_dev);
+	fs_put_dax(dif->dax_dev, NULL);
 	if (dif->bdev)
 		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
 	kfree(dif->path);
@@ -756,7 +758,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		return;
 
 	erofs_free_dev_context(sbi->devs);
-	fs_put_dax(sbi->dax_dev);
+	fs_put_dax(sbi->dax_dev, NULL);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index f6a19f6d9f6d..4638946251b9 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -171,7 +171,7 @@ static void ext2_put_super (struct super_block * sb)
 	brelse (sbi->s_sbh);
 	sb->s_fs_info = NULL;
 	kfree(sbi->s_blockgroup_lock);
-	fs_put_dax(sbi->s_daxdev);
+	fs_put_dax(sbi->s_daxdev, NULL);
 	kfree(sbi);
 }
 
@@ -835,7 +835,8 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	sb->s_fs_info = sbi;
 	sbi->s_sb_block = sb_block;
-	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
+					   NULL, NULL);
 
 	spin_lock_init(&sbi->s_lock);
 	ret = -EINVAL;
@@ -1204,7 +1205,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 failed_mount:
 	brelse(bh);
 failed_sbi:
-	fs_put_dax(sbi->s_daxdev);
+	fs_put_dax(sbi->s_daxdev, NULL);
 	sb->s_fs_info = NULL;
 	kfree(sbi->s_blockgroup_lock);
 	kfree(sbi);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f5f4f2606ab2..59d5b2e8f838 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1300,7 +1300,7 @@ static void ext4_put_super(struct super_block *sb)
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
 	kfree(sbi->s_blockgroup_lock);
-	fs_put_dax(sbi->s_daxdev);
+	fs_put_dax(sbi->s_daxdev, NULL);
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
@@ -4351,7 +4351,7 @@ static void ext4_free_sbi(struct ext4_sb_info *sbi)
 		return;
 
 	kfree(sbi->s_blockgroup_lock);
-	fs_put_dax(sbi->s_daxdev);
+	fs_put_dax(sbi->s_daxdev, NULL);
 	kfree(sbi);
 }
 
@@ -4363,7 +4363,8 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
 	if (!sbi)
 		return NULL;
 
-	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
+					   NULL, NULL);
 
 	sbi->s_blockgroup_lock =
 		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
@@ -4375,7 +4376,7 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
 	sbi->s_sb = sb;
 	return sbi;
 err_out:
-	fs_put_dax(sbi->s_daxdev);
+	fs_put_dax(sbi->s_daxdev, NULL);
 	kfree(sbi);
 	return NULL;
 }
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e1afb9e503e1..f9ca08398d32 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1911,7 +1911,7 @@ xfs_free_buftarg(
 	list_lru_destroy(&btp->bt_lru);
 
 	blkdev_issue_flush(btp->bt_bdev);
-	fs_put_dax(btp->bt_daxdev);
+	fs_put_dax(btp->bt_daxdev, NULL);
 
 	kmem_free(btp);
 }
@@ -1964,7 +1964,8 @@ xfs_alloc_buftarg(
 	btp->bt_mount = mp;
 	btp->bt_dev =  bdev->bd_dev;
 	btp->bt_bdev = bdev;
-	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
+	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off, NULL,
+					    NULL);
 
 	/*
 	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9fc5f99a0ae2..9c426a207ba8 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -32,8 +32,21 @@ struct dax_operations {
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 };
 
+struct dax_holder_operations {
+	/*
+	 * notify_failure - notify memory failure into inner holder device
+	 * @dax_dev: the dax device which contains the holder
+	 * @offset: offset on this dax device where memory failure occurs
+	 * @len: length of this memory failure event
+	 * @flags: action flags for memory failure handler
+	 */
+	int (*notify_failure)(struct dax_device *dax_dev, u64 offset,
+			u64 len, int mf_flags);
+};
+
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
+void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
@@ -53,6 +66,10 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 	return dax_synchronous(dax_dev);
 }
 #else
+static inline void *dax_holder(struct dax_device *dax_dev)
+{
+	return NULL;
+}
 static inline struct dax_device *alloc_dax(void *private,
 		const struct dax_operations *ops)
 {
@@ -96,12 +113,9 @@ struct writeback_control;
 #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
 int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
 void dax_remove_host(struct gendisk *disk);
-struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
-		u64 *start_off);
-static inline void fs_put_dax(struct dax_device *dax_dev)
-{
-	put_dax(dax_dev);
-}
+struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off,
+		void *holder, const struct dax_holder_operations *ops);
+void fs_put_dax(struct dax_device *dax_dev, void *holder);
 #else
 static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 {
@@ -111,11 +125,12 @@ static inline void dax_remove_host(struct gendisk *disk)
 {
 }
 static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
-		u64 *start_off)
+		u64 *start_off, void *holder,
+		const struct dax_holder_operations *ops)
 {
 	return NULL;
 }
-static inline void fs_put_dax(struct dax_device *dax_dev)
+static inline void fs_put_dax(struct dax_device *dax_dev, void *holder)
 {
 }
 #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
@@ -185,6 +200,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off, u64 len,
+		int mf_flags);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.35.1



