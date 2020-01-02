Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F8312E3CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 09:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgABIYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 03:24:14 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:52890 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgABIYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:24:12 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200102082408epoutp03e95525e3b2014473e9864cedf38a8d77~mBE0mtXPi0070300703epoutp03M
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 08:24:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200102082408epoutp03e95525e3b2014473e9864cedf38a8d77~mBE0mtXPi0070300703epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577953448;
        bh=lxkFqc0ygThCmwF5n0ai/z3zixLCrXftHW3rR5k+E7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yt+4hJIShFMATTV59Ms7SEqpP2XfQ0kxr3a50Cnaw4Grd8rcRLCOMqnyrx3F5zGQ4
         g3JZHkVds/p3KC5QXTldTRJMO3WC/hn9cnqA3fCGAh9HSigm5fJwi1gKsY2LUxSwbe
         vhwS3lid6HqKMhWgiL8NJFGNUQz1nZZNKwU/qj8U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200102082408epcas1p270c325b5a8c444b498675378ad05faee~mBE0MMgLy1717417174epcas1p29;
        Thu,  2 Jan 2020 08:24:08 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47pLfZ6VFSzMqYkY; Thu,  2 Jan
        2020 08:24:06 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.2F.48019.6A8AD0E5; Thu,  2 Jan 2020 17:24:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082406epcas1p268f260d90213bdaabee25a7518f86625~mBEyfWriF0996409964epcas1p2v;
        Thu,  2 Jan 2020 08:24:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200102082406epsmtrp1bc34cfd727213cf6768f05cd635103de~mBEyetmAv2232622326epsmtrp1a;
        Thu,  2 Jan 2020 08:24:06 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-1b-5e0da8a66ee1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.88.06569.6A8AD0E5; Thu,  2 Jan 2020 17:24:06 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082406epsmtip26852754a0c70b2c1a847cb9a5e2f8b64~mBEyV3bkk2215622156epsmtip2Y;
        Thu,  2 Jan 2020 08:24:06 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v9 09/13] exfat: add misc operations
Date:   Thu,  2 Jan 2020 16:20:32 +0800
Message-Id: <20200102082036.29643-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102082036.29643-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmru6yFbxxBps+mVg0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBF5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynk
        Jeam2iq5+AToumXmAB2lpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07M
        LS7NS9dLzs+1MjQwMDIFqkzIyTjwPq3gjU3FvsN5DYzz9bsYOTkkBEwkWg7vZu9i5OIQEtjB
        KHH5XhcjhPOJUWLrs8tQmW+MEoe3nWKBafm/rR2qai+jxMkZ31hBEmAtT+eKdDFycLAJaEv8
        2SIKEhYRsJfYPPsAC0g9s8AmRok987+C1QsDDZp/dSLYUBYBVYlPC5exg9i8ArYSv5oeM0Es
        k5dYveEAM4jNCRSf+b6VDWSQhMAWNome1U/ZIYpcJJY+fMUIYQtLvDq+BSouJfGyv40d5CAJ
        gWqJj/uZIcIdjBIvvttC2MYSN9dvYAUpYRbQlFi/CxosihI7f88Fm8gswCfx7msPK8QUXomO
        NiGIElWJvkuHoa6Uluhq/wC11EPi56FuaLhNYJRY96qRZQKj3CyEDQsYGVcxiqUWFOempxYb
        FpggR9cmRnCS07LYwbjnnM8hRgEORiUe3hvzeOKEWBPLiitzDzFKcDArifCWB/LGCfGmJFZW
        pRblxxeV5qQWH2I0BQbkRGYp0eR8YALOK4k3NDUyNja2MDEzNzM1VhLn5fhxMVZIID2xJDU7
        NbUgtQimj4mDU6qBcbv7DT5nrbZTfy5cOpXzS9y1+GKQe/MOHpfk666vyxmWaM87ckg4L2Z1
        8EyRh2m+v0ImWj+eML340o25snJnFndtK3x6d/LZ2L2XVtYFzFh482pVC6tFtEcqy3S7zLo9
        j76LLogQ/dblPHG6Tepmux3LQ6956FfJznbfs0bvUKHRze86nTqOGkosxRmJhlrMRcWJAPLR
        NnCIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO6yFbxxBk2f5S2aF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNosf0+stJp7+zWSx5d8RVotL7z+wOHB67Jx1l91j/9w17B67bzaw
        efRtWcXo8XmTnMeh7W/YAtiiuGxSUnMyy1KL9O0SuDIOvE8reGNTse9wXgPjfP0uRk4OCQET
        if/b2hm7GLk4hAR2M0rcmf+FDSIhLXHsxBnmLkYOIFtY4vDhYoiaD4wS0/5/YwSJswloS/zZ
        IgpSLiLgKNG76zALSA2zwC5GiROnTzOCJISBFsy/OpEFxGYRUJX4tHAZO4jNK2Ar8avpMRPE
        LnmJ1RsOMIPYnEDxme9bwW4QErCRePXvMdsERr4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL
        89L1kvNzNzGCg1FLawfjiRPxhxgFOBiVeHhvzOOJE2JNLCuuzD3EKMHBrCTCWx7IGyfEm5JY
        WZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBMeHqhS35K/+Hm7nM
        svEvEHxyypHziNSeWwweHbn7FydZXd9/+H/90UDDf0tv6B48uPIdxyEzWb8gjgOZ1k66+fu3
        m+csDVGpnfxbcabVpGMyEh6uTTzzOI+pd7/KWWu5Yt+0wzucmne1svivm2/LO2/Zb9Oj10wu
        93lpJR/kPF80/YPXnW/+s5VYijMSDbWYi4oTAd+AihtCAgAA
