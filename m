Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F43104A27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 06:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKUF3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 00:29:25 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:58267 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUF3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:29:24 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191121052922epoutp041688764f1d2ae1e4ff059c0eee0ea324~ZFmOr1YcM2300223002epoutp04S
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 05:29:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191121052922epoutp041688764f1d2ae1e4ff059c0eee0ea324~ZFmOr1YcM2300223002epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574314162;
        bh=6pP9/t3Y+QPUL8I3w8RVSR4AP1ZnhZ/R45fIUNg9Vvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iD/2o8k4SRDSgA2eKsmn3Fqcnb3TIOvzs7ml9xmSZ1ywXffK9ja6qDGJuvECCWmBv
         TqjRbEMLOup+eyoMTcE1JGxEk+kxQgGNYImQ6WS2lyOgNAyNYqO3tj484q4x71gjl4
         4dgPVIJpfyy2ysXFqP8/slnxKAKjXeI2JlyS9GB4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191121052921epcas1p1e8d84936bb4893709fd41bacca5a9720~ZFmOCJ1Tx0315303153epcas1p1e;
        Thu, 21 Nov 2019 05:29:21 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47JSmJ2zhMzMqYkl; Thu, 21 Nov
        2019 05:29:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.9C.04072.0B026DD5; Thu, 21 Nov 2019 14:29:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191121052920epcas1p2a38edd92dece3ad2cec74439175fcc52~ZFmMw9q4L0047500475epcas1p2e;
        Thu, 21 Nov 2019 05:29:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191121052920epsmtrp25a607e14b549ba8b72183586db86b0fa~ZFmMwPnka1671516715epsmtrp2K;
        Thu, 21 Nov 2019 05:29:20 +0000 (GMT)
X-AuditID: b6c32a35-9a5ff70000000fe8-b8-5dd620b0c246
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.06.03654.FA026DD5; Thu, 21 Nov 2019 14:29:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191121052919epsmtip1f6bcca9a0a7677560e4a21a210428b40~ZFmMjHWOq1311613116epsmtip1a;
        Thu, 21 Nov 2019 05:29:19 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v4 09/13] exfat: add misc operations
Date:   Thu, 21 Nov 2019 00:26:14 -0500
Message-Id: <20191121052618.31117-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121052618.31117-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm27nsaE1O89KHRa0TQlbajmt6ilZBtwNFGUFBIXZwJyeena2d
        TTKpRobVKFFLjKURdMEy0ua6aN5QK8Sw1EyWqWiQEeKti1GZbR67/Hve532e9314v49A1Ll4
        JJEm2nmbyAkUHow+aIqOjanQvE7S1rSEMk3vCpRM9rVynLlV9kTBdPe+QZia2haU6awuxplp
        9xDGfCs6wUwPn0IZ769mjOkYHUM3zmGr3L1Ktr7kjpJ97HPibK73NmDLvV0oW9maxX7yLGIb
        Hw7jbM/7B2hi0H5hnYnnjLxNw4spFmOamGqgtu9J3pSsj9fSMfQaJoHSiJyZN1CbdyTGbE0T
        /GEpTQYnOPxUIidJ1Kr162wWh53XmCyS3UDxVqNgpbXWWIkzSw4xNTbFYl5La7Vxer/yoGBq
        u+/BrL1rjoy0t+BO0LnSBYIISK6GPaXtwAWCCTX5CMAbbYMKuZgAsKQoG5WLrwCOnTyP/LFk
        TzhnG7UA/pzKAX8thZ4upQsQBE6ugD+94QFDGLkBVl5umDEgZDeA799cwgKNUP+kuzfb0ABG
        ySj4ua4YBLCKNMCr58cV8rbFsKyiAQnMDPLz/T8yA3Mg2YPDAt/bGR6Sm2F+9iFZHgo/PvMq
        ZRwJP43U4rIkC47Xz+Y/A+CHSYOMddBXXoEFJAgZDcurV8n0Elj1o2QmDEKGwJEv5zB5igqe
        yVHLkiiY29E0m3EBdJ0em13KQvdACS4fJA/A1uoGJA8scv/bcBWA2yCCt0rmVF6irfT/7+UB
        M39xuf4RuNi2oxGQBKDmqkzLupLUGJchZZobASQQKkxV0/0qSa0ycplHeZsl2eYQeKkR6P1n
        zEciw1Ms/p8t2pNpfZxOp2NWxyfE63XUfBXxrT1JTaZydj6d56287Y9PQQRFOsEFQz3hEx4f
        aI8YUk/iBzrsT7fV5TdvKe37Or2SHBo4VFmZdviJI2VnxKDCIwxGH391a+LOaF+CMmdpTYYb
        E7P6e8t2L7TsKxzdle7qYDOVziLs+dS9KpXa8Wxs+7Ej+zbRL28UzAk553kx72z+9e+qD77J
        BXUjU3F7jeKVVtrZT6GSiaOXIzaJ+w2Px28yoQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnO56hWuxBg33zCwOP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZxSXTUpqTmZZapG+
        XQJXxrmtm1gL7lpWvLt4kq2B8bJOFyMnh4SAiUTzpwaWLkYuDiGB3YwS387dYYdISEscO3GG
        uYuRA8gWljh8uBii5gOjxJ1rv9hB4mwC2hJ/toiClIsIOEr07joMNodZ4DGjxInzTxhBEsJA
        C9YtO8cCYrMIqEp82TcHLM4rYCuxoPcjE8QueYnVGw6A7eIEit//XQkSFhKwkbh64gXrBEa+
        BYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgsNXS3MH4+Ul8YcYBTgYlXh4MzSu
        xgqxJpYVV+YeYpTgYFYS4d1z/UqsEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tS
        s1NTC1KLYLJMHJxSDYxlN/cHquU1fp9r1CohwOle5bPMMjLFQGTytC/CxrNMWoxmrs7S1VLP
        La58qn9pi+HSb1VZdztdS1QO730huZ7lxc9bffn3s65esJ6Y/tF+Yby9m3fjrvopB79xBXmU
        NZ1jTlOf/XcP94PTKStmnCr5+y/Rd4nlQj9HNfazQhFGyY/bbic1myixFGckGmoxFxUnAgAb
        C6YtWwIAAA==
X-CMS-MailID: 20191121052920epcas1p2a38edd92dece3ad2cec74439175fcc52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191121052920epcas1p2a38edd92dece3ad2cec74439175fcc52
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
        <CGME20191121052920epcas1p2a38edd92dece3ad2cec74439175fcc52@epcas1p2.samsung.com>
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
index 000000000000..a3b35ed4db05
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
+	set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(sb)->s_state);
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

