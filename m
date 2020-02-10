Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A558158297
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBJShA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33088 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJShA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so3175422plb.0;
        Mon, 10 Feb 2020 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BTOjeQ/2BKNTV1JxSE5WmRTz6JA+//foRxORVkB6X9A=;
        b=RkxXfxopB2FPSuE1hvXbJ8aU7SR4VtMndn0HWn8WaehomXjqViakSQcS44bPqMxQJO
         O3ldkPRT1kuFp10kaEWyE8GtNj8bLaJzNGZHWV8ExqfGDVq3YyhlGQ5VObup4CT4Azt/
         w6xCtCmEfeM0cMOrPDx8QK+IO7jalizIDoFh72MTp99sMa6K9GOz42zZMyI9v9RSOfC3
         2LLUzecVamvJEbjUuONv+yEYQ/vX+zjNdXyMpv76oenwyrvVEZa8UXcG70l6mnIJJYXI
         MC8U0gTidBbtI8KN2WPFjs8igmNJzxms7LFnrYVr3tNMYOwTi8DYOe1fmXfkA3A/shmH
         27zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BTOjeQ/2BKNTV1JxSE5WmRTz6JA+//foRxORVkB6X9A=;
        b=p1OaWJ/dDnc5CyMgYx5sK8qlzxwEpoABs/JvUrHZW9aa35/8Pke8M1l4gg7KbOia8g
         EbTIWapYqB6PNJ1/HTjCEMeBNqGf0tmYGH9o5TdcV00NL94vc3MAwfiwFhHWnI9/5SgA
         AFTk+KJ6Y/V6UX47uhtfX64/fYrXhfrqNwQxn4ouNHeNJXk9yCY+bWjTHAn7OXJ0/Ebi
         NgzlOUiCEZaF6wJqeqgsSdrUlh/9P9omJ4hP02ChFfQvKsP2mTp+rUYXtaTjjtTmprot
         llwoWu5ve3qoXSpZpB++k7Tuc7//B/WE9UQXc7ffD0DRdElu4/YsC4fPh5L4V+Xxdu7V
         EYBA==
X-Gm-Message-State: APjAAAW1iDAcDRKsvq7HcVkyYrbi25ppRgWAbt2lZtQJyAQBB+SZPWl9
        5s2Y0KYqjLXbBj2skrDdkKM=
X-Google-Smtp-Source: APXvYqzS9fkQGhelpYTJo/wX7kN06/t62F1B7YMJpoA0KytQwCH5g0tl3JxbQig2C3QfiuMk/iydxg==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr439747pjb.49.1581359819618;
        Mon, 10 Feb 2020 10:36:59 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:36:59 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 06/19] staging: exfat: Rename variable 'Second' to 'second'
Date:   Tue, 11 Feb 2020 00:05:45 +0530
Message-Id: <20200210183558.11836-7-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "Second" to "second"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index fe0270e7b685..20179ef7b956 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -227,7 +227,7 @@ struct date_time_t {
 	u16      day;
 	u16      hour;
 	u16      minute;
-	u16      Second;
+	u16      second;
 	u16      MilliSecond;
 };
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 9e1b6a7ad5ff..eced4a408f68 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -60,7 +60,7 @@ static void exfat_write_super(struct super_block *sb);
 static void exfat_time_fat2unix(struct timespec64 *ts, struct date_time_t *tp)
 {
 	ts->tv_sec = mktime64(tp->year + 1980, tp->month + 1, tp->day,
-			      tp->hour, tp->minute, tp->Second);
+			      tp->hour, tp->minute, tp->second);
 
 	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
 }
@@ -75,7 +75,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 
 	if (second < UNIX_SECS_1980) {
 		tp->MilliSecond = 0;
-		tp->Second	= 0;
+		tp->second	= 0;
 		tp->minute	= 0;
 		tp->hour	= 0;
 		tp->day		= 1;
@@ -86,7 +86,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 
 	if (second >= UNIX_SECS_2108) {
 		tp->MilliSecond = 999;
-		tp->Second	= 59;
+		tp->second	= 59;
 		tp->minute	= 59;
 		tp->hour	= 23;
 		tp->day		= 31;
@@ -96,7 +96,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	}
 
 	tp->MilliSecond = ts->tv_nsec / NSEC_PER_MSEC;
-	tp->Second	= tm.tm_sec;
+	tp->second	= tm.tm_sec;
 	tp->minute	= tm.tm_min;
 	tp->hour	= tm.tm_hour;
 	tp->day		= tm.tm_mday;
@@ -1510,7 +1510,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->CreateTimestamp.day = tm.day;
 	info->CreateTimestamp.hour = tm.hour;
 	info->CreateTimestamp.minute = tm.min;
-	info->CreateTimestamp.Second = tm.sec;
+	info->CreateTimestamp.second = tm.sec;
 	info->CreateTimestamp.MilliSecond = 0;
 
 	exfat_get_entry_time(ep, &tm, TM_MODIFY);
@@ -1519,7 +1519,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->ModifyTimestamp.day = tm.day;
 	info->ModifyTimestamp.hour = tm.hour;
 	info->ModifyTimestamp.minute = tm.min;
-	info->ModifyTimestamp.Second = tm.sec;
+	info->ModifyTimestamp.second = tm.sec;
 	info->ModifyTimestamp.MilliSecond = 0;
 
 	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
@@ -1605,7 +1605,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	exfat_set_entry_attr(ep, info->Attr);
 
 	/* set FILE_INFO structure using the acquired struct dentry_t */
-	tm.sec  = info->CreateTimestamp.Second;
+	tm.sec  = info->CreateTimestamp.second;
 	tm.min  = info->CreateTimestamp.minute;
 	tm.hour = info->CreateTimestamp.hour;
 	tm.day  = info->CreateTimestamp.day;
@@ -1613,7 +1613,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	tm.year = info->CreateTimestamp.year;
 	exfat_set_entry_time(ep, &tm, TM_CREATE);
 
-	tm.sec  = info->ModifyTimestamp.Second;
+	tm.sec  = info->ModifyTimestamp.second;
 	tm.min  = info->ModifyTimestamp.minute;
 	tm.hour = info->ModifyTimestamp.hour;
 	tm.day  = info->ModifyTimestamp.day;
@@ -1927,7 +1927,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.day = tm.day;
 			dir_entry->CreateTimestamp.hour = tm.hour;
 			dir_entry->CreateTimestamp.minute = tm.min;
-			dir_entry->CreateTimestamp.Second = tm.sec;
+			dir_entry->CreateTimestamp.second = tm.sec;
 			dir_entry->CreateTimestamp.MilliSecond = 0;
 
 			exfat_get_entry_time(ep, &tm, TM_MODIFY);
@@ -1936,7 +1936,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->ModifyTimestamp.day = tm.day;
 			dir_entry->ModifyTimestamp.hour = tm.hour;
 			dir_entry->ModifyTimestamp.minute = tm.min;
-			dir_entry->ModifyTimestamp.Second = tm.sec;
+			dir_entry->ModifyTimestamp.second = tm.sec;
 			dir_entry->ModifyTimestamp.MilliSecond = 0;
 
 			memset((char *)&dir_entry->AccessTimestamp, 0,
-- 
2.17.1

