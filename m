Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D2E11A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 07:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbfJWF2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 01:28:35 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60938 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389394AbfJWF2f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:28:35 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5SXhK003446
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:33 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5SSdS023637
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:33 -0400
Received: by mail-qt1-f199.google.com with SMTP id m20so20087828qtq.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 22:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1ZfVmulmjsU3Cyo+ca3bv9XfNhytkiBUHJH7LMRWmLo=;
        b=lg76M0pShGDo5PAbfj/dOeEaa2YzMK5fkVBR9fH1/72s1jWaD9dLXDKupuCllJQ5ys
         DshUlB3TXLYv49BXdoB/mcOzMjHhTpPE9pcfwyaTKKijqMBFhc+SnJoFPpAxtgak9IpP
         0gJFdiTpB0op9Nv+FCQpJXAMX5pce+12Wi08TXQUh5AMryLAZdrgbBq+S+cgGLNCtGG3
         uNmljzM5M/TOkQAkmk7K2HQDDCsvpET6ZxgemEOwsPK88YszK4fjm4u8PLeGqefxB4zO
         3uhTagq989a14Hx/iODyLQt+3xyWRGRiOQgqVW7519m9MgkrrQUHKynqqsEqaQlIv8NW
         8xGg==
X-Gm-Message-State: APjAAAVSr5gTv1WtZQizbqGkuC0uM+caabFaVuf6TwHvP81LmQ1K2yKn
        eUg/aGKaoei6y+LFxYF/HvHHJ6rPjVpApYgd1MrGJdoMDToDfMe+ZwyF+KMykjjawlNS9e2SE63
        Ju3cXy26lE/ITaHTQ4BRPO3zab5WkqX39bHqy
X-Received: by 2002:ac8:5556:: with SMTP id o22mr7357015qtr.217.1571808508496;
        Tue, 22 Oct 2019 22:28:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxa4tINSJ8hrkJr9ykxfcaSkUDylsH8LXjFhl71sfPlJNyCzr5HxGoTpVHwOlGkhBekPk9nvQ==
X-Received: by 2002:ac8:5556:: with SMTP id o22mr7357004qtr.217.1571808508213;
        Tue, 22 Oct 2019 22:28:28 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 14sm10397445qtb.54.2019.10.22.22.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:28:27 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valdis.Kletnieks@vt.edu
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: exfat: Cleanup static entries in exfat.h
Date:   Wed, 23 Oct 2019 01:27:47 -0400
Message-Id: <20191023052752.693689-5-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Many of the static definitions that remain are not needed, as the function
definition is already before the first use.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h | 53 -----------------------------------
 1 file changed, 53 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 9cd78b6417d0..dbd86a6cdc95 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -782,17 +782,9 @@ static void buf_sync(struct super_block *sb);
 
 /* fs management functions */
 void fs_set_vol_flags(struct super_block *sb, u32 new_flag);
-static void fs_error(struct super_block *sb);
 
 /* cluster management functions */
-static s32 clear_cluster(struct super_block *sb, u32 clu);
-static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
-			struct chain_t *p_chain);
-static void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
-			s32 do_relse);
-static u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain);
 s32 count_num_clusters(struct super_block *sb, struct chain_t *dir);
-static s32 exfat_count_used_clusters(struct super_block *sb);
 void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len);
 
 /* allocation bitmap management functions */
@@ -808,36 +800,12 @@ s32 load_upcase_table(struct super_block *sb);
 void free_upcase_table(struct super_block *sb);
 
 /* dir entry management functions */
-static u32 exfat_get_entry_type(struct dentry_t *p_entry);
-static void exfat_set_entry_type(struct dentry_t *p_entry, u32 type);
-static u32 exfat_get_entry_attr(struct dentry_t *p_entry);
-static void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
-static u8 exfat_get_entry_flag(struct dentry_t *p_entry);
-static void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
-static u32 exfat_get_entry_clu0(struct dentry_t *p_entry);
-static void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
-static u64 exfat_get_entry_size(struct dentry_t *p_entry);
-static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size);
 struct timestamp_t *tm_current(struct timestamp_t *tm);
-static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			  u8 mode);
-static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			  u8 mode);
-static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			 s32 entry, u32 type, u32 start_clu, u64 size);
-static s32 exfat_init_ext_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			     s32 entry, s32 num_entries,
-			     struct uni_name_t *p_uniname,
-		struct dos_name_t *p_dosname);
 static void init_file_entry(struct file_dentry_t *ep, u32 type);
 static void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu,
 		     u64 size);
 static void init_name_entry(struct name_dentry_t *ep, u16 *uniname);
-static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			    s32 entry, s32 order, s32 num_entries);
 
-static s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
-		  sector_t *sector, s32 *offset);
 struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 				  s32 entry, sector_t *sector);
 struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
@@ -846,18 +814,6 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 					       struct dentry_t **file_ep);
 void release_entry_set(struct entry_set_cache_t *es);
 static s32 write_whole_entry_set(struct super_block *sb, struct entry_set_cache_t *es);
-static s32 write_partial_entries_in_entry_set(struct super_block *sb,
-				       struct entry_set_cache_t *es,
-				       struct dentry_t *ep, u32 count);
-static s32 search_deleted_or_unused_entry(struct super_block *sb,
-				   struct chain_t *p_dir, s32 num_entries);
-static s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir,
-		     s32 num_entries);
-static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			 struct uni_name_t *p_uniname, s32 num_entries,
-			 struct dos_name_t *p_dosname, u32 type);
-static s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
-			    s32 entry, struct dentry_t *p_entry);
 s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 			   u32 type);
 static void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
@@ -873,25 +829,16 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 void get_uni_name_from_dos_entry(struct super_block *sb,
 				 struct dos_dentry_t *ep,
 				 struct uni_name_t *p_uniname, u8 mode);
-static void fat_get_uni_name_from_ext_entry(struct super_block *sb,
-				     struct chain_t *p_dir, s32 entry,
-				     u16 *uniname);
-static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
-				       struct chain_t *p_dir, s32 entry,
-				       u16 *uniname);
 static s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
 				            s32 order);
 static s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 			  struct dos_name_t *p_dosname);
 static void fat_attach_count_to_dos_name(u8 *dosname, s32 count);
-static s32 fat_calc_num_entries(struct uni_name_t *p_uniname);
-static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname);
 u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type);
 
 /* name resolution functions */
 s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 		 struct uni_name_t *p_uniname);
-static s32 resolve_name(u8 *name, u8 **arg);
 
 /* file operation functions */
 s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
-- 
2.23.0

