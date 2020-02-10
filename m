Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7541582B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBJShq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50204 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgBJShq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so135924pjb.0;
        Mon, 10 Feb 2020 10:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TP4KIXmliZlSTTkmdhzqJOjPZvhN6oRbhKPNHj7WueI=;
        b=DMXGFyJM/yDFrK+YqR/XKM8P9CbDdzXYxFhO7X7bBuVL6jV8OWiJ93N+QOqCFM8eZy
         Nz43tVKSflqXdFbpVUJ4jH76YEzq3dM1WoXvQwin4CsgR3P3F/uwm2Y9/2TQOZGxifTa
         90YcOTyy4nfDzd8hHUwlmumrIWLkwJl9v9QXq0aZB9cB3aZ90n9/7jvdB2RATAr6JGQm
         WdSpAkCGRqXwBr6PqTTwm3OxnDITH3L6MO/RENp5ToBq4dNXRGnN4x11yJvBsdIdlnrr
         Lxx40JH+7NinXGB8An5M7mlc1c0p6NKlzoQqk5iMqB7mHIgwtJfJhlUnAhceMQ7u9qxz
         kkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TP4KIXmliZlSTTkmdhzqJOjPZvhN6oRbhKPNHj7WueI=;
        b=RUnrEY6MzLxINt4FjMts3aFBE2tuB/pZuiR8G9JYfI7i1XNvDvZauDfOtlCelhbxvT
         arGS1vdVPkM+a0kPjGsAw+67oHabPWL79PvaU/PZ1Pw4redoOrS4x3zNC1DiyDgHsgmO
         ZNc8G7zv6tUCqH2D/KML8pSuLvUTbOMmhoAQOpJY1oLzvGtOSEfXPtXG749NWdP9qxOG
         v6DmfaOmTy1HJhqarmwC6UqbzBGW7VRMCFAjhYIHZ0uthS9MXEQHQK8WbtOOGW7VQFxj
         Gcq3oiJ75z6ySRIh3G75oBF0WKjdL2yrGVwL4CA1X6Pavpn7dwFTQyDHC6vOb1DTmJf/
         lsyg==
X-Gm-Message-State: APjAAAW1BGVSY+plESDKBHA97tOy96VbPXP7UTZBg+YQRqaWSL1rjWT4
        qX/9azJxtFb9vlWAHxfJip0PAhvbH3A=
X-Google-Smtp-Source: APXvYqwJJuMPvB7/KCETiV0lz8ywm0ELl2ZAU2n1a/xcBLoTD3dMbg7STDKYTrIYas6lnyUdnpTVlg==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr432958pjt.67.1581359865346;
        Mon, 10 Feb 2020 10:37:45 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:44 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 15/19] staging: exfat: Rename variable 'Attr' to 'attr'
Date:   Tue, 11 Feb 2020 00:05:54 +0530
Message-Id: <20200210183558.11836-16-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "Attr" to "attr"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 319c53fb62dc..883e2c5ae6df 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -275,7 +275,7 @@ struct dir_entry_t {
 	/* used only for FAT12/16/32, not used for exFAT */
 	char short_name[DOS_NAME_LENGTH + 2];
 
-	u32 Attr;
+	u32 attr;
 	u64 Size;
 	u32 NumSubdirs;
 	struct date_time_t CreateTimestamp;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index d32759d5ba68..13ff6ba97528 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1457,7 +1457,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	if (is_dir) {
 		if ((fid->dir.dir == p_fs->root_dir) &&
 		    (fid->entry == -1)) {
-			info->Attr = ATTR_SUBDIR;
+			info->attr = ATTR_SUBDIR;
 			memset((char *)&info->CreateTimestamp, 0,
 			       sizeof(struct date_time_t));
 			memset((char *)&info->ModifyTimestamp, 0,
@@ -1502,7 +1502,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	ep2 = ep + 1;
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
-	info->Attr = exfat_get_entry_attr(ep);
+	info->attr = exfat_get_entry_attr(ep);
 
 	exfat_get_entry_time(ep, &tm, TM_CREATE);
 	info->CreateTimestamp.year = tm.year;
@@ -1602,7 +1602,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	}
 	ep2 = ep + 1;
 
-	exfat_set_entry_attr(ep, info->Attr);
+	exfat_set_entry_attr(ep, info->attr);
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
 	tm.sec  = info->CreateTimestamp.second;
@@ -1919,7 +1919,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 				continue;
 
 			exfat_buf_lock(sb, sector);
-			dir_entry->Attr = exfat_get_entry_attr(ep);
+			dir_entry->attr = exfat_get_entry_attr(ep);
 
 			exfat_get_entry_time(ep, &tm, TM_CREATE);
 			dir_entry->CreateTimestamp.year = tm.year;
@@ -2147,7 +2147,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 	}
 
 	if (!dir_emit(ctx, de.name, strlen(de.name), inum,
-		      (de.Attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
+		      (de.attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
 		goto out;
 
 	ctx->pos = cpos;
@@ -3156,25 +3156,25 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 	INC_IVERSION(inode);
 	inode->i_generation = prandom_u32();
 
-	if (info.Attr & ATTR_SUBDIR) { /* directory */
+	if (info.attr & ATTR_SUBDIR) { /* directory */
 		inode->i_generation &= ~1;
-		inode->i_mode = exfat_make_mode(sbi, info.Attr, 0777);
+		inode->i_mode = exfat_make_mode(sbi, info.attr, 0777);
 		inode->i_op = &exfat_dir_inode_operations;
 		inode->i_fop = &exfat_dir_operations;
 
 		i_size_write(inode, info.Size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
 		set_nlink(inode, info.NumSubdirs);
-	} else if (info.Attr & ATTR_SYMLINK) { /* symbolic link */
+	} else if (info.attr & ATTR_SYMLINK) { /* symbolic link */
 		inode->i_generation |= 1;
-		inode->i_mode = exfat_make_mode(sbi, info.Attr, 0777);
+		inode->i_mode = exfat_make_mode(sbi, info.attr, 0777);
 		inode->i_op = &exfat_symlink_inode_operations;
 
 		i_size_write(inode, info.Size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
 	} else { /* regular file */
 		inode->i_generation |= 1;
-		inode->i_mode = exfat_make_mode(sbi, info.Attr, 0777);
+		inode->i_mode = exfat_make_mode(sbi, info.attr, 0777);
 		inode->i_op = &exfat_file_inode_operations;
 		inode->i_fop = &exfat_file_operations;
 		inode->i_mapping->a_ops = &exfat_aops;
@@ -3183,7 +3183,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 		i_size_write(inode, info.Size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
 	}
-	exfat_save_attr(inode, info.Attr);
+	exfat_save_attr(inode, info.attr);
 
 	inode->i_blocks = ((i_size_read(inode) + (p_fs->cluster_size - 1))
 				& ~((loff_t)p_fs->cluster_size - 1)) >> 9;
@@ -3256,7 +3256,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (inode->i_ino == EXFAT_ROOT_INO)
 		return 0;
 
-	info.Attr = exfat_make_attr(inode);
+	info.attr = exfat_make_attr(inode);
 	info.Size = i_size_read(inode);
 
 	exfat_time_unix2fat(&inode->i_mtime, &info.ModifyTimestamp);
-- 
2.17.1

