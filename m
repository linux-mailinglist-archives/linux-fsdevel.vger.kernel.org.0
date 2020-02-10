Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFE51582B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBJShf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33124 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgBJShf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so4137429pfn.0;
        Mon, 10 Feb 2020 10:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jbKKaescAW/v3sV/i5FrPVYboB/i+KggEt5JPV7L6jQ=;
        b=TAWBNlljSk8lPBPwK5CmzKMcrsFA4PXq1IP60W4cWi6lQcr+h7/+dNdEWSt7OAsE/L
         RrN+0mfwxWzGUw/btpIH1vKJV81jO8F5q0DuAPtxS9uEfUWkKIHW0c4DJ90Zz6oZNJR1
         UsfmLIobpdNCdjYqZ1AB0XPhbJAQSos4duuvuFZOyDz4Kbb7IHs5SGJAbi34KSB8isCF
         wDIwLKFBfPTgJstawo0knWV+H/6jt6NZU9BxaIQg4pdq4Euu+Mnzfj+EUBbWvRq8Fgd5
         eOZnq0HkS5npCXxfbMTO/8E6dOIrFLCFNEJVsKHcF4ZmzszYhJdPMJ2ChXy1H1fnp87/
         93mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jbKKaescAW/v3sV/i5FrPVYboB/i+KggEt5JPV7L6jQ=;
        b=RezNWY3vwFHJ4OSPo533jkVOMzwfjcWUfO42jnM+6Bk/kxUvL05Wg1PAYm3uWkeIxx
         u7QGTb7iekDK9bZMl363135405NuLzmX4eB01UK3y4l3WXFslEUxK514F4nxgkJQ7QpX
         RHmdO9LnlqEDv5Psiz76cUD8QhhcZzG0prAkMGo3oFvr11yknRJFRfEhCxt9jfXahvYg
         mggNAlh6tojZ0nyu/Z7o2QDw7LpkctZq66T9H2kMtzmagnn1KAvwpCqFUft2U9gFxiWB
         khmGipbXE4XwSXL0q5nhAvoGTy0tb5RUukXrY0YHN0ZfZ0j8LeY5ccRC6M00wNVhiPJe
         ngag==
X-Gm-Message-State: APjAAAUcMD45yPvtYcJ6Xi4GKMrW8iUC4cQ/naAx7s1IBmmbMsabRmJ+
        R0HJxn6Xd0UKDwWZiEqCFOI=
X-Google-Smtp-Source: APXvYqxBbLWi252RVx3W4hTgWiu/o+iKDFgx29jy6k/w1NqPCiPhN5MzVuF2QDdEKQKVihh1NAaWVg==
X-Received: by 2002:a62:cd8c:: with SMTP id o134mr2343779pfg.22.1581359854914;
        Mon, 10 Feb 2020 10:37:34 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:34 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 13/19] staging: exfat: Rename variable 'Name' to 'name'
Date:   Tue, 11 Feb 2020 00:05:52 +0530
Message-Id: <20200210183558.11836-14-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "Name" to "name"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 01d79dcc1c94..3acb4701a30b 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -270,7 +270,7 @@ struct file_id_t {
 };
 
 struct dir_entry_t {
-	char Name[MAX_NAME_LENGTH * MAX_CHARSET_SIZE];
+	char name[MAX_NAME_LENGTH * MAX_CHARSET_SIZE];
 
 	/* used only for FAT12/16/32, not used for exFAT */
 	char ShortName[DOS_NAME_LENGTH + 2];
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 7d70206eb5f8..566a6f62ed67 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1465,7 +1465,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			memset((char *)&info->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
 			strcpy(info->ShortName, ".");
-			strcpy(info->Name, ".");
+			strcpy(info->name, ".");
 
 			dir.dir = p_fs->root_dir;
 			dir.flags = 0x01;
@@ -1530,7 +1530,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	 */
 	exfat_get_uni_name_from_ext_entry(sb, &fid->dir, fid->entry,
 					  uni_name.name);
-	nls_uniname_to_cstring(sb, info->Name, &uni_name);
+	nls_uniname_to_cstring(sb, info->name, &uni_name);
 
 	info->NumSubdirs = 2;
 
@@ -1945,7 +1945,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			*uni_name.name = 0x0;
 			exfat_get_uni_name_from_ext_entry(sb, &dir, dentry,
 							  uni_name.name);
-			nls_uniname_to_cstring(sb, dir_entry->Name, &uni_name);
+			nls_uniname_to_cstring(sb, dir_entry->name, &uni_name);
 			exfat_buf_unlock(sb, sector);
 
 			ep = get_entry_in_dir(sb, &clu, i + 1, NULL);
@@ -1988,7 +1988,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 		}
 	}
 
-	*dir_entry->Name = '\0';
+	*dir_entry->name = '\0';
 
 	fid->rwoffset = (s64)(++dentry);
 
@@ -2126,7 +2126,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 
 	cpos = EXFAT_I(inode)->fid.rwoffset << DENTRY_SIZE_BITS;
 
-	if (!de.Name[0])
+	if (!de.name[0])
 		goto end_of_dir;
 
 	if (!memcmp(de.ShortName, DOS_CUR_DIR_NAME, DOS_NAME_LENGTH)) {
@@ -2146,7 +2146,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 		}
 	}
 
-	if (!dir_emit(ctx, de.Name, strlen(de.Name), inum,
+	if (!dir_emit(ctx, de.name, strlen(de.name), inum,
 		      (de.Attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
 		goto out;
 
-- 
2.17.1

