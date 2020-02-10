Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141D11582B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgBJShv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33141 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgBJShu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so4137770pfn.0;
        Mon, 10 Feb 2020 10:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=umt++nmNk2LlD4NsvJDmDt5rq8zdUSLHh/U6VwMmTpU=;
        b=ZVkkUS0yXLzvHRVNZ6u24FHjeejdwBnetcrQbhhsDB/f4CD4jnnTeVlKc6yu30LLhN
         YwF3lwtze9felDDxwKbqtDSSSqkRKKANxNwO2BGFVAakgHc9yb0fuWbKVTcKhSdf32Zd
         K0WZ4go6l8owCO8V2fPQAeKmdIjEJOOeEghmFAzoBylKCCfKHL+YVwceJnlDeQsiPCoe
         jmiAO5V08F80Jqa0N0CnCfmgKn6FzSpO4c83yXesLyCt+Blu4tPELkzt8vRcyZCjJwXv
         3hav9NQ6u+FHe7YkWngVEYWsxsiCxyJrZZkvR1+CR2xYI2wIKF16T9OEPUf+GMPIN8Yl
         UZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=umt++nmNk2LlD4NsvJDmDt5rq8zdUSLHh/U6VwMmTpU=;
        b=KyxF+6b+byS8v5BqXsYh5lKvcIkC18HwpJGH2zO6QRq7nam3nCAWmLzWTWZiX6TkJl
         nHaeKIIpadILzdpAI9Kohlh7G54SW69apNx9MiXOVAxMz2xfECmXAnoZ5XmiiWaVr4b+
         /kwHJ8WxICddxkI+jtalUHfHW5oamsYiUGVR2RlWsbd0DzqAlgIjzHnbONSOcryScYe6
         MHY7diORYEPrkRJeOWTo2aNYvfUHwas91RLH8yMTkAWUNEzRKU10mnN7tUik3yw7Tgnm
         6uaz7Rn6Sw8GYYnlDg6VfsEmF3DCLH5Hbrr03jY8nwJrgpSmrVg1MYFsfHkzTOOTdsKv
         UMIQ==
X-Gm-Message-State: APjAAAXgd+UqqZMbUdI3Qish3Y0IXjH+La3Crla4hAt+qRRXauQ6eQEJ
        78uGkD9+BpM2PI40UT0e3Jg=
X-Google-Smtp-Source: APXvYqxAaiFR2ChuoSbvv3OdgcYZIZ4roX0XchWCJNhHZ6j3qGnJibm3mJ/4STzERapuYLkxUBI19g==
X-Received: by 2002:aa7:9f47:: with SMTP id h7mr2262393pfr.13.1581359870113;
        Mon, 10 Feb 2020 10:37:50 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:49 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 16/19] staging: exfat: Rename variable 'NumSubdirs' to 'num_subdirs'
Date:   Tue, 11 Feb 2020 00:05:55 +0530
Message-Id: <20200210183558.11836-17-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "NumSubdirs" to "num_subdirs"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 883e2c5ae6df..90153175bbb9 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -277,7 +277,7 @@ struct dir_entry_t {
 
 	u32 attr;
 	u64 Size;
-	u32 NumSubdirs;
+	u32 num_subdirs;
 	struct date_time_t CreateTimestamp;
 	struct date_time_t ModifyTimestamp;
 	struct date_time_t AccessTimestamp;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 13ff6ba97528..365e9e719bcf 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1484,7 +1484,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 				ret = count; /* propagate error upward */
 				goto out;
 			}
-			info->NumSubdirs = count;
+			info->num_subdirs = count;
 
 			if (p_fs->dev_ejected)
 				ret = -EIO;
@@ -1532,7 +1532,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 					  uni_name.name);
 	nls_uniname_to_cstring(sb, info->name, &uni_name);
 
-	info->NumSubdirs = 2;
+	info->num_subdirs = 2;
 
 	info->Size = exfat_get_entry_size(ep2);
 
@@ -1551,7 +1551,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			ret = count; /* propagate error upward */
 			goto out;
 		}
-		info->NumSubdirs += count;
+		info->num_subdirs += count;
 	}
 
 	if (p_fs->dev_ejected)
@@ -3164,7 +3164,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 
 		i_size_write(inode, info.Size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
-		set_nlink(inode, info.NumSubdirs);
+		set_nlink(inode, info.num_subdirs);
 	} else if (info.attr & ATTR_SYMLINK) { /* symbolic link */
 		inode->i_generation |= 1;
 		inode->i_mode = exfat_make_mode(sbi, info.attr, 0777);
@@ -3664,7 +3664,7 @@ static int exfat_read_root(struct inode *inode)
 	inode->i_mtime = curtime;
 	inode->i_atime = curtime;
 	inode->i_ctime = curtime;
-	set_nlink(inode, info.NumSubdirs + 2);
+	set_nlink(inode, info.num_subdirs + 2);
 
 	return 0;
 }
-- 
2.17.1

