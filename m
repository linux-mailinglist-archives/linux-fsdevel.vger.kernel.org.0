Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5E158299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgBJShG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55837 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJShF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:05 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so125365pjz.5;
        Mon, 10 Feb 2020 10:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsCf4k2H7Qd6YQ/+eI0UPgq5XblhMAu81QTwn6YWwe0=;
        b=s/Mlj6K97lkaZiXXXT9qKKY/hlanIXfPnP/ayOjS8VuT7p+ZPwYLnB3PGJE/7/dzuN
         /jHt5TyAeXhosT0cyGIMy1oHNPseuVrx1qhYWpnCH84KmOrfbB+VdWggv/egdyk06Twc
         6CKmoE0M5eteweY2FZrmZHUBjou61kUbKknjgZ2GxaBynRlOqw2wQH9zYEO8csPM9O43
         mui9hYiQfX6lfq2FXIEWpC1KkSh0p+02irTkH0oDbyOuncUqeBsJc/77o+N1TFAdXVZs
         /jd0CmJv5/SYeagQ8uJpwFHHkF6xnxDT3gej0UVm9Xwjw3rr7fXMzNV2+994eUn2g/Ll
         zYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsCf4k2H7Qd6YQ/+eI0UPgq5XblhMAu81QTwn6YWwe0=;
        b=OVJ3hnHbXX79b0oHqU8xOWxqz+QXSQrl1tc36UZ6/WlqPfBo68syKpdd+EBILbpsjG
         O8uX/R76SmYons0j78M4r9M1My+U5rJh1bOspC6HO+zMj2b1ZFIF9pXI1oqhepO/Je3m
         si0YXPyOv1o+uMbb+fYdeSddiVQDyDyQhUU2aywqqq24bRVwwpdr5r1vS5zbmqCjxVVc
         pl0qSFuTj6gkEwOzrDK3INKBTh7bFFwI44r69+8cxyq8aegVmfTXOPFSIdylJOAsneVO
         Zh3bCpBiLjSoK+O6XzbXapAj4/NdYlM7p+T5z944YpUl2l9dxoXeJBLzlreIiXCy7Wtm
         C4TA==
X-Gm-Message-State: APjAAAUPNfYwFLoYfxebxtRWBtcyV1c68VBg+ojRz+GDHivQ8nRUog1A
        brgKkspU5wZnK2Dwr4O8J2k=
X-Google-Smtp-Source: APXvYqwZ4zsEoVOVi2hsXltqN8RZ+zZe/+WoSUjeCVNe+XW8aeBat4NaYJ028s4jrLMM6RKUTeNYVg==
X-Received: by 2002:a17:90a:7d07:: with SMTP id g7mr467183pjl.17.1581359824819;
        Mon, 10 Feb 2020 10:37:04 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:04 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 07/19] staging: exfat: Rename variable 'MilliSecond' to 'millisecond'
Date:   Tue, 11 Feb 2020 00:05:46 +0530
Message-Id: <20200210183558.11836-8-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "MilliSecond" to "millisecond"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
Changes in v1:
 -Rename variable "MilliSecond" to "milli_second"

Changes in v2:
 -Remove unnecessary '_' underscore character in renamed identifier
  name.
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 20179ef7b956..96e1e1553e56 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -228,7 +228,7 @@ struct date_time_t {
 	u16      hour;
 	u16      minute;
 	u16      second;
-	u16      MilliSecond;
+	u16      millisecond;
 };
 
 struct part_info_t {
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index eced4a408f68..472a6c8efcbb 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -62,7 +62,7 @@ static void exfat_time_fat2unix(struct timespec64 *ts, struct date_time_t *tp)
 	ts->tv_sec = mktime64(tp->year + 1980, tp->month + 1, tp->day,
 			      tp->hour, tp->minute, tp->second);
 
-	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
+	ts->tv_nsec = tp->millisecond * NSEC_PER_MSEC;
 }
 
 /* Convert linear UNIX date to a FAT time/date pair. */
@@ -74,7 +74,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	time64_to_tm(second, 0, &tm);
 
 	if (second < UNIX_SECS_1980) {
-		tp->MilliSecond = 0;
+		tp->millisecond = 0;
 		tp->second	= 0;
 		tp->minute	= 0;
 		tp->hour	= 0;
@@ -85,7 +85,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	}
 
 	if (second >= UNIX_SECS_2108) {
-		tp->MilliSecond = 999;
+		tp->millisecond = 999;
 		tp->second	= 59;
 		tp->minute	= 59;
 		tp->hour	= 23;
@@ -95,7 +95,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		return;
 	}
 
-	tp->MilliSecond = ts->tv_nsec / NSEC_PER_MSEC;
+	tp->millisecond = ts->tv_nsec / NSEC_PER_MSEC;
 	tp->second	= tm.tm_sec;
 	tp->minute	= tm.tm_min;
 	tp->hour	= tm.tm_hour;
@@ -1511,7 +1511,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->CreateTimestamp.hour = tm.hour;
 	info->CreateTimestamp.minute = tm.min;
 	info->CreateTimestamp.second = tm.sec;
-	info->CreateTimestamp.MilliSecond = 0;
+	info->CreateTimestamp.millisecond = 0;
 
 	exfat_get_entry_time(ep, &tm, TM_MODIFY);
 	info->ModifyTimestamp.year = tm.year;
@@ -1520,7 +1520,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->ModifyTimestamp.hour = tm.hour;
 	info->ModifyTimestamp.minute = tm.min;
 	info->ModifyTimestamp.second = tm.sec;
-	info->ModifyTimestamp.MilliSecond = 0;
+	info->ModifyTimestamp.millisecond = 0;
 
 	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
 
@@ -1928,7 +1928,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.hour = tm.hour;
 			dir_entry->CreateTimestamp.minute = tm.min;
 			dir_entry->CreateTimestamp.second = tm.sec;
-			dir_entry->CreateTimestamp.MilliSecond = 0;
+			dir_entry->CreateTimestamp.millisecond = 0;
 
 			exfat_get_entry_time(ep, &tm, TM_MODIFY);
 			dir_entry->ModifyTimestamp.year = tm.year;
@@ -1937,7 +1937,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->ModifyTimestamp.hour = tm.hour;
 			dir_entry->ModifyTimestamp.minute = tm.min;
 			dir_entry->ModifyTimestamp.second = tm.sec;
-			dir_entry->ModifyTimestamp.MilliSecond = 0;
+			dir_entry->ModifyTimestamp.millisecond = 0;
 
 			memset((char *)&dir_entry->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
-- 
2.17.1

