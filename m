Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC42142B32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 13:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgATMpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 07:45:24 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:39366 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgATMpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:45:22 -0500
Received: by mail-pl1-f181.google.com with SMTP id g6so13155893plp.6;
        Mon, 20 Jan 2020 04:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqAJVKZA94lUuRa4sj7Fdg4g5ynZ5egEjuECG/6bwXI=;
        b=jgQsRDl/NI8GaKz3+NcE2s2ecJEk+DhnJHDSyzugsg/WCKA7xemID5ua2DzuPu5d2J
         /bO4RjD5EuF5MHh0/XPTsa7HDXEbodoAHMw1ItkykPhxMy+cPHc0gVPxnE8o4NRAUEj3
         A6BmAHSyDDzLzU+OE+AvTvSIY1qG0aMF6mFX44g0fQLx9KMZ3kDSqK56NHltv4HYGWNb
         /kpIBpS210BqfD+i0J3WJJfBK95/a+jnVKlQP5jdGiGpF/t5wyH1jRTMlO4gLVi8a3rw
         kpVuNeWpoKLXzGloavhB74GMHx15zGyb+chobUiaJSKjSlUDAt1RhK0YaRhalb0abQnJ
         zT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqAJVKZA94lUuRa4sj7Fdg4g5ynZ5egEjuECG/6bwXI=;
        b=V5DGeJFFt9J3JTziFIPVFHdK03knrvq4Li4Ox6vZPOu2DatTR9y8OfJL5Ankbl02YQ
         HRkEwKQliX1x3A4P+XRKRW3EuHNPihZSRuYFgqI5E01sn4ZojeuKHlMLTeIsdhyjxHXa
         kx5B6RvrGCyWpKNEwgVtdlnv0gWK9fmZATVVwq2fUC/r79k+ZOL6iBpTjn6dULwp+uuD
         u2x8c2nc95rvJHaCPLCCGoH6HEJeT6VR6+WJD7+3QDVRUoBDmO+Eq/Fgrm618gcZ/72M
         qiz3M2Sf9cdZ66/EGoS2JyTMOAN09rGOgAd5fKIyuHZyVMey0+3JF7Q8dHo37CHVgSry
         k67Q==
X-Gm-Message-State: APjAAAW2z0ZqTPW8UOGlhQ7PAcsgJVgkp00BOA6YWGPTcddfSXncL9ON
        qrCMC+QCFDb7xo2GMC85xeGxeRN5
X-Google-Smtp-Source: APXvYqwgpShJb/p2/aEU96wJqXH0N2kyl64piLOlfLLRdQTvwl0TyuhBtLRI5CodqymMDk/1MQeaMg==
X-Received: by 2002:a17:90a:3763:: with SMTP id u90mr23484010pjb.107.1579524321947;
        Mon, 20 Jan 2020 04:45:21 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id h3sm39184590pfo.132.2020.01.20.04.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:45:21 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v12 11/13] exfat: add Kconfig and Makefile
Date:   Mon, 20 Jan 2020 21:44:26 +0900
Message-Id: <20200120124428.17863-12-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120124428.17863-1-linkinjeon@gmail.com>
References: <20200120124428.17863-1-linkinjeon@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/Kconfig        |  3 ++-
 fs/Makefile       |  1 +
 fs/exfat/Kconfig  | 21 +++++++++++++++++++++
 fs/exfat/Makefile |  8 ++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index a3f97ca2bd46..2f14a04ad91d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -140,9 +140,10 @@ endmenu
 endif # BLOCK
 
 if BLOCK
-menu "DOS/FAT/NT Filesystems"
+menu "DOS/FAT/EXFAT/NT Filesystems"
 
 source "fs/fat/Kconfig"
+source "fs/exfat/Kconfig"
 source "fs/ntfs/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 007377f28090..17eb9d6ac886 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
+obj-$(CONFIG_EXFAT_FS)		+= exfat/
 obj-$(CONFIG_BFS_FS)		+= bfs/
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
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

