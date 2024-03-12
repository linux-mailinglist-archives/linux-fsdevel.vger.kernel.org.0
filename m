Return-Path: <linux-fsdevel+bounces-14210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B4C8795D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 15:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCD21C21B76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 14:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4FF7A737;
	Tue, 12 Mar 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhjQRZDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EBE57307;
	Tue, 12 Mar 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252960; cv=none; b=E7E7x9sJtK1WsVZTXx8svNwbrgylwQ0X/a9EyOBxT5gI1gvUQbQuhICmbHlUAey1PMixLBxYWSCHEKYfwFh0OZY33/KmLajBFLNv2ZHftuk35/UAXQYdX9Yc/a5DoOguNpmQoKDroZoKaf29yaJpI+QApLtH82QXjyyQa645Oes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252960; c=relaxed/simple;
	bh=6nPUkJYMV8BT9PyAcnRUtEYmd9f0t4J3gV+n/eWAeSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrYge6NAJ9D1y9QlkCxDpkD4p4VmFZN48MRjMIfrfa/FA2KHX8AfnWT51/dNrMSgF3CHEbUB1v/UcgSBbxxD5cS8jfMpsWv1yXK7pIvvMjsinb311SVzyDUmr3LE9hzgj6V/B9cXVhRKQY/g5piPqOKXuaAqZkckNjC84bkAg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhjQRZDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10534C433C7;
	Tue, 12 Mar 2024 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710252960;
	bh=6nPUkJYMV8BT9PyAcnRUtEYmd9f0t4J3gV+n/eWAeSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhjQRZDLfKKKKvdPVWBN4Ge6Cy0DfjnXIjFtz0FzwGyE4LGOik+dihC3GrN3ELN3o
	 8CNf3ytBtJF6dDuXwM3HRccNCspK+wZnHsNnAVxlHa4kpbckNAaA0QbF58W4NUbQsc
	 OUpwizi0D/qFLLhBPvLlbPCfAae/xCHTQxdYlP0cZwZbWRE8Ayg+du/7aWCYd8YQB+
	 kfY+Y0vp741UAeIhmVdU8pyCSzeDYt/7gv2rUO8oAHN+LKHR9ozJpTBs3k+J8hlMMk
	 xb3sP5zzrqPGiLaL5oeDgdlP42nSfyQSanFI6paB+I2JSAIMba7SPcDyKqzYduPy9L
	 8hNC4hfJzqFMA==
Date: Tue, 12 Mar 2024 15:15:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs pidfd
Message-ID: <20240312-dingo-sehnlich-b3ecc35c6de7@brauner>
References: <20240308-vfs-pidfd-b106369f5406@brauner>
 <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hi544pxirl5tf4xv"
Content-Disposition: inline
In-Reply-To: <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>


--hi544pxirl5tf4xv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Mar 11, 2024 at 01:05:06PM -0700, Linus Torvalds wrote:
> On Fri, 8 Mar 2024 at 02:14, Christian Brauner <brauner@kernel.org> wrote:
> >
> > * Move pidfds from the anonymous inode infrastructure to a tiny
> >   pseudo filesystem. This will unblock further work that we weren't able
> >   to do simply because of the very justified limitations of anonymous
> >   inodes. Moving pidfds to a tiny pseudo filesystem allows for statx on
> >   pidfds to become useful for the first time. They can now be compared
> >   by inode number which are unique for the system lifetime.
> 
> So I obviously pulled this already, but I did have one question - we
> don't make nsfs conditional, and I'm not convinced we should make
> pidfs conditional either.
> 
> I think (and *hope*) all the semantic annoyances got sorted out, and I
> don't think there are any realistic size advantages to not enabling
> CONFIG_FS_PID.
> 
> Is there some fundamental reason for that config entry to exist?

No, the size of struct pid was the main reason but I don't think it
matters. A side-effect was that we could easily enforce 64bit inode
numbers. But realistically it's trivial enough to workaround. Here's a
patch for what I think is pretty simple appended. Does that work?

--hi544pxirl5tf4xv
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-pidfs-remove-config-option.patch"

From ce1c50a3d8d569be338f2a06f5e8470603038363 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 12 Mar 2024 10:39:44 +0100
Subject: [PATCH] pidfs: remove config option

Enable pidfs unconditionally. There's no real reason not do to it. One
of the really nice properties of pidfs is that we have unique inode
numbers for the system lifetime which allows userspace to do a bunch of
elegant things. So we should retain that property. So on arches where
inode number in the kernel are only 32bit we simply use get_next_ino()
and print the full value into fdinfo. On 64bit we do it cleanly and put
this into stat where it belongs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/Kconfig            |  7 ------
 fs/pidfs.c            | 50 ++++++-------------------------------------
 include/linux/pid.h   |  4 +---
 include/linux/pidfs.h |  1 -
 kernel/pid.c          |  4 ----
 5 files changed, 7 insertions(+), 59 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index f3dbd84a0e40..89fdbefd1075 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -174,13 +174,6 @@ source "fs/proc/Kconfig"
 source "fs/kernfs/Kconfig"
 source "fs/sysfs/Kconfig"
 
