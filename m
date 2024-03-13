Return-Path: <linux-fsdevel+bounces-14313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B86E87AFA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92018B20E1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3281A38D7;
	Wed, 13 Mar 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKjZYMC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24760EFE;
	Wed, 13 Mar 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349826; cv=none; b=pJWFOQTHx/gmi6mYMl0Qk92lT2BLMi5vDFzWIQOABeSPRZ/BSVmL9qwh59r5IMkRuv0+5YnAoVO6i0aJNpOOSQ8Ee24AKc7j1At4abVYeD+VUP+5XiS4JQXAxbhr74KhpXPpAgvOMv3JsXkPUGothPRHpsKY00LXEae7onn5ROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349826; c=relaxed/simple;
	bh=i+iLRyRa65NORZzC6Eat7+l7u1KEAu6B7oMoroXUPRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmeAg9MjB8kl42fEQ2rIkEDMJBoeJYDAF+5K4rx6lhGbuyPMYVgUsqxuxQiv11OgE+Guc6Kx2F1xCwtdsT2fGp38nrTesm6ibW9Mgnth7vxMa26G9LhNgZgrV8omA/0niopE7Ze0F2M4rK8zFsEcloaWh4Y1P18L5CQY7LW2RD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKjZYMC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AC9C433C7;
	Wed, 13 Mar 2024 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349826;
	bh=i+iLRyRa65NORZzC6Eat7+l7u1KEAu6B7oMoroXUPRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKjZYMC8k2JE4X5UHK/5swIKkdNK8P50kYdvUj5DEHPtNnslpcOhyijRRhP1xm0S6
	 GnoUd9980VEKMKlD6x20Kezwq4CRAh61j8HTJJS7odGOv2/chG+jwPIDMoXzsIO3R5
	 LX1Gaj1m3y2dtoxapi3NjKhrM9uAETcnjhetyR9Nn8gwI1eocsQ6ILFvCqY2c5dOW1
	 yE8qKL9Pm6q1BmNzPpjLCl9E4BTZt2eV+4SQcuWdZhmm5xWvYB9WvHxvjCiFhojqSJ
	 zLiljlemxV70M5p79H3E9sqqKQlGdJlohW45Q6DWFyUX6fylN067EZUg+3m7z7H3NQ
	 IQZEVQKqCuBaw==
Date: Wed, 13 Mar 2024 18:10:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs pidfd
Message-ID: <20240313-matschen-mutieren-283c6e07694b@brauner>
References: <20240308-vfs-pidfd-b106369f5406@brauner>
 <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
 <20240312-dingo-sehnlich-b3ecc35c6de7@brauner>
 <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
 <20240312-pflug-sandalen-0675311c1ec5@brauner>
 <CAHk-=wjLkkGS=50D6hjCdGJjkTbNj73++CrRXDrw=o_on4RPAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lmmbn22pwxzkhza2"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjLkkGS=50D6hjCdGJjkTbNj73++CrRXDrw=o_on4RPAg@mail.gmail.com>


--lmmbn22pwxzkhza2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Mar 12, 2024 at 01:21:34PM -0700, Linus Torvalds wrote:
> On Tue, 12 Mar 2024 at 13:09, Christian Brauner <brauner@kernel.org> wrote:
> >
> > It's used to compare pidfs and someone actually already sent a pull
> > request for this to another project iirc. So it'd be good to keep that
> > property.
> 
> Hmm. If people really do care, I guess we should spend the effort on
> making those things unique.

So, I cleaned that patch and took the chance to simplify things a bit
more and now we give the same guarantees for 32bit and 64bit. We're
still removing a lot more code than we add. I provided a detailed
description and some already existing users.

If you're fine with it I would ask you to please just apply it or if you
prefer I can send a pull request tomorrow. I'm still stuck at the
doctor's office.

I spent most of my day compiling and test i386 kernel and userspace.
Surprisingly, trauma isn't the best teacher because I had completely
forgotten how horrible it all is and I'm glad I'm back in a world where
64bit is a thing.

--lmmbn22pwxzkhza2
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-pidfs-remove-config-option.patch"

