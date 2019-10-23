Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA73AE1199
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 07:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfJWF2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 01:28:34 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44840 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388504AbfJWF2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:28:34 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5SVfF019994
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:31 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5SQ12021421
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:31 -0400
Received: by mail-qt1-f200.google.com with SMTP id i25so13201591qtm.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 22:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kh/ZJY/e2Y38o2eaan9Rvm9EAE1dWaen+LESE1jJOX4=;
        b=c+T2p6r8AQEYGQ7310hAK0FZbGFFTthVNhZwudj8thJ2GBWME0m7cahHmdkrRYqPWo
         DPpaap7zB2sLNDzzFmJqMu2WAg1KZapQVcoSWpyYTmD42HmGiWaNgDsj3rNUgRVanAyR
         OwQ6EuZRySgKxFcm0jttdp2Wi1YDk7jreg79QsWh5bUuO6QbejvFOi3CPfsPoY29H9jQ
         d5nUtxtCXXVskNz70ERfKJqeObM6R+6xUfY8GWevYu0FCAHDs/iROQKB2tLDY8/fFADC
         y3ZIvLDd3Oak7YWXk2ZJNu2N3C7cDWwetSABUYyTk5dgLyPXFVy7ZccMMRFVCYZRMk1a
         Q+Vg==
X-Gm-Message-State: APjAAAVLjaJo2Pu9ZzmxYOJHH5PifuZk+K7QBApRx9MbgvzeMbRq2QTg
        L9abGtqkEyvh+qTNMEWFOSh+xbu2uWVCGJSKbVR7s9KdlEV2ZDrwrDqw7SIOhY4Qfw7eGKXH6Oj
        lJ0bRVpl5UBdY6SJWEUpvlLwHCUbHX82gIrdG
X-Received: by 2002:a0c:8b57:: with SMTP id d23mr7188295qvc.159.1571808506282;
        Tue, 22 Oct 2019 22:28:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMVCKNzOT1zlLMXmJMHac4KZPXgN8rWCxjeV79nCLovSww7QToN82lsm5YPWziQVvhD6a5zQ==
X-Received: by 2002:a0c:8b57:: with SMTP id d23mr7188250qvc.159.1571808505257;
        Tue, 22 Oct 2019 22:28:25 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 14sm10397445qtb.54.2019.10.22.22.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:28:24 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valdis.Kletnieks@vt.edu
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: exfat: Remove FAT/VFAT mount support, part 2
Date:   Wed, 23 Oct 2019 01:27:46 -0400
Message-Id: <20191023052752.693689-4-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove no longer referenced FAT/VFAT routines.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      |  49 +-
 drivers/staging/exfat/exfat_core.c | 755 -----------------------------
 2 files changed, 2 insertions(+), 802 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c2db3e9e9785..9cd78b6417d0 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -786,17 +786,12 @@ static void fs_error(struct super_block *sb);
 
 /* cluster management functions */
 static s32 clear_cluster(struct super_block *sb, u32 clu);
-static s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
-		      struct chain_t *p_chain);
 static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 			struct chain_t *p_chain);
-static void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
-		      s32 do_relse);
 static void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 			s32 do_relse);
 static u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain);
 s32 count_num_clusters(struct super_block *sb, struct chain_t *dir);
-static s32 fat_count_used_clusters(struct super_block *sb);
 static s32 exfat_count_used_clusters(struct super_block *sb);
 void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len);
 
@@ -813,63 +808,36 @@ s32 load_upcase_table(struct super_block *sb);
 void free_upcase_table(struct super_block *sb);
 
 /* dir entry management functions */
-static u32 fat_get_entry_type(struct dentry_t *p_entry);
 static u32 exfat_get_entry_type(struct dentry_t *p_entry);
-static void fat_set_entry_type(struct dentry_t *p_entry, u32 type);
 static void exfat_set_entry_type(struct dentry_t *p_entry, u32 type);
-static u32 fat_get_entry_attr(struct dentry_t *p_entry);
 static u32 exfat_get_entry_attr(struct dentry_t *p_entry);
-static void fat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
 static void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
-static u8 fat_get_entry_flag(struct dentry_t *p_entry);
 static u8 exfat_get_entry_flag(struct dentry_t *p_entry);
-static void fat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
 static void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
-static u32 fat_get_entry_clu0(struct dentry_t *p_entry);
 static u32 exfat_get_entry_clu0(struct dentry_t *p_entry);
-static void fat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
 static void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
-static u64 fat_get_entry_size(struct dentry_t *p_entry);
 static u64 exfat_get_entry_size(struct dentry_t *p_entry);
