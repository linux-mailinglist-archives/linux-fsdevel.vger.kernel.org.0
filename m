Return-Path: <linux-fsdevel+bounces-5479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC4F80CD33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03F3B2168E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6204A98A;
	Mon, 11 Dec 2023 14:07:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142BC1BC;
	Mon, 11 Dec 2023 06:07:23 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Spk8M2xyzz4f3lVW;
	Mon, 11 Dec 2023 22:07:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 466A21A0961;
	Mon, 11 Dec 2023 22:07:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xGTF3dlDYFxDQ--.28013S5;
	Mon, 11 Dec 2023 22:07:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
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
Subject: [PATCH RFC v2 for-6.8/block 01/18] block: add some bdev apis
Date: Mon, 11 Dec 2023 22:05:35 +0800
Message-Id: <20231211140552.973290-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211140552.973290-1-yukuai1@huaweicloud.com>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xGTF3dlDYFxDQ--.28013S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4kWFWUAr1DGF1UWF17Wrg_yoW7CryUpF
	yUGa45JrW5Gw1Igrs2ya13Zryag3W0kF1xZa4xJ34Yk3yktr9agFZ5CwnrArWftrWkAFZr
	XFya9rWxCr1jkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbpuWJUU
	UUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Those apis will be used for other modules, so that bd_inode won't be
accessed directly from other modules.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c           | 70 ++++++++++++++++++++++++++++++++++++++++++
 block/blk.h            |  2 --
 include/linux/blkdev.h | 17 ++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 750aec178b6a..9a469753eb4b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -89,6 +89,13 @@ void invalidate_bdev(struct block_device *bdev)
 }
 EXPORT_SYMBOL(invalidate_bdev);
 
+void invalidate_bdev_range(struct block_device *bdev, pgoff_t start,
+			   pgoff_t end)
+{
+	invalidate_mapping_pages(bdev->bd_inode->i_mapping, start, end);
+}
+EXPORT_SYMBOL_GPL(invalidate_bdev_range);
+
 /*
  * Drop all buffers & page cache for given bdev range. This function bails
  * with error if bdev has other exclusive owner (such as filesystem).
@@ -121,6 +128,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
 					     lstart >> PAGE_SHIFT,
 					     lend >> PAGE_SHIFT);
 }
+EXPORT_SYMBOL_GPL(truncate_bdev_range);
 
 static void set_init_blocksize(struct block_device *bdev)
 {
@@ -1102,3 +1110,65 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
 
 	blkdev_put_no_open(bdev);
 }
+
+struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos)
+{
+	return mapping_read_folio_gfp(bdev->bd_inode->i_mapping,
+				      pos >> PAGE_SHIFT, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(bdev_read_folio);
+
+struct folio *__bdev_get_folio(struct block_device *bdev, loff_t pos,
+			       fgf_t fgp_flags, gfp_t gfp)
+{
+	return __filemap_get_folio(bdev->bd_inode->i_mapping, pos >> PAGE_SHIFT,
+				   fgp_flags, gfp);
+}
+EXPORT_SYMBOL_GPL(__bdev_get_folio);
+
+int bdev_wb_err_check(struct block_device *bdev, errseq_t since)
+{
+	return errseq_check(&bdev->bd_inode->i_mapping->wb_err, since);
+}
+EXPORT_SYMBOL_GPL(bdev_wb_err_check);
+
+int bdev_wb_err_check_and_advance(struct block_device *bdev, errseq_t *since)
+{
+	return errseq_check_and_advance(&bdev->bd_inode->i_mapping->wb_err,
+					since);
+}
+EXPORT_SYMBOL_GPL(bdev_wb_err_check_and_advance);
+
+void bdev_balance_dirty_pages_ratelimited(struct block_device *bdev)
+{
+	return balance_dirty_pages_ratelimited(bdev->bd_inode->i_mapping);
+}
+EXPORT_SYMBOL_GPL(bdev_balance_dirty_pages_ratelimited);
+
+void bdev_sync_readahead(struct block_device *bdev, struct file_ra_state *ra,
+			 struct file *file, pgoff_t index,
+			 unsigned long req_count)
+{
+	struct file_ra_state tmp_ra = {};
+
+	if (!ra) {
+		ra = &tmp_ra;
+		file_ra_state_init(ra, bdev->bd_inode->i_mapping);
+	}
+	page_cache_sync_readahead(bdev->bd_inode->i_mapping, ra, file, index,
+				  req_count);
+}
+EXPORT_SYMBOL_GPL(bdev_sync_readahead);
+
+void bdev_attach_wb(struct block_device *bdev)
+{
+	inode_attach_wb(bdev->bd_inode, NULL);
+}
+EXPORT_SYMBOL_GPL(bdev_attach_wb);
+
+void bdev_associated_mapping(struct block_device *bdev,
+			     struct address_space *mapping)
+{
+	mapping->host = bdev->bd_inode;
+}
+EXPORT_SYMBOL_GPL(bdev_associated_mapping);
diff --git a/block/blk.h b/block/blk.h
index 08a358bc0919..da4becd4f7e9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -467,8 +467,6 @@ extern struct device_attribute dev_attr_events_poll_msecs;
 extern struct attribute_group blk_trace_attr_group;
 
 blk_mode_t file_to_blk_mode(struct file *file);
-int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
-		loff_t lstart, loff_t lend);
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17c0a7d0d319..d2453424a9eb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -24,6 +24,7 @@
 #include <linux/sbitmap.h>
 #include <linux/uuid.h>
 #include <linux/xarray.h>
+#include <linux/pagemap.h>
 
 struct module;
 struct request_queue;
@@ -1502,6 +1503,22 @@ struct block_device *blkdev_get_no_open(dev_t dev);
 void blkdev_put_no_open(struct block_device *bdev);
 
 struct block_device *I_BDEV(struct inode *inode);
+void invalidate_bdev_range(struct block_device *bdev, pgoff_t start,
+			   pgoff_t end);
+int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
+		loff_t lstart, loff_t lend);
+struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos);
+struct folio *__bdev_get_folio(struct block_device *bdev, loff_t pos,
+			       fgf_t fgp_flags, gfp_t gfp);
+int bdev_wb_err_check(struct block_device *bdev, errseq_t since);
+int bdev_wb_err_check_and_advance(struct block_device *bdev, errseq_t *since);
+void bdev_balance_dirty_pages_ratelimited(struct block_device *bdev);
+void bdev_sync_readahead(struct block_device *bdev, struct file_ra_state *ra,
+			 struct file *file, pgoff_t index,
+			 unsigned long req_count);
+void bdev_attach_wb(struct block_device *bdev);
+void bdev_associated_mapping(struct block_device *bdev,
+			     struct address_space *mapping);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
-- 
2.39.2


