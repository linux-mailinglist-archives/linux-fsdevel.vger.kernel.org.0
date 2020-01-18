Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7159F141830
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 16:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgARPEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 10:04:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34276 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgARPEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 10:04:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so13451041pfc.1;
        Sat, 18 Jan 2020 07:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGmvAAnw9eaGVLAQsKyJhMctV4mWX9TD0G5BGJ1HZ1Y=;
        b=pW8voaC0oyv2WDreJ/DqJsvCnSzyldirlquUuc0KZ+EAl89QNJ27kFa1+/M9WZxekX
         P7A7rpWlPV8yd00dSOqjr/uqlHV9CxWcmJi33OfNVg5HOaS+z1qcp4PcLQjYd0lSKHLR
         OEvzih+ra2En2mIywnruytMZ1K0Pvi8tCQMEaLCtrrfZIDO/aBJL67mH8o2mJddfAty3
         dr8XFBTbDYvWfS0WC1GRA5guN5Cp3kF18E12n7uUGhSYnGE/7VEis0l0uOdRjuudhCyR
         o2oT481HO12GLtbopeqgDBkZN8xSt+MnAII7eJDJwrWtXbJO3gvTtw92/sOdNXCEr/xi
         1nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGmvAAnw9eaGVLAQsKyJhMctV4mWX9TD0G5BGJ1HZ1Y=;
        b=D6aFxDby3/yahCfnqkySm5Mx9KiU/74hnBsBh24d2SKFlOUr/J71ZnSeBruOiZIB5h
         LWrFh8dzcCwpvM4+gk0Xzo2N4I8/imKXAPqDxMmlNAfLxZ49U0A1ikNvPkdm8Sl8AgK1
         mUNvK1//lveKrECVj3WIxRbGQqbecEoZObMeGtgZupvbmh3w7bLyAMg59KCWxgMqnXRY
         7HtKnPyg4JT1e/m9GCKH3cxScIo7tXJToGC9oHF0Exrc4YU/eUWGA7mVLmNPDUmggBPF
         w4fGVvAl4GRRmHNS+Qw697FhPnwwMSSfJ8c7RkL6MsdcGTGU/DKA7oAGLHeWqAdDVxQ4
         8qbQ==
X-Gm-Message-State: APjAAAUPKdhuiqFrur8wZoPRvtxnj9w620iJqN5lN6LnaLgIOnt9qXHa
        QKxT3AmTgSYSveFzblE0yKVfEl1E
X-Google-Smtp-Source: APXvYqwTqkm83JMt98A5BuoZN4puzYL5ptEd4OlKNGpq/+Tb2MwKUAkR6f17sHZp7sU8pQi58sMuEw==
X-Received: by 2002:a63:d802:: with SMTP id b2mr50923952pgh.414.1579359884042;
        Sat, 18 Jan 2020 07:04:44 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v10sm32072078pgk.24.2020.01.18.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 07:04:43 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v11 09/14] exfat: add misc operations
Date:   Sun, 19 Jan 2020 00:03:43 +0900
Message-Id: <20200118150348.9972-10-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118150348.9972-1-linkinjeon@gmail.com>
References: <20200118150348.9972-1-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

This adds the implementation of misc operations for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
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

