Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6A914A18F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgA0KO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:14:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35395 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgA0KO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:14:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so3588771plt.2;
        Mon, 27 Jan 2020 02:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tEM/K2p0OKdkhu4fa54pWtgam3l1wl2+9m+RBwz++1E=;
        b=rMaa7kMgO7Fm538GIgRuCebbJkPnIVc6oEjE0pcPBdYdwEgdsdAlJoXScyL6D2qlpf
         +R+o46/hPgtOusFqsM75WgM3nPT/TCmSL4moIr9G/a9jIHxX6agNdaQfEweZQteF5tul
         NMGhe84rh9fK8ERvr5AQwhkEEPjKBt+5Xc1Gf95JRroE2Zp9lBpmbg9moQhoUaTg6lud
         Kauus6Lcs1ZYHUBVjzzSeSxwlxEeptHUvEbvvzaq5j3O+oPYI6vBwRakht5hrX3tFm9v
         AAHRiA0Au3IWWZ3GFiOvgxzKc95pFeHt/0o+zfwSbjbnv12mCCpMMFm5xwnJ4aM9xxPQ
         J9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tEM/K2p0OKdkhu4fa54pWtgam3l1wl2+9m+RBwz++1E=;
        b=VPVn4oGANlbzBkEuv9bNQ1fVJDAN+NYum3K1RaYAA+WQLYWCclXFGsQtQBVjh8QDue
         yK+lgdoAxUrIzJXlQ/ehfrO/E3YGwqxG0n/qUP/9ZVOO2O37nui30qLU9dMWwDT4Dbtj
         tP+c7k5dyV48nSL852k2bejQ9H9jKIyEVb6t8sQ+ainf6th5xHI3ntUm24QbBFr/lszN
         rhP5eU5NEeqwrI1NLv9OnSaW2gmlirs/8wjbJHp5bSs4g3dvu+hC+i7DAdYld6seygJQ
         KDzzZZGV0dZzjS5GryrL934UhiwByHmMZrUf1R1wamOmktZYOBZOJ+0EvWML2EAfCZDm
         f/WQ==
X-Gm-Message-State: APjAAAVC25C0sJJYKbMu9LN6VdQb3MZzu5I1fVZ9/5WkVV6/tEo4Eq3a
        eIJ43IYRldPYJ4yd9h884c4=
X-Google-Smtp-Source: APXvYqzZsYzpHvcxRkFriY0hHks8yS7FJVowSraYfrsB9k9poiSSDzEpJ1YgV+l5IURSMDIPI0WHjA==
X-Received: by 2002:a17:902:a710:: with SMTP id w16mr17139298plq.43.1580120067559;
        Mon, 27 Jan 2020 02:14:27 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:14:27 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 01/22] staging: exfat: Rename variable "Year" to "year"
Date:   Mon, 27 Jan 2020 15:43:22 +0530
Message-Id: <20200127101343.20415-2-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "Year" to "year" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 51c665a924b7..c3c562fba133 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -222,7 +222,7 @@ static inline u16 get_row_index(u16 i)
 #endif
 
 struct date_time_t {
-	u16      Year;
+	u16      year;
 	u16      Month;
 	u16      Day;
 	u16      Hour;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 9f91853b189b..7534b86192aa 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -59,7 +59,7 @@ static void exfat_write_super(struct super_block *sb);
 /* Convert a FAT time/date pair to a UNIX date (seconds since 1 1 70). */
 static void exfat_time_fat2unix(struct timespec64 *ts, struct date_time_t *tp)
 {
-	ts->tv_sec = mktime64(tp->Year + 1980, tp->Month + 1, tp->Day,
+	ts->tv_sec = mktime64(tp->year + 1980, tp->Month + 1, tp->Day,
 			      tp->Hour, tp->Minute, tp->Second);
 
 	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
@@ -80,7 +80,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		tp->Hour	= 0;
 		tp->Day		= 1;
 		tp->Month	= 1;
-		tp->Year	= 0;
+		tp->year	= 0;
 		return;
 	}
 
@@ -91,7 +91,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		tp->Hour	= 23;
 		tp->Day		= 31;
 		tp->Month	= 12;
-		tp->Year	= 127;
+		tp->year	= 127;
 		return;
 	}
 
@@ -101,7 +101,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	tp->Hour	= tm.tm_hour;
 	tp->Day		= tm.tm_mday;
 	tp->Month	= tm.tm_mon + 1;
-	tp->Year	= tm.tm_year + 1900 - 1980;
+	tp->year	= tm.tm_year + 1900 - 1980;
 }
 
 struct timestamp_t *tm_current(struct timestamp_t *tp)
@@ -1505,7 +1505,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->Attr = p_fs->fs_func->get_entry_attr(ep);
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_CREATE);
-	info->CreateTimestamp.Year = tm.year;
+	info->CreateTimestamp.year = tm.year;
 	info->CreateTimestamp.Month = tm.mon;
 	info->CreateTimestamp.Day = tm.day;
 	info->CreateTimestamp.Hour = tm.hour;
@@ -1514,7 +1514,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->CreateTimestamp.MilliSecond = 0;
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
-	info->ModifyTimestamp.Year = tm.year;
+	info->ModifyTimestamp.year = tm.year;
 	info->ModifyTimestamp.Month = tm.mon;
 	info->ModifyTimestamp.Day = tm.day;
 	info->ModifyTimestamp.Hour = tm.hour;
@@ -1610,7 +1610,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.hour = info->CreateTimestamp.Hour;
 	tm.day  = info->CreateTimestamp.Day;
 	tm.mon  = info->CreateTimestamp.Month;
-	tm.year = info->CreateTimestamp.Year;
+	tm.year = info->CreateTimestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_CREATE);
 
 	tm.sec  = info->ModifyTimestamp.Second;
@@ -1618,7 +1618,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.hour = info->ModifyTimestamp.Hour;
 	tm.day  = info->ModifyTimestamp.Day;
 	tm.mon  = info->ModifyTimestamp.Month;
-	tm.year = info->ModifyTimestamp.Year;
+	tm.year = info->ModifyTimestamp.year;
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_MODIFY);
 
 	p_fs->fs_func->set_entry_size(ep2, info->Size);
@@ -1925,7 +1925,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->Attr = fs_func->get_entry_attr(ep);
 
 			fs_func->get_entry_time(ep, &tm, TM_CREATE);
-			dir_entry->CreateTimestamp.Year = tm.year;
+			dir_entry->CreateTimestamp.year = tm.year;
 			dir_entry->CreateTimestamp.Month = tm.mon;
 			dir_entry->CreateTimestamp.Day = tm.day;
 			dir_entry->CreateTimestamp.Hour = tm.hour;
@@ -1934,7 +1934,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.MilliSecond = 0;
 
 			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
-			dir_entry->ModifyTimestamp.Year = tm.year;
+			dir_entry->ModifyTimestamp.year = tm.year;
 			dir_entry->ModifyTimestamp.Month = tm.mon;
 			dir_entry->ModifyTimestamp.Day = tm.day;
 			dir_entry->ModifyTimestamp.Hour = tm.hour;
-- 
2.17.1

