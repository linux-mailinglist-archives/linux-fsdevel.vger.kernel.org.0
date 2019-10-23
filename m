Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 656CCE11A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 07:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbfJWF2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 01:28:48 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60956 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389516AbfJWF2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:28:47 -0400
Received: from mr1.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5SjUS003477
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:45 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5SeQq006981
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:45 -0400
Received: by mail-qk1-f198.google.com with SMTP id c4so14507175qkg.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 22:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3ePf9F6IcLHL4eSAUuR/dFlnNun9yggS3P0eDCd4d5c=;
        b=nIwPbAzsTBJSCOYss3UNBo2p1tGCx8ZkzA1YQmcZASQN5JaW0bQtiqnCTcJHj7tOIs
         P5lKWTZ4vRp0gROSN8wti6i4W0ddlD0xWeZpWshYaRWMJxQKUns8X3yOnyzeHp8crm/Q
         EQ8MX5TtQyu1eKcKmK38TKPjdgUXgNn1mTQIeYlWLEyWg1osOEzvwr25GGu+Yw7fhC17
         Oxo6H/DokrPh2s5jzKgjqKDuwUTfDw+PNibO69c0bhvjwTn6KHiAsAwGAN6tFXJRBdu3
         8ChYI9PLvhr5CiPbzA9UBBhvseobqhI/aOJwQnYIMgTBO1wFHNHy4CMgUpM92Xmy2X9/
         ZKNQ==
X-Gm-Message-State: APjAAAXBE8FO96qAYxz+QWvQAFsp62/wOoHdwjDH36X4xBmjRslY1oIq
        bhRGUKst876xa+RaQ+mhqIxISrqVXCs+MACP/DjpbWtr9lCcV1pRo0bcQti25fR6DZetciRpWuS
        7c7Jz3OLTpA3hlJjNV8RKLg+/ObFx+tGb+a7z
X-Received: by 2002:a37:8d01:: with SMTP id p1mr6585105qkd.210.1571808520138;
        Tue, 22 Oct 2019 22:28:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwuO7zluAMwyK/JntwxLteqnNrrtioGH29mNPg7W1oCHNmHhCXD0iLHMtI8Xq/wb7MXIKm2dA==
X-Received: by 2002:a37:8d01:: with SMTP id p1mr6585081qkd.210.1571808519338;
        Tue, 22 Oct 2019 22:28:39 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 14sm10397445qtb.54.2019.10.22.22.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:28:38 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valdis.Kletnieks@vt.edu
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: exfat: Finished code movement for static cleanups in exfat_core.c
Date:   Wed, 23 Oct 2019 01:27:50 -0400
Message-Id: <20191023052752.693689-8-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move static function bodies before first use, remove the definition in exfat.h

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      |  10 -
 drivers/staging/exfat/exfat_core.c | 661 ++++++++++++++---------------
 2 files changed, 330 insertions(+), 341 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index b93df526355b..8738e41dd5a5 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -793,10 +793,6 @@ void free_upcase_table(struct super_block *sb);
 
 /* dir entry management functions */
 struct timestamp_t *tm_current(struct timestamp_t *tm);
-static void init_file_entry(struct file_dentry_t *ep, u32 type);
-static void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu,
-		     u64 size);
-static void init_name_entry(struct name_dentry_t *ep, u16 *uniname);
 
 struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 				  s32 entry, sector_t *sector);
@@ -805,7 +801,6 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 					       u32 type,
 					       struct dentry_t **file_ep);
 void release_entry_set(struct entry_set_cache_t *es);
-static s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es);
 s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 			   u32 type);
 void update_dir_checksum_with_entry_set(struct super_block *sb,
@@ -819,11 +814,6 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 void get_uni_name_from_dos_entry(struct super_block *sb,
 				 struct dos_dentry_t *ep,
 				 struct uni_name_t *p_uniname, u8 mode);
-static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
-				            s32 order);
-static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
-			  struct dos_name_t *p_dosname);
-static void fat_attach_count_to_dos_name(u8 *dosname, s32 count);
 u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type);
 
 /* name resolution functions */
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 1a49da231946..7332e69fcbcd 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -791,6 +791,168 @@ void free_upcase_table(struct super_block *sb)
 	p_fs->vol_utbl = NULL;
 }
 
