Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BBF8A391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfHLQmv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:42:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43595 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfHLQmv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:42:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so30570044wru.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tomYsWi3MVaX9iVQ29F1A+RyVCL1vdq7gJSEqFPbu7g=;
        b=JbE/yrxqOGer4sYs8cG0frn3AkwvFQp3x73SuGQnhBbQUlG66RGwjn5LtVcGMWCDEa
         EiByPDY7QRKsnjVci83Pia8BH8NC5VlW+tej3PnoybSFNSzSuSkvkAs2FlSda8r4n8aG
         6GEQhu2w32FfcQN6i7H/feERsPZdjrdQRkjJQGAv6nJkqsEHbwVHyJCKtbANI98RGahf
         A+w5t80k6aoMRYpalv5nhU6SVKaoyqqQRdJBjkPZ56Dmh8DMMSWTp+Nqa4polpybLPDT
         HdBlJpzrv2SdbNmcfQ7QnBPnUmXmzi2UG1tyBZyB2qBODrxAL3GHIanzbTZIwmIbPQ+j
         E6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tomYsWi3MVaX9iVQ29F1A+RyVCL1vdq7gJSEqFPbu7g=;
        b=YLKL0Jit6u6oQjluD6EnT8xP1vedEs7Vp3cWP2yAQ2Cr2zZ0W1Bvym4moRcpPIuD8m
         GOfu3gONBQa2xqkIYZoJug/lV+4C8YFmu37vPJ/dOyEV7avG35yA6cZEpnDCGF6vH7tM
         pVNY6PCJES5vLEpmXs/YkQk1jJSVH2WzBjylF0DQJI8jdZqw1hoYOfYpPBfUz5O1SmCZ
         /Pe852H/+sFBhfY2ejLaljP5WYZcnF9oQ0QixFX5NmGUvf+PSCmoRqwKB+qwczkX8tMk
         RIVyak/qEi82bc592fNrUAB4uAUlY8veT6TMhr7EbN34okbP8fDg/0BD48pkgiNgi47h
         QmPw==
X-Gm-Message-State: APjAAAWcu4W956klN/3v1ePx/7EG/qVhcro0/M/sQQGpC8pzBwPyODaM
        R3qeE5ZKD20uBP9bRYnrI7ewdmx6e2I=
X-Google-Smtp-Source: APXvYqw+rFowEwgR5CBJyYWT+QoIVWmxEaEXXCYz1fvn/HGjLELH/66K8DrUHJucd6dDvoxYMh9P7Q==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr9175405wrp.42.1565628169035;
        Mon, 12 Aug 2019 09:42:49 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id i5sm8901563wrn.48.2019.08.12.09.42.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:42:48 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     Boaz Harrosh <boaz@plexistor.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Boaz Harrosh <boazh@netapp.com>
Subject: [PATCH 01/16] fs: Add the ZUF filesystem to the build + License
Date:   Mon, 12 Aug 2019 19:42:29 +0300
Message-Id: <20190812164244.15580-2-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164244.15580-1-boazh@netapp.com>
References: <20190812164244.15580-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the ZUF filesystem-in-user_mode module to the
fs/ build system.

Also added:
	* fs/zuf/Kconfig
	* fs/zuf/module.c - This file contains the LICENCE
			    of zuf code base
	* fs/zuf/Makefile - Rather empty Makefile with only
			    module.c above

I add the fs/zuf/Makefile to demonstrate that at every
patch-set stage code still compiles and there are no external
references outside of the code already submitted.

Off course only at the very last patch we have a working ZUF feeder

[LICENCE]

  zuf.ko is a GPLv2 licensed project.

  However the ZUS user mode Server is a BSD-3-Clause licensed
  project.
  Therefor you will see that:
	zus_api.h
	md_def.h
	md.h
	t2.h
  Are common files with the ZUS project. And are separately dual
  Licensed as:
	GPL-2.0 WITH Linux-syscall-note or BSD-3-Clause.

  Any code contributor to these headers should note that her/his code to
  these files only, is dual licensed.

  This is for the obvious reasons as these headers define the API between
  Kernel and the user-mode Server.

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/Kconfig       |   1 +
 fs/Makefile      |   1 +
 fs/zuf/Kconfig   |  24 ++++++++++++
 fs/zuf/Makefile  |  14 +++++++
 fs/zuf/module.c  |  28 +++++++++++++
 fs/zuf/zus_api.h | 100 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+)
 create mode 100644 fs/zuf/Kconfig
 create mode 100644 fs/zuf/Makefile
 create mode 100644 fs/zuf/module.c
 create mode 100644 fs/zuf/zus_api.h

