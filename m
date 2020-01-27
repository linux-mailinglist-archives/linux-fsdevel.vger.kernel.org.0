Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8898B14A1CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgA0KQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:16:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34333 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgA0KQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:16:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so4706066pfc.1;
        Mon, 27 Jan 2020 02:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RAuZJZqC2SGkCShIla0AvvSszot+qHX00yLZwza0yk4=;
        b=vEfiaWQmCdtZdGxBTp/pxFIot0PLcVqbhRRWpByRfBqnFaR/WX0ue8E4RIaLLgV36+
         shCJQG128WsoN6SwDlpU6xsmsS7MFBz7NasXeO7nN9uUExHLtu1GjONZi0Atu8h0fIBK
         G6mfMq2ZQSbLz/n0KVqtDEcicFLHA4lLmD3pu/SxUikZ34GZPY2sua1bDPjJCKezGsZ4
         67CwtNOdKjdtl1Emr4vQrIqJecn7eybE+quuHrkSNR7MZY8faivJ2iTkn4JE7R8RD4Vm
         gRpRjFQkxIWVxR5WzfBHmkqBd6h0ZagU1ayRBYLj9sadiFPAWhLnilP+AAvw+HihjDDV
         iwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RAuZJZqC2SGkCShIla0AvvSszot+qHX00yLZwza0yk4=;
        b=G4QW61vXpyvgdnMQXFMOrhJ2i9ZA8OAcCc8mhblBZdqmx4xklxr/mnbVzQ1XHF0cQy
         CHhNLx+Wfg1/EDacf6udSub/eIB3JzCQAswxkTnc4GL7Afg1/DSglR/sg6UEDclY3QPL
         VvdsZ1lNhv55fqts4sSXH1q0ZKMrMopAIv1dgJFw2ct2xCO2MVZDK4r2wGPOcnqB6JmF
         /QUQ7Jf8hO9mZ3rmhrVVmihGRrmYffaPRzXvxJuc+xS0VVF/rK7owK5hUdRTa9hEv4FC
         kMiHJOwwCPjVV2cUuTTkkzFwn/xoIHSxyn2bWv/qQRY3dj71JyPyyEc1x2piZE5DxFpG
         W53Q==
X-Gm-Message-State: APjAAAWh9wI8eGPz5NgTGsXKur3WZI6gJc4uEoAyIAW5J1QN2L9VTfkE
        FrUI6xkznAk06l5Qd4i4wLY=
X-Google-Smtp-Source: APXvYqzOVJgs6ZnwvWmfrefHgl9aA6HPZYD1L31qFPIOKDlMVTzOu30DvyMdi5Vaek1b/0/9GrjvUg==
X-Received: by 2002:aa7:9556:: with SMTP id w22mr15592005pfq.198.1580120160623;
        Mon, 27 Jan 2020 02:16:00 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:59 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 20/22] staging: exfat: Rename variabel "CreateTimestamp" to "create_timestamp"
