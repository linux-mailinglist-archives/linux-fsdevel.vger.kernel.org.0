Return-Path: <linux-fsdevel+bounces-5495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2922A80CE04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48721F217BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC351C34;
	Mon, 11 Dec 2023 14:10:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCDA44AA;
	Mon, 11 Dec 2023 06:10:09 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SpkCZ5hzfz4f3kGD;
	Mon, 11 Dec 2023 22:10:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2F9511A08B0;
	Mon, 11 Dec 2023 22:10:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDnNw46GHdlJ7BxDQ--.34937S4;
	Mon, 11 Dec 2023 22:10:04 +0800 (CST)
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
Subject: [PATCH RFC v2 for-6.8/block 18/18] ext4: use bdev apis
Date: Mon, 11 Dec 2023 22:08:39 +0800
Message-Id: <20231211140839.976021-1-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDnNw46GHdlJ7BxDQ--.34937S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF47JryfCw48Xw1Duw48JFb_yoW5XF4fpa
	43GFyDGr4Dury09wsrGFsrZa40kw18GFy3GryfZa42qrWaqrySkFykKF1xZF1UX3y8X348
	XFyjkryxAr45CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8JwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjfUe_
	MaUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Avoid to access bd_inode directly, prepare to remove bd_inode from
block_devcie.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/ext4/dir.c       | 6 ++----
 fs/ext4/ext4_jbd2.c | 6 +++---
 fs/ext4/super.c     | 3 +--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 3985f8c33f95..64e35eb6a324 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -191,10 +191,8 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 			pgoff_t index = map.m_pblk >>
 					(PAGE_SHIFT - inode->i_blkbits);
 			if (!ra_has_index(&file->f_ra, index))
-				page_cache_sync_readahead(
-					sb->s_bdev->bd_inode->i_mapping,
-					&file->f_ra, file,
-					index, 1);
+				bdev_sync_readahead(sb->s_bdev, &file->f_ra,
+						    file, index, 1);
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
 			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
 			if (IS_ERR(bh)) {
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d1a2e6624401..c1bf3a00fad9 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -206,7 +206,6 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
 
 static void ext4_check_bdev_write_error(struct super_block *sb)
 {
-	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int err;
 
@@ -216,9 +215,10 @@ static void ext4_check_bdev_write_error(struct super_block *sb)
 	 * we could read old data from disk and write it out again, which
 	 * may lead to on-disk filesystem inconsistency.
 	 */
-	if (errseq_check(&mapping->wb_err, READ_ONCE(sbi->s_bdev_wb_err))) {
+	if (bdev_wb_err_check(sb->s_bdev, READ_ONCE(sbi->s_bdev_wb_err))) {
 		spin_lock(&sbi->s_bdev_wb_lock);
-		err = errseq_check_and_advance(&mapping->wb_err, &sbi->s_bdev_wb_err);
+		err = bdev_wb_err_check_and_advance(sb->s_bdev,
+						    &sbi->s_bdev_wb_err);
 		spin_unlock(&sbi->s_bdev_wb_lock);
 		if (err)
 			ext4_error_err(sb, -err,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3b5e2b557488..96724cae622a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5544,8 +5544,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * used to detect the metadata async write error.
 	 */
 	spin_lock_init(&sbi->s_bdev_wb_lock);
-	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
-				 &sbi->s_bdev_wb_err);
+	bdev_wb_err_check_and_advance(sb->s_bdev, &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);
 	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
-- 
2.39.2