X-CMS-MailID: 20200102082406epcas1p268f260d90213bdaabee25a7518f86625
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082406epcas1p268f260d90213bdaabee25a7518f86625
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082406epcas1p268f260d90213bdaabee25a7518f86625@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of misc operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/misc.c | 253 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 253 insertions(+)
 create mode 100644 fs/exfat/misc.c

diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
new file mode 100644
index 000000000000..7f533bcb3b3f
--- /dev/null
+++ b/fs/exfat/misc.c
@@ -0,0 +1,253 @@
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
+#define TIMEZONE_SEC(x)	((x) * 15 * SECS_PER_MIN)
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
+	ts->tv_sec =  tp->second  + tp->minute * SECS_PER_MIN +
+		tp->hour * SECS_PER_HOUR +
+		(year * 365 + ld + accum_days_in_year[tp->month] +
+		(tp->day - 1) + DAYS_DELTA_DECADE) * SECS_PER_DAY;
+
+	ts->tv_nsec = 0;
+
+	/* Treat as local time */
+	if (!tp->timezone.valid) {
+		ts->tv_sec += sys_tz.tz_minuteswest * SECS_PER_MIN;
+		return;
+	}
+
+	/* Treat as UTC time, but need to adjust timezone to UTC0 */
+	if (tp->timezone.off <= 0x3F)
+		ts->tv_sec -= TIMEZONE_SEC(tp->timezone.off);
+	else /* 0x40 <= (tp->timezone & 0x7F) <=0x7F */
+		ts->tv_sec += TIMEZONE_SEC(0x80 - tp->timezone.off);
+}
+
+#define TIMEZONE_CUR_OFFSET()	((sys_tz.tz_minuteswest / (-15)) & 0x7F)
+/* Convert linear UNIX date to a FAT time/date pair. */
+void exfat_time_unix2fat(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		struct exfat_date_time *tp)
+{
+	time_t second = ts->tv_sec;
+	time_t day, month, year;
+	time_t ld; /* leap day */
+
+	/* Treats as local time with proper time */
+	second -= sys_tz.tz_minuteswest * SECS_PER_MIN;
+	tp->timezone.valid = 1;
+	tp->timezone.off = TIMEZONE_CUR_OFFSET();
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
+
+	if (second >= UNIX_SECS_2108) {
+		tp->second  = 59;
+		tp->minute  = 59;
+		tp->hour = 23;
+		tp->day  = 31;
+		tp->month  = 12;
+		tp->year = 127;
+		return;
+	}
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
+	tp->tz.value = dt.timezone.value;
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
+void exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec)
+{
+	return exfat_chain_set(dup, ec->dir, ec->size, ec->flags);
+}
-- 
2.17.1