-static void fat_set_entry_size(struct dentry_t *p_entry, u64 size);
 static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size);
 struct timestamp_t *tm_current(struct timestamp_t *tm);
-static void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			u8 mode);
 static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode);
-static void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			u8 mode);
 static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode);
-static s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
-		       u32 type, u32 start_clu, u64 size);
 static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry, u32 type, u32 start_clu, u64 size);
-static s32 fat_init_ext_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			   s32 entry, s32 num_entries,
-			   struct uni_name_t *p_uniname,
-			   struct dos_name_t *p_dosname);
 static s32 exfat_init_ext_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			     s32 entry, s32 num_entries,
 			     struct uni_name_t *p_uniname,
 		struct dos_name_t *p_dosname);
-static void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu);
-static void init_ext_entry(struct ext_dentry_t *ep, s32 order, u8 chksum,
-		    u16 *uniname);
 static void init_file_entry(struct file_dentry_t *ep, u32 type);
 static void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu,
 		     u64 size);
 static void init_name_entry(struct name_dentry_t *ep, u16 *uniname);
-static void fat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			  s32 entry, s32 order, s32 num_entries);
 static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, s32 order, s32 num_entries);
 
 static s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		  sector_t *sector, s32 *offset);
-static struct dentry_t *get_entry_with_sector(struct super_block *sb, sector_t sector,
-				       s32 offset);
 struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 				  s32 entry, sector_t *sector);
 struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
@@ -885,14 +853,9 @@ static s32 search_deleted_or_unused_entry(struct super_block *sb,
 				   struct chain_t *p_dir, s32 num_entries);
 static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir,
 		     s32 num_entries);
-static s32 fat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-		       struct uni_name_t *p_uniname, s32 num_entries,
-		       struct dos_name_t *p_dosname, u32 type);
 static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 struct uni_name_t *p_uniname, s32 num_entries,
 			 struct dos_name_t *p_dosname, u32 type);
-static s32 fat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
-			  s32 entry, struct dentry_t *p_entry);
 static s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, struct dentry_t *p_entry);
 s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
@@ -916,18 +879,14 @@ static void fat_get_uni_name_from_ext_entry(struct super_block *sb,
 static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 				       struct chain_t *p_dir, s32 entry,
 				       u16 *uniname);
-static s32 extract_uni_name_from_ext_entry(struct ext_dentry_t *ep,
-				    u16 *uniname, s32 order);
-static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep,
-				     u16 *uniname, s32 order);
+static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
+				            s32 order);
 static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 			  struct dos_name_t *p_dosname);
 static void fat_attach_count_to_dos_name(u8 *dosname, s32 count);
 static s32 fat_calc_num_entries(struct uni_name_t *p_uniname);
 static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname);
-static u8 calc_checksum_1byte(void *data, s32 len, u8 chksum);
 u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type);
-static u32 calc_checksum_4byte(void *data, s32 len, u32 chksum, s32 type);
 
 /* name resolution functions */
 s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
@@ -952,10 +911,6 @@ int sector_read(struct super_block *sb, sector_t sec,
 		struct buffer_head **bh, bool read);
 int sector_write(struct super_block *sb, sector_t sec,
 		 struct buffer_head *bh, bool sync);
-static int multi_sector_read(struct super_block *sb, sector_t sec,
-		      struct buffer_head **bh, s32 num_secs, bool read);
-static int multi_sector_write(struct super_block *sb, sector_t sec,
-		       struct buffer_head *bh, s32 num_secs, bool sync);
 
 void bdev_open(struct super_block *sb);
 void bdev_close(struct super_block *sb);
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index fd481b21f8b6..dd69a9a6dddc 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -167,60 +167,6 @@ static s32 clear_cluster(struct super_block *sb, u32 clu)
 	return ret;
 }
 