From 6c72192dca868a9e04d23bbcfe0db1e35b7dd71f Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 12 Mar 2024 10:39:44 +0100
Subject: [PATCH] pidfs: remove config option

As Linus suggested this enables pidfs unconditionally. A key property to
retain is the ability to compare pidfds by inode number (cf. [1]).
That's extremely helpful just as comparing namespace file descriptors by
inode number is. They are used in a variety of scenarios where they need
to be compared, e.g., when receiving a pidfd via SO_PEERPIDFD from a
socket to trivially authenticate a the sender and various other
use-cases.

For 64bit systems this is pretty trivial to do. For 32bit it's slightly
more annoying as we discussed but we simply add a dumb ida based
allocator that gets used on 32bit. This gives the same guarantees about
inode numbers on 64bit without any overflow risk. Practically, we'll
never run into overflow issues because we're contstrained by the number
of processes that can exist on 32bit and by the number of open files
that can exist on a 32bit system. On 64bit none of this matters and
things are very simple.

If 32bit also needs the uniqueness guarantee they can simply parse the
contents of /proc/<pid>/fd/<nr>. The uniqueness guarantees have a
variety of use-cases. One of the most obvious ones is that they will
make pidfiles (or "pidfdfiles", I guess) reliable as the unique
identifier can be placed into there that won't be reycled. Also a
frequent request.

Note, I took the chance and simplified path_from_stashed() even further.
Instead of passing the inode number explicitly to path_from_stashed() we
let the filesystem handle that internally. So path_from_stashed() ends
up even simpler than it is now. This is also a good solution allowing
the cleanup code to be clean and consistent between 32bit and 64bit. The
cleanup path in prepare_anon_dentry() is also switched around so we put
the inode before the dentry allocation. This means we only have to call
the cleanup handler for the filesystem's inode data once and can rely
->evict_inode() otherwise.

Aside from having to have a bit of extra code for 32bit it actually ends
up a nice cleanup for path_from_stashed() imho.

Tested on both 32 and 64bit including error injection.

Link: https://github.com/systemd/systemd/pull/31713 [1]
Link: https://lore.kernel.org/r/20240312-dingo-sehnlich-b3ecc35c6de7@brauner
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/Kconfig            |   7 ---
 fs/internal.h         |   6 +--
 fs/libfs.c            |  33 +++++++-------
 fs/nsfs.c             |  11 +++--
 fs/pidfs.c            | 101 ++++++++++++++++++++----------------------
 include/linux/pid.h   |   6 +--
 include/linux/pidfs.h |   1 -
 kernel/pid.c          |   6 ---
 8 files changed, 78 insertions(+), 93 deletions(-)

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
diff --git a/fs/internal.h b/fs/internal.h
index 7d3edcdf59cc..0a54b6dfaea2 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -312,8 +312,8 @@ struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
 void mnt_idmap_put(struct mnt_idmap *idmap);
 struct stashed_operations {
 	void (*put_data)(void *data);
-	void (*init_inode)(struct inode *inode, void *data);
+	int (*init_inode)(struct inode *inode, void *data);
 };
-int path_from_stashed(struct dentry **stashed, unsigned long ino,
-		      struct vfsmount *mnt, void *data, struct path *path);
+int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
+		      struct path *path);
 void stashed_dentry_prune(struct dentry *dentry);
