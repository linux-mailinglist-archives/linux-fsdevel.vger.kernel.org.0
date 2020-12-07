Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2552D0F0E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgLGLcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgLGLcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:32:31 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61917C0613D0;
        Mon,  7 Dec 2020 03:31:45 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c79so9606637pfc.2;
        Mon, 07 Dec 2020 03:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewpiaZqTRGdJ05S6FvGPc0qF7vcc593bt6ShYsuckHQ=;
        b=RPs0JFNrA34b2v6m4o0WKzzEMoIgFha8rYwcJlJYFwLi4ku7d2HYbJ7wKa//+yfUBX
         tJ3QIj9uXjYAV7QDBPF4i8kWN/WukA9vB1cJPlVE8J6zlIPP6dECt3+Gy067gGDUNMfT
         pq4e3VandG+gI0X1miFP+Ome0AN6naVoR6X8H6B3T3wm6ewpqwDAyeGbGhKie5qRvkry
         7yhUTV47Un0jRI9sEq2r17tOIMitEH+ebYmdWLf4zCGTHh9IVoeUf8FE6QbNebsYSzAi
         pNi6cX4KjaxtUH7vfGNTEGN+cfuBtxZeaa5w5yXo88wxc/a85VdJd282dDdVw8c3iW1Q
         p9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewpiaZqTRGdJ05S6FvGPc0qF7vcc593bt6ShYsuckHQ=;
        b=sbhDI1PjE1U3BKnCMrFIfes99h7royl/4sU1UGkeL4p1CWx29sDp3xLL2JQr0NXSVP
         f7JfPKx7anfkTX054xWF7iAB9vqTXgnHWGZH27rCEiSP/N2ypkKZE5548ZiPEhtno2ut
         UTHxvcrF7mUl/gONcDN1kJivGc9I8RPxSgiX+wMuehhjJtffqPHSTG6AOWxJY+qpqRdJ
         r3rJYbTc1T2PY1aTUZAt8SNg+Ex9HDFgEub82BRY2H9JdN/otqWQi5GzNC5soXVzUoBz
         Fvcpem59njBQ2u/QlDZ5IG9lT4ELtQrIvOUqFjL14WVd9js04zfGwCZYQNCL2fC8leuW
         yz1Q==
X-Gm-Message-State: AOAM5325RfVR96+MDZLAC58QoA2fwqZDGgRv3wg4o00U5izWAMwLXQ/N
        ExEIhFlmoY9QQ10R19tM+8c=
X-Google-Smtp-Source: ABdhPJyMmiiecC7lQBFkhMTn89Ja1IhAR/H6fUYhXm8PI2Ykcxu8WlFJkRhL9epCDiG6RPld96HGHg==
X-Received: by 2002:a17:902:8341:b029:d8:d123:2297 with SMTP id z1-20020a1709028341b02900d8d1232297mr15889510pln.65.1607340704982;
        Mon, 07 Dec 2020 03:31:44 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.31.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:31:44 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [RFC V2 01/37] fs: introduce dmemfs module
Date:   Mon,  7 Dec 2020 19:30:54 +0800
Message-Id: <d3e9df357201a1dc99678128b825c79713f35e0c.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

dmemfs (Direct Memory filesystem) is device memory or reserved
memory based filesystem. This kind of memory is special as it
is not managed by kernel and it is not associated with 'struct page'.

The original purpose for dmemfs is to drop the usage of
'struct page' to save extra system memory in public cloud
enviornment.

This patch introduces the basic framework of dmemfs and only
mkdir and create regular file are supported.

Signed-off-by: Xiao Guangrong  <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/Kconfig                 |   1 +
 fs/Makefile                |   1 +
 fs/dmemfs/Kconfig          |  13 +++
 fs/dmemfs/Makefile         |   7 ++
 fs/dmemfs/inode.c          | 266 +++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/magic.h |   1 +
 6 files changed, 289 insertions(+)
 create mode 100644 fs/dmemfs/Kconfig
 create mode 100644 fs/dmemfs/Makefile
 create mode 100644 fs/dmemfs/inode.c

diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c122..18e7208 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -41,6 +41,7 @@ source "fs/btrfs/Kconfig"
 source "fs/nilfs2/Kconfig"
 source "fs/f2fs/Kconfig"
 source "fs/zonefs/Kconfig"