-static s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
-		      struct chain_t *p_chain)
-{
-	int i, num_clusters = 0;
-	u32 new_clu, last_clu = CLUSTER_32(~0), read_clu;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	new_clu = p_chain->dir;
-	if (new_clu == CLUSTER_32(~0))
-		new_clu = p_fs->clu_srch_ptr;
-	else if (new_clu >= p_fs->num_clusters)
-		new_clu = 2;
-
-	__set_sb_dirty(sb);
-
-	p_chain->dir = CLUSTER_32(~0);
-
-	for (i = 2; i < p_fs->num_clusters; i++) {
-		if (FAT_read(sb, new_clu, &read_clu) != 0)
-			return -1;
-
-		if (read_clu == CLUSTER_32(0)) {
-			if (FAT_write(sb, new_clu, CLUSTER_32(~0)) < 0)
-				return -1;
-			num_clusters++;
-
-			if (p_chain->dir == CLUSTER_32(~0)) {
-				p_chain->dir = new_clu;
-			} else {
-				if (FAT_write(sb, last_clu, new_clu) < 0)
-					return -1;
-			}
-
-			last_clu = new_clu;
-
-			if ((--num_alloc) == 0) {
-				p_fs->clu_srch_ptr = new_clu;
-				if (p_fs->used_clusters != UINT_MAX)
-					p_fs->used_clusters += num_clusters;
-
-				return num_clusters;
-			}
-		}
-		if ((++new_clu) >= p_fs->num_clusters)
-			new_clu = 2;
-	}
-
-	p_fs->clu_srch_ptr = new_clu;
-	if (p_fs->used_clusters != UINT_MAX)
-		p_fs->used_clusters += num_clusters;
-
-	return num_clusters;
-}
-
 static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 			struct chain_t *p_chain)
 {
@@ -300,47 +246,6 @@ static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 	return num_clusters;
 }
 
-static void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
-		      s32 do_relse)
-{
-	s32 num_clusters = 0;
-	u32 clu, prev;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	int i;
-	sector_t sector;
-
-	if ((p_chain->dir == CLUSTER_32(0)) || (p_chain->dir == CLUSTER_32(~0)))
-		return;
-	__set_sb_dirty(sb);
-	clu = p_chain->dir;
-
-	if (p_chain->size <= 0)
-		return;
-
-	do {
-		if (p_fs->dev_ejected)
-			break;
-
-		if (do_relse) {
-			sector = START_SECTOR(clu);
-			for (i = 0; i < p_fs->sectors_per_clu; i++)
-				buf_release(sb, sector + i);
-		}
-
-		prev = clu;
-		if (FAT_read(sb, clu, &clu) == -1)
-			break;
-
-		if (FAT_write(sb, prev, CLUSTER_32(0)) < 0)
-			break;
-		num_clusters++;
-
-	} while (clu != CLUSTER_32(~0));
-
-	if (p_fs->used_clusters != UINT_MAX)
-		p_fs->used_clusters -= num_clusters;
-}
-
 static void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 			s32 do_relse)
 {
@@ -447,22 +352,6 @@ s32 count_num_clusters(struct super_block *sb, struct chain_t *p_chain)
 	return count;
 }
 
-static s32 fat_count_used_clusters(struct super_block *sb)
-{
-	int i, count = 0;
-	u32 clu;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	for (i = 2; i < p_fs->num_clusters; i++) {
-		if (FAT_read(sb, i, &clu) != 0)
-			break;
-		if (clu != CLUSTER_32(0))
-			count++;
-	}
-
-	return count;
-}
-
 static s32 exfat_count_used_clusters(struct super_block *sb)
 {
 	int i, map_i, map_b, count = 0;
@@ -906,28 +795,6 @@ void free_upcase_table(struct super_block *sb)
  *  Directory Entry Management Functions
  */
 
-static u32 fat_get_entry_type(struct dentry_t *p_entry)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	if (*(ep->name) == 0x0)
-		return TYPE_UNUSED;
-
-	else if (*(ep->name) == 0xE5)
-		return TYPE_DELETED;
-
-	else if (ep->attr == ATTR_EXTEND)
-		return TYPE_EXTEND;
-
-	else if ((ep->attr & (ATTR_SUBDIR | ATTR_VOLUME)) == ATTR_VOLUME)
-		return TYPE_VOLUME;
-
-	else if ((ep->attr & (ATTR_SUBDIR | ATTR_VOLUME)) == ATTR_SUBDIR)
-		return TYPE_DIR;
-
-	return TYPE_FILE;
-}
-
 static u32 exfat_get_entry_type(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -973,29 +840,6 @@ static u32 exfat_get_entry_type(struct dentry_t *p_entry)
 	return TYPE_BENIGN_SEC;
 }
 
-static void fat_set_entry_type(struct dentry_t *p_entry, u32 type)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	if (type == TYPE_UNUSED)
-		*(ep->name) = 0x0;
-
-	else if (type == TYPE_DELETED)
-		*(ep->name) = 0xE5;
-
-	else if (type == TYPE_EXTEND)
-		ep->attr = ATTR_EXTEND;
-
-	else if (type == TYPE_DIR)
-		ep->attr = ATTR_SUBDIR;
-
-	else if (type == TYPE_FILE)
-		ep->attr = ATTR_ARCHIVE;
-
-	else if (type == TYPE_SYMLINK)
-		ep->attr = ATTR_ARCHIVE | ATTR_SYMLINK;
-}
-
 static void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -1026,13 +870,6 @@ static void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 	}
 }
 
