Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64622143D78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAUM6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 07:58:23 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:33564 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgAUM6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:58:22 -0500
Received: by mail-pl1-f176.google.com with SMTP id ay11so1321600plb.0;
        Tue, 21 Jan 2020 04:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ncP6r9SqbKvcu4jkl8YedIhqcVSgVT3D2xzDadpOcg=;
        b=DoFzgO64Gd7r+JsnXe/fx6QjTzX6ntcn15Wkna6QIgChMBa8/pParXQbpJo30julGb
         648FZH28syWD+sToY+Q/kSQTSIY7l8pw6mhxZP13c8xwfa4N7Qj9Ce8GAfHmoRBBeoAx
         wQ/YifICtY0z6DQXTWIGAPwA413g7bbCLsy3r0E5KRfqie31iMjvjj1NC369C5+aJeTk
         rCukJyTs8JcStvWKm13QJckgWaJu5mcinps6x9MVbr05zw/1/AM/+uJyVTZ3yC1bn/kW
         8H8PGgsij3zDtpKzAaCkKAGJPHRFqZdtpzxN4YhkJ37blSsGNESXO4INx/cd5w9LUKfj
         Kznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ncP6r9SqbKvcu4jkl8YedIhqcVSgVT3D2xzDadpOcg=;
        b=AtfMaRdI3uSQn1oza7EHClmDLkBpLHDv1JQOwLBPSr26gK+e8CiBBMC9f40/J4eJ1e
         QqQdf3vE7pV7nnz+os/pNZB8VQiNFKs6QGwtNVQ1KPDLgNXvJEkFyiGhA9cYvi22lCwf
         IO6HFqotmlQAqMHh403olz695eiKxcvjPnxDllGXHnxtBVg14dzoD3k0xPbsl8+VZsQM
         d5Efq9ItF6n3JvHbSZDf4m2k1l7Ep/tiTunM6FEJEJj0YT5nS7Ot6Vr6k/5E0Z1WL1I2
         Cn7KZs94RZGT+bzlKywW03k1YVR2eH7VRvhniXdmp6MbCOHMaM23z51iWxfrqb1QgKk4
         N0xQ==
X-Gm-Message-State: APjAAAV5RuLqNOrzDqFVTwhvAHGCwqwiMlC4WmYuqUDShXcNoPiUXUpy
        3MSTHX7+Y0lReCLAZMwCH+04yg0N
X-Google-Smtp-Source: APXvYqwuQifphStWzcjtkS20HKkZANWl4DFCvXiKAPj7WjMIZBp7Khw60O+ny4/xdbfNITj2HbUVew==
X-Received: by 2002:a17:90a:222c:: with SMTP id c41mr5078929pje.35.1579611501924;
        Tue, 21 Jan 2020 04:58:21 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v4sm43130132pfn.181.2020.01.21.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 04:58:21 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, viro@zeniv.linux.org.uk,
        Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v13 11/13] exfat: add Kconfig and Makefile
Date:   Tue, 21 Jan 2020 21:57:25 +0900
Message-Id: <20200121125727.24260-12-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121125727.24260-1-linkinjeon@gmail.com>
References: <20200121125727.24260-1-linkinjeon@gmail.com>
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
+	  UTF-16 character that exfat filesystem use, and can be overridden with
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

