Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C51FABF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 09:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfKMIXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 03:23:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21145 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfKMIW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:22:28 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191113082225epoutp029c16cd41c850678bb1dfdad6711e144c~WqzC-NoEa0087600876epoutp02y
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:22:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191113082225epoutp029c16cd41c850678bb1dfdad6711e144c~WqzC-NoEa0087600876epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573633345;
        bh=XpygHjuf8d7CE3zc20VcrTtJAW5giJFyIx169VoIE/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbagU+ywENeIkurjJoBwTYQmoKyyb5qK5TTZaI0regEgT2hnRAV6lVZdAILbCFItR
         Q3zR1vAmorhlnqCNAKiwzTZzyN5nl4X1xDGK4fbwoU27/zoGRUePdUqUgRQkdeAXEf
         DJ/tlDKeAJXxSkurMn5geOZvEIE1GCJes6WosMHc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191113082225epcas1p3617005cfe956bd1b99d005f9d0dc445c~WqzCsv-mu0267902679epcas1p3d;
        Wed, 13 Nov 2019 08:22:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47Cczh0DLlzMqYlh; Wed, 13 Nov
        2019 08:22:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.8B.04085.E3DBBCD5; Wed, 13 Nov 2019 17:22:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082222epcas1p17c34378124600f41b2659e068b8609f9~Wqy-_IF971395613956epcas1p1k;
        Wed, 13 Nov 2019 08:22:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113082222epsmtrp206bdbd97d8c6767814e0193fdc616099~Wqy-9ORU32391923919epsmtrp2D;
        Wed, 13 Nov 2019 08:22:22 +0000 (GMT)
X-AuditID: b6c32a37-e31ff70000000ff5-8d-5dcbbd3efdb7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.C1.25663.E3DBBCD5; Wed, 13 Nov 2019 17:22:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082222epsmtip1dd024c9966496c648e3340085e8660a0~Wqy-wrd8Y2165921659epsmtip1i;
        Wed, 13 Nov 2019 08:22:22 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 09/13] exfat: add misc operations
Date:   Wed, 13 Nov 2019 03:17:56 -0500
Message-Id: <20191113081800.7672-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113081800.7672-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmrq7d3tOxBt8vmls0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2qBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6
        yfm5VoYGBkamQJUJORmNS3YwFlyxrNh6p429gfGUThcjJ4eEgInE/XOPGLsYuTiEBHYwSnSf
        2skG4XxilHhz4jlU5hujxN+GH4wwLfOfHWSBSOxllFgw4TYTXMuKvh4gh4ODTUBb4s8WUZAG
        EQF7ic2zD4A1MAvMYZTY0TsLbJKwgKFE7/GLLCA2i4CqxOSOdUwgNq+AjcSEnhvsENvkJVZv
        OMAMMpMTKH5trS3IHAmBDWwSP7+/hKpxkdj34yEThC0s8er4Fqi4lMTnd3vZQHolBKolPu5n
        hgh3MEq8+G4LYRtL3Fy/gRWkhFlAU2L9Ln2IsKLEzt9zwa5kFuCTePe1hxViCq9ER5sQRImq
        RN+lw1BLpSW62j9ALfWQmL//EjMkRPoZJR51PGSdwCg3C2HDAkbGVYxiqQXFuempxYYFxsgR
        tokRnN60zHcwbjjnc4hRgINRiYdXYuGpWCHWxLLiytxDjBIczEoivDsqTsQK8aYkVlalFuXH
        F5XmpBYfYjQFhuNEZinR5Hxg6s0riTc0NTI2NrYwMTM3MzVWEud1XL40VkggPbEkNTs1tSC1
        CKaPiYNTqoFR/eGEpct9at/IFXqo7p8ud4nvt2/KtVVJH/VUtUrf74pmZrtzx/u73532Lv/E
        sD+f++uZ+KMuyu8MOTMn02fbA6Xy5aUH+p/sr/PhvPyzgj+y29n30BpHncC/JjfTr3cXbGyo
        8jsiMPVD9M13uxg//1oYE/GhXdhy25JZiuff3/HalMwv6pSqxFKckWioxVxUnAgA0I4tAIUD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnK7d3tOxBk9nC1k0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6MxiU7GAuuWFZsvdPG3sB4SqeLkZNDQsBEYv6z
        gyxdjFwcQgK7GSVWHLzOCpGQljh24gxzFyMHkC0scfhwMUTNB0aJvXeWsYPE2QS0Jf5sEQUp
        FxFwlOjddRhsDrPAIkaJdx8ng80RFjCU6D1+kQXEZhFQlZjcsY4JxOYVsJGY0HODHWKXvMTq
        DQfAdnECxa+ttQUJCwlYS3x9e4B5AiPfAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5
        uZsYwUGopbWD8cSJ+EOMAhyMSjy8B+adihViTSwrrsw9xCjBwawkwruj4kSsEG9KYmVValF+
        fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6pBsa0e33KxsY9hk136213eDds
        0HkmcjdSd6P6KbNkjoPL+TadK1nF/CHpxO4T/m9fq2fb+vttmJNjGTfrr+fXR0xT3Q09l8q8
        P9WcaHOoR31tqICQ84a+U5uje8w38pas9Irjce3Subvt0bYjl2ZLZ8yb2D7N3EUoeyNDzuLu
        FxaRYXOLZ8crNiixFGckGmoxFxUnAgD6Hi0ePgIAAA==