+static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
+						struct entry_set_cache_t *es,
+						sector_t sec, s32 off, u32 count)
+{
+	s32 num_entries, buf_off = (off - es->offset);
+	u32 remaining_byte_in_sector, copy_entries;
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
+	u32 clu;
+	u8 *buf, *esbuf = (u8 *)&(es->__buf);
+
+	pr_debug("%s entered es %p sec %llu off %d count %d\n",
+		__func__, es, (unsigned long long)sec, off, count);
+	num_entries = count;
+
+	while (num_entries) {
+		/* white per sector base */
+		remaining_byte_in_sector = (1 << p_bd->sector_size_bits) - off;
+		copy_entries = min_t(s32,
+				     remaining_byte_in_sector >> DENTRY_SIZE_BITS,
+				     num_entries);
+		buf = buf_getblk(sb, sec);
+		if (!buf)
+			goto err_out;
+		pr_debug("es->buf %p buf_off %u\n", esbuf, buf_off);
+		pr_debug("copying %d entries from %p to sector %llu\n",
+			copy_entries, (esbuf + buf_off),
+			(unsigned long long)sec);
+		memcpy(buf + off, esbuf + buf_off,
+		       copy_entries << DENTRY_SIZE_BITS);
+		buf_modify(sb, sec);
+		num_entries -= copy_entries;
+
+		if (num_entries) {
+			/* get next sector */
+			if (IS_LAST_SECTOR_IN_CLUSTER(sec)) {
+				clu = GET_CLUSTER_FROM_SECTOR(sec);
+				if (es->alloc_flag == 0x03) {
+					clu++;
+				} else {
+					if (FAT_read(sb, clu, &clu) == -1)
+						goto err_out;
+				}
+				sec = START_SECTOR(clu);
+			} else {
+				sec++;
+			}
+			off = 0;
+			buf_off += copy_entries << DENTRY_SIZE_BITS;
+		}
+	}
+
+	pr_debug("%s exited successfully\n", __func__);
+	return FFS_SUCCESS;
+err_out:
+	pr_debug("%s failed\n", __func__);
+	return FFS_ERROR;
+}
+
+/* write back all entries in entry set */
+static s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es)
+{
+	return __write_partial_entries_in_entry_set(sb, es, es->sector,
+						    es->offset,
+						    es->num_entries);
+}
+
+/* search EMPTY CONTINUOUS "num_entries" entries */
+static s32 search_deleted_or_unused_entry(struct super_block *sb,
+				   struct chain_t *p_dir, s32 num_entries)
+{
+	int i, dentry, num_empty = 0;
+	s32 dentries_per_clu;
+	u32 type;
+	struct chain_t clu;
+	struct dentry_t *ep;
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+
+	if (p_dir->dir == CLUSTER_32(0)) /* FAT16 root_dir */
+		dentries_per_clu = p_fs->dentries_in_root;
+	else
+		dentries_per_clu = p_fs->dentries_per_clu;
+
+	if (p_fs->hint_uentry.dir == p_dir->dir) {
+		if (p_fs->hint_uentry.entry == -1)
+			return -1;
+
+		clu.dir = p_fs->hint_uentry.clu.dir;
+		clu.size = p_fs->hint_uentry.clu.size;
+		clu.flags = p_fs->hint_uentry.clu.flags;
+
+		dentry = p_fs->hint_uentry.entry;
+	} else {
+		p_fs->hint_uentry.entry = -1;
+
+		clu.dir = p_dir->dir;
+		clu.size = p_dir->size;
+		clu.flags = p_dir->flags;
+
+		dentry = 0;
+	}
+
+	while (clu.dir != CLUSTER_32(~0)) {
+		if (p_fs->dev_ejected)
+			break;
+
+		if (p_dir->dir == CLUSTER_32(0)) /* FAT16 root_dir */
+			i = dentry % dentries_per_clu;
+		else
+			i = dentry & (dentries_per_clu - 1);
+
+		for (; i < dentries_per_clu; i++, dentry++) {
+			ep = get_entry_in_dir(sb, &clu, i, NULL);
+			if (!ep)
+				return -1;
+
+			type = p_fs->fs_func->get_entry_type(ep);
+
+			if (type == TYPE_UNUSED) {
+				num_empty++;
+				if (p_fs->hint_uentry.entry == -1) {
+					p_fs->hint_uentry.dir = p_dir->dir;
+					p_fs->hint_uentry.entry = dentry;
+
+					p_fs->hint_uentry.clu.dir = clu.dir;
+					p_fs->hint_uentry.clu.size = clu.size;
+					p_fs->hint_uentry.clu.flags = clu.flags;
+				}
+			} else if (type == TYPE_DELETED) {
+				num_empty++;
+			} else {
+				num_empty = 0;
+			}
+
+			if (num_empty >= num_entries) {
+				p_fs->hint_uentry.dir = CLUSTER_32(~0);
+				p_fs->hint_uentry.entry = -1;
+
+				if (p_fs->vol_type == EXFAT)
+					return dentry - (num_entries - 1);
+				else
+					return dentry;
+			}
+		}
+
+		if (p_dir->dir == CLUSTER_32(0))
+			break; /* FAT16 root_dir */
+
+		if (clu.flags == 0x03) {
+			if ((--clu.size) > 0)
+				clu.dir++;
+			else
+				clu.dir = CLUSTER_32(~0);
+		} else {
+			if (FAT_read(sb, clu.dir, &clu.dir) != 0)
+				return -1;
+		}
+	}
+
+	return -1;
+}
+
 static void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry)
 {
@@ -1038,6 +1200,45 @@ static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *t
 	}
 }
 
