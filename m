Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAFE149A4F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 12:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgAZLDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jan 2020 06:03:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34956 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgAZLDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jan 2020 06:03:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so3523215pfo.2;
        Sun, 26 Jan 2020 03:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2iTiMPPhL4l8d9hwcj+LZ9egCs5iR9+1Z4raQoL0t4s=;
        b=hoYwI9qS+qfFMdOUCETJd9QY7aejs9wo8KWiTrCGTs9mKbBP4iSmZ+JYg2/ZK8ndFf
         jg+KgOgL6ioD+qDtB6wmUytKoTpS6jDG5YYDE6gKxSsS1Cs57RcF2IRKY/VUNx+an40g
         7RDlLzWcaxUK3dHJTV3EWiONiOJLQtEmAblDJzlIaAXboI5yRSQh7U1E+8SuH8kMOKiY
         RSL65WzODJPAY0LNqIhiTuBb2OQ03ne4d0af5qIoPyxXHUOfgXB6wfGD0E1ZUcajzMAG
         GCYwo5CAqaZyf2i6UYonuBVrKqp6Wo8QU+1n8iHLwiCfEGAR8XXoxuuJnDXJFC0nKRwq
         pk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2iTiMPPhL4l8d9hwcj+LZ9egCs5iR9+1Z4raQoL0t4s=;
        b=gHamBqrWcOOOUeVQI3g1guqfWNgGqeQUj29ZQMIElH2UZrZ6AWbpBuUCRJUm1nbOsV
         NgM3TyrJb2TlBASihHaXG+wSJe3fKU3CHa2HvcpYPGmzA+3IetCtzqGoEE0BGwDEIZ1i
         6IXY7mVjlZmmiEtuz2u7BgKYlxkD9apkL4JWbOAiY6nGKPzUAlfgXWZKxwemSMAg4uu9
         Dkp6UfHLQifYn4gcijfw/nypWvszLIPQrTTn/n7zTGqxlGmg1XmkGUe5pryuckwEDsP6
         q44R2lNdB0ySe/WM+J4OGgenKnLUA0tJ7LHgRdp+8u+y101bUvDt7B4M0zyQ9U2B8GDD
         7rFg==
X-Gm-Message-State: APjAAAUHcmL5VJpSRUAMBHqcpSS0JMzpnATj0QrlIb61nwydNrdffAaQ
        L5GkeR6D6dF67UpMkuBp83k=
X-Google-Smtp-Source: APXvYqyv8lAp6JxinY7pHqR9wY4WBatQbf4YEBbHeSBe6tSKCcyB2gXTpzk07e++AlOtNWfBLH7llw==
X-Received: by 2002:a63:106:: with SMTP id 6mr14005698pgb.190.1580036614966;
        Sun, 26 Jan 2020 03:03:34 -0800 (PST)
Received: from localhost.localdomain ([2405:204:808c:b30e:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id b26sm12150028pgn.1.2020.01.26.03.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 03:03:34 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [RESEND PATCH] staging: exfat: Fix alignment warnings
Date:   Sun, 26 Jan 2020 16:32:55 +0530
Message-Id: <20200126110255.20506-1-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200125133814.GA3518118@kroah.com>
References: <20200125133814.GA3518118@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning "Alignment should match open parenthesis".

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_blkdev.c |  4 ++--
 drivers/staging/exfat/exfat_core.c   | 29 ++++++++++++++--------------
 drivers/staging/exfat/exfat_super.c  |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index 7bcd98b13109..3068bfda39e4 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -31,7 +31,7 @@ void exfat_bdev_close(struct super_block *sb)
 }
 
 int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
-	      u32 num_secs, bool read)
+		    u32 num_secs, bool read)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -66,7 +66,7 @@ int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head *
 }
 
 int exfat_bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
-	       u32 num_secs, bool sync)
+		     u32 num_secs, bool sync)
 {
 	s32 count;
 	struct buffer_head *bh2;
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 794000e7bc6f..754407c738b7 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -250,7 +250,7 @@ static u32 test_alloc_bitmap(struct super_block *sb, u32 clu)
 }
 
 static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
-			struct chain_t *p_chain)
+			       struct chain_t *p_chain)
 {
 	s32 num_clusters = 0;
 	u32 hint_clu, new_clu, last_clu = CLUSTER_32(~0);
@@ -329,7 +329,7 @@ static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 }
 
 static void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
-			s32 do_relse)
+			       s32 do_relse)
 {
 	s32 num_clusters = 0;
 	u32 clu;
@@ -920,7 +920,7 @@ static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 }
 
 static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			  u8 mode)
+				 u8 mode)
 {
 	u16 t = 0x00, d = 0x21;
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -949,7 +949,7 @@ static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *t
 }
 
 static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			  u8 mode)
+				 u8 mode)
 {
 	u16 t, d;
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -1013,7 +1013,7 @@ static void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
 }
 
 static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			 s32 entry, u32 type, u32 start_clu, u64 size)
+				s32 entry, u32 type, u32 start_clu, u64 size)
 {
 	sector_t sector;
 	u8 flags;
@@ -1089,7 +1089,7 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 }
 
 static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			    s32 entry, s32 order, s32 num_entries)
+				   s32 entry, s32 order, s32 num_entries)
 {
 	int i;
 	sector_t sector;
@@ -1256,7 +1256,7 @@ static s32 _walk_fat_chain(struct super_block *sb, struct chain_t *p_dir,
 }
 
 static s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
-		  sector_t *sector, s32 *offset)
+			 sector_t *sector, s32 *offset)
 {
 	s32 off, ret;
 	u32 clu = 0;
@@ -1492,7 +1492,8 @@ void release_entry_set(struct entry_set_cache_t *es)
 
 /* search EMPTY CONTINUOUS "num_entries" entries */
 static s32 search_deleted_or_unused_entry(struct super_block *sb,
-				   struct chain_t *p_dir, s32 num_entries)
+					  struct chain_t *p_dir,
+					  s32 num_entries)
 {
 	int i, dentry, num_empty = 0;
 	s32 dentries_per_clu;
@@ -1668,7 +1669,7 @@ static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_
 }
 
 static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
-				     s32 order)
+					    s32 order)
 {
 	int i, len = 0;
 
@@ -1690,8 +1691,8 @@ static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *unina
  * -2 : entry with the name does not exist
  */
 static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			 struct uni_name_t *p_uniname, s32 num_entries,
-			 struct dos_name_t *p_dosname, u32 type)
+				struct uni_name_t *p_uniname, s32 num_entries,
+				struct dos_name_t *p_dosname, u32 type)
 {
 	int i = 0, dentry = 0, num_ext_entries = 0, len, step;
 	s32 order = 0;
@@ -1833,7 +1834,7 @@ static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 }
 
 static s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
-			    s32 entry, struct dentry_t *p_entry)
+				   s32 entry, struct dentry_t *p_entry)
 {
 	int i, count = 0;
 	u32 type;
@@ -1996,8 +1997,8 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 }
 
 static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
-				       struct chain_t *p_dir, s32 entry,
-				       u16 *uniname)
+					      struct chain_t *p_dir, s32 entry,
+					      u16 *uniname)
 {
 	int i;
 	struct dentry_t *ep;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 9f91853b189b..75bb36071722 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -365,7 +365,7 @@ static int ffsMountVol(struct super_block *sb)
 
 	if (p_bd->sector_size < sb->s_blocksize) {
 		printk(KERN_INFO "EXFAT: mount failed - sector size %d less than blocksize %ld\n",
-			p_bd->sector_size,  sb->s_blocksize);
+		       p_bd->sector_size,  sb->s_blocksize);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.17.1

