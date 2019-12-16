Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7377D12085C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 15:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfLPOQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 09:16:02 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:40308 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728209AbfLPOQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:16:02 -0500
Received: from faui04i.informatik.uni-erlangen.de (faui04i.informatik.uni-erlangen.de [131.188.30.139])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 7C131241854;
        Mon, 16 Dec 2019 15:15:59 +0100 (CET)
Received: by faui04i.informatik.uni-erlangen.de (Postfix, from userid 66565)
        id 49EB8C808D6; Mon, 16 Dec 2019 15:15:59 +0100 (CET)
From:   Julian Preis <julian.preis@fau.de>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Julian Preis <julian.preis@fau.de>,
        Johannes Weidner <johannes.weidner@fau.de>
Subject: [PATCH v2] drivers/staging/exfat: Fix spelling mistakes
Date:   Mon, 16 Dec 2019 15:12:00 +0100
Message-Id: <20191216141200.8414-1-julian.preis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix spelling mistakes in exfat_core.c and exfat_super.c.

Co-developed-by: Johannes Weidner <johannes.weidner@fau.de>
Signed-off-by: Johannes Weidner <johannes.weidner@fau.de>
Signed-off-by: Julian Preis <julian.preis@fau.de>
---
Changes in v2:
- Add email recipients according to get_maintainer.pl
- Add patch versions
- Use in-reply-to

 drivers/staging/exfat/exfat_core.c  |  6 +++---
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index d2d3447083c7..2c688cf91eac 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1156,7 +1156,7 @@ static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
 	num_entries = count;
 
 	while (num_entries) {
-		/* white per sector base */
+		/* write per sector base */
 		remaining_byte_in_sector = (1 << p_bd->sector_size_bits) - off;
 		copy_entries = min_t(s32,
 				     remaining_byte_in_sector >> DENTRY_SIZE_BITS,
@@ -1392,7 +1392,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 	while (num_entries) {
 		/*
 		 * instead of copying whole sector, we will check every entry.
-		 * this will provide minimum stablity and consistency.
+		 * this will provide minimum stability and consistency.
 		 */
 		entry_type = p_fs->fs_func->get_entry_type(ep);
 
@@ -1683,7 +1683,7 @@ static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *unina
 }
 
 /* return values of exfat_find_dir_entry()
- * >= 0 : return dir entiry position with the name in dir
+ * >= 0 : return dir entry position with the name in dir
  * -1 : (root dir, ".") it is the root dir itself
  * -2 : entry with the name does not exist
  */
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 6e481908c59f..02548335ec82 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -984,7 +984,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	brelse(tmp_bh);
 
-	/* (3) update the direcoty entry */
+	/* (3) update the directory entry */
 	es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 				  ES_ALL_ENTRIES, &ep);
 	if (!es)
@@ -1481,7 +1481,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 			count = count_dos_name_entries(sb, &dir, TYPE_DIR);
 			if (count < 0) {
-				ret = count; /* propogate error upward */
+				ret = count; /* propagate error upward */
 				goto out;
 			}
 			info->NumSubdirs = count;
@@ -1548,7 +1548,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 		count = count_dos_name_entries(sb, &dir, TYPE_DIR);
 		if (count < 0) {
-			ret = count; /* propogate error upward */
+			ret = count; /* propagate error upward */
 			goto out;
 		}
 		info->NumSubdirs += count;
@@ -3689,7 +3689,7 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 
 	/*
 	 * GFP_KERNEL is ok here, because while we do hold the
-	 * supeblock lock, memory pressure can't call back into
+	 * superblock lock, memory pressure can't call back into
 	 * the filesystem, since we're only just about to mount
 	 * it and have no inodes etc active!
 	 */
-- 
2.20.1

