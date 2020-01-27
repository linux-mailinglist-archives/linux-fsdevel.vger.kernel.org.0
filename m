Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7214A19B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgA0KOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:14:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37336 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgA0KOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:14:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so4702019pfn.4;
        Mon, 27 Jan 2020 02:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FgG2toYigAj1ktFJcq6epdxSs10JCAGQPLYrkydZSrU=;
        b=gsW2EdDAJ5J5MGSTPOP4tPFF/qVlbhVDDDkPTXMLCiFsf8MrpV1mYL0ryJqHmvxVj0
         G1oF8uX7wIdswrCIcn6NdtxXnrLDIaj9gry5actVTsbVGfX2HjWkHceqdwqvX4LI+9B2
         6i/0mLhPVjwK6pgcTmgvEKO87HFDR5FV9vMIs96njKMezLdDD+aUbICzp/iW997r2nVc
         fYZJ7DWp+xeuowftP1LpnbVOFo1jZSg4oIgZh+Ectpp1DiwUgJjour10MX/U17J9pS1F
         PjRpJwaktVHKHwOdQSoZY3djUyj9a06l1iDwcefb7yVKZ3OfaG49NtYvcV/P5qXF411m
         yC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FgG2toYigAj1ktFJcq6epdxSs10JCAGQPLYrkydZSrU=;
        b=b4maPubKQefOppLZIoPiJHJp6OJSqcXsVYfIo65A/6xn8FN8YC6dWUExuhGjEdIWyt
         N11NwACzLSIEVlWKuchy3YHGx2j2BtIoULE/GvQtAvNT4Hm1seWL8aC3+o6N3wHoK8X5
         AJGqpDHfQW7l6uEcuGcwg7XR294+Y293/Rfo5pwEZatJFMdu0Pabf++j5B+OTV0SnyDT
         emETPLU2ZzP8gTqT+KvO+rmM2W4fiax5jsZXMnE69PxD2gobL8TCAj8e99ND6kUphpIR
         sOAo4fiSWq4Q+Mg1fmmI2CWoS0ForoVwb7IWzpX+FVWDFcKB9+6jVVY3QE943+y40nP3
         TKVQ==
X-Gm-Message-State: APjAAAW22Yx/bBvrPaUjNYnMZ20v9ZQ3x/OUmwE1EURJgbNIV4lwcar1
        ba7pzdaE/dt7LI/zmrpbLxA=
X-Google-Smtp-Source: APXvYqxW9a4wLsiRch/9+vzAD1eI82074j8NuRdQUwRIHJxGUjE+78WhrJr463frQVmVFBttnhTzPA==
X-Received: by 2002:a63:4a50:: with SMTP id j16mr19137473pgl.323.1580120087409;
        Mon, 27 Jan 2020 02:14:47 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:14:46 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 05/22] staging: exfat: Rename variable "Minute" to "minute"
Date:   Mon, 27 Jan 2020 15:43:26 +0530
Message-Id: <20200127101343.20415-6-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "Minute" to "minute" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 03eaf25692aa..755e2fd6e3fd 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -226,7 +226,7 @@ struct date_time_t {
 	u16      month;
 	u16      day;
 	u16      hour;
-	u16      Minute;
+	u16      minute;
 	u16      Second;
 	u16      MilliSecond;
 };
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index ae9180be4cc0..70fa5f118a38 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -60,7 +60,7 @@ static void exfat_write_super(struct super_block *sb);
 static void exfat_time_fat2unix(struct timespec64 *ts, struct date_time_t *tp)
 {
 	ts->tv_sec = mktime64(tp->year + 1980, tp->month + 1, tp->day,
-			      tp->hour, tp->Minute, tp->Second);
+			      tp->hour, tp->minute, tp->Second);
 
 	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
 }
@@ -76,7 +76,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	if (second < UNIX_SECS_1980) {
 		tp->MilliSecond = 0;
 		tp->Second	= 0;
-		tp->Minute	= 0;
+		tp->minute	= 0;
 		tp->hour	= 0;
 		tp->day		= 1;
 		tp->month	= 1;
@@ -87,7 +87,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	if (second >= UNIX_SECS_2108) {
 		tp->MilliSecond = 999;
 		tp->Second	= 59;
-		tp->Minute	= 59;
+		tp->minute	= 59;
 		tp->hour	= 23;
 		tp->day		= 31;
 		tp->month	= 12;
@@ -97,7 +97,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 
 	tp->MilliSecond = ts->tv_nsec / NSEC_PER_MSEC;
 	tp->Second	= tm.tm_sec;
-	tp->Minute	= tm.tm_min;
+	tp->minute	= tm.tm_min;
 	tp->hour	= tm.tm_hour;
 	tp->day		= tm.tm_mday;
 	tp->month	= tm.tm_mon + 1;
@@ -1509,7 +1509,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->CreateTimestamp.month = tm.mon;
 	info->CreateTimestamp.day = tm.day;
 	info->CreateTimestamp.hour = tm.hour;
-	info->CreateTimestamp.Minute = tm.min;
+	info->CreateTimestamp.minute = tm.min;
 	info->CreateTimestamp.Second = tm.sec;
 	info->CreateTimestamp.MilliSecond = 0;
 
@@ -1518,7 +1518,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->ModifyTimestamp.month = tm.mon;
 	info->ModifyTimestamp.day = tm.day;
 	info->ModifyTimestamp.hour = tm.hour;
-	info->ModifyTimestamp.Minute = tm.min;
+	info->ModifyTimestamp.minute = tm.min;
 	info->ModifyTimestamp.Second = tm.sec;
 	info->ModifyTimestamp.MilliSecond = 0;
 
@@ -1606,7 +1606,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
 	tm.sec  = info->CreateTimestamp.Second;
-	tm.min  = info->CreateTimestamp.Minute;
+	tm.min  = info->CreateTimestamp.minute;
 	tm.hour = info->CreateTimestamp.hour;
 	tm.day  = info->CreateTimestamp.day;
 	tm.mon  = info->CreateTimestamp.month;
@@ -1614,7 +1614,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	p_fs->fs_func->set_entry_time(ep, &tm, TM_CREATE);
 
 	tm.sec  = info->ModifyTimestamp.Second;
-	tm.min  = info->ModifyTimestamp.Minute;
+	tm.min  = info->ModifyTimestamp.minute;
 	tm.hour = info->ModifyTimestamp.hour;
 	tm.day  = info->ModifyTimestamp.day;
 	tm.mon  = info->ModifyTimestamp.month;
@@ -1929,7 +1929,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.month = tm.mon;
 			dir_entry->CreateTimestamp.day = tm.day;
 			dir_entry->CreateTimestamp.hour = tm.hour;
-			dir_entry->CreateTimestamp.Minute = tm.min;
+			dir_entry->CreateTimestamp.minute = tm.min;
 			dir_entry->CreateTimestamp.Second = tm.sec;
 			dir_entry->CreateTimestamp.MilliSecond = 0;
 
@@ -1938,7 +1938,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->ModifyTimestamp.month = tm.mon;
 			dir_entry->ModifyTimestamp.day = tm.day;
 			dir_entry->ModifyTimestamp.hour = tm.hour;
-			dir_entry->ModifyTimestamp.Minute = tm.min;
+			dir_entry->ModifyTimestamp.minute = tm.min;
 			dir_entry->ModifyTimestamp.Second = tm.sec;
 			dir_entry->ModifyTimestamp.MilliSecond = 0;
 
-- 
2.17.1