+static void init_file_entry(struct file_dentry_t *ep, u32 type)
+{
+	struct timestamp_t tm, *tp;
+
+	exfat_set_entry_type((struct dentry_t *)ep, type);
+
+	tp = tm_current(&tm);
+	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_CREATE);
+	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_MODIFY);
+	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_ACCESS);
+	ep->create_time_ms = 0;
+	ep->modify_time_ms = 0;
+	ep->access_time_ms = 0;
+}
+
+static void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu, u64 size)
+{
+	exfat_set_entry_type((struct dentry_t *)ep, TYPE_STREAM);
+	ep->flags = flags;
+	SET32_A(ep->start_clu, start_clu);
+	SET64_A(ep->valid_size, size);
+	SET64_A(ep->size, size);
+}
+
+static void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
+{
+	int i;
+
+	exfat_set_entry_type((struct dentry_t *)ep, TYPE_EXTEND);
+	ep->flags = 0x0;
+
+	for (i = 0; i < 30; i++, i++) {
+		SET16_A(ep->unicode_0_14 + i, *uniname);
+		if (*uniname == 0x0)
+			break;
+		uniname++;
+	}
+}
+
 static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry, u32 type, u32 start_clu, u64 size)
 {
@@ -1114,45 +1315,6 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	return FFS_SUCCESS;
 }
 
-static void init_file_entry(struct file_dentry_t *ep, u32 type)
-{
-	struct timestamp_t tm, *tp;
-
-	exfat_set_entry_type((struct dentry_t *)ep, type);
-
-	tp = tm_current(&tm);
-	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_CREATE);
-	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_MODIFY);
-	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_ACCESS);
-	ep->create_time_ms = 0;
-	ep->modify_time_ms = 0;
-	ep->access_time_ms = 0;
-}
-
-static void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu, u64 size)
-{
-	exfat_set_entry_type((struct dentry_t *)ep, TYPE_STREAM);
-	ep->flags = flags;
-	SET32_A(ep->start_clu, start_clu);
-	SET64_A(ep->valid_size, size);
-	SET64_A(ep->size, size);
-}
-
-static void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
-{
-	int i;
-
-	exfat_set_entry_type((struct dentry_t *)ep, TYPE_EXTEND);
-	ep->flags = 0x0;
-
-	for (i = 0; i < 30; i++, i++) {
-		SET16_A(ep->unicode_0_14 + i, *uniname);
-		if (*uniname == 0x0)
-			break;
-		uniname++;
-	}
-}
-
 static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 		s32 entry, s32 order, s32 num_entries)
 {
@@ -1432,177 +1594,15 @@ void release_entry_set(struct entry_set_cache_t *es)
 	kfree(es);
 }
 