-static u32 fat_get_entry_attr(struct dentry_t *p_entry)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	return (u32)ep->attr;
-}
-
 static u32 exfat_get_entry_attr(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -1040,13 +877,6 @@ static u32 exfat_get_entry_attr(struct dentry_t *p_entry)
 	return (u32)GET16_A(ep->attr);
 }
 
-static void fat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	ep->attr = (u8)attr;
-}
-
 static void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
@@ -1054,11 +884,6 @@ static void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
 	SET16_A(ep->attr, (u16)attr);
 }
 
-static u8 fat_get_entry_flag(struct dentry_t *p_entry)
-{
-	return 0x01;
-}
-
 static u8 exfat_get_entry_flag(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1066,10 +891,6 @@ static u8 exfat_get_entry_flag(struct dentry_t *p_entry)
 	return ep->flags;
 }
 
-static void fat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
-{
-}
-
 static void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1077,14 +898,6 @@ static void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
 	ep->flags = flags;
 }
 
-static u32 fat_get_entry_clu0(struct dentry_t *p_entry)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	return ((u32)GET16_A(ep->start_clu_hi) << 16) |
-		GET16_A(ep->start_clu_lo);
-}
-
 static u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1092,14 +905,6 @@ static u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
 	return GET32_A(ep->start_clu);
 }
 
-static void fat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	SET16_A(ep->start_clu_lo, CLUSTER_16(start_clu));
-	SET16_A(ep->start_clu_hi, CLUSTER_16(start_clu >> 16));
-}
-
 static void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1107,13 +912,6 @@ static void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
 	SET32_A(ep->start_clu, start_clu);
 }
 
-static u64 fat_get_entry_size(struct dentry_t *p_entry)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	return (u64)GET32_A(ep->size);
-}
-
 static u64 exfat_get_entry_size(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1121,13 +919,6 @@ static u64 exfat_get_entry_size(struct dentry_t *p_entry)
 	return GET64_A(ep->valid_size);
 }
 
-static void fat_set_entry_size(struct dentry_t *p_entry, u64 size)
-{
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	SET32_A(ep->size, (u32)size);
-}
-
 static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
@@ -1136,31 +927,6 @@ static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 	SET64_A(ep->size, size);
 }
 
-static void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			u8 mode)
-{
-	u16 t = 0x00, d = 0x21;
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	switch (mode) {
-	case TM_CREATE:
-		t = GET16_A(ep->create_time);
-		d = GET16_A(ep->create_date);
-		break;
-	case TM_MODIFY:
-		t = GET16_A(ep->modify_time);
-		d = GET16_A(ep->modify_date);
-		break;
-	}
-
-	tp->sec  = (t & 0x001F) << 1;
-	tp->min  = (t >> 5) & 0x003F;
-	tp->hour = (t >> 11);
-	tp->day  = (d & 0x001F);
-	tp->mon  = (d >> 5) & 0x000F;
-	tp->year = (d >> 9);
-}
-
 static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
@@ -1190,27 +956,6 @@ static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *t
 	tp->year = (d >> 9);
 }
 
-static void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			u8 mode)
-{
-	u16 t, d;
-	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
-
-	t = (tp->hour << 11) | (tp->min << 5) | (tp->sec >> 1);
-	d = (tp->year <<  9) | (tp->mon << 5) |  tp->day;
-
-	switch (mode) {
-	case TM_CREATE:
-		SET16_A(ep->create_time, t);
-		SET16_A(ep->create_date, d);
-		break;
-	case TM_MODIFY:
-		SET16_A(ep->modify_time, t);
-		SET16_A(ep->modify_date, d);
-		break;
-	}
-}
-
 static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
@@ -1236,23 +981,6 @@ static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *t
 	}
 }
 
-static s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
-		       u32 type, u32 start_clu, u64 size)
-{
-	sector_t sector;
-	struct dos_dentry_t *dos_ep;
-
-	dos_ep = (struct dos_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
-							 &sector);
-	if (!dos_ep)
-		return FFS_MEDIAERR;
-
-	init_dos_entry(dos_ep, type, start_clu);
-	buf_modify(sb, sector);
-
-	return FFS_SUCCESS;
-}
-
 static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry, u32 type, u32 start_clu, u64 size)
 {
@@ -1283,57 +1011,6 @@ static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	return FFS_SUCCESS;
 }
 
