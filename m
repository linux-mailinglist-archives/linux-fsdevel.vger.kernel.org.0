Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83514CED7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgA2Q7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:59:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43188 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgA2Q7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:59:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id p11so160506plq.10;
        Wed, 29 Jan 2020 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P+UaHXAUZO2+8blEJCSj51jRdgohduCuRxIISSD4GSQ=;
        b=GPunuMmncvxInaip/zKRI935R23NZQWcAayRy9786QCFGm6i9+49KRfKPPFbTGuErB
         otSkub6IZGZZslxOsMmtIjhhp2lXxuj0n1X+rRYhGb63XvZEiU9pTvMvoIuoibHWRXWR
         5TrLJx6/M50oaHc7K2kQiR1neM6Z8j8pWlcGZO26dyHHUBmtQNqHTpR8W08Rt3fFLyuF
         46t0htkxVQZ2WMieWeGHA6pyUyUaIYDXXnOyaIut669Jm7S1w3nBPiUYSmmGAHYwahKo
         a3tZk2eqikS/xv/NrErcSPyEOUU5Zem7BYf1kHIIDLBqNafSi4Qgclciw86hu/tQYUA7
         N3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P+UaHXAUZO2+8blEJCSj51jRdgohduCuRxIISSD4GSQ=;
        b=pq6WxhMMM5LvW/SECeS2WSuYvS6NVjMt1nEA9j2xpwoKO+s+TxMq+jow7A61zjz82j
         j1/a5UQSH6epVuiAgwZujkDx2HXKevt5wHIKN29kWPTrbM/j6AcB6FkiEZ8tPs/NopKB
         xyQE9hBk3fDl7E9BgvgcXmLjcBGa1ClkD+LpGxXZJ4IiDxrUavSDhLCNsNSMtgJarDg0
         B67vpQSKbdGgTPeoRge3r8KejVzkfQd70ITHV03yn+VTdokqh2GhXKSewHWWjt7RF1X0
         BK988B3+4D8giXYwn89imOpcGQRQsp2jdLXweAOxXlQWy/9Dajg9USAae1v2w3cF4m5O
         uO9g==
X-Gm-Message-State: APjAAAV24XuKZLLOGIsMtEgdp5cLVsbNYmwF9HaiRWf+ki9sFA3vLTSA
        CT8stVu8iHnnGYzOyW/5Gms=
X-Google-Smtp-Source: APXvYqwfXfpR9UYdsB7IWOpc6eSg4/7Xvlde8WePg8+yQVEmOmGfveAHxmeCwJ8/OEfwDLzspbl5pQ==
X-Received: by 2002:a17:902:fe93:: with SMTP id x19mr278315plm.155.1580317171758;
        Wed, 29 Jan 2020 08:59:31 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:59:31 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 07/19] staging: exfat: Rename variable 'MilliSecond' to 'millisecond'
Date:   Wed, 29 Jan 2020 22:28:20 +0530
Message-Id: <20200129165832.10574-8-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "MilliSecond" to "millisecond"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>

---
Changes in v1:
	-Rename "MilliSecond" as "milli_second"
Changes in v2:
	-Remove unnecessary '_'(underscore) character form renamed
	 identifier name.
	-Rename "MilliSecond" as "millisecond"
---
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 85fbea44219a..55405dcbf8f7 100644
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
index 0582c49f091d..e51abb9b3826 100644
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
 
 	p_fs->fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 	info->ModifyTimestamp.year = tm.year;
@@ -1520,7 +1520,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->ModifyTimestamp.hour = tm.hour;
 	info->ModifyTimestamp.minute = tm.min;
 	info->ModifyTimestamp.second = tm.sec;
-	info->ModifyTimestamp.MilliSecond = 0;
+	info->ModifyTimestamp.millisecond = 0;
 
 	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
 
@@ -1931,7 +1931,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->CreateTimestamp.hour = tm.hour;
 			dir_entry->CreateTimestamp.minute = tm.min;
 			dir_entry->CreateTimestamp.second = tm.sec;
-			dir_entry->CreateTimestamp.MilliSecond = 0;
+			dir_entry->CreateTimestamp.millisecond = 0;
 
 			fs_func->get_entry_time(ep, &tm, TM_MODIFY);
 			dir_entry->ModifyTimestamp.year = tm.year;
@@ -1940,7 +1940,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->ModifyTimestamp.hour = tm.hour;
 			dir_entry->ModifyTimestamp.minute = tm.min;
 			dir_entry->ModifyTimestamp.second = tm.sec;
-			dir_entry->ModifyTimestamp.MilliSecond = 0;
+			dir_entry->ModifyTimestamp.millisecond = 0;
 
 			memset((char *)&dir_entry->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
-- 
2.17.1

