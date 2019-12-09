Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6551711672D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 07:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfLIGzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 01:55:36 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:36484 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLIGzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:55:08 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191209065505epoutp01bb84548d6f5ba5aa6d41f68f597c069f~eoYNbXVge3045930459epoutp01D
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2019 06:55:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191209065505epoutp01bb84548d6f5ba5aa6d41f68f597c069f~eoYNbXVge3045930459epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575874505;
        bh=J+4PwgH3TYBRzu+LcldYsRc/UZd2ZS/N3Ib9SXjcw4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIp+jUUHC8nSIKNuNiTmVOMTQ23phyf3yCR1lOLzgWtSag5bXUuVV9k5/vQPT5l+g
         KB4OWM59Vu9jO4u7RzI32vDJk4ksCYe6iI6yJikSym2YWYRoo+pq2UMlWIrYtxOLin
         3TKTS16q7HjFM4T9j+UxHy0k/F/GXzBeW4g3UlgU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191209065504epcas1p499a3c489ee017c2f46569ade4a0f9cb8~eoYMvAUob0851508515epcas1p4Q;
        Mon,  9 Dec 2019 06:55:04 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47WYpv20F9zMqYkl; Mon,  9 Dec
        2019 06:55:03 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.87.48019.6CFEDED5; Mon,  9 Dec 2019 15:55:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191209065502epcas1p4337a0f7518e55dbef1573d53c99f88ef~eoYKxmIUu1134311343epcas1p4d;
        Mon,  9 Dec 2019 06:55:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209065502epsmtrp260add306645178fdc3dec902cfa76e69~eoYKwsURv2761927619epsmtrp2S;
        Mon,  9 Dec 2019 06:55:02 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-b4-5dedefc6fe9f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.E9.06569.6CFEDED5; Mon,  9 Dec 2019 15:55:02 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191209065502epsmtip1727bf21e173edd41dbf1aa4704856cf0~eoYKpMhgn1943719437epsmtip1T;
        Mon,  9 Dec 2019 06:55:02 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v6 09/13] exfat: add misc operations
Date:   Mon,  9 Dec 2019 01:51:44 -0500
Message-Id: <20191209065149.2230-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209065149.2230-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmvu6x929jDeZM1rRoXryezWLl6qNM
        Fnv2nmSxuLxrDpvFj+n1Flv+HWG1uPT+A4sDu8f+uWvYPXbfbGDz6NuyitHj8yY5j0Pb37AF
        sEbl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaGk
        UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWq
        TMjJ+LXvHkvBU4uKb/+jGxi/ancxcnJICJhI7L31mb2LkYtDSGAHo8SSnSeYIJxPjBLT1rVC
        Od8YJRZNnc4K03JjxUMWiMReRomLR+cww7XcvL2NsYuRg4NNQFvizxZRkAYRAXuJzbMPgDUw
        C7QwSiw4/YMZJCEMNGnP6lVMIDaLgKrE6fcvwOK8AjYS83ZdZoLYJi+xesMBsDgnUPxNz0Gw
        kyQE5rBJNC46zQ6yTELARaL5XzlEvbDEq+Nb2CFsKYnP7/ayQZRUS3zczwwR7mCUePHdFsI2
        lri5fgMrSAmzgKbE+l36EGFFiZ2/5zKC2MwCfBLvvvawQkzhlehoE4IoUZXou3QY6khpia72
        D1BLPSSOdGxmg4RIP6PE0sUNrBMY5WYhbFjAyLiKUSy1oDg3PbXYsMAEOb42MYITmZbFDsY9
        53wOMQpwMCrx8CpYvY0VYk0sK67MPcQowcGsJMK7ZOKrWCHelMTKqtSi/Pii0pzU4kOMpsBw
        nMgsJZqcD0yyeSXxhqZGxsbGFiZm5mamxkrivBw/LsYKCaQnlqRmp6YWpBbB9DFxcEo1MBps
        LD37xCbvSfa2A2cLu13akx7utLZ9qcIltDSuR/XnxKuaDSbLM34JW29crxzzZt2KmJ86RZ5z
        90X18cioLPE9FPRaguWzZtmpMwv23jxSfnLeklz/fS+u7GjNu6opfu2trwmH8czfPIEW3293
        Oc/S6PzwRp+hqVSnaOP2sr2/FXXPrkrWeKXEUpyRaKjFXFScCACrfLJyegMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSnO6x929jDRoXClo0L17PZrFy9VEm
        iz17T7JYXN41h83ix/R6iy3/jrBaXHr/gcWB3WP/3DXsHrtvNrB59G1ZxejxeZOcx6Htb9gC
        WKO4bFJSczLLUov07RK4Mn7tu8dS8NSi4tv/6AbGr9pdjJwcEgImEjdWPGTpYuTiEBLYzSix
        sKGBFSIhLXHsxBnmLkYOIFtY4vDhYoiaD4wSzbPusILE2QS0Jf5sEQUpFxFwlOjddRhsDrNA
        F6PEo6ZvzCAJYaAFe1avYgKxWQRUJU6/fwEW5xWwkZi36zITxC55idUbDoDFOYHib3oOgsWF
        BKwlrr5cyjiBkW8BI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzggNPS2sF44kT8
        IUYBDkYlHl4Fq7exQqyJZcWVuYcYJTiYlUR4l0x8FSvEm5JYWZValB9fVJqTWnyIUZqDRUmc
        Vz7/WKSQQHpiSWp2ampBahFMlomDU6qBUaP83hRWA7OXv4NPNnfy39wckKkbxcT3PWDCkQm7
        wnpKNKb+ZnTP+N67NNjtxObVX16deFgXZqLyJKX/3PfCpIMyMbyC6qr9BxyfTXBTnTlF73m7
        1pSj835vr3NeO/+B7d1HBxfe65ntni3YqyIUWzv9x+/Ss61b94rtjnO/tLo07+6XDIGyYCWW
        4oxEQy3mouJEAPPAjTM0AgAA
X-CMS-MailID: 20191209065502epcas1p4337a0f7518e55dbef1573d53c99f88ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209065502epcas1p4337a0f7518e55dbef1573d53c99f88ef
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
        <CGME20191209065502epcas1p4337a0f7518e55dbef1573d53c99f88ef@epcas1p4.samsung.com>
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