-static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
-						struct entry_set_cache_t *es,
-						sector_t sec, s32 off, u32 count)
+static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries)
 {
-	s32 num_entries, buf_off = (off - es->offset);
-	u32 remaining_byte_in_sector, copy_entries;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-	u32 clu;
-	u8 *buf, *esbuf = (u8 *)&(es->__buf);
-
-	pr_debug("%s entered es %p sec %llu off %d count %d\n",
-		__func__, es, (unsigned long long)sec, off, count);
-	num_entries = count;
-
-	while (num_entries) {
-		/* white per sector base */
-		remaining_byte_in_sector = (1 << p_bd->sector_size_bits) - off;
-		copy_entries = min_t(s32,
-				     remaining_byte_in_sector >> DENTRY_SIZE_BITS,
-				     num_entries);
-		buf = buf_getblk(sb, sec);
-		if (!buf)
-			goto err_out;
-		pr_debug("es->buf %p buf_off %u\n", esbuf, buf_off);
-		pr_debug("copying %d entries from %p to sector %llu\n",
-			copy_entries, (esbuf + buf_off),
-			(unsigned long long)sec);
-		memcpy(buf + off, esbuf + buf_off,
-		       copy_entries << DENTRY_SIZE_BITS);
-		buf_modify(sb, sec);
-		num_entries -= copy_entries;
-
-		if (num_entries) {
-			/* get next sector */
-			if (IS_LAST_SECTOR_IN_CLUSTER(sec)) {
-				clu = GET_CLUSTER_FROM_SECTOR(sec);
-				if (es->alloc_flag == 0x03) {
-					clu++;
-				} else {
-					if (FAT_read(sb, clu, &clu) == -1)
-						goto err_out;
-				}
-				sec = START_SECTOR(clu);
-			} else {
-				sec++;
-			}
-			off = 0;
-			buf_off += copy_entries << DENTRY_SIZE_BITS;
-		}
-	}
-
-	pr_debug("%s exited successfully\n", __func__);
-	return FFS_SUCCESS;
-err_out:
-	pr_debug("%s failed\n", __func__);
-	return FFS_ERROR;
-}
-
-/* write back all entries in entry set */
-static s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es)
-{
-	return __write_partial_entries_in_entry_set(sb, es, es->sector,
-						    es->offset,
-						    es->num_entries);
-}
-
-/* search EMPTY CONTINUOUS "num_entries" entries */
-static s32 search_deleted_or_unused_entry(struct super_block *sb,
-				   struct chain_t *p_dir, s32 num_entries)
-{
-	int i, dentry, num_empty = 0;
-	s32 dentries_per_clu;
-	u32 type;
-	struct chain_t clu;
-	struct dentry_t *ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	if (p_dir->dir == CLUSTER_32(0)) /* FAT16 root_dir */
-		dentries_per_clu = p_fs->dentries_in_root;
-	else
-		dentries_per_clu = p_fs->dentries_per_clu;
-
-	if (p_fs->hint_uentry.dir == p_dir->dir) {
-		if (p_fs->hint_uentry.entry == -1)
-			return -1;
-
-		clu.dir = p_fs->hint_uentry.clu.dir;
-		clu.size = p_fs->hint_uentry.clu.size;
-		clu.flags = p_fs->hint_uentry.clu.flags;
-
-		dentry = p_fs->hint_uentry.entry;
-	} else {
-		p_fs->hint_uentry.entry = -1;
-
-		clu.dir = p_dir->dir;
-		clu.size = p_dir->size;
-		clu.flags = p_dir->flags;
-
-		dentry = 0;
-	}
-
-	while (clu.dir != CLUSTER_32(~0)) {
-		if (p_fs->dev_ejected)
-			break;
-
-		if (p_dir->dir == CLUSTER_32(0)) /* FAT16 root_dir */
-			i = dentry % dentries_per_clu;
-		else
-			i = dentry & (dentries_per_clu - 1);
-
-		for (; i < dentries_per_clu; i++, dentry++) {
-			ep = get_entry_in_dir(sb, &clu, i, NULL);
-			if (!ep)
-				return -1;
-
-			type = p_fs->fs_func->get_entry_type(ep);
-
-			if (type == TYPE_UNUSED) {
-				num_empty++;
-				if (p_fs->hint_uentry.entry == -1) {
-					p_fs->hint_uentry.dir = p_dir->dir;
-					p_fs->hint_uentry.entry = dentry;
-
-					p_fs->hint_uentry.clu.dir = clu.dir;
-					p_fs->hint_uentry.clu.size = clu.size;
-					p_fs->hint_uentry.clu.flags = clu.flags;
-				}
-			} else if (type == TYPE_DELETED) {
-				num_empty++;
-			} else {
-				num_empty = 0;
-			}
-
-			if (num_empty >= num_entries) {
-				p_fs->hint_uentry.dir = CLUSTER_32(~0);
-				p_fs->hint_uentry.entry = -1;
-
-				if (p_fs->vol_type == EXFAT)
-					return dentry - (num_entries - 1);
-				else
-					return dentry;
-			}
-		}
-
-		if (p_dir->dir == CLUSTER_32(0))
-			break; /* FAT16 root_dir */
-
-		if (clu.flags == 0x03) {
-			if ((--clu.size) > 0)
-				clu.dir++;
-			else
-				clu.dir = CLUSTER_32(~0);
-		} else {
-			if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-				return -1;
-		}
-	}
-
-	return -1;
-}
-
-static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries)
-{
-	s32 ret, dentry;
-	u32 last_clu;
-	sector_t sector;
-	u64 size = 0;
-	struct chain_t clu;
-	struct dentry_t *ep = NULL;
-	struct super_block *sb = inode->i_sb;
+	s32 ret, dentry;
+	u32 last_clu;
+	sector_t sector;
+	u64 size = 0;
+	struct chain_t clu;
+	struct dentry_t *ep = NULL;
+	struct super_block *sb = inode->i_sb;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct file_id_t *fid = &(EXFAT_I(inode)->fid);
 
@@ -1680,6 +1680,23 @@ static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_
 	return dentry;
 }
 
