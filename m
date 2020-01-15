Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A7513BAF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAOI2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:28:34 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:55806 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgAOI23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:29 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200115082826epoutp025edd745fbccb82cf8270a46beef38e4f~qAhSU3VVO2048120481epoutp020
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:28:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200115082826epoutp025edd745fbccb82cf8270a46beef38e4f~qAhSU3VVO2048120481epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579076906;
        bh=jsH5G013RLxSFl8WtPQKej8XbWO9bHMjwKKIk/bUPp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+CxrWfqiROAvjDuXEM0abZDRD0Cvhzao/Ixka4DaUEJRS7ktfH8peD5qRO3hE/jx
         Rcz9PVPHNJdGJ42P19T+UI3UYbo0df1Mgs6EyGZdHwKZoZMupALsGxpskUNpgbL0q0
         G8gaJ9JD6myoVss3Yi1qB5i85VCd1MJad/S4MeBk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200115082826epcas1p3b7f46bbf7398b600c43dbca79b58fa71~qAhRwxbay0348603486epcas1p3m;
        Wed, 15 Jan 2020 08:28:26 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47yL7Y20SdzMqYkp; Wed, 15 Jan
        2020 08:28:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.AE.57028.82DCE1E5; Wed, 15 Jan 2020 17:28:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276~qAhPz06vv3123831238epcas1p4y;
        Wed, 15 Jan 2020 08:28:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200115082824epsmtrp16c3dbf6ac9ea2d8ca41b194adf198f9e~qAhPzC-kY0486104861epsmtrp1A;
        Wed, 15 Jan 2020 08:28:24 +0000 (GMT)
X-AuditID: b6c32a35-974d39c00001dec4-78-5e1ecd285993
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.3C.06569.72DCE1E5; Wed, 15 Jan 2020 17:28:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082823epsmtip1e4708795331454c4b85de549bdb04126~qAhPmrz4l0431104311epsmtip1S;
        Wed, 15 Jan 2020 08:28:23 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        arnd@arndb.de, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v10 09/14] exfat: add misc operations
Date:   Wed, 15 Jan 2020 17:24:42 +0900
Message-Id: <20200115082447.19520-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115082447.19520-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTQFfjrFycQfsEUYu/k46xWzQvXs9m
        sXL1USaL63dvMVvs2XuSxeLyrjlsFj+m11tMPP2byWLLvyOsFpfef2Bx4PL4/WsSo8fOWXfZ
        PfbPXcPusftmA5tH35ZVjB6fN8l5HNr+hi2APSrHJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7U
        zMBQ19DSwlxJIS8xN9VWycUnQNctMwfoPCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJq
        QUpOgaFBgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk5G+/fNTAWLtCo+TJ3P2MA4QamLkZNDQsBE
        4sPaNyxdjFwcQgI7GCW+b7zJCuF8YpT4MPkZVOYbo8TyhcdYYFp+r5jCDpHYyyjxcMFZhJbb
        i6cBVXFwsAloS/zZIgrSICJgL7F59gGwScwCBxkl3lyYyw6SEBYwleiddI8NpJ5FQFViwhZD
        EJNXwFaieQkTxC55idUbDjCD2JxA4SNbLoPtlRA4wiZxsOk5M0SRi8SHPdehjhOWeHV8CzuE
        LSXxsr+NHWSmhEC1xMf9UOUdjBIvvttC2MYSN9dvYAUpYRbQlFi/Sx8irCix8/dcRhCbWYBP
        4t3XHlaIKbwSHW1CECWqEn2XDkNdKS3R1f4BaqmHRM/qHmjoTGCUuPDnDMsERrlZCBsWMDKu
        YhRLLSjOTU8tNiwwRI6vTYzg1KdluoNxyjmfQ4wCHIxKPLwKd2TjhFgTy4orcw8xSnAwK4nw
        npwBFOJNSaysSi3Kjy8qzUktPsRoCgzGicxSosn5wLScVxJvaGpkbGxsYWJmbmZqrCTO67JA
        Lk5IID2xJDU7NbUgtQimj4mDU6qBcduNOu7AsP07Avhuy37cmRoR/t+1WWWR+qLWDcdqJzlt
        P2qasyzvg8DcULG1Bu6fj71+XlTktGGBD9OCrx+f2fA8O/RwhvaHTSuPxC45fMNy1+vT/h/W
        5HUrCEccYpAs333mp82a+fPNNb6u6zrrzBU5Lfafg67ixNCwF11VJ7X+n+Pk0Gu8e1KJpTgj
        0VCLuag4EQAwK1JikwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnK76Wbk4g/XLrS3+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HFgcvj969JjB47Z91l
        99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA9igum5TUnMyy1CJ9uwSujPbvm5kKFmlVfJg6
        n7GBcYJSFyMnh4SAicTvFVPYuxi5OIQEdjNK7P7+iQUiIS1x7MQZ5i5GDiBbWOLw4WKImg+M
        EocPbmIEibMJaEv82SIKUi4i4CjRu+swC0gNs8BpRonujQ+ZQBLCAqYSvZPusYHUswioSkzY
        Yghi8grYSjQvYYLYJC+xesMBZhCbEyh8ZMtldhBbSMBGYtqTk0wTGPkWMDKsYpRMLSjOTc8t
        Niwwykst1ytOzC0uzUvXS87P3cQIDlAtrR2MJ07EH2IU4GBU4uFVuCMbJ8SaWFZcmXuIUYKD
        WUmE9+QMoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQZG
        P2utoO3XtnOwld7Vuy1+Y6WHQIn21YQJ07+HnXhpHH6Cd8776Mu/JxQuzOHbsPTI4mo3L9YZ
        mvbvBPeo2N2+GPCcO7TqjMXZiYd2qYUnLLRkcU4RaRaT+HY4rFqkzybyWV9gVNaqMrZqOztf
        sacuWv0Z127+m1IVdtnNVSXVbVnG88VzGA4rsRRnJBpqMRcVJwIAVRVptkwCAAA=
