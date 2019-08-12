Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73C28A39A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfHLQnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:43:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33943 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfHLQnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:43:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so383068wme.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNLxdJdu9qzQiLDWBp8L+Elu1TKNz67ma3l41CLrMSg=;
        b=VljebWucZ9+kla1y8Yh8tnlHNKLdhyBZfPbW3fwYAB9dG0XIz0hjSRfJk0uYGAqCjG
         TrkaM10ReOzOctBnV2xDo7tj5YGshHQbIT/Vf2OTLDuyU7aIV4rQheWq4TsKEyN7i4j5
         wVjdBrFxu3UNYjotfcNE4iCjR8S5pksJZTXxiNhfi4+k7xFQB0FB55GFPWWk2ynvTYfB
         vkhpJRbMJaYdMgyrx7sJmAEyKDw/p79duSiqcn7AuN7VfFXg4iHB2Rb++l423Qp834nY
         DNRgeqhXYie5iO6LpetZKup0wwNlJspPfLw2ixTZebjCquJdCPT6haROKo7qfHT+HSb3
         cWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNLxdJdu9qzQiLDWBp8L+Elu1TKNz67ma3l41CLrMSg=;
        b=o3qjy5JaSU4rfuzQUk+x11S/3BzDW3cMYoINOZUejJ8KfO9OiA8cNRxeNJEEdualrv
         m7LhF3dsORR7HkolOzu3CUsQrNrA2knQEX7k3KPM+8o5sEjL/8j23WLWZTk9szVRCf7M
         /a+b5JwphQ8fz1PC6GH6idByGGsK0D6zeq81BH31rizFk68lwbL79xSL4Cm9v5tcLfGt
         sCJMtf6brE0lniS2Pg4PhdZu1CEn9/CBNK5sp1Ig80KW+1XliKGMLFgwDV3gNOtCVUda
         mLpF3rdchu9rm+CzAg1zbBgQ0hpwg0VMnJYE4cbkmqS68ozQuqGEYPuFt4thILpd4bKa
         misg==
X-Gm-Message-State: APjAAAXLeNHNRXIqVNheRh+G3U1aOAUfmMu3ooEPEMphd+siBmPr+GXi
        enScTfEI9QKs8viEBnc2D3TiA6ya3Uc=
X-Google-Smtp-Source: APXvYqwhMMTMhHvRwRUFYz98plC5OhIkoiPAJ2lHiv1Rm44NKQD7rACylTOl4kPa2zYnk6D74KLMFA==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr164696wmh.129.1565628189987;
        Mon, 12 Aug 2019 09:43:09 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id c15sm53431280wrb.80.2019.08.12.09.43.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:43:09 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     Boaz Harrosh <boaz@plexistor.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Boaz Harrosh <boazh@netapp.com>
Subject: [PATCH 10/16] zuf: symlink
Date:   Mon, 12 Aug 2019 19:42:38 +0300
Message-Id: <20190812164244.15580-11-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164244.15580-1-boazh@netapp.com>
References: <20190812164244.15580-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The symlink support is all hidden within the creation/open
of the inode.

As part of ZUFS_OP_NEW_INODE we also send the requested
content of the symlink for storage.

On an open of an existing symlink the link information
is returned within the zufs_inode structure via a zufs_dpp_t
pointer. (See Documentation about zufs_dpp_t pointers)

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile  |  2 +-
 fs/zuf/_extern.h |  7 +++++
 fs/zuf/inode.c   |  7 +++++
 fs/zuf/namei.c   | 27 ++++++++++++++++++
 fs/zuf/symlink.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 fs/zuf/symlink.c

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index 2bfed45723e3..04c31b7bb9ff 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -17,5 +17,5 @@ zuf-y += md.o t1.o t2.o
 zuf-y += zuf-core.o zuf-root.o
 
 # Main FS
-zuf-y += super.o inode.o directory.o namei.o file.o
+zuf-y += super.o inode.o directory.o namei.o file.o symlink.o
 zuf-y += module.o
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index bf4531ccb80e..918a6510e635 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -90,6 +90,10 @@ void zuf_set_inode_flags(struct inode *inode, struct zus_inode *zi);
 int zuf_add_dentry(struct inode *dir, struct qstr *str, struct inode *inode);
 int zuf_remove_dentry(struct inode *dir, struct qstr *str, struct inode *inode);
 
+/* symlink.c */
+uint zuf_prepare_symname(struct zufs_ioc_new_inode *ioc_new_inode,
+			const char *symname, ulong len, struct page *pages[2]);
+
 /* t1.c */
 int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma);
 
@@ -111,4 +115,7 @@ extern const struct inode_operations zuf_special_inode_operations;
 /* dir.c */
 extern const struct file_operations zuf_dir_operations;
 
+/* symlink.c */
+extern const struct inode_operations zuf_symlink_inode_operations;
+
 #endif	/*ndef __ZUF_EXTERN_H__*/
