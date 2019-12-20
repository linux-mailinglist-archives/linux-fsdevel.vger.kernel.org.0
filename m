Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D961275C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 07:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLTG2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 01:28:23 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38343 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfLTG1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:27:41 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191220062738epoutp030fd47c3d8406c230987fd7ac5605325d~iAGY-lSXK1157711577epoutp03s
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 06:27:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191220062738epoutp030fd47c3d8406c230987fd7ac5605325d~iAGY-lSXK1157711577epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576823258;
        bh=J+4PwgH3TYBRzu+LcldYsRc/UZd2ZS/N3Ib9SXjcw4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ5AYm173CUBvQIepPs8X9J8CzJHeuDgPugv3CvoE8CB7dEe5tSCr4yCCu+gE158t
         yP19rha9grefHid5RJ4rzeD0fMGGIJg87Cm8V1EesR6N/lrwkiYV9C8hbSfrrDRlFJ
         0iU7e8zdrvx4mf0eHyqVq9wYQfOZfnoRka3542Gk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191220062738epcas1p41e117ccc94996172ea6d24ba1a509dcb~iAGYsi4_C0237302373epcas1p4U;
        Fri, 20 Dec 2019 06:27:38 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47fJh93NJ1zMqYkp; Fri, 20 Dec
        2019 06:27:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.DB.48498.9D96CFD5; Fri, 20 Dec 2019 15:27:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191220062737epcas1p3c0f9e408640148c9186b84efc6d6658b~iAGXkgjy-2863528635epcas1p3O;
        Fri, 20 Dec 2019 06:27:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191220062737epsmtrp1fdec2a4a7f5b515760652a235af29014~iAGXj15UA2110821108epsmtrp1P;
        Fri, 20 Dec 2019 06:27:37 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-ce-5dfc69d95fcf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.BA.06569.9D96CFD5; Fri, 20 Dec 2019 15:27:37 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191220062736epsmtip131a10380db700abdff934267cc1d00f4~iAGXQbHcr2572925729epsmtip1F;
        Fri, 20 Dec 2019 06:27:36 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v8 09/13] exfat: add misc operations
Date:   Fri, 20 Dec 2019 01:24:15 -0500
Message-Id: <20191220062419.23516-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220062419.23516-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmvu7NzD+xBg/eS1s0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2qBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6
        yfm5VoYGBkamQJUJORm/9t1jKXhqUfHtf3QD41ftLkZODgkBE4kt+/YzdjFycQgJ7GCUWDv3
        CDuE84lRYtvd96wQzjcgZ8Ut5i5GDrCWlp8xEPG9jBJPHv1D6Lj/5i4rSBGbgLbEny2iICtE
        BOwlNs8+wAJSwywwh1FiR+8sRpAaYaBB855KgtSwCKhKfFoxjR3E5hWwlfh4uosZ4jx5idUb
        DoDZnEDx31+fM4HMkRBYwybx4ttqNoiDXCSW7oGqF5Z4dXwLO4QtJfGyv40doqRa4uN+qJIO
        RokX320hbGOJm+s3gF3MLKApsX6XPkRYUWLn77mMIDazAJ/Eu689rBBTeCU62oQgSlQl+i4d
        ZoKwpSW62j9ALfWQeHtqOTTUJjBKdB5+wjaBUW4WwoYFjIyrGMVSC4pz01OLDQuMkGNrEyM4
        sWmZ7WBcdM7nEKMAB6MSD69D2u9YIdbEsuLK3EOMEhzMSiK8tzt+xgrxpiRWVqUW5ccXleak
        Fh9iNAWG40RmKdHkfGDSzSuJNzQ1MjY2tjAxMzczNVYS5+X4cTFWSCA9sSQ1OzW1ILUIpo+J
        g1OqgXHG+aVzLDib9kde2x7/+fq2L4Wmm9c/mvo97t+cmXZOroJKfBeuWSwMnTxjyfXdd2f8
        ZKp4en1lhKRRsleJ4O5rhl/4d5TmfDt7RqLkxja/liPNu1dM3nBbpKnto9CBozdvZUfdvehw
        /ujjGzIeAdZh15wiPMpMtf5vP+h1ty70+e4w429Z8zpfKbEUZyQaajEXFScCAM8H2BuCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO7NzD+xBl1b2S2aF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNosf0+sttvw7wmpx6f0HFgcOj52z7rJ77J+7ht1j980GNo++LasY
        PT5vkvM4tP0NWwBbFJdNSmpOZllqkb5dAlfGr333WAqeWlR8+x/dwPhVu4uRg0NCwESi5WdM
        FyMXh5DAbkaJs3c+sXQxcgLFpSWOnTjDDFEjLHH4cDFEzQdGifsPt7KDxNkEtCX+bBEFKRcR
        cJTo3XWYBaSGWWARo8S7j5NZQWqEgebPeyoJUsMioCrxacU0dhCbV8BW4uPpLmaIVfISqzcc
        ALM5geK/vz5nArGFBGwkGretYZzAyLeAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7u
        JkZwAGpp7WA8cSL+EKMAB6MSD69D2u9YIdbEsuLK3EOMEhzMSiK8tzt+xgrxpiRWVqUW5ccX
        leakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLglGpgLDva1qJRdfRvyKn7J1IWHwuY
        /8TalvFGhdjBF8ElZ1WvfN9+UXGO9Brlfc53j2raBnxgnPpyodviKeq5fEe81jdvXPK5uNFP
        8US3wxPmHSzPNc8trrf61xD0OfHuteCzuwJaV0s+uTK7Zbm3UnPiIl87niNck80ydn3rZjTb
        eSbv3XfRZme5lUosxRmJhlrMRcWJAP/g3rU8AgAA
X-CMS-MailID: 20191220062737epcas1p3c0f9e408640148c9186b84efc6d6658b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191220062737epcas1p3c0f9e408640148c9186b84efc6d6658b
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
        <CGME20191220062737epcas1p3c0f9e408640148c9186b84efc6d6658b@epcas1p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of misc operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/misc.c | 240 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)
 create mode 100644 fs/exfat/misc.c

diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
new file mode 100644
index 000000000000..2fa182cd4ff2
--- /dev/null
+++ b/fs/exfat/misc.c
@@ -0,0 +1,240 @@
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
+void exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec)
+{
+	return exfat_chain_set(dup, ec->dir, ec->size, ec->flags);
+}
-- 
2.17.1

