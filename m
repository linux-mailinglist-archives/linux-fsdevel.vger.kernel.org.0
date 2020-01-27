Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1490414A191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgA0KOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:14:33 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40510 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgA0KOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:14:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so1513894pjb.5;
        Mon, 27 Jan 2020 02:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s531A7Z0Ik0oiSQOQqFpgF9IVErIBCQR/I11OaiKgqY=;
        b=TXsvh4YvCTMep5XW9sAfq33cQuGoR5HM1n+LuNq74Cyuw7pJaEFGLdyEzhZcjPSRCm
         AwJaj/opeQTTlirMJUqh2cdooQ/T9rF4bZ7H2C+5Z+uJKqiX7eDVcGUi83gqw42Qgcwx
         Goz/e4te25MkO6NgwaBKhCwLVsDpK1WVATymw6Xb50R/W9Uuv+vcf3nZyIcNCJnRKYHG
         SJwso4atQoy5IGB2qhuujFxVHxYpohu8vN4HZ4AqdyNj4G4UW4S3hTJKy94Cqt61LsdV
         VCwxFkc3MHWLB5XleMQ03jERP283gWofGgvH+0nCUWPNU1QUMfmq5xm+YgWJHULZb688
         zS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s531A7Z0Ik0oiSQOQqFpgF9IVErIBCQR/I11OaiKgqY=;
        b=ZvAiyFSiUJsy4bmV8Rd5sHMkouRcz/UQWfJj+bdZFE1OBiTwYoA+uVUXSCKMhhIKyF
         PFj65fmUnRhb8W4+nCauVGiQihhXnlVmAXUfuHDIUbBamKocWvZ9/kvfjrqMe7irNLOH
         MaIE1a/QyjbGGzFu0N0iV4fMDwXm0pjzlaRCOcn6RRwcx8OFnOopIBQNpRryjifSBN3g
         9Mwb2IsRVS4t0OvQyGirFgYTVrPszKp8QYkW/1VvckaUqkoCOzRUJSjOuE+5uDo+6Ec5
         PUBiS/h6AzWe2UOb2qij/bB2iU/DMCkGxTQSdCwjMIbFkYSDnBHOf82AXDWePQwEpnm2
         OMaw==
X-Gm-Message-State: APjAAAW4zeJjANdCcTVBJh6Og7dgiyO4W+lgHMujB2k+RSxi1CYo8BSC
        3D2lrOfpU01gKg8FZBIox5Q=
X-Google-Smtp-Source: APXvYqwku1zLa3MFJlsk1bct0Uc/qAkhHxLuCVvKZ1F+qlhgI6TJxoCA8eUcSpNFONXsxRBpmCxNkg==
X-Received: by 2002:a17:90a:5206:: with SMTP id v6mr13627170pjh.136.1580120072238;
        Mon, 27 Jan 2020 02:14:32 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:14:31 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 02/22] staging: exfat: Rename variable "Month" to "mont"h
Date:   Mon, 27 Jan 2020 15:43:23 +0530
Message-Id: <20200127101343.20415-3-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "Month" to "month" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c3c562fba133..95e27aed350d 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -223,7 +223,7 @@ static inline u16 get_row_index(u16 i)
 
 struct date_time_t {
 	u16      year;
-	u16      Month;
+	u16      month;
 	u16      Day;
 	u16      Hour;
 	u16      Minute;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 7534b86192aa..293d103a6b54 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -59,7 +59,7 @@ static void exfat_write_super(struct super_block *sb);
 /* Convert a FAT time/date pair to a UNIX date (seconds since 1 1 70). */
 static void exfat_time_fat2unix(struct timespec64 *ts, struct date_time_t *tp)
 {
-	ts->tv_sec = mktime64(tp->year + 1980, tp->Month + 1, tp->Day,
+	ts->tv_sec = mktime64(tp->year + 1980, tp->month + 1, tp->Day,
 			      tp->Hour, tp->Minute, tp->Second);
 
 	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
@@ -79,7 +79,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		tp->Minute	= 0;
 		tp->Hour	= 0;
 		tp->Day		= 1;
-		tp->Month	= 1;
+		tp->month	= 1;
 		tp->year	= 0;
 		return;
 	}
@@ -90,7 +90,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		tp->Minute	= 59;
 		tp->Hour	= 23;
 		tp->Day		= 31;
-		tp->Month	= 12;
+		tp->month	= 12;
 		tp->year	= 127;
 		return;
 	}
@@ -100,7 +100,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	tp->Minute	= tm.tm_min;
 	tp->Hour	= tm.tm_hour;
 	tp->Day		= tm.tm_mday;
-	tp->Month	= tm.tm_mon + 1;
+	tp->month	= tm.tm_mon + 1;
 	tp->year	= tm.tm_year + 1900 - 1980;
 }
 
@@ -1506,7 +1506,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_CREATE);
 	info->CreateTimestamp.year = tm.year;
-	info->CreateTimestamp.Month = tm.mon;
+	info->CreateTimestamp.month = tm.mon;
 	info->CreateTimestamp.Day = tm.day;
 	info->CreateTimestamp.Hour = tm.hour;
 	info->CreateTimestamp.Minute = tm.min;
@@ -1515,7 +1515,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 	info->ModifyTimestamp.year = tm.year;
-	info->ModifyTimestamp.Month = tm.mon;
+	info->ModifyTimestamp.month = tm.mon;
 	info->ModifyTimestamp.Day = tm.day;
 	info->ModifyTimestamp.Hour = tm.hour;
 	info->ModifyTimestamp.Minute = tm.min;
@@ -1609,7 +1609,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.min  = info->CreateTimestamp.Minute;
 	tm.hour = info->CreateTimestamp.Hour;
 	tm.day  = info->CreateTimestamp.Day;
-	tm.mon  = info->CreateTimestamp.Month;
+	tm.mon  = info->CreateTimestamp.month;
 	tm.year = info->CreateTimestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_CREATE);
 
@@ -1617,7 +1617,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.min  = info->ModifyTimestamp.Minute;
 	tm.hour = info->ModifyTimestamp.Hour;
 	tm.day  = info->ModifyTimestamp.Day;
-	tm.mon  = info->ModifyTimestamp.Month;
+	tm.mon  = info->ModifyTimestamp.month;
 	tm.year = info->ModifyTimestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_MODIFY);
 
@@ -1926,7 +1926,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 
 			fs_func->get_entry_time(ep, &tm, TM_CREATE);
 			dir_entry->CreateTimestamp.year = tm.year;
-			dir_entry->CreateTimestamp.Month = tm.mon;
+			dir_entry->CreateTimestamp.month = tm.mon;
 			dir_entry->CreateTimestamp.Day = tm.day;
 			dir_entry->CreateTimestamp.Hour = tm.hour;
 			dir_entry->CreateTimestamp.Minute = tm.min;
@@ -1935,7 +1935,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 
 			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 			dir_entry->ModifyTimestamp.year = tm.year;
-			dir_entry->ModifyTimestamp.Month = tm.mon;
+			dir_entry->ModifyTimestamp.month = tm.mon;
 			dir_entry->ModifyTimestamp.Day = tm.day;
 			dir_entry->ModifyTimestamp.Hour = tm.hour;
 			dir_entry->ModifyTimestamp.Minute = tm.min;
-- 
2.17.1