diff --git a/fs/zuf/inode.c b/fs/zuf/inode.c
index 0e6d835b4db5..539b40ecbc47 100644
--- a/fs/zuf/inode.c
+++ b/fs/zuf/inode.c
@@ -85,6 +85,9 @@ static void _set_inode_from_zi(struct inode *inode, struct zus_inode *zi)
 		inode->i_op = &zuf_dir_inode_operations;
 		inode->i_fop = &zuf_dir_operations;
 		break;
+	case S_IFLNK:
+		inode->i_op = &zuf_symlink_inode_operations;
+		break;
 	case S_IFBLK:
 	case S_IFCHR:
 	case S_IFIFO:
@@ -350,6 +353,10 @@ struct inode *zuf_new_inode(struct inode *dir, umode_t mode,
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		init_special_inode(inode, mode, rdev_or_isize);
+	} else if (symname) {
+		inode->i_size = rdev_or_isize;
+		nump = zuf_prepare_symname(&ioc_new_inode, symname,
+					   rdev_or_isize, pages);
 	}
 
 	err = _set_zi_from_inode(dir, &ioc_new_inode.zi, inode);
diff --git a/fs/zuf/namei.c b/fs/zuf/namei.c
index 299134ca7c07..e78aa04f10d5 100644
--- a/fs/zuf/namei.c
+++ b/fs/zuf/namei.c
@@ -164,6 +164,32 @@ static int zuf_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return 0;
 }
 
+static int zuf_symlink(struct inode *dir, struct dentry *dentry,
+		       const char *symname)
+{
+	struct inode *inode;
+	ulong len;
+
+	zuf_dbg_vfs("[%ld] de->name=%s symname=%s\n",
+			dir->i_ino, dentry->d_name.name, symname);
+
+	len = strlen(symname);
+	if (len + 1 > ZUFS_MAX_SYMLINK)
+		return -ENAMETOOLONG;
+
+	inode = zuf_new_inode(dir, S_IFLNK|S_IRWXUGO, &dentry->d_name,
+			       symname, len, false);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	inode->i_op = &zuf_symlink_inode_operations;
+	inode->i_mapping->a_ops = &zuf_aops;
+
+	_instantiate_unlock(dentry, inode);
+
+	return 0;
+}
+
 static int zuf_link(struct dentry *dest_dentry, struct inode *dir,
 		    struct dentry *dentry)
 {
@@ -385,6 +411,7 @@ const struct inode_operations zuf_dir_inode_operations = {
 	.lookup		= zuf_lookup,
 	.link		= zuf_link,
 	.unlink		= zuf_unlink,
+	.symlink	= zuf_symlink,
 	.mkdir		= zuf_mkdir,
 	.rmdir		= zuf_rmdir,
 	.mknod		= zuf_mknod,
diff --git a/fs/zuf/symlink.c b/fs/zuf/symlink.c
new file mode 100644
index 000000000000..1446bdf60cb9
--- /dev/null
+++ b/fs/zuf/symlink.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Symlink operations
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+
+#include "zuf.h"
+
+/* Can never fail all checks already made before.
+ * Returns: The number of pages stored @pages
+ */
+uint zuf_prepare_symname(struct zufs_ioc_new_inode *ioc_new_inode,
+			 const char *symname, ulong len,
+			 struct page *pages[2])
+{
+	uint nump;
+
+	ioc_new_inode->zi.i_size = cpu_to_le64(len);
+	if (len < sizeof(ioc_new_inode->zi.i_symlink)) {
+		memcpy(&ioc_new_inode->zi.i_symlink, symname, len);
+		return 0;
+	}
+
+	pages[0] = virt_to_page(symname);
+	nump = 1;
+
+	ioc_new_inode->hdr.len = len;
+	ioc_new_inode->hdr.offset = (ulong)symname & (PAGE_SIZE - 1);
+
+	if (PAGE_SIZE < ioc_new_inode->hdr.offset + len) {
+		pages[1] = virt_to_page(symname + PAGE_SIZE);
+		++nump;
+	}
+
+	return nump;
+}
+
+/*
+ * In case of short symlink, we serve it directly from zi; otherwise, read
+ * symlink value directly from pmem using dpp mapping.
+ */
+static const char *zuf_get_link(struct dentry *dentry, struct inode *inode,
+				struct delayed_call *notused)
+{
+	const char *link;
+	struct zuf_inode_info *zii = ZUII(inode);
+
+	if (inode->i_size < sizeof(zii->zi->i_symlink))
+		return zii->zi->i_symlink;
+
+	link = zuf_dpp_t_addr(inode->i_sb, le64_to_cpu(zii->zi->i_sym_dpp));
+	if (!link) {
+		zuf_err("bad symlink: i_sym_dpp=0x%llx\n", zii->zi->i_sym_dpp);
+		return ERR_PTR(-EIO);
+	}
+	return link;
+}
+
+const struct inode_operations zuf_symlink_inode_operations = {
+	.get_link	= zuf_get_link,
+	.update_time	= zuf_update_time,
+	.setattr	= zuf_setattr,
+	.getattr	= zuf_getattr,
+};
-- 
2.20.1

