Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF414A195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgA0KOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:14:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36225 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgA0KOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:14:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so3589174plm.3;
        Mon, 27 Jan 2020 02:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gr3h8StdJ+sIQoYNE4dg+34LxHG1ti1yO2tDGHyNGW0=;
        b=scd6NEV18x4utUgL2bG+zhuicf+W3kh2DZuR2yW1JmHNjJt0O1FkTWMirAbKlsv2s6
         A2j9189isvCiEGlLQYj+gqWaborEIC2QBF3vC2664pFY0ER83nHcaMRIpYi+JSIN6B2A
         E3++8e7bm0hoFf2DYuss0BXfc8W2q6iw8ju0GP9ZlzAgx5ltJ2MgmDrSREUgOtIGTqQo
         7scfFBTc56+ow6+o0gR4/yoezj1UgboEeA1ovkhlPZt2XudpsbR+OmTb4ISzB/zHyS2N
         PceSEaDfBeSnM0Vl52OeNFWaPItyPtDPZm07QSmhxW1ozBHWnRuMwbPfwM3owE6CZCZU
         6LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gr3h8StdJ+sIQoYNE4dg+34LxHG1ti1yO2tDGHyNGW0=;
        b=f6jkRf+WjWYQp+ibocZngn7f2EkJXcKEQbAmk69WQ8rolRzfzkYmUGLdQBVzEvy2A2
         aY2IxvelYm0GnRi9Lomi9saTFPyCdAAMmEUea+/16+gFVLz1J0wdbNpxrVIRNO5ZipKN
         ViEtAsvN+geHVPrliu0DNYnOqPa+jMKiFLyAD4aI+I6OwzsmRDVe+peUsP1FlLn2eumy
         78Bw0Zflj3lsfHtWe83bnsebmF7uLoYPpkOj83cYo0yP5iakNBtlz5xXoPMTSBSkk/L3
         qTpBeuLbL2IUINGgvOfQGjDA9TZtIR1QcuO5aa1K9ESNbtVbfKVIaqcAeXW+w9D618dL
         CVCw==
X-Gm-Message-State: APjAAAW/ww/jzv2CeWJTwTfs4tp7CsszmmQDxv+UcUaKZvb5MGe3a1dm
        EDT9qP7gNt8M4Cvk5bC2o8g=
X-Google-Smtp-Source: APXvYqx7phoKqTU8KZkbARJBxUoncdQrwlzuY/LkH6HYE5JdxFdc2vXyCfxgyzADzu0VQdPia5+y2g==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr16937812plz.269.1580120076927;
        Mon, 27 Jan 2020 02:14:36 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:14:36 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 03/22] staging: exfat: Rename variable "Day" to "day"
Date:   Mon, 27 Jan 2020 15:43:24 +0530
Message-Id: <20200127101343.20415-4-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "Day" to "day" in exfat.

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

