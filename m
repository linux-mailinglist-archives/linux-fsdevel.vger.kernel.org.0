Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3734014CEEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgA2RAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 12:00:05 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37907 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgA2RAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:00:05 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so28239pjz.3;
        Wed, 29 Jan 2020 09:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bPvZB2eXnaQVO0WfOG+R7PFYHNHOhAB7tEpy1Zm0ayk=;
        b=b696053/Lt9vjqeFFvinQoccKggmldIV0Y1dzSBoR7i3gVTaRlbbMgLIp0TzZQCFwX
         Ryg50luCMbqng2qTecKgyo9na24UhZiRqmsLXR3oV1zcIirYWmu7dqtUyPwvSIaZy5X+
         /iL5AkJjnwIg4RH3c7zNApVrMneIZeTQCJhakDmqu/P15MVEiAnqUMHPtosbVpLi3+mt
         Nu/d+MnRe6NmhlXIZFlGGSm7wFZ7l2aVt2xEHOa7iRklUqJ5MAveXW4SbK0eHUYvaHuE
         7rS5qXrL79jLKCgpcd5kklcWt8evCPADzm59uRvGUFYtyNwJXlv6a5dbsf2Bka1dE0Wz
         6oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bPvZB2eXnaQVO0WfOG+R7PFYHNHOhAB7tEpy1Zm0ayk=;
        b=eA4IQOo9U4oIY56WzVGh833sm4YYLMOxYxYdu2vvqTjQqVKlCl3u2CxztZYZ4q0KR+
         /V769oI+1Xu0VCVLgETOLH2lE8HHhHp600BOEK1/xPTNLsado3EXFn/srXseLjhFyuPO
         7NLq3N/6VLb18KkO2dMuuej7DiWEG97b6nckCCBDIaxTVlVlTRp/ohMvlwKOUjJeWpN4
         Uarv9x3KcWBtJdhYle7FswEe5pG0nTl5dNFqC4ePgaZshjDi9S0rWw54sEHHXCZMnHOU
         soE0x2SFJ4TtQZ26kB9Yn6Ezjk2qlwjavVpx2XLvJrFt/m85bDGL44rgWvn88wR54Msb
         5YXw==
X-Gm-Message-State: APjAAAWnoruEVd4SOfD98sf4iI+J5hCQHNWh5TT6U9PwFrrE9fCFhyni
        w/V4srIrsNJKc7wE2za4pW81gX9uT5w=
X-Google-Smtp-Source: APXvYqzxWBAM79wHdhfvx7HHnyjNePmla14ZZU8SCEMcp3qgnwSWntL6S+VfriBAQyiyMUfbBfvcng==
X-Received: by 2002:a17:902:ba8a:: with SMTP id k10mr271498pls.333.1580317204283;
        Wed, 29 Jan 2020 09:00:04 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 09:00:03 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 13/19] staging: exfat: Rename variable 'Name' to 'name'
Date:   Wed, 29 Jan 2020 22:28:26 +0530
Message-Id: <20200129165832.10574-14-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "Name" to "name"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 2242cf1fdb4a..e74e4d5fecd4 100644
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
index 4b8ffb8ab557..8e9684808cba 100644
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