-static s32 fat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
-			      s32 entry, s32 num_entries,
-			      struct uni_name_t *p_uniname,
-			      struct dos_name_t *p_dosname)
-{
-	int i;
-	sector_t sector;
-	u8 chksum;
-	u16 *uniname = p_uniname->name;
-	struct dos_dentry_t *dos_ep;
-	struct ext_dentry_t *ext_ep;
-
-	dos_ep = (struct dos_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
-							 &sector);
-	if (!dos_ep)
-		return FFS_MEDIAERR;
-
-	dos_ep->lcase = p_dosname->name_case;
-	memcpy(dos_ep->name, p_dosname->name, DOS_NAME_LENGTH);
-	buf_modify(sb, sector);
-
-	if ((--num_entries) > 0) {
-		chksum = calc_checksum_1byte((void *)dos_ep->name,
-					     DOS_NAME_LENGTH, 0);
-
-		for (i = 1; i < num_entries; i++) {
-			ext_ep = (struct ext_dentry_t *)get_entry_in_dir(sb,
-									 p_dir,
-									 entry - i,
-									 &sector);
-			if (!ext_ep)
-				return FFS_MEDIAERR;
-
-			init_ext_entry(ext_ep, i, chksum, uniname);
-			buf_modify(sb, sector);
-			uniname += 13;
-		}
-
-		ext_ep = (struct ext_dentry_t *)get_entry_in_dir(sb, p_dir,
-								 entry - i,
-								 &sector);
-		if (!ext_ep)
-			return FFS_MEDIAERR;
-
-		init_ext_entry(ext_ep, i + 0x40, chksum, uniname);
-		buf_modify(sb, sector);
-	}
-
-	return FFS_SUCCESS;
-}
-
 static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 				s32 entry, s32 num_entries,
 				struct uni_name_t *p_uniname,
@@ -1380,70 +1057,6 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	return FFS_SUCCESS;
 }
 
-static void init_dos_entry(struct dos_dentry_t *ep, u32 type, u32 start_clu)
-{
-	struct timestamp_t tm, *tp;
-
-	fat_set_entry_type((struct dentry_t *)ep, type);
-	SET16_A(ep->start_clu_lo, CLUSTER_16(start_clu));
-	SET16_A(ep->start_clu_hi, CLUSTER_16(start_clu >> 16));
-	SET32_A(ep->size, 0);
-
-	tp = tm_current(&tm);
-	fat_set_entry_time((struct dentry_t *)ep, tp, TM_CREATE);
-	fat_set_entry_time((struct dentry_t *)ep, tp, TM_MODIFY);
-	SET16_A(ep->access_date, 0);
-	ep->create_time_ms = 0;
-}
-
-static void init_ext_entry(struct ext_dentry_t *ep, s32 order, u8 chksum, u16 *uniname)
-{
-	int i;
-	bool end = false;
-
-	fat_set_entry_type((struct dentry_t *)ep, TYPE_EXTEND);
-	ep->order = (u8)order;
-	ep->sysid = 0;
-	ep->checksum = chksum;
-	SET16_A(ep->start_clu, 0);
-
-	for (i = 0; i < 10; i += 2) {
-		if (!end) {
-			SET16(ep->unicode_0_4 + i, *uniname);
-			if (*uniname == 0x0)
-				end = true;
-			else
-				uniname++;
-		} else {
-			SET16(ep->unicode_0_4 + i, 0xFFFF);
-		}
-	}
-
-	for (i = 0; i < 12; i += 2) {
-		if (!end) {
-			SET16_A(ep->unicode_5_10 + i, *uniname);
-			if (*uniname == 0x0)
-				end = true;
-			else
-				uniname++;
-		} else {
-			SET16_A(ep->unicode_5_10 + i, 0xFFFF);
-		}
-	}
-
-	for (i = 0; i < 4; i += 2) {
-		if (!end) {
-			SET16_A(ep->unicode_11_12 + i, *uniname);
-			if (*uniname == 0x0)
-				end = true;
-			else
-				uniname++;
-		} else {
-			SET16_A(ep->unicode_11_12 + i, 0xFFFF);
-		}
-	}
-}
-
 static void init_file_entry(struct file_dentry_t *ep, u32 type)
 {
 	struct timestamp_t tm, *tp;
@@ -1483,24 +1096,6 @@ static void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
 	}
 }
 
