Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD9183A71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 21:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCLUNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 16:13:17 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:44785 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgCLUNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:13:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B69C63FB;
        Thu, 12 Mar 2020 16:03:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 12 Mar 2020 16:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=M+E5QimJJ7S/c
        0nKhArR5IdwBJvASG/qtOi1ZOkT6yA=; b=JGm4dO18SVZ5FcqsDbXSVe4TdpgPF
        zLvvjh8TQa8gOTfTMMGRXos50yXcuJ1+LjHzMT4QCCeZUD/thfqaSG0vaWr/0T95
        7sS6nG+pq+6KF13VFneUyYLvaY9wrT9Crg4tJjV65f/gWkEht8Vy8d4bQGz7OCS5
        xikbJsyThKRhhhdcdl0/wB8XtMiuohQ5SlT+xI6PFbpigu2IiFsPolmw2l6E+QXR
        /f8HiB5CCCoCJxG1b2P41GYcW6PGeN8J04Rkw0R83j3T+uWvFj9O0a1zmsUDwmuF
        Dj0CpZnpKkeFPHQ7/fBry8MP91xBNbx74yXxCQ4Qy2I2AFXZBVXosyitQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=M+E5QimJJ7S/c0nKhArR5IdwBJvASG/qtOi1ZOkT6yA=; b=sFipKrES
        rSQN0eoxoTc/5d5dYtVFBcjeJvFrIWx1LwVmMrE27WSSri8MmFyaLBRVqtc/DWqb
        V+8nXWO499l8awPYKB43jR1m/llPY0u3AD1R0oUKLSWevraVMp/nCNzTZhVW7YuX
        aKyNe63BKSWZfLMIYxjcPf8CLhzQ87WlasoIljdjoljiTI//2cnjh7WTTWh2sWRL
        MvbhX1/GaUcQJ6v3M6ykQ+/hi13uhfZoKaKX5VIBxqrdVrWElcKTpd3bjIi42XzL
        QTEOw3fyIjii5jESP2XoD302nOGs1uGhX+f8gxGMHvs+W7LGTD7pw1T8u78D5Fz5
        +WdwiggmkrKnCg==
X-ME-Sender: <xms:nZVqXnWsO3GIV39wrGhnq5_rLLSobh-8ZpO-lUl6e9-gKrlrUaKuXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrdegnecuve
    hluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:nZVqXnBvWXjvK_8hAo96471koUmU-TGxDJkdH6wgV602MJFkl6UOUQ>
    <xmx:nZVqXsUeOsUY2rPG0oqZJ9t7akWt9Ni3AiK2VCP7CAN0kdqM-UyY1w>
    <xmx:nZVqXtSS89FwKAVX72yw3FV52yKSt7HKdMnhDFFrXP-7Gt0QH8ASIw>
    <xmx:nZVqXgbw1tGuZy4EeoTniIes1UwQJfVwI2kh2vPeXwSNtxauaIHB6okUPus>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 018163060F09;
        Thu, 12 Mar 2020 16:03:39 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, viro@zeniv.linux.org.uk
Cc:     Daniel Xu <dxu@dxuuu.xyz>, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Subject: [PATCH v3 3/4] kernfs: Add option to enable user xattrs
Date:   Thu, 12 Mar 2020 13:03:16 -0700
Message-Id: <20200312200317.31736-4-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312200317.31736-1-dxu@dxuuu.xyz>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

User extended attributes are useful as metadata storage for kernfs
consumers like cgroups. Especially in the case of cgroups, it is useful
to have a central metadata store that multiple processes/services can
use to coordinate actions.

A concrete example is for userspace out of memory killers. We want to
let delegated cgroup subtree owners (running as non-root) to be able to
say "please avoid killing this cgroup". This is especially important for
desktop linux as delegated subtrees owners are less likely to run as
root.

This patch introduces a new flag, KERNFS_ROOT_SUPPORT_USER_XATTR, that
lets kernfs consumers enable user xattr support. An initial limit of 128
entries or 128KB -- whichever is hit first -- is placed per cgroup
because xattrs come from kernel memory and we don't want to let
unprivileged users accidentally eat up too much kernel memory.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/kernfs/inode.c           | 89 +++++++++++++++++++++++++++++++++++++
 fs/kernfs/kernfs-internal.h |  2 +
 include/linux/kernfs.h      | 11 ++++-
 3 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 5f10ae95fbfa..fc2469a20fed 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -53,6 +53,8 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
 	kn->iattr->ia_ctime = kn->iattr->ia_atime;
 
 	simple_xattrs_init(&kn->iattr->xattrs);
+	atomic_set(&kn->iattr->nr_user_xattrs, 0);
+	atomic_set(&kn->iattr->user_xattr_size, 0);
 out_unlock:
 	ret = kn->iattr;
 	mutex_unlock(&iattr_mutex);
@@ -327,6 +329,86 @@ static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
 	return kernfs_xattr_set(kn, name, value, size, flags);
 }
 