+static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
+				     s32 order)
+{
+	int i, len = 0;
+
+	for (i = 0; i < 30; i += 2) {
+		*uniname = GET16_A(ep->unicode_0_14 + i);
+		if (*uniname == 0x0)
+			return len;
+		uniname++;
+		len++;
+	}
+
+	*uniname = 0x0;
+	return len;
+}
+
 /* return values of exfat_find_dir_entry()
  * >= 0 : return dir entiry position with the name in dir
  * -1 : (root dir, ".") it is the root dir itself
@@ -1971,116 +1988,31 @@ bool is_dir_empty(struct super_block *sb, struct chain_t *p_dir)
 /*
  *  Name Conversion Functions
  */
-
-/* input  : dir, uni_name
- * output : num_of_entry, dos_name(format : aaaaaa~1.bbb)
- */
-s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
-				 struct uni_name_t *p_uniname, s32 *entries,
-				 struct dos_name_t *p_dosname)
-{
-	s32 ret, num_entries;
-	bool lossy = false;
-	char **r;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	num_entries = p_fs->fs_func->calc_num_entries(p_uniname);
-	if (num_entries == 0)
-		return FFS_INVALIDPATH;
-
-	if (p_fs->vol_type != EXFAT) {
-		nls_uniname_to_dosname(sb, p_dosname, p_uniname, &lossy);
-
-		if (lossy) {
-			ret = fat_generate_dos_name(sb, p_dir, p_dosname);
-			if (ret)
-				return ret;
-		} else {
-			for (r = reserved_names; *r; r++) {
-				if (!strncmp((void *)p_dosname->name, *r, 8))
-					return FFS_INVALIDPATH;
-			}
-
-			if (p_dosname->name_case != 0xFF)
-				num_entries = 1;
-		}
-
-		if (num_entries > 1)
-			p_dosname->name_case = 0x0;
-	}
-
-	*entries = num_entries;
-
-	return FFS_SUCCESS;
-}
-
-void get_uni_name_from_dos_entry(struct super_block *sb,
-				 struct dos_dentry_t *ep,
-				 struct uni_name_t *p_uniname, u8 mode)
-{
-	struct dos_name_t dos_name;
-
-	if (mode == 0x0)
-		dos_name.name_case = 0x0;
-	else
-		dos_name.name_case = ep->lcase;
-
-	memcpy(dos_name.name, ep->name, DOS_NAME_LENGTH);
-	nls_dosname_to_uniname(sb, p_uniname, &dos_name);
-}
-
-static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
-				       struct chain_t *p_dir, s32 entry,
-				       u16 *uniname)
+static void fat_attach_count_to_dos_name(u8 *dosname, s32 count)
 {
-	int i;
-	struct dentry_t *ep;
-	struct entry_set_cache_t *es;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	es = get_entry_set_in_dir(sb, p_dir, entry, ES_ALL_ENTRIES, &ep);
-	if (!es || es->num_entries < 3) {
-		if (es)
-			release_entry_set(es);
-		return;
-	}
+	int i, j, length;
+	char str_count[6];
 
-	ep += 2;
+	snprintf(str_count, sizeof(str_count), "~%d", count);
+	length = strlen(str_count);
 
-	/*
-	 * First entry  : file entry
-	 * Second entry : stream-extension entry
-	 * Third entry  : first file-name entry
-	 * So, the index of first file-name dentry should start from 2.
-	 */
-	for (i = 2; i < es->num_entries; i++, ep++) {
-		if (p_fs->fs_func->get_entry_type(ep) == TYPE_EXTEND)
-			extract_uni_name_from_name_entry((struct name_dentry_t *)
-							 ep, uniname, i);
+	i = 0;
+	j = 0;
+	while (j <= (8 - length)) {
+		i = j;
+		if (dosname[j] == ' ')
+			break;
+		if (dosname[j] & 0x80)
+			j += 2;
 		else
-			goto out;
-		uniname += 15;
+			j++;
 	}
 
-out:
-	release_entry_set(es);
-}
-
-static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
-				     s32 order)
-{
-	int i, len = 0;
-
-	for (i = 0; i < 30; i += 2) {
-		*uniname = GET16_A(ep->unicode_0_14 + i);
-		if (*uniname == 0x0)
-			return len;
-		uniname++;
-		len++;
-	}
+	for (j = 0; j < length; i++, j++)
+		dosname[i] = (u8)str_count[j];
 
-	*uniname = 0x0;
-	return len;
+	if (i == 7)
+		dosname[7] = ' ';
 }
 
 static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
