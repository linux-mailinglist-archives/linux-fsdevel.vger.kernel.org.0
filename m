Return-Path: <linux-fsdevel+bounces-5494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16980CDF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893D0281AD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAF24C3B0;
	Mon, 11 Dec 2023 14:10:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44EA3269;
	Mon, 11 Dec 2023 06:10:01 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpkCT6TGMz4f3kJr;
	Mon, 11 Dec 2023 22:09:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0E0251A0893;
	Mon, 11 Dec 2023 22:09:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhA0GHdlbq5xDQ--.18493S4;
	Mon, 11 Dec 2023 22:09:58 +0800 (CST)
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
Subject: [PATCH RFC v2 for-6.8/block 17/18] ext4: remove block_device_ejected()
Date: Mon, 11 Dec 2023 22:08:33 +0800
Message-Id: <20231211140833.975935-1-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXWhA0GHdlbq5xDQ--.18493S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4UGw1xJF1fWr48KFy3urg_yoW8uFyfp3
	y3Cw1fArW8ur1I9ayxJr48W340qayvkay0gFyxur1Fqr1fJ34IgFWktF1Iya40vrZ3uw1F
	qF1UCrWxCr18GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUb
	YLvtUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

block_device_ejected() is added by commit bdfe0cbd746a ("Revert
"ext4: remove block_device_ejected"") in 2015. At that time 'bdi->wb'
is destroyed synchronized from del_gendisk(), hence if ext4 is still
mounted, and then mark_buffer_dirty() will reference destroyed 'wb'.
However, such problem doesn't exist anymore:

- commit d03f6cdc1fc4 ("block: Dynamically allocate and refcount
backing_dev_info") switch bdi to use refcounting;
- commit 13eec2363ef0 ("fs: Get proper reference for s_bdi"), will grab
additional reference of bdi while mounting, so that 'bdi->wb' will not
be destroyed until generic_shutdown_super().

Hence remove this dead function block_device_ejected().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/ext4/super.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ae41204f52d4..3b5e2b557488 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -467,22 +467,6 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 		schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
 }
 
-/*
- * The del_gendisk() function uninitializes the disk-specific data
- * structures, including the bdi structure, without telling anyone
- * else.  Once this happens, any attempt to call mark_buffer_dirty()
- * (for example, by ext4_commit_super), will cause a kernel OOPS.
- * This is a kludge to prevent these oops until we can put in a proper
- * hook in del_gendisk() to inform the VFS and file system layers.
- */
-static int block_device_ejected(struct super_block *sb)
-{
-	struct inode *bd_inode = sb->s_bdev->bd_inode;
-	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
-
-	return bdi->dev == NULL;
-}
-
 static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 {
 	struct super_block		*sb = journal->j_private;
@@ -6162,8 +6146,6 @@ static int ext4_commit_super(struct super_block *sb)
 
 	if (!sbh)
 		return -EINVAL;
-	if (block_device_ejected(sb))
-		return -ENODEV;
 
 	ext4_update_super(sb);
 
-- 
2.39.2