-static void fat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-		s32 entry, s32 order, s32 num_entries)
-{
-	int i;
-	sector_t sector;
-	struct dentry_t *ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	for (i = num_entries - 1; i >= order; i--) {
-		ep = get_entry_in_dir(sb, p_dir, entry - i, &sector);
-		if (!ep)
-			return;
-
-		p_fs->fs_func->set_entry_type(ep, TYPE_DELETED);
-		buf_modify(sb, sector);
-	}
-}
-
 static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 		s32 entry, s32 order, s32 num_entries)
 {
@@ -1633,19 +1228,6 @@ static s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entr
 	return FFS_SUCCESS;
 }
 
-static struct dentry_t *get_entry_with_sector(struct super_block *sb, sector_t sector,
-				       s32 offset)
-{
-	u8 *buf;
-
-	buf = buf_getblk(sb, sector);
-
-	if (!buf)
-		return NULL;
-
-	return (struct dentry_t *)(buf + offset);
-}
-
 struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 				  s32 entry, sector_t *sector)
 {
@@ -1917,45 +1499,6 @@ static s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_
 						    es->num_entries);
 }
 
-/* write back some entries in entry set */
-static s32 write_partial_entries_in_entry_set(struct super_block *sb,
-	struct entry_set_cache_t *es, struct dentry_t *ep, u32 count)
-{
-	s32 ret, byte_offset, off;
-	u32 clu = 0;
-	sector_t sec;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-	struct chain_t dir;
-
-	/* vaidity check */
-	if (ep + count  > ((struct dentry_t *)&(es->__buf)) + es->num_entries)
-		return FFS_ERROR;
-
-	dir.dir = GET_CLUSTER_FROM_SECTOR(es->sector);
-	dir.flags = es->alloc_flag;
-	dir.size = 0xffffffff;		/* XXX */
-
-	byte_offset = (es->sector - START_SECTOR(dir.dir)) <<
-			p_bd->sector_size_bits;
-	byte_offset += ((void **)ep - &(es->__buf)) + es->offset;
-
-	ret = _walk_fat_chain(sb, &dir, byte_offset, &clu);
-	if (ret != FFS_SUCCESS)
-		return ret;
-
-	/* byte offset in cluster */
-	byte_offset &= p_fs->cluster_size - 1;
-
-	/* byte offset in sector    */
-	off = byte_offset & p_bd->sector_size_mask;
-
-	/* sector offset in cluster */
-	sec = byte_offset >> p_bd->sector_size_bits;
-	sec += START_SECTOR(clu);
-	return __write_partial_entries_in_entry_set(sb, es, sec, off, count);
-}
-
 /* search EMPTY CONTINUOUS "num_entries" entries */
 static s32 search_deleted_or_unused_entry(struct super_block *sb,
 				   struct chain_t *p_dir, s32 num_entries)
@@ -2137,104 +1680,6 @@ static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_
 	return dentry;
 }
 
