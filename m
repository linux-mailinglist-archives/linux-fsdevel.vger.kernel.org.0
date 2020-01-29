Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6449914CEC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgA2Q7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:59:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40596 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgA2Q7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:59:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so61846pgt.7;
        Wed, 29 Jan 2020 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lEFEJXUhs5Ltc1UiIgPuUbFSBFCmSK3DJzmiGipDO1I=;
        b=XkNI+dJLr0nHCeuULHLiQ/4iIVi7SUlRw4qwe8eU3JBNRcKtcX0qU+8cZFDMLhe5Pi
         blhlvEPrZLmvxss1n1DKP4hPynKTBiCkqarwpqe2cdgHrIzQZyl4hHkZsSjeZs02/hB9
         LvQfZPmZpQvRRiYeIvjL7P8uK4HopxEUZXBnvkYFT5FzYnDr4KbsjidxmRha/UI999wr
         N+6Mr8We90km8hGmFLa+EyRX3pjJN72QZYg+cosAi+h8bqCCH9wuhgYPMMjM+XtubZj+
         hAgbJYYinWeROe2E4OnGClWBKm7Ta474KtkHdh/CaKwmsfRPSK5jJ6qfZXsUoX7LFiCi
         FT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lEFEJXUhs5Ltc1UiIgPuUbFSBFCmSK3DJzmiGipDO1I=;
        b=Zfp2/c0g8f8WVHJSMPiCP3v0PgcaXlbQ7V1viBS4PQbWHxI3fMgXpFvf8TBe3/wupQ
         VDqa4OwGSV3QY4v/eTATHRVMyP2Ua8gOXX5MDBLUfcYjADT4ublI1dBh5aYFLp+lA5Yi
         l34ltCONJNbvK8DfZfCuSz8J3qRNUnRrdONiCIrYvBMZjEW1a9a6rvF5oWtMAwIQwxHp
         s0s82/6jDdIEPy0W24RrZ+Y6qMuxFahTsAUTsDHysbnzNiGmoJDNTv0bkgjraoGn3eoQ
         SxVUxuPce0TO/WRRLka5gPsfwTgp54MxD/dquqNP5yCZR2TyMumE2kGDvNsdQa6/OWS1
         cZ6w==
X-Gm-Message-State: APjAAAXLRZpzCKA98WQ8wPU3naxLNxrSRXp8BHNeV0omVNsKZQiVyq3A
        TN1Tvs9HUqr+UNspgp+97aLsrmRSRTE=
X-Google-Smtp-Source: APXvYqwW3yNT0BVbWL1rygjcE2+2Gy1JVIxt5l8/68/WlKZyelGMsa9n3VaVbtxcTC23wV+nJ7R2VQ==
X-Received: by 2002:a63:eb15:: with SMTP id t21mr32617259pgh.365.1580317149498;
        Wed, 29 Jan 2020 08:59:09 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:59:08 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 03/19] staging: exfat: Rename variable 'Day' to 'day'
