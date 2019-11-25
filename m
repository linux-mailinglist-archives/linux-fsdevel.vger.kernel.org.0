Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4311085C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfKYAGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:06:47 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:26193 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfKYAGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:06:39 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191125000634epoutp01c63d75d3e42d1edb81727c8dd91516da~aPxiVWhU40817008170epoutp01p
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 00:06:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191125000634epoutp01c63d75d3e42d1edb81727c8dd91516da~aPxiVWhU40817008170epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574640394;
        bh=J+4PwgH3TYBRzu+LcldYsRc/UZd2ZS/N3Ib9SXjcw4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvZHNET9VL1lDQcqN/ZxG21Mf3xQFq6e8FPayCmA2V7NVs6bv4g9Kcqo31wZNTwxY
         wBH3C8QKLrYwx/ve83K1UkNQr3LA7jjGzeMt6r/IaLv7cHkMLwqI/ovVKYu34EhwQ3
         c1ezrVIB2kpc3c5wCYc9FC3dzVJkP2GQwdIJOcHs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191125000634epcas1p3e81cd3b14281b5f4691e44e561bffd7f~aPxh5EYBb0344003440epcas1p3-;
        Mon, 25 Nov 2019 00:06:34 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47LnQ06pqKzMqYlv; Mon, 25 Nov
        2019 00:06:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.64.52419.80B1BDD5; Mon, 25 Nov 2019 09:06:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191125000632epcas1p1b9c9adefdad82bc538f914924ce9fa21~aPxgjHeFg2648426484epcas1p1V;
        Mon, 25 Nov 2019 00:06:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191125000632epsmtrp115243d633e8c3c59c086a5ff1366855e~aPxgiU-iw2803928039epsmtrp1U;
        Mon, 25 Nov 2019 00:06:32 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-27-5ddb1b084158
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.11.06569.80B1BDD5; Mon, 25 Nov 2019 09:06:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000632epsmtip24dedbccb70b33cc7131f4675f34ff5b8~aPxgYdgeH1911519115epsmtip2b;
        Mon, 25 Nov 2019 00:06:32 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 09/13] exfat: add misc operations
Date:   Sun, 24 Nov 2019 19:03:22 -0500
Message-Id: <20191125000326.24561-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125000326.24561-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURzu7N7dXa3JZT46Kdm6NqHE3FrTW7gKkrhglGQPKMa6udu09mp3
        SmWQPaxY7wdpW0UgUWqi2bA0X1w1m1GQWdrMolqmvUuyJ9nmtcd/3/nO953v43d+OCI7gEXj
        ORYHa7cwJhILRWtapicl4jG9OqWXT6Fanh+TULtKKjGqtLxNRHX3+RCqvsGLUvfqTmPUiOul
        mPpatJ0aebMbpTy/WsVU5/sP6ILxdK2rT0I3nbkkoa8/LMDoQ54yQFd67qP0lVv59FB1LM1f
        fYPRvf01aEbIalNqNssYWLuctWRZDTkWo5ZMz9Qv1GuSlapE1RwqhZRbGDOrJdMWZyQuyjEF
        ypLyPMaUG6AyGI4jk+al2q25DlaebeUcWpK1GUw2ldI2k2PMXK7FODPLap6rUipnaQLKtabs
        742PUdsLavPwyJoC8DnBCUJwSMyGpYWdEicIxWXENQCLBz5hwuETgBd2No7dDAPoG3qKOAE+
        ahmqTxf4BgBr+XLkr8Pd3osFRRiRAH96IoMREcR8eMXdjAY1CNENYL+vWBzUhAceevYgMahB
        CQU82FUrDmIpoYUXh/tQod4UWF7VjARxSIC/2VEzmgWJbgz2FPWKBVEavNrRNmYIh6/aPRIB
        R8PBw3skQul8+LEJEeh9AA580QpYDR9WVo3WQYjpsLIuSaCnwtofZ0AQI0QYfPf5gFh4RQr3
        7ZEJEgU81NkiEnAMdO79MBZEQ38nKgzkCIDnP/rBERDr+hdwDoAyEMXaOLOR5VQ29f+/VQ1G
        N3FGyjVQdWcxDwgckBOkVRU+nUzM5HFbzDyAOEJGSBfd7tHJpAZmy1bWbtXbc00sxwNNYI5H
        kejILGtgry0OvUozS61WU7OTU5I1anKiFP96VycjjIyD3ciyNtb+xyfCQ6ILALvjWJf87Zol
        73esLAwrcRcY9GfjL8vvK/J1xmVNJ/221z3H20q8gxvi+JhNTd2KFY0dre2hx72PGBMf6dzf
        P1lfuOJEKh9P/Dq1/hnmKhJRlGKau+XJtvxJ+uXVK83+hKXYjd2iVeseRIT7vJl2T8WE8CK/
        a8BTkjyu1R0X9Y1EuWxGNQOxc8xvp9ntAZ8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSvC6H9O1YgydLFS0OP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eov/b1pYLLb8O8Jqcen9BxYHbo+ds+6y
        e+yfu4bdY/fNBjaPvi2rGD3Wb7nK4rH5dLXH501yHoe2v2HzuP1sG0sAZxSXTUpqTmZZapG+
        XQJXxq9991gKnlpUfPsf3cD4VbuLkYNDQsBE4vMe7y5GLg4hgd2MEod2HmXtYuQEiktLHDtx
        hhmiRlji8OFiiJoPjBJzJ3QygsTZBLQl/mwRBSkXEXCU6N11mAWkhlngMaPEifNPwGqEgeY/
        uqYLUsMioCrRe2Un2HheAVuJFd/uskCskpdYveEAM4jNCRQ/cWobmC0kYCPRfugo2wRGvgWM
        DKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJDV0trB+OJE/GHGAU4GJV4eDk23IoV
        Yk0sK67MPcQowcGsJMLrdvZGrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6Yklqdmp
        qQWpRTBZJg5OqQZGIc7svA0bnJImLJ1e8OHQPf7XPjHp08PfNBmw5OpniHvf4T9qzcUZGrEx
        KLChdXctWylDqaTKFAd+dq5LHNcFdp2JFNn267bK+jfxekcLA5xln/uIq3tqlPxp3dLlJsH1
        fP2pqf3M+/abpZkrz9vHl/n9JFf6GfOSvMnb//2t2VR3lH274EklluKMREMt5qLiRACZsQ1F
        WQIAAA==
X-CMS-MailID: 20191125000632epcas1p1b9c9adefdad82bc538f914924ce9fa21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191125000632epcas1p1b9c9adefdad82bc538f914924ce9fa21
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
        <CGME20191125000632epcas1p1b9c9adefdad82bc538f914924ce9fa21@epcas1p1.samsung.com>
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

