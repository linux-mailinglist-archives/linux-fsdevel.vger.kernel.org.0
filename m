Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A30141834
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgARPEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 10:04:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37936 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgARPEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 10:04:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so13176460pgm.5;
        Sat, 18 Jan 2020 07:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGLBxBJYpMJBSqgMMxl3AhL0r+T1ONpzrTMKm6CgRtc=;
        b=u4IohG9QI+LyUs/kzJgv7vAAxunjW81Ojr765v67jPqd24PiLXLmcuPWJ63a6ZT5XA
         uSjb8NzNGEdYF+2ZKJDk6F1gI9o5xIrC5q4UpBclLwCWiWGX8hYipBa2kRl6qPweheBh
         W7SJu5pMaeua92qUaNQItWMODp3lEhf5vog8yYp/fWgM1nRBEN/rwL16ng3EThB4WjtL
         AWG0mQwkePR1G6HWs08QjZlcr+nBClatv9pwzKd8FAgX7ubzQeqeHtcd1GAuWsFBYd/3
         Id86MnP03cxBYj0neaDlrPHLi14plOACjd+dm1dvL3NUhEI10sQcL6vlscnRsNwUuzzd
         sokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGLBxBJYpMJBSqgMMxl3AhL0r+T1ONpzrTMKm6CgRtc=;
        b=RbxlSeTlIy78fEqOXU110NoHifLUxOpRW/5rQgc5OlmZ45LR/h/u42+4FtTjATkOKL
         mOeVj8Ew4+stAgixm9PSgogBs0Dx41Q0U9ZWJh56mZs8om2vhztxnDkNO/aJH5GcgMb2
         bYcxF4lpRUWo3U4m1tUfkz/uxKa9ozbKSVCVakCMg+9hjpvI9JbW3M+eCCbewW3oKp/o
         3ebGi54hHZUs6AJqF8OMeHnzp4pQ+gwsivRhKVHc5+sUYxswRmJn6S29I9HtCnIzUAyi
         PO7tclWHtQu00kJFJ++m3VOJ2hAo4syAyaGg32Qh6rAna0stA+8WlsEXhvzxqJn1iNLP
         u4Sg==
X-Gm-Message-State: APjAAAXQ4VJxKpEo0sCkDHC7DV9mtGa/oY+frRdPjpn2K5CyTJ8Nye4f
        qOsBQVePd6InLeEzZx47vi3PdDQq
X-Google-Smtp-Source: APXvYqyoa2zk2ivkKKMk4NJH0hmkl+ZC4W+oL597mtJiT8O/s0NpJ15MkAOJIjy2FgmXhFPNYQaDKw==
X-Received: by 2002:a62:8202:: with SMTP id w2mr8685863pfd.100.1579359891680;
        Sat, 18 Jan 2020 07:04:51 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v10sm32072078pgk.24.2020.01.18.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 07:04:51 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v11 11/14] exfat: add Kconfig and Makefile
Date:   Sun, 19 Jan 2020 00:03:45 +0900
Message-Id: <20200118150348.9972-12-linkinjeon@gmail.com>
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

This adds the Kconfig and Makefile for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/exfat/Kconfig  | 21 +++++++++++++++++++++
 fs/exfat/Makefile |  8 ++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile

diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
new file mode 100644
index 000000000000..f2b0cf2c16b5
--- /dev/null
+++ b/fs/exfat/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config EXFAT_FS
+	tristate "exFAT filesystem support"
+	select NLS
+	help
+	  This allows you to mount devices formatted with the exFAT file system.
+	  exFAT is typically used on SD-Cards or USB sticks.
+
+	  To compile this as a module, choose M here: the module will be called
+	  exfat.
+
+config EXFAT_DEFAULT_IOCHARSET
+	string "Default iocharset for exFAT"
+	default "utf8"
+	depends on EXFAT_FS
+	help
+	  Set this to the default input/output character set to use for
+	  converting between the encoding is used for user visible filename and
+	  UTF-16 character that exfat filesystem use. and can be overridden with
+	  the "iocharset" mount option for exFAT filesystems.
diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
new file mode 100644
index 000000000000..ed51926a4971
--- /dev/null
+++ b/fs/exfat/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for the linux exFAT filesystem support.
+#
+obj-$(CONFIG_EXFAT_FS) += exfat.o
+
+exfat-y	:= inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o \
+	   file.o balloc.o
-- 
2.17.1