Date:   Wed, 29 Jan 2020 22:28:16 +0530
Message-Id: <20200129165832.10574-4-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurences of identifier "Day" to "day"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 95e27aed350d..4211148405c5 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -224,7 +224,7 @@ static inline u16 get_row_index(u16 i)
 struct date_time_t {
 	u16      year;
 	u16      month;
-	u16      Day;
+	u16      day;
 	u16      Hour;
 	u16      Minute;
 	u16      Second;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 293d103a6b54..b30f9517cfef 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -59,7 +59,7 @@ static void exfat_write_super(struct super_block *sb);
 /* Convert a FAT time/date pair to a UNIX date (seconds since 1 1 70). */
 static void exfat_time_fat2unix(struct timespec64 *ts, struct date_time_t *tp)
 {
-	ts->tv_sec = mktime64(tp->year + 1980, tp->month + 1, tp->Day,
+	ts->tv_sec = mktime64(tp->year + 1980, tp->month + 1, tp->day,
 			      tp->Hour, tp->Minute, tp->Second);
 
 	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
@@ -78,7 +78,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		tp->Second	= 0;
 		tp->Minute	= 0;
 		tp->Hour	= 0;
-		tp->Day		= 1;
+		tp->day		= 1;
 		tp->month	= 1;
 		tp->year	= 0;
 		return;
@@ -89,7 +89,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		tp->Second	= 59;
 		tp->Minute	= 59;
 		tp->Hour	= 23;
-		tp->Day		= 31;
+		tp->day		= 31;
 		tp->month	= 12;
 		tp->year	= 127;
 		return;
@@ -99,7 +99,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	tp->Second	= tm.tm_sec;
 	tp->Minute	= tm.tm_min;
 	tp->Hour	= tm.tm_hour;
-	tp->Day		= tm.tm_mday;
+	tp->day		= tm.tm_mday;
 	tp->month	= tm.tm_mon + 1;
 	tp->year	= tm.tm_year + 1900 - 1980;
 }
@@ -1507,7 +1507,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_CREATE);
 	info->CreateTimestamp.year = tm.year;
 	info->CreateTimestamp.month = tm.mon;
-	info->CreateTimestamp.Day = tm.day;
+	info->CreateTimestamp.day = tm.day;
 	info->CreateTimestamp.Hour = tm.hour;
 	info->CreateTimestamp.Minute = tm.min;
 	info->CreateTimestamp.Second = tm.sec;
@@ -1516,7 +1516,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 	info->ModifyTimestamp.year = tm.year;
 	info->ModifyTimestamp.month = tm.mon;
-	info->ModifyTimestamp.Day = tm.day;
+	info->ModifyTimestamp.day = tm.day;
 	info->ModifyTimestamp.Hour = tm.hour;
 	info->ModifyTimestamp.Minute = tm.min;
 	info->ModifyTimestamp.Second = tm.sec;
@@ -1608,7 +1608,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.sec  = info->CreateTimestamp.Second;
 	tm.min  = info->CreateTimestamp.Minute;
 	tm.hour = info->CreateTimestamp.Hour;
-	tm.day  = info->CreateTimestamp.Day;
+	tm.day  = info->CreateTimestamp.day;
 	tm.mon  = info->CreateTimestamp.month;
 	tm.year = info->CreateTimestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_CREATE);
@@ -1616,7 +1616,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.sec  = info->ModifyTimestamp.Second;
 	tm.min  = info->ModifyTimestamp.Minute;
 	tm.hour = info->ModifyTimestamp.Hour;
-	tm.day  = info->ModifyTimestamp.Day;
+	tm.day  = info->ModifyTimestamp.day;
 	tm.mon  = info->ModifyTimestamp.month;
 	tm.year = info->ModifyTimestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_MODIFY);
@@ -1927,7 +1927,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			fs_func->get_entry_time(ep, &tm, TM_CREATE);
 			dir_entry->CreateTimestamp.year = tm.year;
 			dir_entry->CreateTimestamp.month = tm.mon;
-			dir_entry->CreateTimestamp.Day = tm.day;
+			dir_entry->CreateTimestamp.day = tm.day;
 			dir_entry->CreateTimestamp.Hour = tm.hour;
 			dir_entry->CreateTimestamp.Minute = tm.min;
 			dir_entry->CreateTimestamp.Second = tm.sec;
@@ -1936,7 +1936,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 			dir_entry->ModifyTimestamp.year = tm.year;
 			dir_entry->ModifyTimestamp.month = tm.mon;
-			dir_entry->ModifyTimestamp.Day = tm.day;
+			dir_entry->ModifyTimestamp.day = tm.day;
 			dir_entry->ModifyTimestamp.Hour = tm.hour;
 			dir_entry->ModifyTimestamp.Minute = tm.min;
 			dir_entry->ModifyTimestamp.Second = tm.sec;
-- 
2.17.1