-config FS_PID
-	bool "Pseudo filesystem for process file descriptors"
-	depends on 64BIT
-	default y
-	help
-	  Pidfs implements advanced features for process file descriptors.
-
 config TMPFS
 	bool "Tmpfs virtual memory file system support (former shm fs)"
 	depends on SHMEM
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 8fd71a00be9c..677fa2f1bbbb 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -16,17 +16,6 @@
 
 #include "internal.h"
 
-static int pidfd_release(struct inode *inode, struct file *file)
-{
-#ifndef CONFIG_FS_PID
-	struct pid *pid = file->private_data;
-
-	file->private_data = NULL;
-	put_pid(pid);
-#endif
-	return 0;
-}
-
 #ifdef CONFIG_PROC_FS
 /**
  * pidfd_show_fdinfo - print information about a pidfd
@@ -89,6 +78,9 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 		for (i = ns->level + 1; i <= pid->level; i++)
 			seq_put_decimal_ll(m, "\t", pid->numbers[i].nr);
 	}
+#endif
+#if BITS_PER_LONG == 32
+	seq_put_decimal_ll(m, "\nPidfsId:\t", pid->ino);
 #endif
 	seq_putc(m, '\n');
 }
@@ -120,7 +112,6 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 }
 
 static const struct file_operations pidfs_file_operations = {
-	.release	= pidfd_release,
 	.poll		= pidfd_poll,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= pidfd_show_fdinfo,
@@ -131,14 +122,9 @@ struct pid *pidfd_pid(const struct file *file)
 {
 	if (file->f_op != &pidfs_file_operations)
 		return ERR_PTR(-EBADF);
-#ifdef CONFIG_FS_PID
 	return file_inode(file)->i_private;
-#else
-	return file->private_data;
-#endif
 }
 
-#ifdef CONFIG_FS_PID
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
 /*
@@ -200,6 +186,9 @@ static void pidfs_init_inode(struct inode *inode, void *data)
 	inode->i_mode |= S_IRWXU;
 	inode->i_op = &pidfs_inode_operations;
 	inode->i_fop = &pidfs_file_operations;
+#if BITS_PER_LONG == 32
+	inode->i_ino = get_next_ino();
+#endif
 }
 
 static void pidfs_put_data(void *data)
@@ -261,30 +250,3 @@ void __init pidfs_init(void)
 	if (IS_ERR(pidfs_mnt))
 		panic("Failed to mount pidfs pseudo filesystem");
 }
-
-bool is_pidfs_sb(const struct super_block *sb)
-{
-	return sb == pidfs_mnt->mnt_sb;
-}
-
-#else /* !CONFIG_FS_PID */
-
-struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
-{
-	struct file *pidfd_file;
-
-	pidfd_file = anon_inode_getfile("[pidfd]", &pidfs_file_operations, pid,
-					flags | O_RDWR);
-	if (IS_ERR(pidfd_file))
-		return pidfd_file;
-
-	get_pid(pid);
-	return pidfd_file;
-}
-
-void __init pidfs_init(void) { }
-bool is_pidfs_sb(const struct super_block *sb)
-{
-	return false;
-}
-#endif
diff --git a/include/linux/pid.h b/include/linux/pid.h
index c79a0efd0258..ae0c0fd943c4 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -55,10 +55,8 @@ struct pid
 	refcount_t count;
 	unsigned int level;
 	spinlock_t lock;
-#ifdef CONFIG_FS_PID
 	struct dentry *stashed;
-	unsigned long ino;
-#endif
+	u64 ino;
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
 	struct hlist_head inodes;
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 40dd325a32a6..75bdf9807802 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -4,6 +4,5 @@
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
-bool is_pidfs_sb(const struct super_block *sb);
 
 #endif /* _LINUX_PID_FS_H */
diff --git a/kernel/pid.c b/kernel/pid.c
index 99a0c5eb24b8..8ced4e208c22 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -66,13 +66,11 @@ int pid_max = PID_MAX_DEFAULT;
 
 int pid_max_min = RESERVED_PIDS + 1;
 int pid_max_max = PID_MAX_LIMIT;
-#ifdef CONFIG_FS_PID
 /*
  * Pseudo filesystems start inode numbering after one. We use Reserved
  * PIDs as a natural offset.
  */
 static u64 pidfs_ino = RESERVED_PIDS;
-#endif
 
 /*
  * PID-map pages start out as NULL, they get allocated upon
@@ -280,10 +278,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	spin_lock_irq(&pidmap_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
-#ifdef CONFIG_FS_PID
 	pid->stashed = NULL;
 	pid->ino = ++pidfs_ino;
-#endif
 	for ( ; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);
-- 
2.43.0


--hi544pxirl5tf4xv--