+static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
+				     const char *full_name,
+				     struct simple_xattrs *xattrs,
+				     const void *value, size_t size, int flags)
+{
+	atomic_t *sz = &kn->iattr->user_xattr_size;
+	atomic_t *nr = &kn->iattr->nr_user_xattrs;
+	ssize_t removed_size;
+	int ret;
+
+	if (atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
+		ret = -ENOSPC;
+		goto dec_count_out;
+	}
+
+	if (atomic_add_return(size, sz) > KERNFS_USER_XATTR_SIZE_LIMIT) {
+		ret = -ENOSPC;
+		goto dec_size_out;
+	}
+
+	ret = simple_xattr_set(xattrs, full_name, value, size, flags,
+			       &removed_size);
+
+	if (!ret && removed_size >= 0)
+		size = removed_size;
+	else if (!ret)
+		return 0;
+dec_size_out:
+	atomic_sub(size, sz);
+dec_count_out:
+	atomic_dec(nr);
+	return ret;
+}
+
+static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
+				    const char *full_name,
+				    struct simple_xattrs *xattrs,
+				    const void *value, size_t size, int flags)
+{
+	atomic_t *sz = &kn->iattr->user_xattr_size;
+	atomic_t *nr = &kn->iattr->nr_user_xattrs;
+	ssize_t removed_size;
+	int ret;
+
+	ret = simple_xattr_set(xattrs, full_name, value, size, flags,
+			       &removed_size);
+
+	if (removed_size >= 0) {
+		atomic_sub(removed_size, sz);
+		atomic_dec(nr);
+	}
+
+	return ret;
+}
+
+static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
+				     struct dentry *unused, struct inode *inode,
+				     const char *suffix, const void *value,
+				     size_t size, int flags)
+{
+	const char *full_name = xattr_full_name(handler, suffix);
+	struct kernfs_node *kn = inode->i_private;
+	struct kernfs_iattrs *attrs;
+
+	if (!(kernfs_root(kn)->flags & KERNFS_ROOT_SUPPORT_USER_XATTR))
+		return -EOPNOTSUPP;
+
+	attrs = kernfs_iattrs(kn);
+	if (!attrs)
+		return -ENOMEM;
+
+	if (value)
+		return kernfs_vfs_user_xattr_add(kn, full_name, &attrs->xattrs,
+						 value, size, flags);
+	else
+		return kernfs_vfs_user_xattr_rm(kn, full_name, &attrs->xattrs,
+						value, size, flags);
+
+}
+
 static const struct xattr_handler kernfs_trusted_xattr_handler = {
 	.prefix = XATTR_TRUSTED_PREFIX,
 	.get = kernfs_vfs_xattr_get,
@@ -339,8 +421,15 @@ static const struct xattr_handler kernfs_security_xattr_handler = {
 	.set = kernfs_vfs_xattr_set,
 };
 
+static const struct xattr_handler kernfs_user_xattr_handler = {
+	.prefix = XATTR_USER_PREFIX,
+	.get = kernfs_vfs_xattr_get,
+	.set = kernfs_vfs_user_xattr_set,
+};
+
 const struct xattr_handler *kernfs_xattr_handlers[] = {
 	&kernfs_trusted_xattr_handler,
 	&kernfs_security_xattr_handler,
+	&kernfs_user_xattr_handler,
 	NULL
 };
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 2f3c51d55261..7ee97ef59184 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -26,6 +26,8 @@ struct kernfs_iattrs {
 	struct timespec64	ia_ctime;
 
 	struct simple_xattrs	xattrs;
+	atomic_t		nr_user_xattrs;
+	atomic_t		user_xattr_size;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index dded2e5a9f42..89f6a4214a70 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -37,8 +37,10 @@ enum kernfs_node_type {
 	KERNFS_LINK		= 0x0004,
 };
 
-#define KERNFS_TYPE_MASK	0x000f
-#define KERNFS_FLAG_MASK	~KERNFS_TYPE_MASK
+#define KERNFS_TYPE_MASK		0x000f
+#define KERNFS_FLAG_MASK		~KERNFS_TYPE_MASK
+#define KERNFS_MAX_USER_XATTRS		128
+#define KERNFS_USER_XATTR_SIZE_LIMIT	(128 << 10)
 
 enum kernfs_node_flag {
 	KERNFS_ACTIVATED	= 0x0010,
@@ -78,6 +80,11 @@ enum kernfs_root_flag {
 	 * fhandle to access nodes of the fs.
 	 */
 	KERNFS_ROOT_SUPPORT_EXPORTOP		= 0x0004,
+
+	/*
+	 * Support user xattrs to be written to nodes rooted at this root.
+	 */
+	KERNFS_ROOT_SUPPORT_USER_XATTR		= 0x0008,
 };
 
 /* type-specific structures for kernfs_node union members */
-- 
2.21.1