@@ -2178,31 +2110,98 @@ static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 	return FFS_SUCCESS;
 }
 
-static void fat_attach_count_to_dos_name(u8 *dosname, s32 count)
+/* input  : dir, uni_name
+ * output : num_of_entry, dos_name(format : aaaaaa~1.bbb)
+ */
+s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
+				 struct uni_name_t *p_uniname, s32 *entries,
+				 struct dos_name_t *p_dosname)
 {
-	int i, j, length;
-	char str_count[6];
+	s32 ret, num_entries;
+	bool lossy = false;
+	char **r;
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	snprintf(str_count, sizeof(str_count), "~%d", count);
-	length = strlen(str_count);
+	num_entries = p_fs->fs_func->calc_num_entries(p_uniname);
+	if (num_entries == 0)
+		return FFS_INVALIDPATH;
 
-	i = 0;
-	j = 0;
-	while (j <= (8 - length)) {
-		i = j;
-		if (dosname[j] == ' ')
-			break;
-		if (dosname[j] & 0x80)
-			j += 2;
-		else
-			j++;
+	if (p_fs->vol_type != EXFAT) {
+		nls_uniname_to_dosname(sb, p_dosname, p_uniname, &lossy);
+
+		if (lossy) {
+			ret = fat_generate_dos_name(sb, p_dir, p_dosname);
+			if (ret)
+				return ret;
+		} else {
+			for (r = reserved_names; *r; r++) {
+				if (!strncmp((void *)p_dosname->name, *r, 8))
+					return FFS_INVALIDPATH;
+			}
+
+			if (p_dosname->name_case != 0xFF)
+				num_entries = 1;
+		}
+
+		if (num_entries > 1)
+			p_dosname->name_case = 0x0;
 	}
 
-	for (j = 0; j < length; i++, j++)
-		dosname[i] = (u8)str_count[j];
+	*entries = num_entries;
 
-	if (i == 7)
-		dosname[7] = ' ';
+	return FFS_SUCCESS;
+}
+
+void get_uni_name_from_dos_entry(struct super_block *sb,
+				 struct dos_dentry_t *ep,
+				 struct uni_name_t *p_uniname, u8 mode)
+{
+	struct dos_name_t dos_name;
+
+	if (mode == 0x0)
+		dos_name.name_case = 0x0;
+	else
+		dos_name.name_case = ep->lcase;
+
+	memcpy(dos_name.name, ep->name, DOS_NAME_LENGTH);
+	nls_dosname_to_uniname(sb, p_uniname, &dos_name);
+}
+
+static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
+				       struct chain_t *p_dir, s32 entry,
+				       u16 *uniname)
+{
+	int i;
+	struct dentry_t *ep;
+	struct entry_set_cache_t *es;
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+
+	es = get_entry_set_in_dir(sb, p_dir, entry, ES_ALL_ENTRIES, &ep);
+	if (!es || es->num_entries < 3) {
+		if (es)
+			release_entry_set(es);
+		return;
+	}
+
+	ep += 2;
+
+	/*
+	 * First entry  : file entry
+	 * Second entry : stream-extension entry
+	 * Third entry  : first file-name entry
+	 * So, the index of first file-name dentry should start from 2.
+	 */
+	for (i = 2; i < es->num_entries; i++, ep++) {
+		if (p_fs->fs_func->get_entry_type(ep) == TYPE_EXTEND)
+			extract_uni_name_from_name_entry((struct name_dentry_t *)
+							 ep, uniname, i);
+		else
+			goto out;
+		uniname += 15;
+	}
+
+out:
+	release_entry_set(es);
 }
 
 static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
-- 
2.23.0