Date:   Mon, 27 Jan 2020 15:43:41 +0530
Message-Id: <20200127101343.20415-21-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurreces of "CreateTimestamp" to "create_timestamp" in
exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 46 ++++++++++++++---------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 2e07cb6b694a..9b3b4a6f586b 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -278,7 +278,7 @@ struct dir_entry_t {
 	u32 attr;
 	u64 Size;
 	u32 num_subdirs;
-	struct date_time_t CreateTimestamp;
+	struct date_time_t create_timestamp;
 	struct date_time_t ModifyTimestamp;
 	struct date_time_t AccessTimestamp;
 };
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 2fe59bdabb56..4279fb309f9e 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1458,7 +1458,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 		if ((fid->dir.dir == p_fs->root_dir) &&
 		    (fid->entry == -1)) {
 			info->attr = ATTR_SUBDIR;
-			memset((char *)&info->CreateTimestamp, 0,
+			memset((char *)&info->create_timestamp, 0,
 			       sizeof(struct date_time_t));
 			memset((char *)&info->ModifyTimestamp, 0,
 			       sizeof(struct date_time_t));
@@ -1505,13 +1505,13 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->attr = p_fs->fs_func->get_entry_attr(ep);
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_CREATE);
-	info->CreateTimestamp.year = tm.year;
-	info->CreateTimestamp.month = tm.mon;
-	info->CreateTimestamp.day = tm.day;
-	info->CreateTimestamp.hour = tm.hour;
-	info->CreateTimestamp.minute = tm.min;
-	info->CreateTimestamp.second = tm.sec;
-	info->CreateTimestamp.milli_second = 0;
+	info->create_timestamp.year = tm.year;
+	info->create_timestamp.month = tm.mon;
+	info->create_timestamp.day = tm.day;
+	info->create_timestamp.hour = tm.hour;
+	info->create_timestamp.minute = tm.min;
+	info->create_timestamp.second = tm.sec;
+	info->create_timestamp.milli_second = 0;
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 	info->ModifyTimestamp.year = tm.year;
@@ -1605,12 +1605,12 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	p_fs->fs_func->set_entry_attr(ep, info->attr);
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
-	tm.sec  = info->CreateTimestamp.second;
-	tm.min  = info->CreateTimestamp.minute;
-	tm.hour = info->CreateTimestamp.hour;
-	tm.day  = info->CreateTimestamp.day;
-	tm.mon  = info->CreateTimestamp.month;
-	tm.year = info->CreateTimestamp.year;
+	tm.sec  = info->create_timestamp.second;
+	tm.min  = info->create_timestamp.minute;
+	tm.hour = info->create_timestamp.hour;
+	tm.day  = info->create_timestamp.day;
+	tm.mon  = info->create_timestamp.month;
+	tm.year = info->create_timestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_CREATE);
 
 	tm.sec  = info->ModifyTimestamp.second;
@@ -1925,13 +1925,13 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->attr = fs_func->get_entry_attr(ep);
 
 			fs_func->get_entry_time(ep, &tm, TM_CREATE);
-			dir_entry->CreateTimestamp.year = tm.year;
-			dir_entry->CreateTimestamp.month = tm.mon;
-			dir_entry->CreateTimestamp.day = tm.day;
-			dir_entry->CreateTimestamp.hour = tm.hour;
-			dir_entry->CreateTimestamp.minute = tm.min;
-			dir_entry->CreateTimestamp.second = tm.sec;
-			dir_entry->CreateTimestamp.milli_second = 0;
+			dir_entry->create_timestamp.year = tm.year;
+			dir_entry->create_timestamp.month = tm.mon;
+			dir_entry->create_timestamp.day = tm.day;
+			dir_entry->create_timestamp.hour = tm.hour;
+			dir_entry->create_timestamp.minute = tm.min;
+			dir_entry->create_timestamp.second = tm.sec;
+			dir_entry->create_timestamp.milli_second = 0;
 
 			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 			dir_entry->ModifyTimestamp.year = tm.year;
@@ -3192,7 +3192,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 				& ~((loff_t)p_fs->cluster_size - 1)) >> 9;
 
 	exfat_time_fat2unix(&inode->i_mtime, &info.ModifyTimestamp);
-	exfat_time_fat2unix(&inode->i_ctime, &info.CreateTimestamp);
+	exfat_time_fat2unix(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_fat2unix(&inode->i_atime, &info.AccessTimestamp);
 
 	return 0;
@@ -3263,7 +3263,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	info.Size = i_size_read(inode);
 
 	exfat_time_unix2fat(&inode->i_mtime, &info.ModifyTimestamp);
-	exfat_time_unix2fat(&inode->i_ctime, &info.CreateTimestamp);
+	exfat_time_unix2fat(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_unix2fat(&inode->i_atime, &info.AccessTimestamp);
 
 	ffsWriteStat(inode, &info);
-- 
2.17.1

