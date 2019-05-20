Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1809D22C0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 08:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfETG03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 02:26:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46083 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfETG03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 02:26:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so6675169pfm.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2019 23:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M29QHGrl4WPf2MIcsZiIfsIvaHh84YE3PGOJpCodWoU=;
        b=W4oNWM/AcltXE6V0EDbkptkvtjL2Bs9aRzGiSArPeiN5NMu3Mq/NXj0WqOgZl9PRPn
         Hm7/LBsWzOl5zEpxXiObhkDQ4xXQwT9MDLY9y+DQBp5K1eEyuulzWINrgMeeVfbwD29r
         KqRBUh7JTj9mKNRKD7yPsY6htG9Z6UAeKz7R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M29QHGrl4WPf2MIcsZiIfsIvaHh84YE3PGOJpCodWoU=;
        b=DoZ6BJCdfi8Wn2J//VGLrwOOIs2BiEvOhnml/X83dsWKTrBBNEFpMAKs+Gy93ML7VJ
         UQPI3+vYauBy7XCnulMqnOuNvOonkbn5GpEIXrzMGlpy5XkvJwmLB4EWr1hG1k+gbNq+
         Nl3HTOaqPSMq5B1+Wyq7ifc3xHw5+vIR6vNb/MtFFdIh171bVd09eZrGRGl/ZnblIIf1
         h/khTrZ66najaS8e039i8fZV4wggtpK3SJIQdE7FquJv3L3mWqwUp+Jl6z8kMFlEQKgp
         1zCwQemlk2oJA6qsJiHuxKnfWUIXXw8m1w6NV+QaAYyTzeTWWzLo7tDXu7WbuIVoC9h9
         N+Qg==
X-Gm-Message-State: APjAAAW47s3GCMjWqxCFYUgjYLcp001DekdHJHVqWR9zmt7iZWw/PFlM
        v83+Soq5u6Na5j9dR3CJD+qaWA==
X-Google-Smtp-Source: APXvYqzIvYEk54q9lJ3XWEqVU7YLZdcBPRc0n1wJz8ytxvXIyB0sAGTzp5WRBiAnTGHk7i7ZeI2k7A==
X-Received: by 2002:a65:48ca:: with SMTP id o10mr73791991pgs.136.1558333588492;
        Sun, 19 May 2019 23:26:28 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id 79sm29290526pfz.144.2019.05.19.23.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 23:26:27 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     nayna@linux.ibm.com, cclaudio@linux.ibm.com,
        linux-fsdevel@vger.kernel.org, greg@kroah.com,
        linuxppc-dev@lists.ozlabs.org
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [WIP RFC PATCH 6/6] fwvarfs: Add opal_secvar backend
Date:   Mon, 20 May 2019 16:25:53 +1000
Message-Id: <20190520062553.14947-7-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520062553.14947-1-dja@axtens.net>
References: <20190520062553.14947-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

COMPILE TESTED ONLY.

mount -t fwvarfs opal_secvar /fw

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/filesystems/fwvarfs.txt |   3 +
 fs/fwvarfs/Kconfig                    |  11 ++
 fs/fwvarfs/Makefile                   |   1 +
 fs/fwvarfs/fwvarfs.c                  |   3 +
 fs/fwvarfs/fwvarfs.h                  |   4 +
 fs/fwvarfs/opal_secvar.c              | 218 ++++++++++++++++++++++++++
 6 files changed, 240 insertions(+)
 create mode 100644 fs/fwvarfs/opal_secvar.c

diff --git a/Documentation/filesystems/fwvarfs.txt b/Documentation/filesystems/fwvarfs.txt
index 7c1e921e5c50..3ecc4b4428a5 100644
--- a/Documentation/filesystems/fwvarfs.txt
+++ b/Documentation/filesystems/fwvarfs.txt
@@ -36,6 +36,9 @@ Supported backends
    backend. Read-only with no creation or deletion, but sufficient that
    efivar --print --name <whatever> works the same as efivarfs.
 
+ * opal_secvar - COMPILE-TESTED ONLY implementation against PowerNV
+   OPAL Secure Variable storage.
+
 Usage
 -----
 
diff --git a/fs/fwvarfs/Kconfig b/fs/fwvarfs/Kconfig
index e4474da11dbc..cb9cbc6f8fb3 100644
--- a/fs/fwvarfs/Kconfig
+++ b/fs/fwvarfs/Kconfig
@@ -34,3 +34,14 @@ config FWVAR_FS_EFI_BACKEND
 	  in the same way the do with efivarfs.
 
 	  Say N here unless you're exploring fwvarfs.
