Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2CE158293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgBJSgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:36:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39846 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJSgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:36:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so3161860plp.6;
        Mon, 10 Feb 2020 10:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xIHWghuq57bNZQmkoa9sD64bgutKszdEWxhIC/P1U/8=;
        b=UBg/E6LEDfYoa2axXFcjSeSEBJyNWs9pyzktqFLalzYKw5filjmv9k7urADelFC49S
         UozMdhHPakXzhfo5bc4e9oSPcDXjSpy50Z0xz6O1O3bxz6c2sj72wVfaXWl+v/AmhOFi
         fKE2LAS4Tz7Iqw6Ir8ZdzziKCYwW9Pr64pkk4KjJRZIGmEGnd0IDiQMlWnLa/wwYAPEU
         eWGku+TNHVgOJJFBq+v4g5SvjHHDBJR4iJVclwY9nvBgfY2wt+8HlSeoKbr4S7mypcnA
         7orVDLtHAt6pSah0G1AM4yYxakSeYierbhOFGE/Svp9S+PzOqrkx/yC1VQWWrD/M/7JF
         CbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xIHWghuq57bNZQmkoa9sD64bgutKszdEWxhIC/P1U/8=;
        b=aI1efSkijaFj6o8EoF0UmOrXu4QLbwpxqsiM2nLL0EWHsMA7sseH2os+y6xNgm0zB4
         QNbo9KcK8taFDir3OpGWcwXF4maFfR/IGpAslzkg3IqoIJkdGgiFS1OMUzjDlrAgRPCY
         78N6nLXBo7PB24c+3gDQKiDKX6Qve/92vVTVv26uYnU2HvQH440aiPvmE8FUNfobk2k1
         /3k+0ttJWomVzK3qkMH1Cu+PKAC5/bHoDo8tqkrFBtuEkTeMfWUA/65o82x91KaSx3pl
         /ZZIdlYgFT9w52ZfHluJz1b5a7vQGkSb5hS9uQIJP20layOGsuOgq138Oz8qaSy36hTG
         rquQ==
X-Gm-Message-State: APjAAAUHgW5i39TPRyyd0s099RHIYP0I5CQRCdzLfsDwiz+FpTOLGzh5
        28C9H3Q6YIFSZp7U3quhQnc=
X-Google-Smtp-Source: APXvYqzjAHJVrtBuqvTIav0VcPlZjtwEefaqhO0qMC5uO7X6Dtv8H90x3gmxu53scY8wMv0NRcVw1w==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr13817768ple.95.1581359809336;
        Mon, 10 Feb 2020 10:36:49 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:36:48 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 04/19] staging: exfat: Rename variable 'Hour' to 'hour'
Date:   Tue, 11 Feb 2020 00:05:43 +0530
Message-Id: <20200210183558.11836-5-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "Hour" to "hour"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 49e9390b4372..4ec4660e3a4d 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -225,7 +225,7 @@ struct date_time_t {
 	u16      year;
 	u16      month;
 	u16      day;
-	u16      Hour;
+	u16      hour;
 	u16      Minute;
 	u16      Second;
 	u16      MilliSecond;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 020529228fdd..41e4fb8b697f 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -60,7 +60,7 @@ static void exfat_write_super(struct super_block *sb);
 static void exfat_time_fat2unix(struct timespec64 *ts, struct date_time_t *tp)
 {
 	ts->tv_sec = mktime64(tp->year + 1980, tp->month + 1, tp->day,
-			      tp->Hour, tp->Minute, tp->Second);
+			      tp->hour, tp->Minute, tp->Second);
 
 	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
 }
@@ -77,7 +77,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		tp->MilliSecond = 0;
 		tp->Second	= 0;
 		tp->Minute	= 0;
-		tp->Hour	= 0;
+		tp->hour	= 0;
 		tp->day		= 1;
 		tp->month	= 1;
 		tp->year	= 0;
