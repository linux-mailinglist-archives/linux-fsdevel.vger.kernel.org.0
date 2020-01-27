Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0992814A1BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgA0KPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41826 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgA0KPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so3573779plr.8;
        Mon, 27 Jan 2020 02:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zrn7+TeOkTDL/p3LQj1UqFH3/1vHE1+1wFLqYAGLVFQ=;
        b=Ue4NKg8DXDExYRFvWUyszMX+E/J0sZFpnwRNCf+XUFtDtHOfJtaQqbGvcIM+Qar5St
         qcbx3ws0c5nX5kwCKMFYHTyvrmTjhTD3jrBp56mLOWQOoVn6wE+v5mC1cycDEgRVF8Dh
         YneupgBhKHzteqCRdHzqsuL5E3SbSOcX2nAUhmiVL21/iGZ1gFuMakOclbdmZ9XoUGJ5
         1/Ro/t8dLB/0J4bfRJqZODjGuPzncpDaEio43mjN6UxspNZW08cVhLOOTvA9VU2SUwRR
         CkVz6ucDgO35azapQBYYyhcXcHX6E+5iNwbfBkwUc3nXrroruRNfBItXS67naqnC6UQu
         EJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zrn7+TeOkTDL/p3LQj1UqFH3/1vHE1+1wFLqYAGLVFQ=;
        b=Ta9bH4AiqUKsNtjgt0/Tv2ZFkQ69CRwgkrS4AGRUIbILqdBHZPVG/9uykArBlYl9R5
         ikZ/edr9+cxAd8D031pOJspQs4T/t1sujvP0xvWqEPggrCy6qSrk3GI7ONSHwhjzPa9L
         OFdDj9cs7eG1oxJnLLqm5uP4xa2NTGS2D5iS4RokueE9QIsYFHWmPXp0LNZlMJC2ZNX4
         jDCCkoyyiAHXkrfzdBLFddkn7SuO7ycjTSqPEzQ+3nc402oT5GoQSBVwOs8Sk/Oi18/Y
         4k2HeMhvCkWgHAzNZE9DZN9FrAeWo94PKslxSqTryFjvwrHtxpixh/ARItrxcJHCjOHD
         CKcQ==
X-Gm-Message-State: APjAAAU0ZQxLDztsOXySD4FeZll55T/Qo3NfEuZeV2Gtw3nR+gPKkG+x
        S9Gq88uP00TZZRWGrDXjC4k=
X-Google-Smtp-Source: APXvYqyniCKZhC1kuMrRPm8eqcHWxRjMBkQxqVV5/6XC3yNbMSHud/o/D8j5MaJj4DYGbntDxDPjxA==
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr17267550plq.325.1580120141216;
        Mon, 27 Jan 2020 02:15:41 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:40 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 16/22] staging: exfat: Rename variable "Name" to "name"
Date:   Mon, 27 Jan 2020 15:43:37 +0530
Message-Id: <20200127101343.20415-17-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "Name" to "name" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index abed7fed3823..bc917b241bab 100644
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
index 223699a21079..8a4915aa3849 100644
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
 	p_fs->fs_func->get_uni_name_from_ext_entry(sb, &fid->dir, fid->entry,
 						   uni_name.name);
-	nls_uniname_to_cstring(sb, info->Name, &uni_name);
+	nls_uniname_to_cstring(sb, info->name, &uni_name);
 
 	info->NumSubdirs = 2;
 
@@ -1948,7 +1948,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			*uni_name.name = 0x0;
 			fs_func->get_uni_name_from_ext_entry(sb, &dir, dentry,
 							     uni_name.name);
-			nls_uniname_to_cstring(sb, dir_entry->Name, &uni_name);
+			nls_uniname_to_cstring(sb, dir_entry->name, &uni_name);
 			exfat_buf_unlock(sb, sector);
 
 			ep = get_entry_in_dir(sb, &clu, i + 1, NULL);
@@ -1991,7 +1991,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 		}
 	}
 
-	*dir_entry->Name = '\0';
+	*dir_entry->name = '\0';
 
 	fid->rwoffset = (s64)(++dentry);
 
@@ -2129,7 +2129,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 
 	cpos = EXFAT_I(inode)->fid.rwoffset << DENTRY_SIZE_BITS;
 
-	if (!de.Name[0])
+	if (!de.name[0])
 		goto end_of_dir;
 
 	if (!memcmp(de.ShortName, DOS_CUR_DIR_NAME, DOS_NAME_LENGTH)) {
@@ -2149,7 +2149,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 		}
 	}
 
-	if (!dir_emit(ctx, de.Name, strlen(de.Name), inum,
+	if (!dir_emit(ctx, de.name, strlen(de.name), inum,
 		      (de.Attr & ATTR_SUBDIR) ? DT_DIR : DT_REG))
 		goto out;
 
-- 
2.17.1