X-CMS-MailID: 20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
        <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of misc operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/misc.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 fs/exfat/misc.c

diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
new file mode 100644
index 000000000000..ed3dae7b54c3
--- /dev/null
+++ b/fs/exfat/misc.c
@@ -0,0 +1,162 @@
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
+static inline int exfat_tz_offset(struct exfat_sb_info *sbi)
+{
+	if (sbi->options.time_offset)
+		return sbi->options.time_offset;
+	return sys_tz.tz_minuteswest;
+}
+
+/* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70). */
+void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		__le16 time, __le16 date, u8 tz)
+{
+	u16 t = le16_to_cpu(time);
+	u16 d = le16_to_cpu(date);
+
+	ts->tv_sec = mktime64(1980 + (d >> 9), d >> 5 & 0x000F, d & 0x001F,
+			      t >> 11, (t >> 5) & 0x003F, (t & 0x001F) << 1);
+	ts->tv_nsec = 0;
+
+	if (tz & EXFAT_TZ_VALID)
+		/* Treat as UTC time, but need to adjust timezone to UTC0 */
+		exfat_adjust_tz(ts, tz & ~EXFAT_TZ_VALID);
+	else
+		/* Treat as local time */
+		ts->tv_sec -= exfat_tz_offset(sbi) * SECS_PER_MIN;
+}
+
+/* Convert linear UNIX date to a EXFAT time/date pair. */
+void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
+		__le16 *time, __le16 *date, u8 *tz)
+{
+	struct tm tm;
+	u16 t, d;
+
+	/* clamp to the range valid in the exfat on-disk representation. */
+	time64_to_tm(clamp_t(time64_t, ts->tv_sec, EXFAT_MIN_TIMESTAMP_SECS,
+		EXFAT_MAX_TIMESTAMP_SECS), -exfat_tz_offset(sbi) * SECS_PER_MIN,
+		&tm);
+	t = (tm.tm_hour << 11) | (tm.tm_min << 5) | (tm.tm_sec >> 1);
+	d = ((tm.tm_year - 80) <<  9) | ((tm.tm_mon + 1) << 5) | tm.tm_mday;
+
+	*time = cpu_to_le16(t);
+	*date = cpu_to_le16(d);
+
+	/*
+	 * exfat ondisk tz offset field decribes the offset from UTF
+	 * in 15 minute interval.
+	 */
+	*tz = ((exfat_tz_offset(sbi) / -15) & 0x7F) | EXFAT_TZ_VALID;
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