-/* return values of fat_find_dir_entry()
- * >= 0 : return dir entiry position with the name in dir
- * -1 : (root dir, ".") it is the root dir itself
- * -2 : entry with the name does not exist
- */
-static s32 fat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-		       struct uni_name_t *p_uniname, s32 num_entries,
-		       struct dos_name_t *p_dosname, u32 type)
-{
-	int i, dentry = 0, len;
-	s32 order = 0;
-	bool is_feasible_entry = true, has_ext_entry = false;
-	s32 dentries_per_clu;
-	u32 entry_type;
-	u16 entry_uniname[14], *uniname = NULL, unichar;
-	struct chain_t clu;
-	struct dentry_t *ep;
-	struct dos_dentry_t *dos_ep;
-	struct ext_dentry_t *ext_ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	if (p_dir->dir == p_fs->root_dir) {
-		if ((!nls_uniname_cmp(sb, p_uniname->name,
-				      (u16 *)UNI_CUR_DIR_NAME)) ||
-			(!nls_uniname_cmp(sb, p_uniname->name,
-					  (u16 *)UNI_PAR_DIR_NAME)))
-			return -1; // special case, root directory itself
-	}
-
-	if (p_dir->dir == CLUSTER_32(0)) /* FAT16 root_dir */
-		dentries_per_clu = p_fs->dentries_in_root;
-	else
-		dentries_per_clu = p_fs->dentries_per_clu;
-
-	clu.dir = p_dir->dir;
-	clu.flags = p_dir->flags;
-
-	while (clu.dir != CLUSTER_32(~0)) {
-		if (p_fs->dev_ejected)
-			break;
-
-		for (i = 0; i < dentries_per_clu; i++, dentry++) {
-			ep = get_entry_in_dir(sb, &clu, i, NULL);
-			if (!ep)
-				return -2;
-
-			entry_type = p_fs->fs_func->get_entry_type(ep);
-
-			if ((entry_type == TYPE_FILE) || (entry_type == TYPE_DIR)) {
-				if ((type == TYPE_ALL) || (type == entry_type)) {
-					if (is_feasible_entry && has_ext_entry)
-						return dentry;
-
-					dos_ep = (struct dos_dentry_t *)ep;
-					if (!nls_dosname_cmp(sb, p_dosname->name, dos_ep->name))
-						return dentry;
-				}
-				is_feasible_entry = true;
-				has_ext_entry = false;
-			} else if (entry_type == TYPE_EXTEND) {
-				if (is_feasible_entry) {
-					ext_ep = (struct ext_dentry_t *)ep;
-					if (ext_ep->order > 0x40) {
-						order = (s32)(ext_ep->order - 0x40);
-						uniname = p_uniname->name + 13 * (order - 1);
-					} else {
-						order = (s32)ext_ep->order;
-						uniname -= 13;
-					}
-
-					len = extract_uni_name_from_ext_entry(ext_ep, entry_uniname, order);
-
-					unichar = *(uniname + len);
-					*(uniname + len) = 0x0;
-
-					if (nls_uniname_cmp(sb, uniname, entry_uniname))
-						is_feasible_entry = false;
-
-					*(uniname + len) = unichar;
-				}
-				has_ext_entry = true;
-			} else if (entry_type == TYPE_UNUSED) {
-				return -2;
-			}
-			is_feasible_entry = true;
-			has_ext_entry = false;
-		}
-
-		if (p_dir->dir == CLUSTER_32(0))
-			break; /* FAT16 root_dir */
-
-		if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-			return -2;
-	}
-
-	return -2;
-}
-
 /* return values of exfat_find_dir_entry()
  * >= 0 : return dir entiry position with the name in dir
  * -1 : (root dir, ".") it is the root dir itself
@@ -2383,36 +1828,6 @@ static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	return -2;
 }
 
-static s32 fat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
-			  s32 entry, struct dentry_t *p_entry)
-{
-	s32 count = 0;
-	u8 chksum;
-	struct dos_dentry_t *dos_ep = (struct dos_dentry_t *)p_entry;
-	struct ext_dentry_t *ext_ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	chksum = calc_checksum_1byte((void *)dos_ep->name, DOS_NAME_LENGTH, 0);
-
-	for (entry--; entry >= 0; entry--) {
-		ext_ep = (struct ext_dentry_t *)get_entry_in_dir(sb, p_dir,
-								 entry, NULL);
-		if (!ext_ep)
-			return -1;
-
-		if ((p_fs->fs_func->get_entry_type((struct dentry_t *)ext_ep) ==
-		     TYPE_EXTEND) && (ext_ep->checksum == chksum)) {
-			count++;
-			if (ext_ep->order > 0x40)
-				return count;
-		} else {
-			return count;
-		}
-	}
-
-	return count;
-}
-
 static s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, struct dentry_t *p_entry)
 {
@@ -2614,33 +2029,6 @@ void get_uni_name_from_dos_entry(struct super_block *sb,
 	nls_dosname_to_uniname(sb, p_uniname, &dos_name);
 }
 
-static void fat_get_uni_name_from_ext_entry(struct super_block *sb,
-				     struct chain_t *p_dir, s32 entry,
-				     u16 *uniname)
-{
-	int i;
-	struct ext_dentry_t *ep;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	for (entry--, i = 1; entry >= 0; entry--, i++) {
-		ep = (struct ext_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
-							     NULL);
-		if (!ep)
-			return;
-
-		if (p_fs->fs_func->get_entry_type((struct dentry_t *)ep) ==
-		    TYPE_EXTEND) {
-			extract_uni_name_from_ext_entry(ep, uniname, i);
-			if (ep->order > 0x40)
-				return;
-		} else {
-			return;
-		}
-
-		uniname += 13;
-	}
-}
-
 static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 				       struct chain_t *p_dir, s32 entry,
 				       u16 *uniname)
@@ -2678,51 +2066,6 @@ static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 	release_entry_set(es);
 }
 
-static s32 extract_uni_name_from_ext_entry(struct ext_dentry_t *ep, u16 *uniname,
-				    s32 order)
-{
-	int i, len = 0;
-
-	for (i = 0; i < 10; i += 2) {
-		*uniname = GET16(ep->unicode_0_4 + i);
-		if (*uniname == 0x0)
-			return len;
-		uniname++;
-		len++;
-	}
-
-	if (order < 20) {
-		for (i = 0; i < 12; i += 2) {
-			*uniname = GET16_A(ep->unicode_5_10 + i);
-			if (*uniname == 0x0)
-				return len;
-			uniname++;
-			len++;
-		}
-	} else {
-		for (i = 0; i < 8; i += 2) {
-			*uniname = GET16_A(ep->unicode_5_10 + i);
-			if (*uniname == 0x0)
-				return len;
-			uniname++;
-			len++;
-		}
-		*uniname = 0x0; /* uniname[MAX_NAME_LENGTH-1] */
-		return len;
-	}
-
-	for (i = 0; i < 4; i += 2) {
-		*uniname = GET16_A(ep->unicode_11_12 + i);
-		if (*uniname == 0x0)
-			return len;
-		uniname++;
-		len++;
-	}
-
-	*uniname = 0x0;
-	return len;
-}
-
 static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
 				     s32 order)
 {
@@ -2862,18 +2205,6 @@ static void fat_attach_count_to_dos_name(u8 *dosname, s32 count)
 		dosname[7] = ' ';
 }
 
