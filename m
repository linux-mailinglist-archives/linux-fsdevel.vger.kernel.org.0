Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB83F1753AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCBG0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:26:31 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42824 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgCBG01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:26:27 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200302062625epoutp03ea06546252e54210f1436131de591bd0~4aLKV8EMb2719227192epoutp03H
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2020 06:26:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200302062625epoutp03ea06546252e54210f1436131de591bd0~4aLKV8EMb2719227192epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583130385;
        bh=bFuhfagXT+uD+WWfH3ln2Yoyeb4WAlsNUzkTMPqxIwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBR0XYJrJwZ/oE3HpuS4T9BeXJHfNpmB2CEO71XTu1+12Ds+HQunNnUnGM6R4sUt3
         UoVJy3kQQ6ttokdtlHeuffegDKyyEWwcgRJHbg7wMzg++sEZrpHF9NBvDAaBnvXk98
         wnfp/nbCauqMue4BdBG3TvOaSjiCfQfYO6aUmM54=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200302062624epcas1p4226d4695c7778a95ad4bed731db61547~4aLJ7_ZTS1238812388epcas1p4D;
        Mon,  2 Mar 2020 06:26:24 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48W9C35hXBzMqYl1; Mon,  2 Mar
        2020 06:26:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.3D.57028.F07AC5E5; Mon,  2 Mar 2020 15:26:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302062623epcas1p11c5190e04bac06999674e4e41ac800d8~4aLIrBpvY2274422744epcas1p1I;
        Mon,  2 Mar 2020 06:26:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302062623epsmtrp27123d50e5b1d0ae38c9f3643431f5a5c~4aLIqSee91821918219epsmtrp2p;
        Mon,  2 Mar 2020 06:26:23 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-26-5e5ca70f9576
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.39.10238.F07AC5E5; Mon,  2 Mar 2020 15:26:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302062623epsmtip24b37e8e0e63a481a3676a78f8f7251d8~4aLIdcPCq2328723287epsmtip2t;
        Mon,  2 Mar 2020 06:26:23 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        linkinjeon@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v14 09/14] exfat: add misc operations
Date:   Mon,  2 Mar 2020 15:21:40 +0900
Message-Id: <20200302062145.1719-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302062145.1719-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmgS7/8pg4g+8tOhZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8Bicf7vcVYHbo/fvyYx
        euycdZfdY//cNeweu282sHn0bVnF6PF5k5zHoe1v2Dw2PXnLFMARlWOTkZqYklqkkJqXnJ+S
        mZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SokkJZYk4pUCggsbhYSd/Opii/
        tCRVISO/uMRWKbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ6P1/RymglbtihO7W5kb
        GE8pdTFyckgImEhcWf+MrYuRi0NIYAejxLNXn5kgnE+MEounL4XKfGOUmLZkIitMy9t1Zxkh
        EnsZJRZs2MwCkgBr+XFZsYuRg4NNQFvizxZRkLCIgLTEmf5LYFOZBRqYJJoPNLGDJIQFTCW6
        fq5hBrFZBFQlDvx4xwZi8wrYSHzadYwdYpm8xOoNB8BqOIHid3ZdYISoEZQ4OfMJ2F5moJrm
        rbOZQRZICLSzS9xofAl1qYvEnTePoQYJS7w6vgXKlpL4/G4vG8ihEgLVEh/3M0OEOxglXny3
        hbCNJW6u38AKUsIsoCmxfpc+RFhRYufvuYwQa/kk3n3tYYWYwivR0SYEUaIq0XfpMBOELS3R
        1f4BaqmHxN75n6HB1s8o0byvhXECo8IsJN/MQvLNLITNCxiZVzGKpRYU56anFhsWGCJH8CZG
        cMLVMt3BOOWczyFGAQ5GJR7eHc+j44RYE8uKK3MPMUpwMCuJ8PpyAoV4UxIrq1KL8uOLSnNS
        iw8xmgIDfiKzlGhyPjAb5JXEG5oaGRsbW5iYmZuZGiuJ8z6M1IwTEkhPLEnNTk0tSC2C6WPi
        4JRqYPRfz2OxzPDDXiaph5ML0vl/z++evyOmU1ZUdssqrVsaqw4b/DE+3BzUYR369vJ8N9Gu
        24923mdseZ/Nuyr7sKB5m+H8CM4T0ycLSiWGnF4Xd0bzwJ2bpc+XnBdrO1170uFR+q20Rya6
        9nNd8/Z2nOhv/eFanx66h7eW53X1aubC5En3A/q7NJRYijMSDbWYi4oTAR5gAoLOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXpd/eUycwanZ4hZ/Jx1jt2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLH5Mr7eYePo3k8WWf0dYLS69/8Bicf7vcVYHbo/fvyYx
        euycdZfdY//cNeweu282sHn0bVnF6PF5k5zHoe1v2Dw2PXnLFMARxWWTkpqTWZZapG+XwJXR
        +n4OU0GrdsWJ3a3MDYynlLoYOTkkBEwk3q47y9jFyMUhJLCbUeLHl1tsEAlpiWMnzjB3MXIA
        2cIShw8XQ9R8YJTY/PYxI0icTUBb4s8WUZByEaDyM/2XmEBqmAV6mCQ+T1nMBJIQFjCV6Pq5
        hhnEZhFQlTjw4x3YfF4BG4lPu46xQ+ySl1i94QBYDSdQ/M6uC4wgtpCAtcTTF3eZIeoFJU7O
        fMICspdZQF1i/TwhkDAzUGvz1tnMExgFZyGpmoVQNQtJ1QJG5lWMkqkFxbnpucWGBYZ5qeV6
        xYm5xaV56XrJ+bmbGMFRpKW5g/HykvhDjAIcjEo8vDufR8cJsSaWFVfmHmKU4GBWEuH15QQK
        8aYkVlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwMjxxzJaJTJm
        rdeqPKOzk0s6/a7djonVPVcrdl75cEsL54oakY8P3hoHaB7fqdbqdebph1+vrrjnPy2PcbB/
        6S+klf3ar/jCxRflkgtK6zIXcvSesWlmtjyy3u6hnMf8M8/CNe/x/o9W+3jqqOfvaS3ba9fO
        b+4LYH7cv2qJXtNEsfaHWoqTlyixFGckGmoxFxUnAgA9jqZZngIAAA==