+source "fs/dmemfs/Kconfig"
 
 config FS_DAX
 	bool "Direct Access (DAX) support"
diff --git a/fs/Makefile b/fs/Makefile
index 999d1a2..34747ec 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -136,3 +136,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_DMEM_FS)		+= dmemfs/
diff --git a/fs/dmemfs/Kconfig b/fs/dmemfs/Kconfig
new file mode 100644
index 00000000..d2894a5
--- /dev/null
+++ b/fs/dmemfs/Kconfig
@@ -0,0 +1,13 @@
+config DMEM_FS
+	tristate "Direct Memory filesystem support"
+	help
+	  dmemfs (Direct Memory filesystem) is device memory or reserved
+	  memory based filesystem. This kind of memory is special as it
+	  is not managed by kernel and it is without 'struct page'.
+
+	  The original purpose of dmemfs is saving extra memory of
+	  'struct page' that reduces the total cost of ownership (TCO)
+	  for cloud providers.
+
+	  To compile this file system support as a module, choose M here: the
+	  module will be called dmemfs.
diff --git a/fs/dmemfs/Makefile b/fs/dmemfs/Makefile
new file mode 100644
index 00000000..73bdc9c
--- /dev/null
+++ b/fs/dmemfs/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux dmem-filesystem routines.
+#
+obj-$(CONFIG_DMEM_FS) += dmemfs.o
+
+dmemfs-y += inode.o
diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
new file mode 100644
index 00000000..0aa3d3b
--- /dev/null
+++ b/fs/dmemfs/inode.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  linux/fs/dmemfs/inode.c
+ *
+ * Authors:
+ *   Xiao Guangrong  <gloryxiao@tencent.com>
+ *   Chen Zhuo	     <sagazchen@tencent.com>
+ *   Haiwei Li	     <gerryhwli@tencent.com>
+ *   Yulei Zhang     <yuleixzhang@tencent.com>
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/file.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/capability.h>
+#include <linux/magic.h>
+#include <linux/mman.h>
+#include <linux/statfs.h>
+#include <linux/pagemap.h>
+#include <linux/parser.h>
+#include <linux/pfn_t.h>
+#include <linux/pagevec.h>
+#include <linux/fs_parser.h>
+#include <linux/seq_file.h>
+
+MODULE_AUTHOR("Tencent Corporation");
+MODULE_LICENSE("GPL v2");
+
+struct dmemfs_mount_opts {
+	unsigned long dpage_size;
+};
+
+struct dmemfs_fs_info {
+	struct dmemfs_mount_opts mount_opts;
+};
+
+enum dmemfs_param {
+	Opt_dpagesize,
+};
+
+const struct fs_parameter_spec dmemfs_fs_parameters[] = {
+	fsparam_string("pagesize", Opt_dpagesize),
+	{}
+};
+
+static int check_dpage_size(unsigned long dpage_size)
+{
+	if (dpage_size != PAGE_SIZE && dpage_size != PMD_SIZE &&
+	      dpage_size != PUD_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct inode *
+dmemfs_get_inode(struct super_block *sb, const struct inode *dir, umode_t mode);
+
+static int
+__create_file(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	struct inode *inode = dmemfs_get_inode(dir->i_sb, dir, mode);
+	int error = -ENOSPC;
+
+	if (inode) {
+		d_instantiate(dentry, inode);
+		dget(dentry);	/* Extra count - pin the dentry in core */
+		error = 0;
+		dir->i_mtime = dir->i_ctime = current_time(inode);
+		if (mode & S_IFDIR)
+			inc_nlink(dir);
+	}
+	return error;
+}
+
+static int dmemfs_create(struct inode *dir, struct dentry *dentry,
+			 umode_t mode, bool excl)
+{
+	return __create_file(dir, dentry, mode | S_IFREG);
+}
+
+static int dmemfs_mkdir(struct inode *dir, struct dentry *dentry,
+			umode_t mode)
+{
+	return __create_file(dir, dentry, mode | S_IFDIR);
+}
+
+static const struct inode_operations dmemfs_dir_inode_operations = {
+	.create		= dmemfs_create,
+	.lookup		= simple_lookup,
+	.unlink		= simple_unlink,
+	.mkdir		= dmemfs_mkdir,
+	.rmdir		= simple_rmdir,
+	.rename		= simple_rename,
+};
+
+static const struct inode_operations dmemfs_file_inode_operations = {
+	.setattr = simple_setattr,
+	.getattr = simple_getattr,
+};
+
+static const struct file_operations dmemfs_file_operations = {
+};
+
+static int dmemfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct dmemfs_fs_info *fsi = fc->s_fs_info;
+	struct fs_parse_result result;
+	int opt, ret;
+
+	opt = fs_parse(fc, dmemfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_dpagesize:
+		fsi->mount_opts.dpage_size = memparse(param->string, NULL);
+		ret = check_dpage_size(fsi->mount_opts.dpage_size);
+		if (ret) {
+			pr_warn("dmemfs: unknown pagesize %x.\n",
+				result.uint_32);
+			return ret;
+		}
+		break;
+	default:
+		pr_warn("dmemfs: unknown mount option [%x].\n",
+			opt);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct inode *dmemfs_get_inode(struct super_block *sb,
+			       const struct inode *dir, umode_t mode)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode_init_owner(inode, dir, mode);
+		inode->i_mapping->a_ops = &empty_aops;
+		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+		mapping_set_unevictable(inode->i_mapping);
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		switch (mode & S_IFMT) {
+		default:
+			init_special_inode(inode, mode, 0);
+			break;
+		case S_IFREG:
+			inode->i_op = &dmemfs_file_inode_operations;
+			inode->i_fop = &dmemfs_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_op = &dmemfs_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+
+			/*
+			 * directory inodes start off with i_nlink == 2
+			 * (for "." entry)
+			 */
+			inc_nlink(inode);
+			break;
+		case S_IFLNK:
+			inode->i_op = &page_symlink_inode_operations;
+			break;
+		}
+	}
+	return inode;
+}
+
+static int dmemfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	simple_statfs(dentry, buf);
+	buf->f_bsize = dentry->d_sb->s_blocksize;
+
+	return 0;
+}
+
+static const struct super_operations dmemfs_ops = {
+	.statfs	= dmemfs_statfs,
+	.drop_inode = generic_delete_inode,
+};
+
+static int
+dmemfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct dmemfs_fs_info *fsi = sb->s_fs_info;
+
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_blocksize = fsi->mount_opts.dpage_size;
+	sb->s_blocksize_bits = ilog2(fsi->mount_opts.dpage_size);
+	sb->s_magic = DMEMFS_MAGIC;
+	sb->s_op = &dmemfs_ops;
+	sb->s_time_gran = 1;
+
+	inode = dmemfs_get_inode(sb, NULL, S_IFDIR);
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int dmemfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, dmemfs_fill_super);
+}
+
+static void dmemfs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations dmemfs_context_ops = {
+	.free		= dmemfs_free_fc,
+	.parse_param	= dmemfs_parse_param,
+	.get_tree	= dmemfs_get_tree,
+};
+
+int dmemfs_init_fs_context(struct fs_context *fc)
+{
+	struct dmemfs_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	fsi->mount_opts.dpage_size = PAGE_SIZE;
+	fc->s_fs_info = fsi;
+	fc->ops = &dmemfs_context_ops;
+	return 0;
+}
+
+static void dmemfs_kill_sb(struct super_block *sb)
+{
+	kill_litter_super(sb);
+}
+
+static struct file_system_type dmemfs_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "dmemfs",
+	.init_fs_context = dmemfs_init_fs_context,
+	.kill_sb	= dmemfs_kill_sb,
+};
+
+static int __init dmemfs_init(void)
+{
+	int ret;
+
+	ret = register_filesystem(&dmemfs_fs_type);
+
+	return ret;
+}
+
+static void __exit dmemfs_uninit(void)
+{
+	unregister_filesystem(&dmemfs_fs_type);
+}
+
+module_init(dmemfs_init)
+module_exit(dmemfs_uninit)
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f3956fc..3fbd066 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -97,5 +97,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define Z3FOLD_MAGIC		0x33
 #define PPC_CMM_MAGIC		0xc7571590
+#define DMEMFS_MAGIC		0x2ace90c6
 
 #endif /* __LINUX_MAGIC_H__ */
-- 
1.8.3.1