diff --git a/fs/libfs.c b/fs/libfs.c
index 65322e11bcda..686dbf6bb0c0 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1989,34 +1989,40 @@ static inline struct dentry *get_stashed_dentry(struct dentry *stashed)
 }
 
 static struct dentry *prepare_anon_dentry(struct dentry **stashed,
-					  unsigned long ino,
 					  struct super_block *sb,
 					  void *data)
 {
 	struct dentry *dentry;
 	struct inode *inode;
 	const struct stashed_operations *sops = sb->s_fs_info;
-
-	dentry = d_alloc_anon(sb);
-	if (!dentry)
-		return ERR_PTR(-ENOMEM);
+	int ret;
 
 	inode = new_inode_pseudo(sb);
 	if (!inode) {
-		dput(dentry);
+		sops->put_data(data);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	inode->i_ino = ino;
 	inode->i_flags |= S_IMMUTABLE;
 	inode->i_mode = S_IFREG;
 	simple_inode_init_ts(inode);
-	sops->init_inode(inode, data);
+
+	ret = sops->init_inode(inode, data);
+	if (ret < 0) {
+		iput(inode);
+		return ERR_PTR(ret);
+	}
 
 	/* Notice when this is changed. */
 	WARN_ON_ONCE(!S_ISREG(inode->i_mode));
 	WARN_ON_ONCE(!IS_IMMUTABLE(inode));
 
+	dentry = d_alloc_anon(sb);
+	if (!dentry) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	/* Store address of location where dentry's supposed to be stashed. */
 	dentry->d_fsdata = stashed;
 
@@ -2050,7 +2056,6 @@ static struct dentry *stash_dentry(struct dentry **stashed,
 /**
  * path_from_stashed - create path from stashed or new dentry
  * @stashed:    where to retrieve or stash dentry
- * @ino:        inode number to use
  * @mnt:        mnt of the filesystems to use
  * @data:       data to store in inode->i_private
  * @path:       path to create
@@ -2065,8 +2070,8 @@ static struct dentry *stash_dentry(struct dentry **stashed,
  *
  * Return: On success zero and on failure a negative error is returned.
  */
-int path_from_stashed(struct dentry **stashed, unsigned long ino,
-		      struct vfsmount *mnt, void *data, struct path *path)
+int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
+		      struct path *path)
 {
 	struct dentry *dentry;
 	const struct stashed_operations *sops = mnt->mnt_sb->s_fs_info;
@@ -2079,11 +2084,9 @@ int path_from_stashed(struct dentry **stashed, unsigned long ino,
 	}
 
 	/* Allocate a new dentry. */
-	dentry = prepare_anon_dentry(stashed, ino, mnt->mnt_sb, data);
-	if (IS_ERR(dentry)) {
-		sops->put_data(data);
+	dentry = prepare_anon_dentry(stashed, mnt->mnt_sb, data);
+	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
-	}
 
 	/* Added a new dentry. @data is now owned by the filesystem. */
 	path->dentry = stash_dentry(stashed, dentry);
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 7aaafb5cb9fc..07e22a15ef02 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -56,7 +56,7 @@ int ns_get_path_cb(struct path *path, ns_get_path_helper_t *ns_get_cb,
 	if (!ns)
 		return -ENOENT;
 
-	return path_from_stashed(&ns->stashed, ns->inum, nsfs_mnt, ns, path);
+	return path_from_stashed(&ns->stashed, nsfs_mnt, ns, path);
 }
 
 struct ns_get_path_task_args {
@@ -101,8 +101,7 @@ int open_related_ns(struct ns_common *ns,
 		return PTR_ERR(relative);
 	}
 
-	err = path_from_stashed(&relative->stashed, relative->inum, nsfs_mnt,
-				relative, &path);
+	err = path_from_stashed(&relative->stashed, nsfs_mnt, relative, &path);
 	if (err < 0) {
 		put_unused_fd(fd);
 		return err;
@@ -199,11 +198,15 @@ static const struct super_operations nsfs_ops = {
 	.show_path = nsfs_show_path,
 };
 
-static void nsfs_init_inode(struct inode *inode, void *data)
+static int nsfs_init_inode(struct inode *inode, void *data)
 {
+	struct ns_common *ns = data;
+
 	inode->i_private = data;
 	inode->i_mode |= S_IRUGO;
 	inode->i_fop = &ns_file_operations;
+	inode->i_ino = ns->inum;
+	return 0;
 }
 
 static void nsfs_put_data(void *data)
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 8fd71a00be9c..a63d5d24aa02 100644
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
@@ -120,7 +109,6 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 }
 
 static const struct file_operations pidfs_file_operations = {
-	.release	= pidfd_release,
 	.poll		= pidfd_poll,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= pidfd_show_fdinfo,
@@ -131,16 +119,45 @@ struct pid *pidfd_pid(const struct file *file)
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
 
+#if BITS_PER_LONG == 32
+/*
+ * Provide a fallback mechanism for 32-bit systems so processes remain
+ * reliably comparable by inode number even on those systems.
+ */
+static DEFINE_IDA(pidfd_inum_ida);
+
+static int pidfs_inum(struct pid *pid, unsigned long *ino)
+{
+	int ret;
+
+	ret = ida_alloc_range(&pidfd_inum_ida, RESERVED_PIDS + 1,
+			      UINT_MAX, GFP_ATOMIC);
+	if (ret < 0)
+		return -ENOSPC;
+
+	*ino = ret;
+	return 0;
+}
+
+static inline void pidfs_free_inum(unsigned long ino)
+{
+	if (ino > 0)
+		ida_free(&pidfd_inum_ida, ino);
+}
+#else
+static inline int pidfs_inum(struct pid *pid, unsigned long *ino)
+{
+	*ino = pid->ino;
+	return 0;
+}
+#define pidfs_free_inum(ino) ((void)(ino))
+#endif
+
 /*
  * The vfs falls back to simple_setattr() if i_op->setattr() isn't
  * implemented. Let's reject it completely until we have a clean
@@ -173,6 +190,7 @@ static void pidfs_evict_inode(struct inode *inode)
 
 	clear_inode(inode);
 	put_pid(pid);
+	pidfs_free_inum(inode->i_ino);
 }
 
 static const struct super_operations pidfs_sops = {
@@ -183,8 +201,10 @@ static const struct super_operations pidfs_sops = {
 
 static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
-	return dynamic_dname(buffer, buflen, "pidfd:[%lu]",
-			     d_inode(dentry)->i_ino);
+	struct inode *inode = d_inode(dentry);
+	struct pid *pid = inode->i_private;
+
+	return dynamic_dname(buffer, buflen, "pidfd:[%llu]", pid->ino);
 }
 
 static const struct dentry_operations pidfs_dentry_operations = {
@@ -193,13 +213,19 @@ static const struct dentry_operations pidfs_dentry_operations = {
 	.d_prune	= stashed_dentry_prune,
 };
 
-static void pidfs_init_inode(struct inode *inode, void *data)
+static int pidfs_init_inode(struct inode *inode, void *data)
 {
 	inode->i_private = data;
 	inode->i_flags |= S_PRIVATE;
 	inode->i_mode |= S_IRWXU;
 	inode->i_op = &pidfs_inode_operations;
 	inode->i_fop = &pidfs_file_operations;
+	/*
+	 * Inode numbering for pidfs start at RESERVED_PIDS + 1. This
+	 * avoids collisions with the root inode which is 1 for pseudo
+	 * filesystems.
+	 */
+	return pidfs_inum(data, &inode->i_ino);
 }
 
 static void pidfs_put_data(void *data)
@@ -240,13 +266,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	struct path path;
 	int ret;
 
-	/*
-	* Inode numbering for pidfs start at RESERVED_PIDS + 1.
-	* This avoids collisions with the root inode which is 1
-	* for pseudo filesystems.
-	 */
-	ret = path_from_stashed(&pid->stashed, pid->ino, pidfs_mnt,
-				get_pid(pid), &path);
+	ret = path_from_stashed(&pid->stashed, pidfs_mnt, get_pid(pid), &path);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
@@ -261,30 +281,3 @@ void __init pidfs_init(void)
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
index c79a0efd0258..a3aad9b4074c 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -45,6 +45,8 @@
  * find_pid_ns() using the int nr and struct pid_namespace *ns.
  */
 
+#define RESERVED_PIDS 300
+
 struct upid {
 	int nr;
 	struct pid_namespace *ns;
@@ -55,10 +57,8 @@ struct pid
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
index 99a0c5eb24b8..da76ed1873f7 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -62,17 +62,13 @@ struct pid init_struct_pid = {
 
 int pid_max = PID_MAX_DEFAULT;
 
-#define RESERVED_PIDS		300
-
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
@@ -280,10 +276,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
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


--lmmbn22pwxzkhza2--

