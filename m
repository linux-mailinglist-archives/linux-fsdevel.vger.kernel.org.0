Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787591582BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgBJSh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38207 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgBJShz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so4127687pfc.5;
        Mon, 10 Feb 2020 10:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3LgDBSCZjxBjgZamIyJB6leQqXfm964yJ7D7RtAIfR8=;
        b=IwNu7+TgWWZ98ABg9NwC6VV5hBvLDRdVtxpanMXSFgJunDdCvMzsf1zql6r4HhcOa/
         AT2z7+MmQwR/YKfKLFa9aPT9B/d401F2RGckLnXeOtDRFtZPaNGGK8xHteOOurJdUsG4
         nlxr8Qn8GqBdkBvnL8+0wxKNQICviJNiJ25fa2+rX/sYsrs23E4NodEp6gxSwK9WgJiu
         L2+yHKwBW1HT1zXaCSv5ATjtO8PwWzCSlXXM7sQcLYSTjX454qbPDs5Du3Z/iXs+q/i2
         Ud74k/tRGlsaELe5FnT83G7zF5G4oDuNFH/KCGhAnKy5jt7nbiEAFDozGhVtwXVoDJQ7
         NgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3LgDBSCZjxBjgZamIyJB6leQqXfm964yJ7D7RtAIfR8=;
        b=D2cJ0wt+B+xVgMntDTsFxN38nhIw4JnBqUtlItRQnAyzLnC4lbgVQ2p99B3rNbubGp
         vE5HT0caCZQD57+RIXnNZysfI3CH0U37BJ4ppkZWxdGMALNPosD84IysqEsdqNS4dzd8
         76HcmnTn8GC0oZezazAoRYeCdnlDAiAZR2qf7M1/VIJgh+wpw8RaaT86I9ZimjXlIA4T
         Zrd3ajOAZifzY/is2k0fjokOqWWz1taRppyJaT2H1p6fgSSKrurLTa+kfQRAvSwvu+sI
         Ntx4s52LXCaq6SZDZLbt3FZh8QVxf+xOj968E7BNZjGhClkk7p93mu/490tz51fJy3dT
         N7vA==
X-Gm-Message-State: APjAAAXxvyAtiTHqh3+nNbuvBdTRekMVGF6oBrED03J8HZdGr2XPO3KV
        Y8DXuuP57JaqMk2G5GIO2hM=
X-Google-Smtp-Source: APXvYqxg/SHoV5oiAZaQA/DiyJwSO6NZNGQen5dGG6yrHhH7/51y6ow4KqGN3wNJqTbe62glhkgiwg==
X-Received: by 2002:a62:7945:: with SMTP id u66mr2428961pfc.82.1581359875129;
        Mon, 10 Feb 2020 10:37:55 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:54 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 17/19] staging: exfat: Rename variable 'CreateTimestamp' to 'create_timestamp'
Date:   Tue, 11 Feb 2020 00:05:56 +0530
Message-Id: <20200210183558.11836-18-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "CreateTimestamp" to
"create_timestamp"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 46 ++++++++++++++---------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 90153175bbb9..c99652ab13f1 100644
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
index 365e9e719bcf..ed862c3e3e10 100644
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
 	info->attr = exfat_get_entry_attr(ep);
 
 	exfat_get_entry_time(ep, &tm, TM_CREATE);
-	info->CreateTimestamp.year = tm.year;
-	info->CreateTimestamp.month = tm.mon;
-	info->CreateTimestamp.day = tm.day;
-	info->CreateTimestamp.hour = tm.hour;
-	info->CreateTimestamp.minute = tm.min;
-	info->CreateTimestamp.second = tm.sec;
-	info->CreateTimestamp.millisecond = 0;
+	info->create_timestamp.year = tm.year;
+	info->create_timestamp.month = tm.mon;
+	info->create_timestamp.day = tm.day;
+	info->create_timestamp.hour = tm.hour;
+	info->create_timestamp.minute = tm.min;
+	info->create_timestamp.second = tm.sec;
+	info->create_timestamp.millisecond = 0;
 
 	exfat_get_entry_time(ep, &tm, TM_MODIFY);
 	info->ModifyTimestamp.year = tm.year;
@@ -1605,12 +1605,12 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	exfat_set_entry_attr(ep, info->attr);
 
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
 	exfat_set_entry_time(ep, &tm, TM_CREATE);
 
 	tm.sec  = info->ModifyTimestamp.second;
@@ -1922,13 +1922,13 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->attr = exfat_get_entry_attr(ep);
 
 			exfat_get_entry_time(ep, &tm, TM_CREATE);
-			dir_entry->CreateTimestamp.year = tm.year;
-			dir_entry->CreateTimestamp.month = tm.mon;
-			dir_entry->CreateTimestamp.day = tm.day;
-			dir_entry->CreateTimestamp.hour = tm.hour;
-			dir_entry->CreateTimestamp.minute = tm.min;
-			dir_entry->CreateTimestamp.second = tm.sec;
-			dir_entry->CreateTimestamp.millisecond = 0;
+			dir_entry->create_timestamp.year = tm.year;
+			dir_entry->create_timestamp.month = tm.mon;
+			dir_entry->create_timestamp.day = tm.day;
+			dir_entry->create_timestamp.hour = tm.hour;
+			dir_entry->create_timestamp.minute = tm.min;
+			dir_entry->create_timestamp.second = tm.sec;
+			dir_entry->create_timestamp.millisecond = 0;
 
 			exfat_get_entry_time(ep, &tm, TM_MODIFY);
 			dir_entry->ModifyTimestamp.year = tm.year;
@@ -3189,7 +3189,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 				& ~((loff_t)p_fs->cluster_size - 1)) >> 9;
 
 	exfat_time_fat2unix(&inode->i_mtime, &info.ModifyTimestamp);
-	exfat_time_fat2unix(&inode->i_ctime, &info.CreateTimestamp);
+	exfat_time_fat2unix(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_fat2unix(&inode->i_atime, &info.AccessTimestamp);
 
 	return 0;
@@ -3260,7 +3260,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	info.Size = i_size_read(inode);
 
 	exfat_time_unix2fat(&inode->i_mtime, &info.ModifyTimestamp);
-	exfat_time_unix2fat(&inode->i_ctime, &info.CreateTimestamp);
+	exfat_time_unix2fat(&inode->i_ctime, &info.create_timestamp);
 	exfat_time_unix2fat(&inode->i_atime, &info.AccessTimestamp);
 
 	ffsWriteStat(inode, &info);
-- 
2.17.1