+
+config FWVAR_FS_OPAL_SECVAR_BACKEND
+	bool "OPAL Secure Variable backend"
+	depends on FWVAR_FS
+	depends on OPAL_SECVAR
+	help
+	  Include a read-only, compile-tested-only, not up-to-date
+	  backend for OPAL Secure Variables. This is really just
+	  designed to show how the code would work, and you should
+	  only select Y here if you are developing OPAL secure
+	  variables.
diff --git a/fs/fwvarfs/Makefile b/fs/fwvarfs/Makefile
index 2ab9dfd650ca..8d258acdfef7 100644
--- a/fs/fwvarfs/Makefile
+++ b/fs/fwvarfs/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_FWVAR_FS)		+= fwvarfs.o
 
 obj-$(CONFIG_FWVAR_FS_MEM_BACKEND)		+= mem.o
 obj-$(CONFIG_FWVAR_FS_EFI_BACKEND)		+= efi.o
+obj-$(CONFIG_FWVAR_FS_OPAL_SECVAR_BACKEND)	+= opal_secvar.o
diff --git a/fs/fwvarfs/fwvarfs.c b/fs/fwvarfs/fwvarfs.c
index 643ec6585b4d..3c93b6442e95 100644
--- a/fs/fwvarfs/fwvarfs.c
+++ b/fs/fwvarfs/fwvarfs.c
@@ -24,6 +24,9 @@ static struct fwvarfs_backend *fwvarfs_backends[] = {
 #endif
 #ifdef CONFIG_FWVAR_FS_EFI_BACKEND
 	&fwvarfs_efi_backend,
+#endif
+#ifdef CONFIG_FWVAR_FS_OPAL_SECVAR_BACKEND
+	&fwvarfs_opal_secvar_backend,
 #endif
 	NULL,
 };
diff --git a/fs/fwvarfs/fwvarfs.h b/fs/fwvarfs/fwvarfs.h
index 49bde268401f..5780046dafae 100644
--- a/fs/fwvarfs/fwvarfs.h
+++ b/fs/fwvarfs/fwvarfs.h
@@ -117,4 +117,8 @@ extern struct fwvarfs_backend fwvarfs_mem_backend;
 extern struct fwvarfs_backend fwvarfs_efi_backend;
 #endif
 
+#if defined(CONFIG_FWVAR_FS_OPAL_SECVAR_BACKEND)
+extern struct fwvarfs_backend fwvarfs_opal_secvar_backend;
+#endif
+
 #endif /* FWVARFS_H */
