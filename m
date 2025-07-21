Return-Path: <linux-fsdevel+bounces-55578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C6B0BFA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D357A56B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB64289835;
	Mon, 21 Jul 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L0uJSn30";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JLHNvto+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88183211A27;
	Mon, 21 Jul 2025 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088709; cv=none; b=Ocvz7SeMkEIEle5+Kr9inckAqWckPJ6osXw4JJ7jEDVeOGw4jT74GtHGXbAp/MaYXbdZUprn3VFDM1dSGXhYNALiv+po99R85CGSepLZSzzHmJpOGz67iU0McdPtvTqS0EysHULnWX+Hi4xkclVmGQWHa/GsqedpbRxvZr8QP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088709; c=relaxed/simple;
	bh=iOBH17w0ZfmjIqdV03ANhka+3PqNUYKXkRmFiiERdEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scxMNCCqhL+T789x9eoOEVQfMT7i7vIWbLGkzcrUfPmCJeyH3F7Y9uO/qF7ScDDu9dqgwlv1n3iRq/nLgFEQ27ndx4WlC1ejo+49WUiAh6M3D9n5bd++1RvZK7AA++gz7IofTPXM921+9j712LiKc/0bi63T3ZoVKEXjSG8+J1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L0uJSn30; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JLHNvto+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753088705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ2msJqJ/vaREGPCHC7y6gOD7AxqqhvZjn/budPvPHo=;
	b=L0uJSn30BhIO40l4NTJh80EUJil78Lh97hO2pknoonTYMt9/y7kv8QlhCWL3akqs0BHVOu
	HGGs6EcxzU048qV+FvFMZOg3Jldu3yt/C/Y/HuEAOgjPG5fYMgMoYa5MdcWfHUtTgbWpWP
	9dbFXwPLk/1oGQ3uKDwjBGz8Qbbzb1x8UFVgvRVfwOldMt2H+fb3TgvlZFmWVereSNqQyG
	uDp/4X0wtuo9N203+ljw839HlCfe/PV3KBHvqjw+uJJJqAH2BL9QO24tCB6qXSn44XG4Xf
	WiLsmJu+ffZiq/aTv3bG6xgxLBIdppD5CFclk5InB4aiK5TTKL5ztEEpkPc9vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753088705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZ2msJqJ/vaREGPCHC7y6gOD7AxqqhvZjn/budPvPHo=;
	b=JLHNvto+l8F0DOFa/FZf9JZES+0jXDO47TDhXGojkKOqAOHIIoEdKwbHWLkQdpA+IkuaLp
	G1p2Gq7lW5O4P4Aw==
Date: Mon, 21 Jul 2025 11:04:42 +0200
Subject: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
In-Reply-To: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753088703; l=7303;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iOBH17w0ZfmjIqdV03ANhka+3PqNUYKXkRmFiiERdEs=;
 b=/Z9vyjGZmSZ1IX0p1tH/PO+H7hGhvwD6dOmq0QCXkue1wr2du3zwMnFJ7YHuildN7+Kg5fGNX
 ViMkvYDM78mDXE3smAvM+L9x5XXz5y40vNPhpz58hHLfVDBEp9YyTaw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilter"),
remove it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/usermode_driver.h |  19 ----
 kernel/Makefile                 |   1 -
 kernel/bpf/preload/Kconfig      |   4 -
 kernel/usermode_driver.c        | 191 ----------------------------------------
 4 files changed, 215 deletions(-)

diff --git a/include/linux/usermode_driver.h b/include/linux/usermode_driver.h
deleted file mode 100644
index ad970416260dd208b43098e17df9ad49b4da7693..0000000000000000000000000000000000000000
--- a/include/linux/usermode_driver.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef __LINUX_USERMODE_DRIVER_H__
-#define __LINUX_USERMODE_DRIVER_H__
-
-#include <linux/umh.h>
-#include <linux/path.h>
-
-struct umd_info {
-	const char *driver_name;
-	struct file *pipe_to_umh;
-	struct file *pipe_from_umh;
-	struct path wd;
-	struct pid *tgid;
-};
-int umd_load_blob(struct umd_info *info, const void *data, size_t len);
-int umd_unload_blob(struct umd_info *info);
-int fork_usermode_driver(struct umd_info *info);
-void umd_cleanup_helper(struct umd_info *info);
-
-#endif /* __LINUX_USERMODE_DRIVER_H__ */
diff --git a/kernel/Makefile b/kernel/Makefile
index 32e80dd626af07d0c43290e3f5c64af5bff07b51..4332de7ffdee40f6a1cf77ff4b422b51142838e9 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -12,7 +12,6 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
 
-obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MULTIUSER) += groups.o
 obj-$(CONFIG_VHOST_TASK) += vhost_task.o
 
diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
index f9b11d01c3b50d4e98a33c686b55015766d17902..aef7b0bc96d6113dbca7ab4b9510c3dcf39a97f4 100644
--- a/kernel/bpf/preload/Kconfig
+++ b/kernel/bpf/preload/Kconfig
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config USERMODE_DRIVER
-	bool
-	default n
-
 menuconfig BPF_PRELOAD
 	bool "Preload BPF file system with kernel specific program and map iterators"
 	depends on BPF
diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
deleted file mode 100644
index 8303f4c7ca714a0aa96aeec4be8c8423ce8a200d..0000000000000000000000000000000000000000
--- a/kernel/usermode_driver.c
+++ /dev/null
@@ -1,191 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * umd - User mode driver support
- */
-#include <linux/shmem_fs.h>
-#include <linux/pipe_fs_i.h>
-#include <linux/mount.h>
-#include <linux/fs_struct.h>
-#include <linux/task_work.h>
-#include <linux/usermode_driver.h>
-
-static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *name)
-{
-	struct file_system_type *type;
-	struct vfsmount *mnt;
-	struct file *file;
-	ssize_t written;
-	loff_t pos = 0;
-
-	type = get_fs_type("tmpfs");
-	if (!type)
-		return ERR_PTR(-ENODEV);
-
-	mnt = kern_mount(type);
-	put_filesystem(type);
-	if (IS_ERR(mnt))
-		return mnt;
-
-	file = file_open_root_mnt(mnt, name, O_CREAT | O_WRONLY, 0700);
-	if (IS_ERR(file)) {
-		kern_unmount(mnt);
-		return ERR_CAST(file);
-	}
-
-	written = kernel_write(file, data, len, &pos);
-	if (written != len) {
-		int err = written;
-		if (err >= 0)
-			err = -ENOMEM;
-		filp_close(file, NULL);
-		kern_unmount(mnt);
-		return ERR_PTR(err);
-	}
-
-	fput(file);
-
-	/* Flush delayed fput so exec can open the file read-only */
-	flush_delayed_fput();
-	task_work_run();
-	return mnt;
-}
-
-/**
- * umd_load_blob - Remember a blob of bytes for fork_usermode_driver
- * @info: information about usermode driver
- * @data: a blob of bytes that can be executed as a file
- * @len:  The lentgh of the blob
- *
- */
-int umd_load_blob(struct umd_info *info, const void *data, size_t len)
-{
-	struct vfsmount *mnt;
-
-	if (WARN_ON_ONCE(info->wd.dentry || info->wd.mnt))
-		return -EBUSY;
-
-	mnt = blob_to_mnt(data, len, info->driver_name);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
-
-	info->wd.mnt = mnt;
-	info->wd.dentry = mnt->mnt_root;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(umd_load_blob);
-
-/**
- * umd_unload_blob - Disassociate @info from a previously loaded blob
- * @info: information about usermode driver
- *
- */
-int umd_unload_blob(struct umd_info *info)
-{
-	if (WARN_ON_ONCE(!info->wd.mnt ||
-			 !info->wd.dentry ||
-			 info->wd.mnt->mnt_root != info->wd.dentry))
-		return -EINVAL;
-
-	kern_unmount(info->wd.mnt);
-	info->wd.mnt = NULL;
-	info->wd.dentry = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(umd_unload_blob);
-
-static int umd_setup(struct subprocess_info *info, struct cred *new)
-{
-	struct umd_info *umd_info = info->data;
-	struct file *from_umh[2];
-	struct file *to_umh[2];
-	int err;
-
-	/* create pipe to send data to umh */
-	err = create_pipe_files(to_umh, 0);
-	if (err)
-		return err;
-	err = replace_fd(0, to_umh[0], 0);
-	fput(to_umh[0]);
-	if (err < 0) {
-		fput(to_umh[1]);
-		return err;
-	}
-
-	/* create pipe to receive data from umh */
-	err = create_pipe_files(from_umh, 0);
-	if (err) {
-		fput(to_umh[1]);
-		replace_fd(0, NULL, 0);
-		return err;
-	}
-	err = replace_fd(1, from_umh[1], 0);
-	fput(from_umh[1]);
-	if (err < 0) {
-		fput(to_umh[1]);
-		replace_fd(0, NULL, 0);
-		fput(from_umh[0]);
-		return err;
-	}
-
-	set_fs_pwd(current->fs, &umd_info->wd);
-	umd_info->pipe_to_umh = to_umh[1];
-	umd_info->pipe_from_umh = from_umh[0];
-	umd_info->tgid = get_pid(task_tgid(current));
-	return 0;
-}
-
-static void umd_cleanup(struct subprocess_info *info)
-{
-	struct umd_info *umd_info = info->data;
-
-	/* cleanup if umh_setup() was successful but exec failed */
-	if (info->retval)
-		umd_cleanup_helper(umd_info);
-}
-
-/**
- * umd_cleanup_helper - release the resources which were allocated in umd_setup
- * @info: information about usermode driver
- */
-void umd_cleanup_helper(struct umd_info *info)
-{
-	fput(info->pipe_to_umh);
-	fput(info->pipe_from_umh);
-	put_pid(info->tgid);
-	info->tgid = NULL;
-}
-EXPORT_SYMBOL_GPL(umd_cleanup_helper);
-
-/**
- * fork_usermode_driver - fork a usermode driver
- * @info: information about usermode driver (shouldn't be NULL)
- *
- * Returns either negative error or zero which indicates success in
- * executing a usermode driver. In such case 'struct umd_info *info'
- * is populated with two pipes and a tgid of the process. The caller is
- * responsible for health check of the user process, killing it via
- * tgid, and closing the pipes when user process is no longer needed.
- */
-int fork_usermode_driver(struct umd_info *info)
-{
-	struct subprocess_info *sub_info;
-	const char *argv[] = { info->driver_name, NULL };
-	int err;
-
-	if (WARN_ON_ONCE(info->tgid))
-		return -EBUSY;
-
-	err = -ENOMEM;
-	sub_info = call_usermodehelper_setup(info->driver_name,
-					     (char **)argv, NULL, GFP_KERNEL,
-					     umd_setup, umd_cleanup, info);
-	if (!sub_info)
-		goto out;
-
-	err = call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
-out:
-	return err;
-}
-EXPORT_SYMBOL_GPL(fork_usermode_driver);
-
-

-- 
2.50.1


