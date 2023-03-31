Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3916D2BC6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Apr 2023 01:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjCaXuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 19:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjCaXuv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:50:51 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D01C1F0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 16:50:48 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id kx3-20020a17090b228300b0023cfd09ed94so11494117pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680306648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=67aN/B+WtOaSUEhiQW5ieKe9kdphJ9yXXZLhFTmAYCY=;
        b=aqbsmcr2pK1zJc/QddLocmFe7u0eN9wv3vYw/b6U0d43YucmpKQusaaQyAaVSa0brL
         LpSKYapJtGiMflg5mvZkz3d5j4vniDYYeKTW9Q4ay1SgV2A+IZ22Cf6Rxm/yGJKvgMN8
         SMKUd9my6zvqI6T79WbKu7yBu6efMqRgxeGWTlGD4T7pNs+f8J8J0byx5Zn/rGxIBacK
         RO2pdC/oG+kndVLe0/EN60h+Ufhb6JX9aJrTNcBTxw5DYOj8yvfJ2FTBeGdPqfrf3kJN
         vw3lhr7RqWCr8GoHdH9B4JRBqn6YLWfmu0XgDDbuD1vuUAihW3PD1pSNBYYD+O6dlOsv
         bwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680306648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67aN/B+WtOaSUEhiQW5ieKe9kdphJ9yXXZLhFTmAYCY=;
        b=swGgzDVVdce4MIjhNkSeo8+3bzAAs0Z3ZKqVKv5ervswr+9Tsb0B1xQKDcFTXaYjBw
         xAokp9VxDZwGhTYScxsMMmPcBDUNmSbPICdUwD6W5Pok2qihdE2smc3EWTQnB8ta1aM4
         6ycJXa07dKun/awRZDxsxnqOGlQL84Lefa0nRTA+/7F9pAfdlNUsZJeSgjEOmF+lKKBd
         ERHPUCWNJ0CgZDug3BL8VkXOp26Y85QuwskCxFvlDiYT+ragI3WxzjFCJ7V6SHtQGyc2
         QxMkN79d4NX9tVAnDpyw/q/XdAolPNzw2dapE3xrGp2ywxBFKJcp4Zf7WqbTvATYKk/Q
         pM0A==
X-Gm-Message-State: AAQBX9fSZqldMLAxsdKNXuiooqeuqB654vzx3ZCEz55X3dGbk66xX6Dq
        CPr8dpsOOn6054o1GA/h6YAK1OLo+Z1wfxnAnw==
X-Google-Smtp-Source: AKy350Y16oanl4juVqg+eyN21vJExuVR4y0XGk1EcBSjqL6yTWS/45m6tpDkpZOf1psTO3M9dHBN9cOBWfihqWNDiA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:ba0a:b0:23f:6eff:9430 with
 SMTP id s10-20020a17090aba0a00b0023f6eff9430mr9066957pjr.3.1680306648452;
 Fri, 31 Mar 2023 16:50:48 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:50:39 +0000
In-Reply-To: <cover.1680306489.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1680306489.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <592ebd9e33a906ba026d56dc68f42d691706f865.1680306489.git.ackerleytng@google.com>
Subject: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By default, the backing shmem file for a restrictedmem fd is created
on shmem's kernel space mount.

With this patch, an optional tmpfs mount can be specified via an fd,
which will be used as the mountpoint for backing the shmem file
associated with a restrictedmem fd.

This will help restrictedmem fds inherit the properties of the
provided tmpfs mounts, for example, hugepage allocation hints, NUMA
binding hints, etc.

Permissions for the fd passed to memfd_restricted() is modeled after
the openat() syscall, since both of these allow creation of a file
upon a mount/directory.

Permission to reference the mount the fd represents is checked upon fd
creation by other syscalls (e.g. fsmount(), open(), or open_tree(),
etc) and any process that can present memfd_restricted() with a valid
fd is expected to have obtained permission to use the mount
represented by the fd. This behavior is intended to parallel that of
the openat() syscall.