X-CMS-MailID: 20191113082222epcas1p17c34378124600f41b2659e068b8609f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113082222epcas1p17c34378124600f41b2659e068b8609f9
References: <20191113081800.7672-1-namjae.jeon@samsung.com>
        <CGME20191113082222epcas1p17c34378124600f41b2659e068b8609f9@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of misc operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/misc.c | 247 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)
 create mode 100644 fs/exfat/misc.c

diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
new file mode 100644
index 000000000000..19a140355cf0
--- /dev/null
+++ b/fs/exfat/misc.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Written 1992,1993 by Werner Almesberger
+ *  22/11/2000 - Fixed fat_date_unix2dos for dates earlier than 01/01/1980
+ *		 and date_dos2unix for date==0 by Igor Zhbanov(bsg@uniyar.ac.ru)
+ * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/time.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/buffer_head.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+/*
+ * exfat_fs_error reports a file system problem that might indicate fa data
+ * corruption/inconsistency. Depending on 'errors' mount option the
+ * panic() is called, or error message is printed FAT and nothing is done,
+ * or filesystem is remounted read-only (default behavior).
+ * In case the file system is remounted read-only, it can be made writable
+ * again by remounting it.
+ */
+void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
+{
+	struct exfat_mount_options *opts = &EXFAT_SB(sb)->options;
+	va_list args;
+	struct va_format vaf;
+
+	if (report) {
+		va_start(args, fmt);
+		vaf.fmt = fmt;
+		vaf.va = &args;
+		exfat_msg(sb, KERN_ERR, "error, %pV\n", &vaf);
+		va_end(args);
+	}
+
+	if (opts->errors == EXFAT_ERRORS_PANIC) {
+		panic("exFAT-fs (%s): fs panic from previous error\n",
+			sb->s_id);
+	} else if (opts->errors == EXFAT_ERRORS_RO && !sb_rdonly(sb)) {
+		sb->s_flags |= SB_RDONLY;
+		exfat_msg(sb, KERN_ERR, "Filesystem has been set read-only");
+	}
+}
+
+/*
+ * exfat_msg() - print preformated EXFAT specific messages.
+ * All logs except what uses exfat_fs_error() should be written by exfat_msg()
+ */
+void exfat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	/* level means KERN_ pacility level */
+	printk("%sexFAT-fs (%s): %pV\n", level, sb->s_id, &vaf);
+	va_end(args);
+}
+
+/* <linux/time.h> externs sys_tz
+ * extern struct timezone sys_tz;
+ */
+#define UNIX_SECS_1980    315532800L
+
+#if BITS_PER_LONG == 64
+#define UNIX_SECS_2108    4354819200L
+#endif
+
+/* days between 1970/01/01 and 1980/01/01 (2 leap days) */
+#define DAYS_DELTA_DECADE    (365 * 10 + 2)
+/* 120 (2100 - 1980) isn't leap year */
+#define NO_LEAP_YEAR_2100    (120)
+#define IS_LEAP_YEAR(y)    (!((y) & 0x3) && (y) != NO_LEAP_YEAR_2100)
+
+#define SECS_PER_MIN    (60)
+#define SECS_PER_HOUR   (60 * SECS_PER_MIN)
+#define SECS_PER_DAY    (24 * SECS_PER_HOUR)
+
+#define MAKE_LEAP_YEAR(leap_year, year)                         \
+	do {                                                    \
+		/* 2100 isn't leap year */                      \
+		if (unlikely(year > NO_LEAP_YEAR_2100))         \
+			leap_year = ((year + 3) / 4) - 1;       \
+		else                                            \
+			leap_year = ((year + 3) / 4);           \
+	} while (0)
+
+/* Linear day numbers of the respective 1sts in non-leap years. */
+static time_t accum_days_in_year[] = {
+	/* Month : N 01  02  03  04  05  06  07  08  09  10  11  12 */
+	0, 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 0, 0, 0,
+};
+
+/* Convert a FAT time/date pair to a UNIX date (seconds since 1 1 70). */
+void exfat_time_fat2unix(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		struct exfat_date_time *tp)
+{
+	time_t year = tp->year;
+	time_t ld; /* leap day */
+
+	MAKE_LEAP_YEAR(ld, year);
+
+	if (IS_LEAP_YEAR(year) && (tp->month) > 2)
+		ld++;
+
+	ts->tv_sec =  tp->second  + tp->minute * SECS_PER_MIN
+			+ tp->hour * SECS_PER_HOUR
+			+ (year * 365 + ld + accum_days_in_year[tp->month]
+			+ (tp->day - 1) + DAYS_DELTA_DECADE) * SECS_PER_DAY;
+
+	if (!sbi->options.tz_utc)
+		ts->tv_sec += sys_tz.tz_minuteswest * SECS_PER_MIN;
+
+	ts->tv_nsec = 0;
+}
+
+/* Convert linear UNIX date to a FAT time/date pair. */
+void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		struct exfat_date_time *tp)
+{
+	time_t second = ts->tv_sec;
+	time_t day, month, year;
+	time_t ld; /* leap day */
+
+	if (!sbi->options.tz_utc)
+		second -= sys_tz.tz_minuteswest * SECS_PER_MIN;
+
+	/* Jan 1 GMT 00:00:00 1980. But what about another time zone? */
+	if (second < UNIX_SECS_1980) {
+		tp->second  = 0;
+		tp->minute  = 0;
+		tp->hour = 0;
+		tp->day  = 1;
+		tp->month  = 1;
+		tp->year = 0;
+		return;
+	}
+#if (BITS_PER_LONG == 64)
+	if (second >= UNIX_SECS_2108) {
+		tp->second  = 59;
+		tp->minute  = 59;
+		tp->hour = 23;
+		tp->day  = 31;
+		tp->month  = 12;
+		tp->year = 127;
+		return;
+	}
+#endif
+
+	day = second / SECS_PER_DAY - DAYS_DELTA_DECADE;
+	year = day / 365;
+
+	MAKE_LEAP_YEAR(ld, year);
+	if (year * 365 + ld > day)
+		year--;
+
+	MAKE_LEAP_YEAR(ld, year);
+	day -= year * 365 + ld;
+
+	if (IS_LEAP_YEAR(year) && day == accum_days_in_year[3]) {
+		month = 2;
+	} else {
+		if (IS_LEAP_YEAR(year) && day > accum_days_in_year[3])
+			day--;
+		for (month = 1; month < 12; month++) {
+			if (accum_days_in_year[month + 1] > day)
+				break;
+		}
+	}
+	day -= accum_days_in_year[month];
+
+	tp->second  = second % SECS_PER_MIN;
+	tp->minute  = (second / SECS_PER_MIN) % 60;
+	tp->hour = (second / SECS_PER_HOUR) % 24;
+	tp->day  = day + 1;
+	tp->month  = month;
+	tp->year = year;
+}
+
+struct exfat_timestamp *exfat_tm_now(struct exfat_sb_info *sbi,
+		struct exfat_timestamp *tp)
+{
+	struct timespec64 ts;
+	struct exfat_date_time dt;
+
+	ktime_get_real_ts64(&ts);
+	exfat_time_unix2fat(sbi, &ts, &dt);
+
+	tp->year = dt.year;
+	tp->mon = dt.month;
+	tp->day = dt.day;
+	tp->hour = dt.hour;
+	tp->min = dt.minute;
+	tp->sec = dt.second;
+
+	return tp;
+}
+
+unsigned short exfat_calc_chksum_2byte(void *data, int len,
+		unsigned short chksum, int type)
+{
+	int i;
+	unsigned char *c = (unsigned char *)data;
+
+	for (i = 0; i < len; i++, c++) {
+		if (((i == 2) || (i == 3)) && (type == CS_DIR_ENTRY))
+			continue;
+		chksum = (((chksum & 1) << 15) | ((chksum & 0xFFFE) >> 1)) +
+			(unsigned short)*c;
+	}
+	return chksum;
+}
+
+void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync)
+{
+	WRITE_ONCE(EXFAT_SB(sb)->s_dirt, true);
+	set_buffer_uptodate(bh);
+	mark_buffer_dirty(bh);
+
+	if (sync)
+		sync_dirty_buffer(bh);
+}
+
+void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
+		unsigned int size, unsigned char flags)
+{
+	ec->dir = dir;
+	ec->size = size;
+	ec->flags = flags;
+}
+
+struct exfat_chain *exfat_chain_dup(struct exfat_chain *ec)
+{
+	struct exfat_chain *dup;
+
+	dup = kmalloc(sizeof(struct exfat_chain), GFP_KERNEL);
+	if (!dup)
+		return NULL;
+
+	exfat_chain_set(dup, ec->dir, ec->size, ec->flags);
+	return dup;
+}
-- 
2.17.1