-static s32 fat_calc_num_entries(struct uni_name_t *p_uniname)
-{
-	s32 len;
-
-	len = p_uniname->name_len;
-	if (len == 0)
-		return 0;
-
-	/* 1 dos name entry + extended entries */
-	return (len - 1) / 13 + 2;
-}
-
 static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
 {
 	s32 len;
@@ -2886,17 +2217,6 @@ static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
 	return (len - 1) / 15 + 3;
 }
 
-static u8 calc_checksum_1byte(void *data, s32 len, u8 chksum)
-{
-	int i;
-	u8 *c = (u8 *)data;
-
-	for (i = 0; i < len; i++, c++)
-		chksum = (((chksum & 1) << 7) | ((chksum & 0xFE) >> 1)) + *c;
-
-	return chksum;
-}
-
 u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type)
 {
 	int i;
@@ -2921,30 +2241,6 @@ u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type)
 	return chksum;
 }
 
-static u32 calc_checksum_4byte(void *data, s32 len, u32 chksum, s32 type)
-{
-	int i;
-	u8 *c = (u8 *)data;
-
-	switch (type) {
-	case CS_PBR_SECTOR:
-		for (i = 0; i < len; i++, c++) {
-			if ((i == 106) || (i == 107) || (i == 112))
-				continue;
-			chksum = (((chksum & 1) << 31) |
-				  ((chksum & 0xFFFFFFFE) >> 1)) + (u32)*c;
-		}
-		break;
-	default
-			:
-		for (i = 0; i < len; i++, c++)
-			chksum = (((chksum & 1) << 31) |
-				  ((chksum & 0xFFFFFFFE) >> 1)) + (u32)*c;
-	}
-
-	return chksum;
-}
-
 /*
  *  Name Resolution Functions
  */
@@ -3506,54 +2802,3 @@ int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 
 	return ret;
 }
-
-static int multi_sector_read(struct super_block *sb, sector_t sec,
-		      struct buffer_head **bh, s32 num_secs, bool read)
-{
-	s32 ret = FFS_MEDIAERR;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	if (((sec + num_secs) > (p_fs->PBR_sector + p_fs->num_sectors)) &&
-	    (p_fs->num_sectors > 0)) {
-		pr_err("[EXFAT] %s: out of range error! (sec = %llu, num_secs = %d)\n",
-		       __func__, (unsigned long long)sec, num_secs);
-		fs_error(sb);
-		return ret;
-	}
-
-	if (!p_fs->dev_ejected) {
-		ret = bdev_read(sb, sec, bh, num_secs, read);
-		if (ret != FFS_SUCCESS)
-			p_fs->dev_ejected = 1;
-	}
-
-	return ret;
-}
-
-static int multi_sector_write(struct super_block *sb, sector_t sec,
-		       struct buffer_head *bh, s32 num_secs, bool sync)
-{
-	s32 ret = FFS_MEDIAERR;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	if ((sec + num_secs) > (p_fs->PBR_sector + p_fs->num_sectors) &&
-	    (p_fs->num_sectors > 0)) {
-		pr_err("[EXFAT] %s: out of range error! (sec = %llu, num_secs = %d)\n",
-		       __func__, (unsigned long long)sec, num_secs);
-		fs_error(sb);
-		return ret;
-	}
-	if (!bh) {
-		pr_err("[EXFAT] %s: bh is NULL!\n", __func__);
-		fs_error(sb);
-		return ret;
-	}
-
-	if (!p_fs->dev_ejected) {
-		ret = bdev_write(sb, sec, bh, num_secs, sync);
-		if (ret != FFS_SUCCESS)
-			p_fs->dev_ejected = 1;
-	}
-
-	return ret;
-}
-- 
2.23.0