diff --git a/fs/fwvarfs/opal_secvar.c b/fs/fwvarfs/opal_secvar.c
new file mode 100644
index 000000000000..4a1749317ed9
--- /dev/null
+++ b/fs/fwvarfs/opal_secvar.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 IBM Corporation
+ * Author: Daniel Axtens
+ *
+ * Loosely based on efivarfs:
+ * Copyright (C) 2012 Red Hat, Inc.
+ * Copyright (C) 2012 Jeremy Kerr <jeremy.kerr@canonical.com>
+ * and drivers/firmware/efi/vars.c:
+ * Copyright (C) 2001,2003,2004 Dell <Matt_Domsch@dell.com>
+ * Copyright (C) 2004 Intel Corporation <matthew.e.tolentino@intel.com>
+ *
+ * We cheat by not allowing for case-insensitivity.
+ */
+
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include "fwvarfs.h"
+
+#include <linux/uuid.h>
+#include <linux/ucs2_string.h>
+#include <asm/opal-api.h>
+#include <asm/opal-secvar.h>
+
+#define pr_fmt(fmt)	"fwvarfs: opal_secvar: " fmt
+
+static LIST_HEAD(opal_secvar_file_list);
+
+struct fwvarfs_opal_secvar_file {
+	struct list_head list;
+	u16 *name;
+	guid_t vendor;
+};
+
+// stolen from efi.h
+static inline char *
+guid_to_str(guid_t *guid, char *out)
+{
+	sprintf(out, "%pUl", guid->b);
+	return out;
+}
+
+// need a forward decl to pass down to register
+struct fwvarfs_backend fwvarfs_opal_secvar_backend;
+
+
+static ssize_t fwvarfs_opal_secvar_read(void *variable, char *buf,
+		size_t count, loff_t off)
+{
+	struct fwvarfs_opal_secvar_file *file_data = variable;
+	unsigned long datasize = 0;
+	u32 attributes;
+	void *data;
+	ssize_t size = 0;
+	loff_t ppos = off;
+	int rc;
+
+	// get size
+	rc = opal_get_secure_variable(file_data->name, &file_data->vendor,
+				      NULL, &datasize, NULL);
+	if (rc != OPAL_SUCCESS && rc != OPAL_PARTIAL)
+		return -EIO;
+
+	data = kmalloc(datasize + sizeof(attributes), GFP_KERNEL);
+
+	if (!data)
+		return -ENOMEM;
+
+	rc = opal_get_secure_variable(file_data->name, &file_data->vendor,
+		&attributes, &datasize, data + sizeof(attributes));
+	if (rc != OPAL_SUCCESS) {
+		size = -EIO;
+		goto out_free;
+	}
+
+	memcpy(data, &attributes, sizeof(attributes));
+	size = memory_read_from_buffer(buf, count, &ppos, data,
+				       datasize + sizeof(attributes));
+out_free:
+	kfree(data);
+
+	return size;
+}
+
+static int fwvarfs_opal_secvar_callback(u16 *name16, guid_t vendor,
+				unsigned long name_size)
+{
+	struct fwvarfs_opal_secvar_file *file_data;
+	char *name;
+	int len;
+	int err = -ENOMEM;
+
+	file_data = kzalloc(sizeof(*file_data), GFP_KERNEL);
+	if (!file_data)
+		return err;
+
+	file_data->name = kmemdup(name16, name_size, GFP_KERNEL);
+	if (!file_data->name)
+		goto fail;
+
+	file_data->vendor = vendor;
+
+	len = ucs2_utf8size(name16);
+
+	/* name, plus '-', plus GUID, plus NUL */
+	name = kmalloc(len + 1 + UUID_STRING_LEN + 1, GFP_KERNEL);
+	if (!name)
+		goto fail_embedded_name;
+
+	ucs2_as_utf8(name, name16, len);
+
+	name[len] = '-';
+
+	guid_to_str(&vendor, name + len + 1);
+
+	name[len + UUID_STRING_LEN + 1] = '\0';
+
+	// no convenient way to get size without reading the whole thing,
+	// present size as 0 for now.
+
+	err = fwvarfs_register_var(&fwvarfs_opal_secvar_backend, name,
+				   file_data, 0);
+	if (err)
+		goto fail_name;
+
+	INIT_LIST_HEAD(&file_data->list);
+	list_add(&opal_secvar_file_list, &file_data->list);
+
+	/* copied by the above, I think */
+	kfree(name);
+
+	return 0;
+fail_name:
+	kfree(name);
+fail_embedded_name:
+	kfree(file_data->name);
+fail:
+	kfree(file_data);
+	return err;
+}
+
+
+static void fwvarfs_opal_secvar_destroy(void *var)
+{
+	struct fwvarfs_opal_secvar_file *file_data = var;
+
+	kfree(file_data->name);
+	list_del(&file_data->list);
+	kfree(file_data);
+}
+
+
+static int fwvarfs_opal_secvar_enumerate(void)
+{
+	int err;
+	struct fwvarfs_opal_secvar_file *pos, *tmp;
+	unsigned long variable_name_size = 1024;
+	u16 *variable_name;
+	unsigned long status;
+	guid_t vendor_guid;
+
+	variable_name = kzalloc(variable_name_size, GFP_KERNEL);
+	if (!variable_name)
+		return -ENOMEM;
+
+	/*
+	 * Assume that as per EFI spec, the maximum storage allocated for both
+	 * the variable name and variable data is 1024 bytes.
+	 */
+
+	do {
+		variable_name_size = 1024;
+
+		status = opal_get_next_secure_variable(&variable_name_size,
+						variable_name,
+						&vendor_guid);
+		switch (status) {
+		case OPAL_SUCCESS:
+			err = fwvarfs_opal_secvar_callback(variable_name,
+					vendor_guid, variable_name_size);
+			if (err)
+				status = OPAL_EMPTY;
+
+			break;
+		case OPAL_EMPTY:
+			break;
+		case OPAL_UNSUPPORTED:
+			status = OPAL_EMPTY;
+			err = -ENODEV;
+		default:
+			pr_warn("opal_get_next_secure_variable: status=%lx\n",
+				status);
+			status = OPAL_EMPTY;
+			err = -EIO;
+			break;
+		}
+
+	} while (status != OPAL_EMPTY);
+
+	kfree(variable_name);
+
+	if (err) {
+		list_for_each_entry_safe(pos, tmp, &opal_secvar_file_list,
+					 list) {
+			fwvarfs_opal_secvar_destroy(pos);
+		}
+	}
+
+	return err;
+}
+
+struct fwvarfs_backend fwvarfs_opal_secvar_backend = {
+	.name = "opal_secvar",
+	.destroy = fwvarfs_opal_secvar_destroy,
+	.enumerate = fwvarfs_opal_secvar_enumerate,
+	.read = fwvarfs_opal_secvar_read,
+};
-- 
2.19.1

