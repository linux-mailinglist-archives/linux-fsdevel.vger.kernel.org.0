Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C6F53C46F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbiFCFiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbiFCFhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:37:54 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4035F36E02;
        Thu,  2 Jun 2022 22:37:51 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AmidyoKATz6uoeRVW/7Hiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fDFXthWkq0mAPnGEbWTvUO/+NM2KgfIpyaI+1/U0EsZeAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/EYqOGXeSHXXcu7iheun2HX6/lnEkA6FYMC/eNwG2t?=
 =?us-ascii?q?P6boTLzVlRhSCgee3ybW7R8Fsm808IcitN4Qa0llgxjHxDPAoW5nPTqzGo9hC0?=
 =?us-ascii?q?18YmcFKGef2ZswXczNjYR3MJRpVNT8/BJs42uXumXj7cjRds3qUo7Y65y7Yywk?=
 =?us-ascii?q?Z+LTkNpzXPMOLQcFUl0ODjmPA42n9RBodMbS3xTia9XSjruzChyX2XMQVDrLQ3?=
 =?us-ascii?q?vprhkCDg2kWIB4IXFC45/6jhSaWUtFHLmQQ+ywzve0881GtQtDhXhq+5nmesXY?=
 =?us-ascii?q?0XcRcEug/wAWM0bbPpQKYAHUUCDJMdrQOtMQ2bTgxyhmFkrvBAzVoobTTSXWH9?=
 =?us-ascii?q?7iJpjOzES4YJikJYipsZQkM5dSlq4EuphXVR91nHei+ididMSv/xDSGszk4r64?=
 =?us-ascii?q?OlsNN26jT1VTGhS+845bSQgMr6wH/QG2o9EV6aZSjaoju7kLUhd5ELYCEXhyCs?=
 =?us-ascii?q?WIClsy28u8DF9eOmTaLTeFLG6umj96BMTvBkRt/EYIJ6Tug4TigcJpW7TU4I11?=
 =?us-ascii?q?mWu4aeCXuSF3evwJPoptSOma6K6htbMSsCKwXIQLIfTj+fqmMKIMQPd4qL0nal?=
 =?us-ascii?q?ByCrHW4hwjF+HXAW4ljUXtDTfuRMA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AVPLeg6zn+XYOGsgSt5GXKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124686801"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 13:37:44 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D6C534D17198;
        Fri,  3 Jun 2022 13:37:41 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:42 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 13:37:41 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.wiliams@intel.com>
Subject: [PATCH v2 01/14] dax: Introduce holder for dax_device
Date:   Fri, 3 Jun 2022 13:37:25 +0800
Message-ID: <20220603053738.1218681-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D6C534D17198.A2764
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.wiliams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/dax/super.c | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/md/dm.c     |  2 +-
 fs/erofs/super.c    | 10 ++++---
 fs/ext2/super.c     |  7 +++--
 fs/ext4/super.c     |  9 +++---
 fs/xfs/xfs_buf.c    |  5 ++--
 include/linux/dax.h | 33 ++++++++++++++++------
 7 files changed, 110 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 50a08b2ec247..9b5e2a5eb0ae 100644
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
@@ -92,11 +99,26 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
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
+	if (dax_dev && holder &&
+	    cmpxchg(&dax_dev->holder_data, holder, NULL) == holder)
+		dax_dev->holder_ops = NULL;
+	put_dax(dax_dev);
+}
+EXPORT_SYMBOL_GPL(fs_put_dax);
 #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
 enum dax_device_flags {
@@ -204,6 +226,29 @@ size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_recovery_write);
 
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
@@ -277,8 +322,15 @@ void kill_dax(struct dax_device *dax_dev)
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
 
@@ -420,6 +472,19 @@ void put_dax(struct dax_device *dax_dev)
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
index dfb0a551bd88..3de8167a3905 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -760,7 +760,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
 	}
 
 	td->dm_dev.bdev = bdev;
-	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);
+	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off, NULL, NULL);
 	return 0;
 }
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 95addc5c9d34..3173debeaa5a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -255,7 +255,8 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (IS_ERR(bdev))
 			return PTR_ERR(bdev);
 		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
+		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off,
+						  NULL, NULL);
 	}
 
 	dif->blocks = le32_to_cpu(dis->blocks);
@@ -720,7 +721,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 
 		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
-						  &sbi->dax_part_off);
+						  &sbi->dax_part_off,
+						  NULL, NULL);
 	}
 
 	err = erofs_read_superblock(sb);
@@ -812,7 +814,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 {
 	struct erofs_device_info *dif = ptr;
 
-	fs_put_dax(dif->dax_dev);
+	fs_put_dax(dif->dax_dev, NULL);
 	if (dif->bdev)
 		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
 	erofs_fscache_unregister_cookie(&dif->fscache);
@@ -886,7 +888,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		return;
 
 	erofs_free_dev_context(sbi->devs);
-	fs_put_dax(sbi->dax_dev);
+	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
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
index 450c918d68fc..0e91243b9616 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1307,7 +1307,7 @@ static void ext4_put_super(struct super_block *sb)
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
 	kfree(sbi->s_blockgroup_lock);
-	fs_put_dax(sbi->s_daxdev);
+	fs_put_dax(sbi->s_daxdev, NULL);
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
@@ -4262,7 +4262,7 @@ static void ext4_free_sbi(struct ext4_sb_info *sbi)
 		return;
 
 	kfree(sbi->s_blockgroup_lock);
-	fs_put_dax(sbi->s_daxdev);
+	fs_put_dax(sbi->s_daxdev, NULL);
 	kfree(sbi);
 }
 
@@ -4274,7 +4274,8 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
 	if (!sbi)
 		return NULL;
 
-	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
+					   NULL, NULL);
 
 	sbi->s_blockgroup_lock =
 		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
@@ -4286,7 +4287,7 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
 	sbi->s_sb = sb;
 	return sbi;
 err_out:
-	fs_put_dax(sbi->s_daxdev);
+	fs_put_dax(sbi->s_daxdev, NULL);
 	kfree(sbi);
 	return NULL;
 }
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 4aa9c9cf5b6e..1ec2a7b6d44e 100644
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
index e7b81634c52a..cf85fc36da5f 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -43,8 +43,21 @@ struct dax_operations {
 			void *addr, size_t bytes, struct iov_iter *iter);
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
@@ -66,6 +79,10 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
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
@@ -114,12 +131,9 @@ struct writeback_control;
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
@@ -129,11 +143,12 @@ static inline void dax_remove_host(struct gendisk *disk)
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
@@ -203,6 +218,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off, u64 len,
+		int mf_flags);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.36.1