@@ -88,7 +88,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		tp->MilliSecond = 999;
 		tp->Second	= 59;
 		tp->Minute	= 59;
-		tp->Hour	= 23;
+		tp->hour	= 23;
 		tp->day		= 31;
 		tp->month	= 12;
 		tp->year	= 127;
@@ -98,7 +98,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	tp->MilliSecond = ts->tv_nsec / NSEC_PER_MSEC;
 	tp->Second	= tm.tm_sec;
 	tp->Minute	= tm.tm_min;
-	tp->Hour	= tm.tm_hour;
+	tp->hour	= tm.tm_hour;
 	tp->day		= tm.tm_mday;
 	tp->month	= tm.tm_mon + 1;
 	tp->year	= tm.tm_year + 1900 - 1980;
@@ -1508,7 +1508,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->CreateTimestamp.year = tm.year;
 	info->CreateTimestamp.month = tm.mon;
 	info->CreateTimestamp.day = tm.day;
-	info->CreateTimestamp.Hour = tm.hour;
+	info->CreateTimestamp.hour = tm.hour;
 	info->CreateTimestamp.Minute = tm.min;
 	info->CreateTimestamp.Second = tm.sec;
 	info->CreateTimestamp.MilliSecond = 0;
@@ -1517,7 +1517,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->ModifyTimestamp.year = tm.year;
 	info->ModifyTimestamp.month = tm.mon;
 	info->ModifyTimestamp.day = tm.day;
-	info->ModifyTimestamp.Hour = tm.hour;
+	info->ModifyTimestamp.hour = tm.hour;
 	info->ModifyTimestamp.Minute = tm.min;
 	info->ModifyTimestamp.Second = tm.sec;
 	info->ModifyTimestamp.MilliSecond = 0;
@@ -1607,7 +1607,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	/* set FILE_INFO structure using the acquired struct dentry_t */
 	tm.sec  = info->CreateTimestamp.Second;
 	tm.min  = info->CreateTimestamp.Minute;
-	tm.hour = info->CreateTimestamp.Hour;
+	tm.hour = info->CreateTimestamp.hour;
 	tm.day  = info->CreateTimestamp.day;
 	tm.mon  = info->CreateTimestamp.month;
 	tm.year = info->CreateTimestamp.year;
@@ -1615,7 +1615,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 
 	tm.sec  = info->ModifyTimestamp.Second;
 	tm.min  = info->ModifyTimestamp.Minute;
-	tm.hour = info->ModifyTimestamp.Hour;
+	tm.hour = info->ModifyTimestamp.hour;
 	tm.day  = info->ModifyTimestamp.day;
 	tm.mon  = info->ModifyTimestamp.month;
 	tm.year = info->ModifyTimestamp.year;
@@ -1925,7 +1925,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.year = tm.year;
 			dir_entry->CreateTimestamp.month = tm.mon;
 			dir_entry->CreateTimestamp.day = tm.day;
-			dir_entry->CreateTimestamp.Hour = tm.hour;
+			dir_entry->CreateTimestamp.hour = tm.hour;
 			dir_entry->CreateTimestamp.Minute = tm.min;
 			dir_entry->CreateTimestamp.Second = tm.sec;
 			dir_entry->CreateTimestamp.MilliSecond = 0;
@@ -1934,7 +1934,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->ModifyTimestamp.year = tm.year;
 			dir_entry->ModifyTimestamp.month = tm.mon;
 			dir_entry->ModifyTimestamp.day = tm.day;
-			dir_entry->ModifyTimestamp.Hour = tm.hour;
+			dir_entry->ModifyTimestamp.hour = tm.hour;
 			dir_entry->ModifyTimestamp.Minute = tm.min;
 			dir_entry->ModifyTimestamp.Second = tm.sec;
 			dir_entry->ModifyTimestamp.MilliSecond = 0;
-- 
2.17.1

