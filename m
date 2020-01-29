Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56514CEF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgA2RAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 12:00:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39527 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA2RAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:00:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id 84so2608725pfy.6;
        Wed, 29 Jan 2020 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vtyE0flC1NExXQRwvL6x01fJu7ladl8XRvt0p+vqVW4=;
        b=mRe/SNWTHEMc3ycS/VpZKKgeTftQCulHRWNKZXee3kdyHlkvZ2H5lKYKU9MnB7ATJs
         S75oPlHBtjtLnb7WGSvxUehVnnjbt2c6WaRCVtThtqEPovGd/1Z0PSteSGf8jT0kjCk/
         EkqOFuVHosTeBcV/qih42nTm/ACox+vTiFSwFeuHAc0yb9hBXjV3f2hjFr3EBvWJRasQ
         MhjVZXdpj8G+aWdEwuB7JFkRCRaVApJrQXd3UBhX1qo3kiQIPRJf35SHgSF5QQ4m4KWU
         n0iB8+MYgkTMYuB62VjCQMZMMyhsh2z7HFHTsHY7htUJRYcnfnrQXfEywkV1yEhEwgvm
         M/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vtyE0flC1NExXQRwvL6x01fJu7ladl8XRvt0p+vqVW4=;
        b=U0y/jSMz0hL+bAWvb4mWM5qPsdGOf9w/V5DrJ8ITLTFNn4aAZTeBA01HC0iJUjri9H
         3TzT3ymRM2mVYMHe0EUxa7e9wy/iLqstkRmBb5lBH5pxGtrHk054ERy87ozJFSfIXicb
         Cihpq1S7ce6Jg1sBIGK5mlXE4A1F9dvsBaRBjnfLzSplnUcOqChhgtao2zH+6lmy3AHM
         LY9cky2eK5Qisq0TUNuHXLdmbttNeRD7h/AeshqxfK3NH514AVmJ/gMzloUSwBOAods/
         LhbbmOkwcalM4rz8pgqYLMcuLmJiajF7pl/VByhJ1hXogZYTby7NZimHDvl7RA2cHV5a
         /kPA==
X-Gm-Message-State: APjAAAU0Agr3u38OaBOZ6ZCrnotis3wsp9IkwwQZy2qbf0XkwNLz8iSN
        3euPJL/ZjBYmxRAOit54hSc=
X-Google-Smtp-Source: APXvYqxu4CqdBLYEM+i1048qcwmGC2eH2teJ8jMRBiEtEIha8lY6a/UkpBDtayyVJxQK9YxI+UhhyQ==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr507975pff.240.1580317232615;
        Wed, 29 Jan 2020 09:00:32 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 09:00:32 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 18/19] staging: exfat: Rename variable 'ModifyTimestamp' to 'modify_timestamp'
Date:   Wed, 29 Jan 2020 22:28:31 +0530
Message-Id: <20200129165832.10574-19-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of "ModifyTimestamp" to "modify_timestamp"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 46 ++++++++++++++---------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 58db8ea700f8..323048cd1903 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -279,7 +279,7 @@ struct dir_entry_t {
 	u64 Size;
 	u32 num_subdirs;
 	struct date_time_t create_timestamp;
-	struct date_time_t ModifyTimestamp;
+	struct date_time_t modify_timestamp;
 	struct date_time_t AccessTimestamp;
 };
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 694acfd8c52a..92670913971f 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1460,7 +1460,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			info->attr = ATTR_SUBDIR;
 			memset((char *)&info->create_timestamp, 0,
 			       sizeof(struct date_time_t));
-			memset((char *)&info->ModifyTimestamp, 0,
+			memset((char *)&info->modify_timestamp, 0,
 			       sizeof(struct date_time_t));
 			memset((char *)&info->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
@@ -1514,13 +1514,13 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->create_timestamp.millisecond = 0;
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
-	info->ModifyTimestamp.year = tm.year;
-	info->ModifyTimestamp.month = tm.mon;
-	info->ModifyTimestamp.day = tm.day;
-	info->ModifyTimestamp.hour = tm.hour;
-	info->ModifyTimestamp.minute = tm.min;
-	info->ModifyTimestamp.second = tm.sec;
-	info->ModifyTimestamp.millisecond = 0;
+	info->modify_timestamp.year = tm.year;
+	info->modify_timestamp.month = tm.mon;
+	info->modify_timestamp.day = tm.day;
+	info->modify_timestamp.hour = tm.hour;
+	info->modify_timestamp.minute = tm.min;
+	info->modify_timestamp.second = tm.sec;
+	info->modify_timestamp.millisecond = 0;
 
 	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
 
@@ -1613,12 +1613,12 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.year = info->create_timestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_CREATE);
 
-	tm.sec  = info->ModifyTimestamp.second;
-	tm.min  = info->ModifyTimestamp.minute;
-	tm.hour = info->ModifyTimestamp.hour;
-	tm.day  = info->ModifyTimestamp.day;
-	tm.mon  = info->ModifyTimestamp.month;
-	tm.year = info->ModifyTimestamp.year;
+	tm.sec  = info->modify_timestamp.second;
+	tm.min  = info->modify_timestamp.minute;
+	tm.hour = info->modify_timestamp.hour;
+	tm.day  = info->modify_timestamp.day;
+	tm.mon  = info->modify_timestamp.month;
+	tm.year = info->modify_timestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_MODIFY);
 
 	p_fs->fs_func->set_entry_size(ep2, info->Size);
@@ -1934,13 +1934,13 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->create_timestamp.millisecond = 0;
 
 			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
-			dir_entry->ModifyTimestamp.year = tm.year;
-			dir_entry->ModifyTimestamp.month = tm.mon;
-			dir_entry->ModifyTimestamp.day = tm.day;
-			dir_entry->ModifyTimestamp.hour = tm.hour;
-			dir_entry->ModifyTimestamp.minute = tm.min;
-			dir_entry->ModifyTimestamp.second = tm.sec;
-			dir_entry->ModifyTimestamp.millisecond = 0;
+			dir_entry->modify_timestamp.year = tm.year;
+			dir_entry->modify_timestamp.month = tm.mon;
+			dir_entry->modify_timestamp.day = tm.day;
+			dir_entry->modify_timestamp.hour = tm.hour;
+			dir_entry->modify_timestamp.minute = tm.min;
+			dir_entry->modify_timestamp.second = tm.sec;
+			dir_entry->modify_timestamp.millisecond = 0;
 
 			memset((char *)&dir_entry->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
@@ -3191,7 +3191,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 	inode->i_blocks = ((i_size_read(inode) + (p_fs->cluster_size - 1))
 				& ~((loff_t)p_fs->cluster_size - 1)) >> 9;
 
-	exfat_time_fat2unix(&inode->i_mtime, &info.ModifyTimestamp);
+	exfat_time_fat2unix(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_fat2unix(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_fat2unix(&inode->i_atime, &info.AccessTimestamp);
 
@@ -3262,7 +3262,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	info.attr = exfat_make_attr(inode);
 	info.Size = i_size_read(inode);
 
-	exfat_time_unix2fat(&inode->i_mtime, &info.ModifyTimestamp);
+	exfat_time_unix2fat(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_unix2fat(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_unix2fat(&inode->i_atime, &info.AccessTimestamp);
 
-- 
2.17.1

