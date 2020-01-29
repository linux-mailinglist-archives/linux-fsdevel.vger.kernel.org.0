Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15FB14CEC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgA2Q7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:59:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39818 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgA2Q7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:59:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id 4so64634pgd.6;
        Wed, 29 Jan 2020 08:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fxM0wwnpk8IneLFf4ZZ3Vk1Wy5NcKBevBAG7IqTUmK0=;
        b=uWnUO9+uG5E8MW+zp1akeOm5vcXMhyBmeb0c2VqJ64EHy3zqNOJ3zOZPuCvD7EENfO
         gWAqizDeeAVJY2fMXil+/5KK1ynQMZXC5RMLVXJ9rw5+8+A64cxEnJoV6jhyuNJllNbi
         dx+DJMyriD6rT6Hl36SJSEiUwAJeQUxHmm5l9+AkjiVJzoG5JVrcVo8hpLMVrppPgEp2
         DEd/X2JIZYtSPOo8+yKZkpzVIyHOBOgRR6jO/BMY42FQk/26aSWpGQTgsaknSCm1KvG9
         B8Fr3w0M0cCURiJJjKMyB53kcIPA3xHj/m7oXi06pSeE1Hd1HVosINBHxOB2H4YTy+d+
         4+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fxM0wwnpk8IneLFf4ZZ3Vk1Wy5NcKBevBAG7IqTUmK0=;
        b=bDOj9jSZ6VBPHSsFvR0k2gajoDrFCqpb7uBJG6gOMgdxq0kQnhXrllDhniohYdAOW3
         rP0D9ymT4z9aFVGYVAP+7oZZucjiIm3gRYaQNGUV27Cp5FhqJq6Fpb0Q2fmq5Bz9mFLc
         0Bhbg0nK0e/nBrSwVQWcQ8Et9qjKqA7sgWwLqzCEWixtIhIJ2cKVgrvO6a+5ARjvdhO/
         u2wSBUHOy0E5cfWwLSULtlXsz/hm2WukQUwBUadjfSw8epc5Rxoeog5PQOAKiUEfMDF1
         GmbbqJI91H9seyi4Uq89CE3CSA+rUNp7F/YoqXx+A5et6T9lxbojuZ23UaRJEvLCGxn3
         Pdwg==
X-Gm-Message-State: APjAAAUQSQBbfzQ5YE0uB8lBNnDo+zu+OOjV4VagfUhwKrfMgW4rgp9C
        Izm5UQoNWwb6wqYjGqKdwcM=
X-Google-Smtp-Source: APXvYqxYw5FFiJZaZznRyy3hLbyWOuH/t9REAM5vWATskN4z5Xa52XkhX5x31ljAr/CC8gbu5JJMlA==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr468484pfn.245.1580317139356;
        Wed, 29 Jan 2020 08:58:59 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:58:58 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 01/19] staging: exfat: Rename variable 'Year' to 'year'
Date:   Wed, 29 Jan 2020 22:28:14 +0530
Message-Id: <20200129165832.10574-2-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "Year" to "year"

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

