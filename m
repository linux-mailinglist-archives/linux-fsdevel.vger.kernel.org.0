Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682F514A1AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgA0KOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:14:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33700 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgA0KOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:14:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so4673403pfn.0;
        Mon, 27 Jan 2020 02:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U2kK5QEuHw6BDRLLriJ4VrZEogoNI4xjUaHdmahuy1Q=;
        b=YPWPhZFIgDWywyLJN6/qIsG31ce0rhTRCkzttxPQWlZLq2it1DamghT2wdD4MQHjTi
         RiRAtFCqtlIl0RrD1uW2cu5Qq8KZMD2D0AaORIlqxzcujKZ9pdvd1rgVfUN7pfGOjjQc
         Iep9icpoZgwkoeKFnSoqSmMYTqg62fjwQ1+guGlJFJ86690MNNv14IdSne44L0LIcsbQ
         oFVOC2Mx5EkWi0O4e1LM3tM991IpdNn9vTYgxl1HoKkCZvB9mavpuLy7bIHxs6n8Kijt
         wJrxngQt6ckSAq1FR+CJctU9KMBhZkRnq9tnacepwEGcRl59IHue2pqLYIRFG5TEMwBv
         Xi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2kK5QEuHw6BDRLLriJ4VrZEogoNI4xjUaHdmahuy1Q=;
        b=Rd8YaxefrD+zcweP9RqWOx0+/xyofqmaH+C7euFiKfOh1IHjwNECOrAylRwtyMOZQS
         bpok003sf2+vrzoDk6qLysfMN1V/Z+sGFCkKtyjEzlDnqhSoAaQsDanf0KsNVHcyExFW
         uQ74d2uUoYBFJCgMvtPft5vlVjfxXWyGiZCzo1GAwhJKryrSJDDxJjKNAMKg37I3c+aH
         w3zAKSNAY+3+XerirH5Y4isNIgPPQT8KVRlS7gpeOouttJAartnshT3SslP+GSi/v0fP
         jCyNeqMNFoNwYOHewzPPcWnT4mHt+5qmUeIJdZ/VB7PtXnRaJPu2+qqDe9J6vobbbx8W
         5BDw==
X-Gm-Message-State: APjAAAVaB1lhdGrBckjP6cqmeLv3/KJTdyjd3wkfAtpJVAgjhvDW9ViM
        W/EwiH58eeZLjIquSL0/rLg=
X-Google-Smtp-Source: APXvYqwnQX1jR4AsX/BW6ri81emgk7pE+99yO4Hrzl7exS6e/hCGUNhvseS3ECuIo15XYE2rECZXpQ==
X-Received: by 2002:a63:5818:: with SMTP id m24mr18836508pgb.358.1580120082582;
        Mon, 27 Jan 2020 02:14:42 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:14:41 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 04/22] staging: exfat: Rename variable "Hour" to "hour"
Date:   Mon, 27 Jan 2020 15:43:25 +0530
Message-Id: <20200127101343.20415-5-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "Hour" to "hour" in exfat.

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