diff --git a/fs/Kconfig b/fs/Kconfig
index bfb1c6095c7a..452244733bb5 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -261,6 +261,7 @@ source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
+source "fs/zuf/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..b007c542de45 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_ZUFS_FS)		+= zuf/
diff --git a/fs/zuf/Kconfig b/fs/zuf/Kconfig
new file mode 100644
index 000000000000..58288f4245c2
--- /dev/null
+++ b/fs/zuf/Kconfig
@@ -0,0 +1,24 @@
+config ZUFS_FS
+	tristate "ZUF - Zero-copy User-mode Feeder"
+	depends on BLOCK
+	depends on ZONE_DEVICE
+	select CRC16
+	select MEMCG
+	help
+	   ZUFS Kernel part.
+	   To enable say Y here.
+
+	   To compile this as a module,  choose M here: the module will be
+	   called zuf.ko
+
+config ZUF_DEBUG
+	bool "ZUF: enable debug subsystems use"
+	depends on ZUFS_FS
+	default n
+	help
+	  INTERNAL QA USE ONLY!!! DO NOT USE!!!
+	  Please leave as N here
+
+	  This option adds some extra code that helps
+	  in QA testing of the code. It may slow the
+	  operation and produce bigger code
diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
new file mode 100644
index 000000000000..452cec55f34d
--- /dev/null
+++ b/fs/zuf/Makefile
@@ -0,0 +1,14 @@
+#
+# ZUF: Zero-copy User-mode Feeder
+#
+# Copyright (c) 2018 NetApp Inc. All rights reserved.
+#
+# ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+#
+# Makefile for the Linux zufs Kernel Feeder.
+#
+
+obj-$(CONFIG_ZUFS_FS) += zuf.o
+
+# Main FS
+zuf-y += module.o
diff --git a/fs/zuf/module.c b/fs/zuf/module.c
new file mode 100644
index 000000000000..523633c1bf9d
--- /dev/null
+++ b/fs/zuf/module.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * zuf - Zero-copy User-mode Feeder
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <https://www.gnu.org/licenses/>.
+ */
+#include <linux/module.h>
+
+#include "zus_api.h"
+
+MODULE_AUTHOR("Boaz Harrosh <boazh@netapp.com>");
+MODULE_AUTHOR("Sagi Manole <sagim@netapp.com>");
+MODULE_DESCRIPTION("Zero-copy User-mode Feeder");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(__stringify(ZUFS_MAJOR_VERSION) "."
+		__stringify(ZUFS_MINOR_VERSION));
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
new file mode 100644
index 000000000000..4b1816e5dfd8
--- /dev/null
+++ b/fs/zuf/zus_api.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note or BSD-3-Clause */
+/*
+ * zufs_api.h:
+ *	ZUFS (Zero-copy User-mode File System) is:
+ *		zuf (Zero-copy User-mode Feeder (Kernel)) +
+ *		zus (Zero-copy User-mode Server (daemon))
+ *
+ *	This file defines the API between the open source FS
+ *	Server, and the Kernel module,
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+#ifndef _LINUX_ZUFS_API_H
+#define _LINUX_ZUFS_API_H
+
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include <linux/fiemap.h>
+#include <stddef.h>
+
+#ifdef __cplusplus
+#define NAMELESS(X) X
+#else
+#define NAMELESS(X)
+#endif
+
+/*
+ * Version rules:
+ *   This is the zus-to-zuf API version. And not the Filesystem
+ * on disk structures versions. These are left to the FS-plugging
+ * to supply and check.
+ * Specifically any of the API structures and constants found in this
+ * file.
+ * If the changes are made in a way backward compatible with old
+ * user-space, MINOR is incremented. Else MAJOR is incremented.
+ *
+ * It is up to the Server to decides if it wants to run with this
+ * Kernel or not. Version is only passively reported.
+ */
+#define ZUFS_MINORS_PER_MAJOR	1024
+#define ZUFS_MAJOR_VERSION 1
+#define ZUFS_MINOR_VERSION 0
+
+/* Kernel versus User space compatibility definitions */
+#ifdef __KERNEL__
+
+#include <linux/statfs.h>
+
+#else /* ! __KERNEL__ */
+
+/* verify statfs64 definition is included */
+#if !defined(__USE_LARGEFILE64) && defined(_SYS_STATFS_H)
+#error "include to 'sys/statfs.h' must appear after 'zus_api.h'"
+#else
+#define __USE_LARGEFILE64 1
+#endif
+
+#include <sys/statfs.h>
+
+#include <string.h>
+
+#define u8 uint8_t
+#define umode_t uint16_t
+
+#define PAGE_SHIFT     12
+#define PAGE_SIZE      (1 << PAGE_SHIFT)
+
+#ifndef __packed
+#	define __packed __attribute__((packed))
+#endif
+
+#ifndef ALIGN
+#define ALIGN(x, a)		ALIGN_MASK(x, (typeof(x))(a) - 1)
+#define ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#endif
+
+#ifndef likely
+#define likely(x_)	__builtin_expect(!!(x_), 1)
+#define unlikely(x_)	__builtin_expect(!!(x_), 0)
+#endif
+
+#ifndef BIT
+#define BIT(b)  (1UL << (b))
+#endif
+
+/* RHEL/CentOS7 are missing these */
+#ifndef FALLOC_FL_UNSHARE_RANGE
+#define FALLOC_FL_UNSHARE_RANGE         0x40
+#endif
+#ifndef FALLOC_FL_INSERT_RANGE
+#define FALLOC_FL_INSERT_RANGE		0x20
+#endif
+
+#endif /*  ndef __KERNEL__ */
+
+#endif /* _LINUX_ZUFS_API_H */
-- 
2.20.1