memfd_restricted() will check that the tmpfs superblock is
writable, and that the mount is also writable, before attempting to
create a restrictedmem file on the mount.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/syscalls.h           |  2 +-
 include/uapi/linux/restrictedmem.h |  8 ++++
 mm/restrictedmem.c                 | 74 +++++++++++++++++++++++++++---
 3 files changed, 77 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/restrictedmem.h

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f9e9e0c820c5..a23c4c385cd3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
-asmlinkage long sys_memfd_restricted(unsigned int flags);
+asmlinkage long sys_memfd_restricted(unsigned int flags, int mount_fd);

 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/restrictedmem.h b/include/uapi/linux/restrictedmem.h
new file mode 100644
index 000000000000..22d6f2285f6d
--- /dev/null
+++ b/include/uapi/linux/restrictedmem.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_RESTRICTEDMEM_H
+#define _UAPI_LINUX_RESTRICTEDMEM_H
+
+/* flags for memfd_restricted */
+#define RMFD_USERMNT		0x0001U
+
+#endif /* _UAPI_LINUX_RESTRICTEDMEM_H */
diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
index c5d869d8c2d8..f7b62364a31a 100644
--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "linux/sbitmap.h"
+#include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/pseudo_fs.h>
 #include <linux/shmem_fs.h>
 #include <linux/syscalls.h>
 #include <uapi/linux/falloc.h>
 #include <uapi/linux/magic.h>
+#include <uapi/linux/restrictedmem.h>
 #include <linux/restrictedmem.h>

 struct restrictedmem {
@@ -189,19 +190,20 @@ static struct file *restrictedmem_file_create(struct file *memfd)
 	return file;
 }

-SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
+static int restrictedmem_create(struct vfsmount *mount)
 {
 	struct file *file, *restricted_file;
 	int fd, err;

-	if (flags)
-		return -EINVAL;
-
 	fd = get_unused_fd_flags(0);
 	if (fd < 0)
 		return fd;

-	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
+	if (mount)
+		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0, VM_NORESERVE);
+	else
+		file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
+
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
 		goto err_fd;
@@ -223,6 +225,66 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
 	return err;
 }

+static bool is_shmem_mount(struct vfsmount *mnt)
+{
+	return mnt && mnt->mnt_sb && mnt->mnt_sb->s_magic == TMPFS_MAGIC;
+}
+
+static bool is_mount_root(struct file *file)
+{
+	return file->f_path.dentry == file->f_path.mnt->mnt_root;
+}
+
+static int restrictedmem_create_on_user_mount(int mount_fd)
+{
+	int ret;
+	struct fd f;
+	struct vfsmount *mnt;
+
+	f = fdget_raw(mount_fd);
+	if (!f.file)
+		return -EBADF;
+
+	ret = -EINVAL;
+	if (!is_mount_root(f.file))
+		goto out;
+
+	mnt = f.file->f_path.mnt;
+	if (!is_shmem_mount(mnt))
+		goto out;
+
+	ret = file_permission(f.file, MAY_WRITE | MAY_EXEC);
+	if (ret)
+		goto out;
+
+	ret = mnt_want_write(mnt);
+	if (unlikely(ret))
+		goto out;
+
+	ret = restrictedmem_create(mnt);
+
+	mnt_drop_write(mnt);
+out:
+	fdput(f);
+
+	return ret;
+}
+
+SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
+{
+	if (flags & ~RMFD_USERMNT)
+		return -EINVAL;
+
+	if (flags == RMFD_USERMNT) {
+		if (mount_fd < 0)
+			return -EINVAL;
+
+		return restrictedmem_create_on_user_mount(mount_fd);
+	} else {
+		return restrictedmem_create(NULL);
+	}
+}
+
 int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
 		       struct restrictedmem_notifier *notifier, bool exclusive)
 {
--
2.40.0.348.gf938b09366-goog
