Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42314CECA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgA2Q7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:59:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgA2Q7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:59:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so6198028pfp.13;
        Wed, 29 Jan 2020 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ucEQKxIRzbBwF74avFk3zbtOcUu6B0pyQtp7Byz+GSo=;
        b=Pi9LKOkMTSmkEYmRIPU57LETMNpwHg7XHVzDDf45P2EYuLWpwhbIsV8phD+0DVRn+o
         YRrm9YIFxPccNWcwThPCdM+mP86ANb2tHZsR9jlNbykZuVeL+mykevzJlo1V1O/ecAF5
         QGsDJ8NvTYFW5Opxm7kbfMI1v+W8SrD6wh1HCAksQlxJeAJI3jwcrCuoUThSxYPjVu7e
         KmZsmQtLgLfW1KyPGiwbgxVavQOg5LG9UwKzhdiaQmZ28Rxa5Lnr661lhyMHNsoddLpf
         rHv/AkLzlzP9db6V/CbOVyiJPfsXiHObJ3/K5iBVfnhRjza3ULN5pLMksf+2JQjDw4xB
         ntBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ucEQKxIRzbBwF74avFk3zbtOcUu6B0pyQtp7Byz+GSo=;
        b=OSBCAIXnoq9yFFpTbmzo9iuZZuYsZ4GYEredk7V8fu80w9IRClUjl8zyq8QiJL3Ml8
         BxI9S2kiZsDP1zCX0g8W+jYSf+vEn/tAxZMG4q3DijB6W/bGG0LTUa5C8j3+uuBVQcxf
         PQBoJ+znoLEmZ/SCj2wOpPaSeulODUGyq8gcKa1nSIZXa2zH1R0oQKRuT60wr3b1YIjY
         GK0polaxuvL3tpUUSjORMzMmuUcgoT4An6o4Qxp3Zl2Cm/4rvAv+XHQqfU4tUPEd+BJW
         8NLW8U2ymO8/mGZNxtgRJPKppDmDzt1G6DNRRmOVk3c5ssvGrzyb9Z1gSvWhjzaDUIrU
         oQSw==
X-Gm-Message-State: APjAAAU5RKiIyAQEaFDEVxrLEY7n/sRTRmv5BPBhCscB9y95rwvd2KQ0
        1UZL+/Htvy6IxaNTiAqa6qs=
X-Google-Smtp-Source: APXvYqxvKskMBipKLUy56KAIDmNEm9hcGssJFTz/dyHTL0Bs44XnymeQxNSN8kbWU5qJ9jbAB0JJXw==
X-Received: by 2002:a62:5bc4:: with SMTP id p187mr530132pfb.82.1580317154937;
        Wed, 29 Jan 2020 08:59:14 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:59:14 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 04/19] staging: exfat: Rename variable 'Hour' to 'hour'
Date:   Wed, 29 Jan 2020 22:28:17 +0530
Message-Id: <20200129165832.10574-5-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "Hour" to "hour"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 4211148405c5..03eaf25692aa 100644
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
index b30f9517cfef..ae9180be4cc0 100644
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
@@ -1928,7 +1928,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.year = tm.year;
 			dir_entry->CreateTimestamp.month = tm.mon;
 			dir_entry->CreateTimestamp.day = tm.day;
-			dir_entry->CreateTimestamp.Hour = tm.hour;
+			dir_entry->CreateTimestamp.hour = tm.hour;
 			dir_entry->CreateTimestamp.Minute = tm.min;
 			dir_entry->CreateTimestamp.Second = tm.sec;
 			dir_entry->CreateTimestamp.MilliSecond = 0;
@@ -1937,7 +1937,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
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

