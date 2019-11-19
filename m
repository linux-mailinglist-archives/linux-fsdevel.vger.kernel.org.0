Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27A9101A33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 08:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfKSHOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 02:14:46 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:41623 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfKSHOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:14:11 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191119071408epoutp015c4830b612b35967abe9058f0087277c~YfvI7-rqc1765217652epoutp015
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 07:14:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191119071408epoutp015c4830b612b35967abe9058f0087277c~YfvI7-rqc1765217652epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574147648;
        bh=XpygHjuf8d7CE3zc20VcrTtJAW5giJFyIx169VoIE/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOgp0WufgSvsLTLG9bfCgM30QjNAuMtK+pBiN1xcO60zNY2ilAKcyYPBzqAcgyELA
         HQTjyqNvx8a4rIlSclIyiSzwArvUjvlXaz+MSBYDBkEc4Ubo9OgNbKf0JNoPhXuOni
         LFIqURCbx8aiFCveimTdDmbYMv9d1qSPqdSjYkvo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191119071408epcas1p10588b44ac2652e04cf61a0d640d0d3c9~YfvIh87M70158901589epcas1p13;
        Tue, 19 Nov 2019 07:14:08 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47HHB70v3WzMqYkb; Tue, 19 Nov
        2019 07:14:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.7B.04072.F3693DD5; Tue, 19 Nov 2019 16:14:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191119071406epcas1p285f075eac966cfdd6f79362ecc433d6b~YfvHHYoD41561515615epcas1p22;
        Tue, 19 Nov 2019 07:14:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191119071406epsmtrp25e932c7e7e61cc78092e03a2fb6c22d9~YfvHGt4Qb0193901939epsmtrp2U;
        Tue, 19 Nov 2019 07:14:06 +0000 (GMT)
X-AuditID: b6c32a35-e16a59c000000fe8-ad-5dd3963f297c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.14.03654.E3693DD5; Tue, 19 Nov 2019 16:14:06 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119071406epsmtip14052a654d776eb92f3434bb26d4ff4ec~YfvG8oQOb1281112811epsmtip1f;
        Tue, 19 Nov 2019 07:14:06 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2 09/13] exfat: add misc operations
Date:   Tue, 19 Nov 2019 02:11:03 -0500
Message-Id: <20191119071107.1947-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119071107.1947-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmrq79tMuxBpf+sVo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMH6DIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGh
        QYFecWJucWleul5yfq6VoYGBkSlQZUJORuOSHYwFVywrtt5pY29gPKXTxcjBISFgItGxLKmL
        kYtDSGAHo8TPg+/YIZxPjBKPv61k7GLkBHK+MUocfhoKYoM0bJj0iw2iaC+jxPRbz1jgOv78
        2MoOMpZNQFvizxZRkAYRAXuJzbMPgNUwC2xmlHi4aSkLSEIYaNKESTfANrAIqEq0PmkGi/MK
        2Ejs/fmMCWKbvMTqDQeYQWxOoHj/vO9g50kI7GGTWHLlLwtEkYvElo4fbBC2sMSr41vYIWwp
        ic/v9rJB/Fkt8XE/M0S4g1HixXdbCNtY4ub6DawgJcwCmhLrd+lDhBUldv6eC3YaswCfxLuv
        PawQU3glOtqEIEpUJfouHYa6Ulqiq/0D1FIPiRPz9rNCgqSfUeLMuyvMExjlZiFsWMDIuIpR
        LLWgODc9tdiwwBA5vjYxghOelukOxinnfA4xCnAwKvHwKqhfjhViTSwrrsw9xCjBwawkwuv3
        6EKsEG9KYmVValF+fFFpTmrxIUZTYEBOZJYSTc4HJuO8knhDUyNjY2MLEzNzM1NjJXFejh8X
        Y4UE0hNLUrNTUwtSi2D6mDg4pRoYD25s2GgRKW1f7sZxuuuFej6TjPiUghaH2N0LC34+69jy
        ICyJfa21qWNnU/Ye7l8zVA/IvL0+P6Na898L7fWnddYpn9oe9fLC4w/3WASY7z2NeJHh5/qp
        5fTcv2KJ6W4rv93gWFt2jGlPTHn36ze6Putm/Pu+ymnq8RfWEqofnC0FHu3MCviRpMRSnJFo
        qMVcVJwIAO8VLmaOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnK7dtMuxBn0XlC2aF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNov/s56zWvyYXm+x5d8RVotL7z+wOHB67Jx1l91j/9w17B67bzaw
        efRtWcXo8XmTnMeh7W/YPG4/28YSwB7FZZOSmpNZllqkb5fAldG4ZAdjwRXLiq132tgbGE/p
        dDFyckgImEhsmPSLrYuRi0NIYDejxMpDV9ghEtISx06cYe5i5ACyhSUOHy6GqPnAKPFm6QxW
        kDibgLbEny2iIOUiAo4SvbsOs4DUMIPM2TL9FyNIQhhowYRJN8BsFgFVidYnzSwgNq+AjcTe
        n8+YIHbJS6zecIAZxOYEivfP+w52g5CAtcTmRUtYJzDyLWBkWMUomVpQnJueW2xYYJiXWq5X
        nJhbXJqXrpecn7uJERyaWpo7GC8viT/EKMDBqMTDe0LlcqwQa2JZcWXuIUYJDmYlEV6/Rxdi
        hXhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamDMr5nqKCCT
        tPJ00aZpzLtsrmidz3VdHP/JwKXa6P8R0Sk/lnKuKbSP9BDonmqu8k2jOFk7UOD5fKPvb1+o
        /ma91W92ybsqJk7HUq4/+stnjbY+CX3eq2F2S55JTZm55VGobNqNh3WBa++mm/E6xYT1ryzl
        rLyW8KBnxh3hT573WLrvL7L1UlRiKc5INNRiLipOBAAblr6ISQIAAA==
X-CMS-MailID: 20191119071406epcas1p285f075eac966cfdd6f79362ecc433d6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071406epcas1p285f075eac966cfdd6f79362ecc433d6b
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071406epcas1p285f075eac966cfdd6f79362ecc433d6b@epcas1p2.samsung.com>
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

