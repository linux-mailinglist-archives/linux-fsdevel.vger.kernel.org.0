Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9831020EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKSJkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:40:31 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:28226 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSJkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:40:31 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191119094029epoutp033fe3b2aa201e28b794f3004c6d54d70a~Yhu6ky0zi1901719017epoutp03L
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 09:40:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191119094029epoutp033fe3b2aa201e28b794f3004c6d54d70a~Yhu6ky0zi1901719017epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574156429;
        bh=XpygHjuf8d7CE3zc20VcrTtJAW5giJFyIx169VoIE/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0k8ymTBt3aQWFU9gjypZzZ4G1hzVt3NMJOoofGbNfP9ZwsEv4mIaWTk1AXWiJPcG
         m+FzbuUYKNguGEkS3Y+yE7ZUdB2pzTjKYUE69sbNqIQ2bEybTAP6r2nCV+k3AT5lx6
         HZ5r4mViGYire+bB1BFpbeHCUgVyfWsrjMq6uHaY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191119094028epcas1p228282a1ee2c2b55f649efbc7f574d07c~Yhu5tjGWV0818108181epcas1p2N;
        Tue, 19 Nov 2019 09:40:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47HLQz35fRzMqYkg; Tue, 19 Nov
        2019 09:40:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.BF.04237.A88B3DD5; Tue, 19 Nov 2019 18:40:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094025epcas1p2bbb3121ac9f1d427f09f6548b8d35dbb~Yhu3AtP3s1035810358epcas1p2T;
        Tue, 19 Nov 2019 09:40:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119094025epsmtrp1e0408cbcdc7c2c2aa15136d9b6f7c3f5~Yhu3ADYhZ0080100801epsmtrp1q;
        Tue, 19 Nov 2019 09:40:25 +0000 (GMT)
X-AuditID: b6c32a39-913ff7000000108d-bd-5dd3b88a2f29
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.92.03814.988B3DD5; Tue, 19 Nov 2019 18:40:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094025epsmtip259c1b575cd4f21dfa5534a45e6bb6d9a~Yhu23d9Vx0817608176epsmtip2D;
        Tue, 19 Nov 2019 09:40:25 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v3 09/13] exfat: add misc operations
Date:   Tue, 19 Nov 2019 04:37:14 -0500
Message-Id: <20191119093718.3501-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119093718.3501-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTn2727u4qLy9T8UnDrgpTvzTm9hutBEReSkKSCSOZFrw/cq90p
        qX+kFD5GmBVhzIyelg/SatnUXujMRySaPVCzUKPXojTNzMzadnv99zu/8zvnd77zHRyRHMIC
        8Ry9mTXpGS2JeaOtXaFRkRb7cKr80gkvqmvqmIg6eL4Zo+obuwXUs/FRhLp1uw+lhttPYdRP
        6xshtVB9gLItO4TUo0/T6EZvus06LqLv1jaJ6I6RYoyutDUA+vqDInr2WjDdefMDRo+9bkWT
        8T3axGyWyWBNMlafbsjI0WepyW0pms0aVZxcEalIoOJJmZ7RsWpyS1Jy5NYcrWtEUpbPaPNc
        VDLDcWT0+kSTIc/MyrINnFlNssYMrVEhN0ZxjI7L02dFpRt06xRyeYzKpUzTZpdcsAPj44T9
        N56XiopBf4QFeOGQiIUn+gcEFuCNSwg7gM7xXhEffAbwxZM5lA/mARys6sL+lJTXtArcWELc
        BrC22+dvxXTbYaEF4DhGhMMlm79b40dsgNdr7nkaIYQDwLdzVSJ3wtfVaMrZgLgxSoTAq9YK
        j4GYSIQllsMobyaFjS33PBovFz9RUwfcjSDRi8H5njHUbQaJLbC/Q8rrfeH7HpuIx4Hw3ZFS
        ES8pgjN3EZ4ud83wVc1jJRxpbvGMjBChsLk9mqdXw7bvtcCNEWIF/PiFfxUkxLC8VMJLQmDl
        oy4Bj4OgpWz6tykNH07OCvmNHAHw8uKysAoEW/85nAGgAaxkjZwui+UURtX//3UNeC4wLMEO
        7g8kdQICB6SPWLZmOFUiZPK5Al0ngDhC+om3Tw6mSsQZTEEhazJoTHlalusEKtcejyKB/ukG
        1z3rzRqFKkapVFKxcfFxKiUZIMYXhlIlRBZjZnNZ1sia/tQJcK/AYjA0EZGANxZappak6rTz
        +UvljuOnd4SnfRscndwb9HZfr3M2tGlAaltlPamrMZ5l5Np+JvqD74aW1dIJB179qmCxcirk
        pS6p7mksxp7dedR7FM9t0G+idldMrv1x0eHcBe1PUzJjWjXVzp7M/fV924rKzt2ZiJC9dNwK
        mJFdEZMkymUzijDExDG/AEg+UZWXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvG7njsuxBjObJC0OP57EbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyf9ZzV4sf0eost/46wWlx6/4HFgctj56y77B77565h
        99h9s4HNo2/LKkaPzaerPT5vkvM4tP0Nm8ftZ9tYAjiiuGxSUnMyy1KL9O0SuDIal+xgLLhi
        WbH1Tht7A+MpnS5GTg4JAROJjtnbmLoYuTiEBHYzShx9vpgRIiEtcezEGeYuRg4gW1ji8OFi
        iJoPjBJrHyxjAYmzCWhL/NkiClIuIuAo0bvrMAtIDbPAOUaJnc+Wgc0RBlrw+PUqZhCbRUBV
        YuOsTjYQm1fARqKxq4cFYpe8xOoNB8BqOIHiD2dD9AoJWEs0Pmpmn8DIt4CRYRWjZGpBcW56
        brFhgVFearlecWJucWleul5yfu4mRnCwamntYDxxIv4QowAHoxIP7wmVy7FCrIllxZW5hxgl
        OJiVRHj9Hl2IFeJNSaysSi3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp
        1cBosu/+srevw1Nv2ewuX1wZufrCxiUzpOK/h5k+vGoeLCZSrjz/OJ+Yr+3bSdnXi2Yunxoq
        VjlbKTU/R9M8ap/TXcNjISo+wRs3Lqwy77l//+H3S//Ut20z2xyrmL+uSE7SUCP4k/y7N5WP
        k3yLmdyfWHw3lk/S2CT064Q3h0TWk9sOK5dkC39WYinOSDTUYi4qTgQAZoaluVICAAA=
X-CMS-MailID: 20191119094025epcas1p2bbb3121ac9f1d427f09f6548b8d35dbb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119094025epcas1p2bbb3121ac9f1d427f09f6548b8d35dbb
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
        <CGME20191119094025epcas1p2bbb3121ac9f1d427f09f6548b8d35dbb@epcas1p2.samsung.com>
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

