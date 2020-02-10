Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA41158291
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBJSgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:36:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJSgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:36:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so4125380pfn.4;
        Mon, 10 Feb 2020 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c//RmWOQHmcnQyvYy0OmNb7DttbpdOpIuQrp7gtjB+4=;
        b=D2QQ383CR7PbO1uCwe1WPGKFybHlP9w3qbZt6pyRqX/xxPCWdUQOUuIMdgx0F88Edk
         uELFeAIIijVNHCWnjhbX2VUUh1GGrSF+z3RSGvXk2fUtcoHg04MNGRRdDoZWHk2b5rxt
         PXLrXyvEyqFei86t9Cs+jmj092mCfB7yZO9GPF3mCftsvDZaHNf0EhARIp4XxYkzOJ6l
         fmCHbzVtqgAAYcGK9DHf4DLC4zTr45MYenfXxZdOW0WhuLGa7Zimrcy0GdJdd4FYNc73
         AvbOVHp0CUpMp5Rj4PIZtn0uziS+AQ4xxUozah4P1cblEP09ivJtq/+lFY3iTbDsG7IE
         rURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c//RmWOQHmcnQyvYy0OmNb7DttbpdOpIuQrp7gtjB+4=;
        b=ABD9DGQ2rcmEboWR9FnL/Dr2bds6Nnn0v+Ei5QA7sBEbIwbqRTK0BIbUO+lm8ip57n
         yOT69Qi4vqNUzy3tNuZCPBznH2c4eH4OuXhzYgwiV2tQ+A9qAABwvz58U1f24R0EatAY
         ryLFG7M/kvswx8WCCEw6kyJDsDFwyDyFTssZFMQ3BeH+wuL272GNYR3NnjEWqTqwnhaR
         DBKuCyolqp9pt59l2t78ao0hmj9AOxKly/OTol7ggDQiw76yHh9dHVQOlXZYqaIuygIy
         jRsC7XBVyGLmDedBtfzV5vCIBJZHmVlKeKtSBNf+QhJ/X3PZrt4bAveKi+IXerr02rXb
         aANQ==
X-Gm-Message-State: APjAAAWjg1JAK15WScOof9N8rDDfqmqtVGKNxU6HCEU/eTZS1PZuRtm8
        dr6KzvgFc1khegKBHFIw21I=
X-Google-Smtp-Source: APXvYqwDggDQLl1CSjWYXzundz2w08oXgKLTZgrjhrxATU8RpWu0+d5wAmONatbuxEQ6jmWKagsRlQ==
X-Received: by 2002:a62:1cd6:: with SMTP id c205mr2341558pfc.179.1581359803997;
        Mon, 10 Feb 2020 10:36:43 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:36:43 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 03/19] staging: exfat: Rename variable 'Day' to 'day'
Date:   Tue, 11 Feb 2020 00:05:42 +0530
Message-Id: <20200210183558.11836-4-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "Day" to "day"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index ae7f8e035a71..49e9390b4372 100644
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
index dfc7b545f67a..020529228fdd 100644
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
 	exfat_get_entry_time(ep, &tm, TM_CREATE);
 	info->CreateTimestamp.year = tm.year;
 	info->CreateTimestamp.month = tm.mon;
-	info->CreateTimestamp.Day = tm.day;
+	info->CreateTimestamp.day = tm.day;
 	info->CreateTimestamp.Hour = tm.hour;
 	info->CreateTimestamp.Minute = tm.min;
 	info->CreateTimestamp.Second = tm.sec;
@@ -1516,7 +1516,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	exfat_get_entry_time(ep, &tm, TM_MODIFY);
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
 	exfat_set_entry_time(ep, &tm, TM_CREATE);
@@ -1616,7 +1616,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.sec  = info->ModifyTimestamp.Second;
 	tm.min  = info->ModifyTimestamp.Minute;
 	tm.hour = info->ModifyTimestamp.Hour;
-	tm.day  = info->ModifyTimestamp.Day;
+	tm.day  = info->ModifyTimestamp.day;
 	tm.mon  = info->ModifyTimestamp.month;
 	tm.year = info->ModifyTimestamp.year;
 	exfat_set_entry_time(ep, &tm, TM_MODIFY);
@@ -1924,7 +1924,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			exfat_get_entry_time(ep, &tm, TM_CREATE);
 			dir_entry->CreateTimestamp.year = tm.year;
 			dir_entry->CreateTimestamp.month = tm.mon;
-			dir_entry->CreateTimestamp.Day = tm.day;
+			dir_entry->CreateTimestamp.day = tm.day;
 			dir_entry->CreateTimestamp.Hour = tm.hour;
 			dir_entry->CreateTimestamp.Minute = tm.min;
 			dir_entry->CreateTimestamp.Second = tm.sec;
@@ -1933,7 +1933,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			exfat_get_entry_time(ep, &tm, TM_MODIFY);
 			dir_entry->ModifyTimestamp.year = tm.year;
 			dir_entry->ModifyTimestamp.month = tm.mon;
-			dir_entry->ModifyTimestamp.Day = tm.day;
+			dir_entry->ModifyTimestamp.day = tm.day;
 			dir_entry->ModifyTimestamp.Hour = tm.hour;
 			dir_entry->ModifyTimestamp.Minute = tm.min;
 			dir_entry->ModifyTimestamp.Second = tm.sec;
-- 
2.17.1

