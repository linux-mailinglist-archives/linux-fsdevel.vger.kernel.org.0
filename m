Return-Path: <linux-fsdevel+bounces-5492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A780CDE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0049B216DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63C5101E;
	Mon, 11 Dec 2023 14:09:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF66199;
	Mon, 11 Dec 2023 06:09:21 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpkBj5lWTz4f3kKB;
	Mon, 11 Dec 2023 22:09:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E98C61A07E4;
	Mon, 11 Dec 2023 22:09:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhAMGHdl2qJxDQ--.24877S4;
	Mon, 11 Dec 2023 22:09:18 +0800 (CST)
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
Subject: [PATCH RFC v2 for-6.8/block 15/18] buffer: add a new helper to read sb block
Date: Mon, 11 Dec 2023 22:07:53 +0800
Message-Id: <20231211140753.975297-1-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDHyhAMGHdl2qJxDQ--.24877S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyUCF4kKryrJrW3trWrXwb_yoW7Ww13pr
	98Kay3trWDKFyaqF1xtwn8Jr13t3Z2v3W8CayfJ3s3ArWUGrn3XF9rGr129FWFyr9rXry5
	XFW5CrWfCr1UWFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_JFI_Gr1lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUb
	ZNVDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Unlike __bread_gfp(), ext4 has special handing while reading sb block:

1) __GFP_NOFAIL is not set, and memory allocation can fail;
2) If buffer write failed before, set buffer uptodate and don't read
   block from disk;
3) REQ_META is set for all IO, and REQ_PRIO is set for reading xattr;
4) If failed, return error ptr instead of NULL;

This patch add a new helper __bread_gfp2() that will match above 2 and 3(
1 will be used, and 4 will still be encapsulated by ext4), and prepare to
prevent calling mapping_gfp_constraint() directly on bd_inode->i_mapping
in ext4.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/buffer.c                 | 68 ++++++++++++++++++++++++++-----------
 include/linux/buffer_head.h | 18 +++++++++-
 2 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 967f34b70aa8..188bd36c9fea 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1255,16 +1255,19 @@ void __bforget(struct buffer_head *bh)
 }
 EXPORT_SYMBOL(__bforget);
 
-static struct buffer_head *__bread_slow(struct buffer_head *bh)
+static struct buffer_head *__bread_slow(struct buffer_head *bh,
+					blk_opf_t op_flags,
+					bool check_write_error)
 {
 	lock_buffer(bh);
-	if (buffer_uptodate(bh)) {
+	if (buffer_uptodate(bh) ||
+	    (check_write_error && buffer_uptodate_or_error(bh))) {
 		unlock_buffer(bh);
 		return bh;
 	} else {
 		get_bh(bh);
 		bh->b_end_io = end_buffer_read_sync;
-		submit_bh(REQ_OP_READ, bh);
+		submit_bh(REQ_OP_READ | op_flags, bh);
 		wait_on_buffer(bh);
 		if (buffer_uptodate(bh))
 			return bh;
@@ -1445,6 +1448,31 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
 }
 EXPORT_SYMBOL(__breadahead);
 
+static struct buffer_head *
+bread_gfp(struct block_device *bdev, sector_t block, unsigned int size,
+	  blk_opf_t op_flags, gfp_t gfp, bool check_write_error)
+{
+	struct buffer_head *bh;
+
+	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+
+	/*
+	 * Prefer looping in the allocator rather than here, at least that
+	 * code knows what it's doing.
+	 */
+	gfp |= __GFP_NOFAIL;
+
+	bh = bdev_getblk(bdev, block, size, gfp);
+	if (unlikely(!bh))
+		return NULL;
+
+	if (buffer_uptodate(bh) ||
+	    (check_write_error && buffer_uptodate_or_error(bh)))
+		return bh;
+
+	return __bread_slow(bh, op_flags, check_write_error);
+}
+
 /**
  *  __bread_gfp() - reads a specified block and returns the bh
  *  @bdev: the block_device to read from
@@ -1458,27 +1486,27 @@ EXPORT_SYMBOL(__breadahead);
  *  It returns NULL if the block was unreadable.
  */
 struct buffer_head *
-__bread_gfp(struct block_device *bdev, sector_t block,
-		   unsigned size, gfp_t gfp)
+__bread_gfp(struct block_device *bdev, sector_t block, unsigned int size,
+	    gfp_t gfp)
 {
-	struct buffer_head *bh;
-
-	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
-
-	/*
-	 * Prefer looping in the allocator rather than here, at least that
-	 * code knows what it's doing.
-	 */
-	gfp |= __GFP_NOFAIL;
-
-	bh = bdev_getblk(bdev, block, size, gfp);
-
-	if (likely(bh) && !buffer_uptodate(bh))
-		bh = __bread_slow(bh);
-	return bh;
+	return bread_gfp(bdev, block, size, 0, gfp, false);
 }
 EXPORT_SYMBOL(__bread_gfp);
 
+/*
+ * This works like __bread_gfp() except:
+ * 1) If buffer write failed before, set buffer uptodate and don't read
+ * block from disk;
+ * 2) Caller can pass in additional op_flags like REQ_META;
+ */
+struct buffer_head *
+__bread_gfp2(struct block_device *bdev, sector_t block, unsigned int size,
+	     blk_opf_t op_flags, gfp_t gfp)
+{
+	return bread_gfp(bdev, block, size, op_flags, gfp, true);
+}
+EXPORT_SYMBOL(__bread_gfp2);
+
 static void __invalidate_bh_lrus(struct bh_lru *b)
 {
 	int i;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 5f23ee599889..751b2744b4ae 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -171,6 +171,18 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
 	return test_bit_acquire(BH_Uptodate, &bh->b_state);
 }
 
+static __always_inline int buffer_uptodate_or_error(struct buffer_head *bh)
+{
+	/*
+	 * If the buffer has the write error flag, data was failed to write
+	 * out in the block. In this case, set buffer uptodate to prevent
+	 * reading old data.
+	 */
+	if (buffer_write_io_error(bh))
+		set_buffer_uptodate(bh);
+	return buffer_uptodate(bh);
+}
+
 static inline unsigned long bh_offset(const struct buffer_head *bh)
 {
 	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
@@ -231,7 +243,11 @@ void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
 void __breadahead(struct block_device *, sector_t block, unsigned int size);
 struct buffer_head *__bread_gfp(struct block_device *,
-				sector_t block, unsigned size, gfp_t gfp);
+				sector_t block, unsigned int size, gfp_t gfp);
+struct buffer_head *__bread_gfp2(struct block_device *bdev, sector_t block,
+				 unsigned int size, blk_opf_t op_flags,
+				 gfp_t gfp);
+
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
-- 
2.39.2


