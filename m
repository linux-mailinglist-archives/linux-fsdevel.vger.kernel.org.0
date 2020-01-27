Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1114A1A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgA0KO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:14:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35393 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgA0KO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:14:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so4921826pgk.2;
        Mon, 27 Jan 2020 02:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XlJHB8xrCce4+qR5fM6OOxaGxduOQnbkJ4KZGhks8Uo=;
        b=UwiXEjdY6sVMBWyGN1kNXEQoEJGK2/8n4QMfKSJkllcW/8q48HAxnUw8kuDW/D6Q8F
         517S6+pDb3WyfxKhyovnw2VywFcXhymJNsqGEVJLQqnnzyLSR7yu2gBouLuJAK01nrVA
         RxogV3WqCE30H3Gu8AfPanYWh1ptaUtAPZdilyV7VYICvVYhRi0yxevoh5kgXD4ZWjiR
         4s39CSoBHnyGqb+Zo1QTLvPO13ZnO+mSOkNCr5cCsdJDRyPzqshTU5KyBSc+Br1Qhhmp
         LGxtTDJdDlmchPG9Gd42nyrkthZduZ/3W5Jj7rVrQZeyDyEIeLR2hWrr1yw46lCMqcUn
         IL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XlJHB8xrCce4+qR5fM6OOxaGxduOQnbkJ4KZGhks8Uo=;
        b=n81N3rPDCR0U6gN6wz8Wbs5sHFf4VQRougB19kYPpEh9MDsOMo/iddUyJGnFgH+UFx
         vtcO/+BrnGm2CflaE2l6/swvwhKaXat/tG4kQxBxaCmk73ENCh0hsgmWbTqo2QaW7TgU
         XZx0RJ5uVx70TZFLuIZkoPU09VHSZoJaB3LZAlyoXkzvUsZ2zLZtQY/lSe9uJNAL3Jqy
         vZFBgXLp4V15pUOeSlfahpQR8rtsvLqQKh8a2xn5ZT6BVMRVXqsY4Bh/3gtH57U5PaWq
         6fqXOO46yzgD5dXbE7APoqxaZaz9WmAs6SDxnxpfqil6S8fPS+v9Njdkm/sRr061dqKY
         4dTw==
X-Gm-Message-State: APjAAAUTk68BFa/8EzYdR53zXMolSHbVM22/i/Zb0UhT9I8OrAfkK5gp
        7E7IbOsw6opH2yl9jo+JXsM=
X-Google-Smtp-Source: APXvYqwCquVZpgIT+Vd/bzcflZ5y2Ef6ovqH3mt+1VuuD0uwNkmeFHIEsnTlUfgQlivUFQOynMUqmA==
X-Received: by 2002:a63:5924:: with SMTP id n36mr18804805pgb.43.1580120097612;
        Mon, 27 Jan 2020 02:14:57 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:14:57 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 07/22] staging: exfat: Rename variable "MilliSecond" to "milli_second"
Date:   Mon, 27 Jan 2020 15:43:28 +0530
Message-Id: <20200127101343.20415-8-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "MilliSecond" to "milli_second" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 85fbea44219a..5c207d715f44 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -228,7 +228,7 @@ struct date_time_t {
 	u16      hour;
 	u16      minute;
 	u16      second;
-	u16      MilliSecond;
+	u16      milli_second;
 };
 
 struct part_info_t {
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 0582c49f091d..6cc21d795589 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -62,7 +62,7 @@ static void exfat_time_fat2unix(struct timespec64 *ts, struct date_time_t *tp)
 	ts->tv_sec = mktime64(tp->year + 1980, tp->month + 1, tp->day,
 			      tp->hour, tp->minute, tp->second);
 
-	ts->tv_nsec = tp->MilliSecond * NSEC_PER_MSEC;
+	ts->tv_nsec = tp->milli_second * NSEC_PER_MSEC;
 }
 
 /* Convert linear UNIX date to a FAT time/date pair. */
@@ -74,7 +74,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	time64_to_tm(second, 0, &tm);
 
 	if (second < UNIX_SECS_1980) {
-		tp->MilliSecond = 0;
+		tp->milli_second = 0;
 		tp->second	= 0;
 		tp->minute	= 0;
 		tp->hour	= 0;
@@ -85,7 +85,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 	}
 
 	if (second >= UNIX_SECS_2108) {
-		tp->MilliSecond = 999;
+		tp->milli_second = 999;
 		tp->second	= 59;
 		tp->minute	= 59;
 		tp->hour	= 23;
@@ -95,7 +95,7 @@ static void exfat_time_unix2fat(struct timespec64 *ts, struct date_time_t *tp)
 		return;
 	}
 
-	tp->MilliSecond = ts->tv_nsec / NSEC_PER_MSEC;
+	tp->milli_second = ts->tv_nsec / NSEC_PER_MSEC;
 	tp->second	= tm.tm_sec;
 	tp->minute	= tm.tm_min;
 	tp->hour	= tm.tm_hour;
@@ -1511,7 +1511,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->CreateTimestamp.hour = tm.hour;
 	info->CreateTimestamp.minute = tm.min;
 	info->CreateTimestamp.second = tm.sec;
-	info->CreateTimestamp.MilliSecond = 0;
+	info->CreateTimestamp.milli_second = 0;
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 	info->ModifyTimestamp.year = tm.year;
@@ -1520,7 +1520,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->ModifyTimestamp.hour = tm.hour;
 	info->ModifyTimestamp.minute = tm.min;
 	info->ModifyTimestamp.second = tm.sec;
-	info->ModifyTimestamp.MilliSecond = 0;
+	info->ModifyTimestamp.milli_second = 0;
 
 	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
 
@@ -1931,7 +1931,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.hour = tm.hour;
 			dir_entry->CreateTimestamp.minute = tm.min;
 			dir_entry->CreateTimestamp.second = tm.sec;
-			dir_entry->CreateTimestamp.MilliSecond = 0;
+			dir_entry->CreateTimestamp.milli_second = 0;
 
 			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 			dir_entry->ModifyTimestamp.year = tm.year;
@@ -1940,7 +1940,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->ModifyTimestamp.hour = tm.hour;
 			dir_entry->ModifyTimestamp.minute = tm.min;
 			dir_entry->ModifyTimestamp.second = tm.sec;
-			dir_entry->ModifyTimestamp.MilliSecond = 0;
+			dir_entry->ModifyTimestamp.milli_second = 0;
 
 			memset((char *)&dir_entry->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
-- 
2.17.1

