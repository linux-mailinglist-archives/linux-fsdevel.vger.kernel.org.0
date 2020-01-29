Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38BEB14CEF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgA2RAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 12:00:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33484 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgA2RAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:00:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so8693504pfn.0;
        Wed, 29 Jan 2020 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E1l6gHXvQ49XV0SVd1Lq576TcvFQ2pyxU0yLbNr7bQg=;
        b=HP+tU1IyiUVjnOJ7B79aKEO6ztkpxtzfvK5qMtNtjG1+yKXi3m88SECzlPwDDdiZEE
         diBgW227eiuJXnTCfp532XhTfwdmuTnlH81TFodIjdtzqmoM5h6KN3rnNY/GZRpViH7n
         CDUeGFTj08OTdTztWiRlHY5dX6Ti77cbR+T90C/RQfl3qgamINwICZziEPEUx8mIKVrx
         aSbLwmTP42e92L2mSkIAVLON7HJWJ/+hO3AMajFoCevXucIok4K638731DR7+eu4K6bn
         slIj+ZmfbdQ7tkzGkCnqvfVK7D651qVD5nwgnYn6iL986sdSZhHzEAIm2UXwmVFHCruv
         oOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E1l6gHXvQ49XV0SVd1Lq576TcvFQ2pyxU0yLbNr7bQg=;
        b=AILmQvVw5Il5PKWZC4kdESJ5hVWcuzeJsFwxvrP9FebyhxvI0qEWJ5+IEqHig0zEN+
         SBuJrgrMfBmLLuD85Mui3H6aBKI5C8Y0wjcfRJcjY3Zcpd0KR63CVeJ5jc5j3UxN9bhk
         3J2UL4WGQLPxtdr5xut8t1iGChedBx9pSrgQ10i3KoWK+bSs0aMUu6iyLCEXnuk+8qFO
         QMZe3NJiqA/RsGl8AmNUOyezmDCaeuF6nhLK6NztTP93l6jC9Pr2IpGz0tRRWCn+3g4V
         He99HvAt5plc+1ccGf7MAMSo6RGgzaoS4joKPbDyovlyoqNYU1KZEInSWC0b8xkwTrTQ
         3B8g==
X-Gm-Message-State: APjAAAWE+TqXm+rT87KXk7WX/pgVJKl4SuT8E5apexu/0dUQeyBg90LY
        9gDrqa0j8vXe7EmchCa7Cko=
X-Google-Smtp-Source: APXvYqyThZCHWdE0CW86oGgw+CrujFSrifKNQZdrUJVMNMmM1WKWgwv4YL2alEpTIW7CWy1KJT/HmQ==
X-Received: by 2002:aa7:92c2:: with SMTP id k2mr487123pfa.93.1580317214793;
        Wed, 29 Jan 2020 09:00:14 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 09:00:14 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 15/19] staging: exfat: Rename variable 'Attr' to 'attr'
Date:   Wed, 29 Jan 2020 22:28:28 +0530
Message-Id: <20200129165832.10574-16-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "Attr" to "attr"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 099730e5b9f1..f1fa4d19a2e2 100644
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
index e155079722c8..73d116b8d769 100644
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
-	info->Attr = p_fs->fs_func->get_entry_attr(ep);
+	info->attr = p_fs->fs_func->get_entry_attr(ep);
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_CREATE);
 	info->CreateTimestamp.year = tm.year;
@@ -1602,7 +1602,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	}
 	ep2 = ep + 1;
 
-	p_fs->fs_func->set_entry_attr(ep, info->Attr);
+	p_fs->fs_func->set_entry_attr(ep, info->attr);
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
 	tm.sec  = info->CreateTimestamp.second;
@@ -1922,7 +1922,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 				continue;
 
 			exfat_buf_lock(sb, sector);
-			dir_entry->Attr = fs_func->get_entry_attr(ep);
+			dir_entry->attr = fs_func->get_entry_attr(ep);
 
 			fs_func->get_entry_time(ep, &tm, TM_CREATE);
 			dir_entry->CreateTimestamp.year = tm.year;
@@ -2150,7 +2150,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 	}
 
 	if (!dir_emit(ctx, de.name, strlen(de.name), inum,
-		      (de.Attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
+		      (de.attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
 		goto out;
 
 	ctx->pos = cpos;
@@ -3159,25 +3159,25 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
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
@@ -3186,7 +3186,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 		i_size_write(inode, info.Size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
 	}
-	exfat_save_attr(inode, info.Attr);
+	exfat_save_attr(inode, info.attr);
 
 	inode->i_blocks = ((i_size_read(inode) + (p_fs->cluster_size - 1))
 				& ~((loff_t)p_fs->cluster_size - 1)) >> 9;
@@ -3259,7 +3259,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (inode->i_ino == EXFAT_ROOT_INO)
 		return 0;
 
-	info.Attr = exfat_make_attr(inode);
+	info.attr = exfat_make_attr(inode);
 	info.Size = i_size_read(inode);
 
 	exfat_time_unix2fat(&inode->i_mtime, &info.ModifyTimestamp);
-- 
2.17.1