X-CMS-MailID: 20200302062623epcas1p11c5190e04bac06999674e4e41ac800d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200302062623epcas1p11c5190e04bac06999674e4e41ac800d8
References: <20200302062145.1719-1-namjae.jeon@samsung.com>
        <CGME20200302062623epcas1p11c5190e04bac06999674e4e41ac800d8@epcas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of misc operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/exfat/misc.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 fs/exfat/misc.c

diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
new file mode 100644
index 000000000000..14a3300848f6
--- /dev/null
+++ b/fs/exfat/misc.c
@@ -0,0 +1,163 @@
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
+#define SECS_PER_MIN    (60)
+#define TIMEZONE_SEC(x)	((x) * 15 * SECS_PER_MIN)
+
+static void exfat_adjust_tz(struct timespec64 *ts, u8 tz_off)
+{
+	if (tz_off <= 0x3F)
+		ts->tv_sec -= TIMEZONE_SEC(tz_off);
+	else /* 0x40 <= (tz_off & 0x7F) <=0x7F */
+		ts->tv_sec += TIMEZONE_SEC(0x80 - tz_off);
+}
+
+/* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70). */
+void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		u8 tz, __le16 time, __le16 date, u8 time_ms)
+{
+	u16 t = le16_to_cpu(time);
+	u16 d = le16_to_cpu(date);
+
+	ts->tv_sec = mktime64(1980 + (d >> 9), d >> 5 & 0x000F, d & 0x001F,
+			      t >> 11, (t >> 5) & 0x003F, (t & 0x001F) << 1);
+
+
+	/* time_ms field represent 0 ~ 199(1990 ms) */
+	if (time_ms) {
+		ts->tv_sec += time_ms / 100;
+		ts->tv_nsec = (time_ms % 100) * 10 * NSEC_PER_MSEC;
+	}
+
+	if (tz & EXFAT_TZ_VALID)
+		/* Adjust timezone to UTC0. */
+		exfat_adjust_tz(ts, tz & ~EXFAT_TZ_VALID);
+	else
+		/* Convert from local time to UTC using time_offset. */
+		ts->tv_sec -= sbi->options.time_offset * SECS_PER_MIN;
+}
+
+/* Convert linear UNIX date to a EXFAT time/date pair. */
+void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms)
+{
+	struct tm tm;
+	u16 t, d;
+
+	time64_to_tm(ts->tv_sec, 0, &tm);
+	t = (tm.tm_hour << 11) | (tm.tm_min << 5) | (tm.tm_sec >> 1);
+	d = ((tm.tm_year - 80) <<  9) | ((tm.tm_mon + 1) << 5) | tm.tm_mday;
+
+	*time = cpu_to_le16(t);
+	*date = cpu_to_le16(d);
+
+	/* time_ms field represent 0 ~ 199(1990 ms) */
+	if (time_ms)
+		*time_ms = (tm.tm_sec & 1) * 100 +
+			ts->tv_nsec / (10 * NSEC_PER_MSEC);
+
+	/*
+	 * Record 00h value for OffsetFromUtc field and 1 value for OffsetValid
+	 * to indicate that local time and UTC are the same.
+	 */
+	*tz = EXFAT_TZ_VALID;
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

