Return-Path: <linux-fsdevel+bounces-56030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96453B11D9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA02B5A6175
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298782EE27B;
	Fri, 25 Jul 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXpIaQmD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF02EE260;
	Fri, 25 Jul 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442868; cv=none; b=u/xpss1pzMI888Kuf004oeNyKUIGyIn+GEd/c4demHWOD29UQnZgAsGnpSPJuJ+dwB4QyERAx/LIb/ulBLutENUHEAopyHdW9550yucgklUbjHcGk0sIVhcr79BU9S96xdgCTHw4X0ihMNNpA9Xd9CZNEJINDkgiFUnN+LM1CPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442868; c=relaxed/simple;
	bh=9w7LcGjm4YswiOCqW0fBwBpuoDV7ajBHgMQcctttYGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKvrwa29O4i9sa8o3cvtwJrJ/G805p7FaFSxIAzwvUZ8PR5PSIESMuynhSBGYRP5Z7UiAINR38xac5guEwVhvq1JGIASMIURNKcZ1xq3sScmwRX4MpAKgIFDr3KOnI3WDU89UGiUwhRw7vZ9gpkFC+Gbfj6iTQvpqqUUQFceh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXpIaQmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F85C4CEF5;
	Fri, 25 Jul 2025 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442868;
	bh=9w7LcGjm4YswiOCqW0fBwBpuoDV7ajBHgMQcctttYGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXpIaQmDVArolk6R9sudyj1E0xqRhYoRWmLdvEEQzA7nYDbKHyQe1RwqUXX4C3PQM
	 IDFX5p5l2JNmJEYJIZfxdJKFQeU8Aw4Fp8J6k8k2MO1NgAG3XET2Yuwzvnn7ix+d7o
	 jtK0E9TC/j6Uq7tI8NshSkeHJBPlTy+VV3dM2FqPB9U2/IxoUKAOrzSav73uzJcHgu
	 pVaQVcPfDqO0AWrFNlbfbPnbrIL6lrt2sqhdKOghdIuIsI16gySZvtPZdI4e1O9vHN
	 up5Uf6Fh4aSjRVJHWUXVzJTxUG/dX/h6S1N2fpg2ArgQEEdhW8pFwfzAJPFy+muImL
	 M8SRDLCSsL9jQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 08/14 for v6.17] vfs pidfs
Date: Fri, 25 Jul 2025 13:27:25 +0200
Message-ID: <20250725-vfs-pidfs-ef67d98fcc31@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26137; i=brauner@kernel.org; h=from:subject:message-id; bh=9w7LcGjm4YswiOCqW0fBwBpuoDV7ajBHgMQcctttYGM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4knHRIJuCrY9M03JrQvIWtSunC8Po/sO/VNV5yl1 1YebJnVUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGPlgz/E3tep809cGpVv2aa ldn614ePeBpa675xioqdYXnLfLIDB8P/ENnUzzpiZjP/B0tn/2iXt4w5w7h14vZFgnwr9rOwdsz lBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains updates for pidfs:

- persistent info

  Persist exit and coredump information independent of whether anyone
  currently holds a pidfd for the struct pid.

  The current scheme allocated pidfs dentries on-demand repeatedly. This
  scheme is reaching it's limits as it makes it impossible to pin
  information that needs to be available after the task has exited or
  coredumped and that should not be lost simply because the pidfd got
  closed temporarily. The next opener should still see the stashed
  information.

  This is also a prerequisite for supporting extended attributes on
  pidfds to allow attaching meta information to them.

  If someone opens a pidfd for a struct pid a pidfs dentry is allocated
  and stashed in pid->stashed. Once the last pidfd for the struct pid is
  closed the pidfs dentry is released and removed from pid->stashed.

  So if 10 callers create a pidfs dentry for the same struct pid
  sequentially, i.e., each closing the pidfd before the other creates a
  new one then a new pidfs dentry is allocated every time.

  Because multiple tasks acquiring and releasing a pidfd for the same
  struct pid can race with each another a task may still find a valid
  pidfs entry from the previous task in pid->stashed and reuse it. Or it
  might find a dead dentry in there and fail to reuse it and so stashes
  a new pidfs dentry. Multiple tasks may race to stash a new pidfs
  dentry but only one will succeed, the other ones will put their
  dentry.

  The current scheme aims to ensure that a pidfs dentry for a struct pid
  can only be created if the task is still alive or if a pidfs dentry
  already existed before the task was reaped and so exit information has
  been was stashed in the pidfs inode.

  That's great except that it's buggy. If a pidfs dentry is stashed in
  pid->stashed after pidfs_exit() but before __unhash_process() is
  called we will return a pidfd for a reaped task without exit
  information being available.

  The pidfds_pid_valid() check does not guard against this race as it
  doens't sync at all with pidfs_exit(). The pid_has_task() check might
  be successful simply because we're before __unhash_process() but after
  pidfs_exit().

  Introduce a new scheme where the lifetime of information associated
  with a pidfs entry (coredump and exit information) isn't bound to the
  lifetime of the pidfs inode but the struct pid itself.

  The first time a pidfs dentry is allocated for a struct pid a struct
  pidfs_attr will be allocated which will be used to store exit and
  coredump information.

  If all pidfs for the pidfs dentry are closed the dentry and inode can
  be cleaned up but the struct pidfs_attr will stick until the struct
  pid itself is freed. This will ensure minimal memory usage while
  persisting relevant information.

  The new scheme has various advantages. First, it allows to close the
  race where we end up handing out a pidfd for a reaped task for which
  no exit information is available. Second, it minimizes memory usage.
  Third, it allows to remove complex lifetime tracking via dentries when
  registering a struct pid with pidfs. There's no need to get or put a
  reference. Instead, the lifetime of exit and coredump information
  associated with a struct pid is bound to the lifetime of struct pid
  itself.

- extended attributes

  Now that we have a way to persist information for pidfs dentries we
  can start supporting extended attributes on pidfds. This will allow
  userspace to attach meta information to tasks.

  One natural extension would be to introduce a custom pidfs.* extended
  attribute space and allow for the inheritance of extended attributes
  across fork() and exec().

  The first simple scheme will allow privileged userspace to set trusted
  extended attributes on pidfs inodes.

- Allow autonomous pidfs file handles 

  Various filesystems such as pidfs and drm support opening file handles
  without having to require a file descriptor to identify the
  filesystem. The filesystem are global single instances and can be
  trivially identified solely on the information encoded in the file
  handle.

  This makes it possible to not have to keep or acquire a sentinal file
  descriptor just to pass it to open_by_handle_at() to identify the
  filesystem. That's especially useful when such sentinel file
  descriptor cannot or should not be acquired.

  For pidfs this means a file handle can function as full replacement
  for storing a pid in a file. Instead a file handle can be stored and
  reopened purely based on the file handle.

  Such autonomous file handles can be opened with or without specifying
  a a file descriptor. If no proper file descriptor is used the
  FD_PIDFS_ROOT sentinel must be passed. This allows us to define
  further special negative fd sentinels in the future.

  Userspace can trivially test for support by trying to open the file
  handle with an invalid file descriptor.

- Allow pidfds for reaped tasks with SCM_PIDFD messages

  This is a logical continuation of the earlier work to create pidfds
  for reaped tasks through the SO_PEERPIDFD socket option merged in
  923ea4d4482b ("Merge patch series "net, pidfs: enable handing out
  pidfds for reaped sk->sk_peer_pid"").

- Two minor fixes:

  * Fold fs_struct->{lock,seq} into a seqlock

  * Don't bother with path_{get,put}() in unix_open_file()

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This will have a merge conflict with the vfs coredump pull request for this
cycle which can be resolved as follows. This is a bit larger than usual. Feel
free to ask me to resend a combined pull request of pidfs and coredumping:

diff --cc fs/coredump.c
index fadf9d4be2e1,55d6a713a0fb..000000000000
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@@ -662,439 -632,8 +662,433 @@@ static int umh_coredump_setup(struct su
  	return 0;
  }
  
 -void do_coredump(const kernel_siginfo_t *siginfo)
 +#ifdef CONFIG_UNIX
 +static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *cprm)
 +{
 +	struct file *file __free(fput) = NULL;
 +	struct sockaddr_un addr = {
 +		.sun_family = AF_UNIX,
 +	};
 +	ssize_t addr_len;
 +	int retval;
 +	struct socket *socket;
 +
 +	addr_len = strscpy(addr.sun_path, cn->corename);
 +	if (addr_len < 0)
 +		return false;
 +	addr_len += offsetof(struct sockaddr_un, sun_path) + 1;
 +
 +	/*
 +	 * It is possible that the userspace process which is supposed
 +	 * to handle the coredump and is listening on the AF_UNIX socket
 +	 * coredumps. Userspace should just mark itself non dumpable.
 +	 */
 +
 +	retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
 +	if (retval < 0)
 +		return false;
 +
 +	file = sock_alloc_file(socket, 0, NULL);
 +	if (IS_ERR(file))
 +		return false;
 +
 +	/*
 +	 * Set the thread-group leader pid which is used for the peer
 +	 * credentials during connect() below. Then immediately register
 +	 * it in pidfs...
 +	 */
 +	cprm->pid = task_tgid(current);
 +	retval = pidfs_register_pid(cprm->pid);
 +	if (retval)
 +		return false;
 +
 +	/*
 +	 * ... and set the coredump information so userspace has it
 +	 * available after connect()...
 +	 */
 +	pidfs_coredump(cprm);
 +
 +	retval = kernel_connect(socket, (struct sockaddr *)(&addr), addr_len,
 +				O_NONBLOCK | SOCK_COREDUMP);
- 	/*
- 	 * ... Make sure to only put our reference after connect() took
- 	 * its own reference keeping the pidfs entry alive ...
- 	 */
- 	pidfs_put_pid(cprm->pid);
- 
 +	if (retval) {
 +		if (retval == -EAGAIN)
 +			coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
 +		else
 +			coredump_report_failure("Coredump socket connection %s failed %d", addr.sun_path, retval);
 +		return false;
 +	}
 +
 +	/* ... and validate that @sk_peer_pid matches @cprm.pid. */
 +	if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid != cprm->pid))
 +		return false;
 +
 +	cprm->limit = RLIM_INFINITY;
 +	cprm->file = no_free_ptr(file);
 +
 +	return true;
 +}
 +
 +static inline bool coredump_sock_recv(struct file *file, struct coredump_ack *ack, size_t size, int flags)
 +{
 +	struct msghdr msg = {};
 +	struct kvec iov = { .iov_base = ack, .iov_len = size };
 +	ssize_t ret;
 +
 +	memset(ack, 0, size);
 +	ret = kernel_recvmsg(sock_from_file(file), &msg, &iov, 1, size, flags);
 +	return ret == size;
 +}
 +
 +static inline bool coredump_sock_send(struct file *file, struct coredump_req *req)
 +{
 +	struct msghdr msg = { .msg_flags = MSG_NOSIGNAL };
 +	struct kvec iov = { .iov_base = req, .iov_len = sizeof(*req) };
 +	ssize_t ret;
 +
 +	ret = kernel_sendmsg(sock_from_file(file), &msg, &iov, 1, sizeof(*req));
 +	return ret == sizeof(*req);
 +}
 +
 +static_assert(sizeof(enum coredump_mark) == sizeof(__u32));
 +
 +static inline bool coredump_sock_mark(struct file *file, enum coredump_mark mark)
 +{
 +	struct msghdr msg = { .msg_flags = MSG_NOSIGNAL };
 +	struct kvec iov = { .iov_base = &mark, .iov_len = sizeof(mark) };
 +	ssize_t ret;
 +
 +	ret = kernel_sendmsg(sock_from_file(file), &msg, &iov, 1, sizeof(mark));
 +	return ret == sizeof(mark);
 +}
 +
 +static inline void coredump_sock_wait(struct file *file)
 +{
 +	ssize_t n;
 +
 +	/*
 +	 * We use a simple read to wait for the coredump processing to
 +	 * finish. Either the socket is closed or we get sent unexpected
 +	 * data. In both cases, we're done.
 +	 */
 +	n = __kernel_read(file, &(char){ 0 }, 1, NULL);
 +	if (n > 0)
 +		coredump_report_failure("Coredump socket had unexpected data");
 +	else if (n < 0)
 +		coredump_report_failure("Coredump socket failed");
 +}
 +
 +static inline void coredump_sock_shutdown(struct file *file)
 +{
 +	struct socket *socket;
 +
 +	socket = sock_from_file(file);
 +	if (!socket)
 +		return;
 +
 +	/* Let userspace know we're done processing the coredump. */
 +	kernel_sock_shutdown(socket, SHUT_WR);
 +}
 +
 +static bool coredump_sock_request(struct core_name *cn, struct coredump_params *cprm)
 +{
 +	struct coredump_req req = {
 +		.size		= sizeof(struct coredump_req),
 +		.mask		= COREDUMP_KERNEL | COREDUMP_USERSPACE |
 +				  COREDUMP_REJECT | COREDUMP_WAIT,
 +		.size_ack	= sizeof(struct coredump_ack),
 +	};
 +	struct coredump_ack ack = {};
 +	ssize_t usize;
 +
 +	if (cn->core_type != COREDUMP_SOCK_REQ)
 +		return true;
 +
 +	/* Let userspace know what we support. */
 +	if (!coredump_sock_send(cprm->file, &req))
 +		return false;
 +
 +	/* Peek the size of the coredump_ack. */
 +	if (!coredump_sock_recv(cprm->file, &ack, sizeof(ack.size),
 +				MSG_PEEK | MSG_WAITALL))
 +		return false;
 +
 +	/* Refuse unknown coredump_ack sizes. */
 +	usize = ack.size;
 +	if (usize < COREDUMP_ACK_SIZE_VER0) {
 +		coredump_sock_mark(cprm->file, COREDUMP_MARK_MINSIZE);
 +		return false;
 +	}
 +
 +	if (usize > sizeof(ack)) {
 +		coredump_sock_mark(cprm->file, COREDUMP_MARK_MAXSIZE);
 +		return false;
 +	}
 +
 +	/* Now retrieve the coredump_ack. */
 +	if (!coredump_sock_recv(cprm->file, &ack, usize, MSG_WAITALL))
 +		return false;
 +	if (ack.size != usize)
 +		return false;
 +
 +	/* Refuse unknown coredump_ack flags. */
 +	if (ack.mask & ~req.mask) {
 +		coredump_sock_mark(cprm->file, COREDUMP_MARK_UNSUPPORTED);
 +		return false;
 +	}
 +
 +	/* Refuse mutually exclusive options. */
 +	if (hweight64(ack.mask & (COREDUMP_USERSPACE | COREDUMP_KERNEL |
 +				  COREDUMP_REJECT)) != 1) {
 +		coredump_sock_mark(cprm->file, COREDUMP_MARK_CONFLICTING);
 +		return false;
 +	}
 +
 +	if (ack.spare) {
 +		coredump_sock_mark(cprm->file, COREDUMP_MARK_UNSUPPORTED);
 +		return false;
 +	}
 +
 +	cn->mask = ack.mask;
 +	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
 +}
 +
 +static bool coredump_socket(struct core_name *cn, struct coredump_params *cprm)
 +{
 +	if (!coredump_sock_connect(cn, cprm))
 +		return false;
 +
 +	return coredump_sock_request(cn, cprm);
 +}
 +#else
 +static inline void coredump_sock_wait(struct file *file) { }
 +static inline void coredump_sock_shutdown(struct file *file) { }
 +static inline bool coredump_socket(struct core_name *cn, struct coredump_params *cprm) { return false; }
 +#endif
 +
 +/* cprm->mm_flags contains a stable snapshot of dumpability flags. */
 +static inline bool coredump_force_suid_safe(const struct coredump_params *cprm)
 +{
 +	/* Require nonrelative corefile path and be extra careful. */
 +	return __get_dumpable(cprm->mm_flags) == SUID_DUMP_ROOT;
 +}
 +
 +static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
 +			  const struct linux_binfmt *binfmt)
 +{
 +	struct mnt_idmap *idmap;
 +	struct inode *inode;
 +	struct file *file __free(fput) = NULL;
 +	int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW | O_LARGEFILE | O_EXCL;
 +
 +	if (cprm->limit < binfmt->min_coredump)
 +		return false;
 +
 +	if (coredump_force_suid_safe(cprm) && cn->corename[0] != '/') {
 +		coredump_report_failure("this process can only dump core to a fully qualified path, skipping core dump");
 +		return false;
 +	}
 +
 +	/*
 +	 * Unlink the file if it exists unless this is a SUID
 +	 * binary - in that case, we're running around with root
 +	 * privs and don't want to unlink another user's coredump.
 +	 */
 +	if (!coredump_force_suid_safe(cprm)) {
 +		/*
 +		 * If it doesn't exist, that's fine. If there's some
 +		 * other problem, we'll catch it at the filp_open().
 +		 */
 +		do_unlinkat(AT_FDCWD, getname_kernel(cn->corename));
 +	}
 +
 +	/*
 +	 * There is a race between unlinking and creating the
 +	 * file, but if that causes an EEXIST here, that's
 +	 * fine - another process raced with us while creating
 +	 * the corefile, and the other process won. To userspace,
 +	 * what matters is that at least one of the two processes
 +	 * writes its coredump successfully, not which one.
 +	 */
 +	if (coredump_force_suid_safe(cprm)) {
 +		/*
 +		 * Using user namespaces, normal user tasks can change
 +		 * their current->fs->root to point to arbitrary
 +		 * directories. Since the intention of the "only dump
 +		 * with a fully qualified path" rule is to control where
 +		 * coredumps may be placed using root privileges,
 +		 * current->fs->root must not be used. Instead, use the
 +		 * root directory of init_task.
 +		 */
 +		struct path root;
 +
 +		task_lock(&init_task);
 +		get_fs_root(init_task.fs, &root);
 +		task_unlock(&init_task);
 +		file = file_open_root(&root, cn->corename, open_flags, 0600);
 +		path_put(&root);
 +	} else {
 +		file = filp_open(cn->corename, open_flags, 0600);
 +	}
 +	if (IS_ERR(file))
 +		return false;
 +
 +	inode = file_inode(file);
 +	if (inode->i_nlink > 1)
 +		return false;
 +	if (d_unhashed(file->f_path.dentry))
 +		return false;
 +	/*
 +	 * AK: actually i see no reason to not allow this for named
 +	 * pipes etc, but keep the previous behaviour for now.
 +	 */
 +	if (!S_ISREG(inode->i_mode))
 +		return false;
 +	/*
 +	 * Don't dump core if the filesystem changed owner or mode
 +	 * of the file during file creation. This is an issue when
 +	 * a process dumps core while its cwd is e.g. on a vfat
 +	 * filesystem.
 +	 */
 +	idmap = file_mnt_idmap(file);
 +	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid())) {
 +		coredump_report_failure("Core dump to %s aborted: cannot preserve file owner", cn->corename);
 +		return false;
 +	}
 +	if ((inode->i_mode & 0677) != 0600) {
 +		coredump_report_failure("Core dump to %s aborted: cannot preserve file permissions", cn->corename);
 +		return false;
 +	}
 +	if (!(file->f_mode & FMODE_CAN_WRITE))
 +		return false;
 +	if (do_truncate(idmap, file->f_path.dentry, 0, 0, file))
 +		return false;
 +
 +	cprm->file = no_free_ptr(file);
 +	return true;
 +}
 +
 +static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
 +			  size_t *argv, int argc)
 +{
 +	int argi;
 +	char **helper_argv __free(kfree) = NULL;
 +	struct subprocess_info *sub_info;
 +
 +	if (cprm->limit == 1) {
 +		/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
 +		 *
 +		 * Normally core limits are irrelevant to pipes, since
 +		 * we're not writing to the file system, but we use
 +		 * cprm.limit of 1 here as a special value, this is a
 +		 * consistent way to catch recursive crashes.
 +		 * We can still crash if the core_pattern binary sets
 +		 * RLIM_CORE = !1, but it runs as root, and can do
 +		 * lots of stupid things.
 +		 *
 +		 * Note that we use task_tgid_vnr here to grab the pid
 +		 * of the process group leader.  That way we get the
 +		 * right pid if a thread in a multi-threaded
 +		 * core_pattern process dies.
 +		 */
 +		coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
 +		return false;
 +	}
 +	cprm->limit = RLIM_INFINITY;
 +
 +	cn->core_pipe_limit = atomic_inc_return(&core_pipe_count);
 +	if (core_pipe_limit && (core_pipe_limit < cn->core_pipe_limit)) {
 +		coredump_report_failure("over core_pipe_limit, skipping core dump");
 +		return false;
 +	}
 +
 +	helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv), GFP_KERNEL);
 +	if (!helper_argv) {
 +		coredump_report_failure("%s failed to allocate memory", __func__);
 +		return false;
 +	}
 +	for (argi = 0; argi < argc; argi++)
 +		helper_argv[argi] = cn->corename + argv[argi];
 +	helper_argv[argi] = NULL;
 +
 +	sub_info = call_usermodehelper_setup(helper_argv[0], helper_argv, NULL,
 +					     GFP_KERNEL, umh_coredump_setup,
 +					     NULL, cprm);
 +	if (!sub_info)
 +		return false;
 +
 +	if (call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC)) {
 +		coredump_report_failure("|%s pipe failed", cn->corename);
 +		return false;
 +	}
 +
 +	/*
 +	 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
 +	 * have this set to NULL.
 +	 */
 +	if (!cprm->file) {
 +		coredump_report_failure("Core dump to |%s disabled", cn->corename);
 +		return false;
 +	}
 +
 +	return true;
 +}
 +
 +static bool coredump_write(struct core_name *cn,
 +			  struct coredump_params *cprm,
 +			  struct linux_binfmt *binfmt)
  {
 +
 +	if (dump_interrupted())
 +		return true;
 +
 +	if (!dump_vma_snapshot(cprm))
 +		return false;
 +
 +	file_start_write(cprm->file);
 +	cn->core_dumped = binfmt->core_dump(cprm);
 +	/*
 +	 * Ensures that file size is big enough to contain the current
 +	 * file postion. This prevents gdb from complaining about
 +	 * a truncated file if the last "write" to the file was
 +	 * dump_skip.
 +	 */
 +	if (cprm->to_skip) {
 +		cprm->to_skip--;
 +		dump_emit(cprm, "", 1);
 +	}
 +	file_end_write(cprm->file);
 +	free_vma_snapshot(cprm);
 +	return true;
 +}
 +
 +static void coredump_cleanup(struct core_name *cn, struct coredump_params *cprm)
 +{
 +	if (cprm->file)
 +		filp_close(cprm->file, NULL);
 +	if (cn->core_pipe_limit) {
 +		VFS_WARN_ON_ONCE(cn->core_type != COREDUMP_PIPE);
 +		atomic_dec(&core_pipe_count);
 +	}
 +	kfree(cn->corename);
 +	coredump_finish(cn->core_dumped);
 +}
 +
 +static inline bool coredump_skip(const struct coredump_params *cprm,
 +				 const struct linux_binfmt *binfmt)
 +{
 +	if (!binfmt)
 +		return true;
 +	if (!binfmt->core_dump)
 +		return true;
 +	if (!__get_dumpable(cprm->mm_flags))
 +		return true;
 +	return false;
 +}
 +
 +void vfs_coredump(const kernel_siginfo_t *siginfo)
 +{
 +	struct cred *cred __free(put_cred) = NULL;
 +	size_t *argv __free(kfree) = NULL;
  	struct core_state core_state;
  	struct core_name cn;
  	struct mm_struct *mm = current->mm;
diff --cc net/unix/af_unix.c
index 52b155123985,c247fb9ac761..000000000000
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@@ -1975,18 -1970,30 +1981,31 @@@ static void unix_skb_to_scm(struct sk_b
   * Some apps rely on write() giving SCM_CREDENTIALS
   * We include credentials if source or destination socket
   * asserted SOCK_PASSCRED.
+  *
+  * Context: May sleep.
+  * Return: On success zero, on error a negative error code is returned.
   */
- static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
- 				 const struct sock *other)
+ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
+ 				const struct sock *other)
  {
  	if (UNIXCB(skb).pid)
- 		return;
+ 		return 0;
  
 -	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
 +	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
 +	    !other->sk_socket) {
- 		UNIXCB(skb).pid = get_pid(task_tgid(current));
+ 		struct pid *pid;
+ 		int err;
+ 
+ 		pid = task_tgid(current);
+ 		err = pidfs_register_pid(pid);
+ 		if (unlikely(err))
+ 			return err;
+ 
+ 		UNIXCB(skb).pid = get_pid(pid);
  		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
  	}
+ 
+ 	return 0;
  }
  
  static bool unix_skb_scm_eq(struct sk_buff *skb,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.pidfs

for you to fetch changes up to 1f531e35c146cca22dc6f4a1bc657098f146f358:

  don't bother with path_get()/path_put() in unix_open_file() (2025-07-14 10:22:47 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.pidfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.pidfs

----------------------------------------------------------------
Al Viro (2):
      fold fs_struct->{lock,seq} into a seqlock
      don't bother with path_get()/path_put() in unix_open_file()

Alexander Mikhalitsyn (7):
      af_unix: rework unix_maybe_add_creds() to allow sleep
      af_unix: introduce unix_skb_to_scm helper
      af_unix: introduce and use scm_replace_pid() helper
      af_unix/scm: fix whitespace errors
      af_unix: stash pidfs dentry when needed
      af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
      selftests: net: extend SCM_PIDFD test to cover stale pidfds

Christian Brauner (31):
      pidfs: raise SB_I_NODEV and SB_I_NOEXEC
      libfs: massage path_from_stashed() to allow custom stashing behavior
      libfs: massage path_from_stashed()
      pidfs: move to anonymous struct
      pidfs: persist information
      pidfs: remove unused members from struct pidfs_inode
      pidfs: remove custom inode allocation
      pidfs: remove pidfs_{get,put}_pid()
      pidfs: remove pidfs_pid_valid()
      libfs: prepare to allow for non-immutable pidfd inodes
      pidfs: make inodes mutable
      pidfs: support xattrs on pidfds
      selftests/pidfd: test extended attribute support
      selftests/pidfd: test extended attribute support
      selftests/pidfd: test setattr support
      pidfs: add some CONFIG_DEBUG_VFS asserts
      Merge patch series "pidfs: persistent info & xattrs"
      pidfs: fix pidfs_free_pid()
      fhandle: raise FILEID_IS_DIR in handle_type
      fhandle: hoist copy_from_user() above get_path_from_fd()
      fhandle: rename to get_path_anchor()
      pidfs: add pidfs_root_path() helper
      fhandle: reflow get_path_anchor()
      uapi/fcntl: mark range as reserved
      fcntl/pidfd: redefine PIDFD_SELF_THREAD_GROUP
      uapi/fcntl: add FD_INVALID
      uapi/fcntl: add FD_PIDFS_ROOT
      fhandle, pidfs: support open_by_handle_at() purely based on file handle
      selftests/pidfd: decode pidfd file handles withou having to specify an fd
      Merge patch series "fhandle, pidfs: allow open_by_handle_at() purely based on file handle"
      Merge patch series "allow to create pidfds for reaped tasks with SCM_PIDFD"

 fs/coredump.c                                      |   6 -
 fs/d_path.c                                        |   8 +-
 fs/exec.c                                          |   4 +-
 fs/fhandle.c                                       |  62 ++-
 fs/fs_struct.c                                     |  36 +-
 fs/internal.h                                      |   4 +
 fs/libfs.c                                         |  34 +-
 fs/namei.c                                         |   8 +-
 fs/pidfs.c                                         | 436 ++++++++++++---------
 include/linux/fs_struct.h                          |  11 +-
 include/linux/pid.h                                |  14 +-
 include/linux/pidfs.h                              |   3 +-
 include/net/scm.h                                  |   4 +-
 include/uapi/linux/fcntl.h                         |  18 +
 include/uapi/linux/pidfd.h                         |  15 -
 kernel/fork.c                                      |  10 +-
 kernel/pid.c                                       |   2 +-
 net/core/scm.c                                     |  32 +-
 net/unix/af_unix.c                                 |  78 ++--
 tools/testing/selftests/net/af_unix/scm_pidfd.c    | 217 +++++++---
 tools/testing/selftests/pidfd/.gitignore           |   2 +
 tools/testing/selftests/pidfd/Makefile             |   5 +-
 tools/testing/selftests/pidfd/pidfd.h              |   6 +-
 .../selftests/pidfd/pidfd_file_handle_test.c       |  60 +++
 tools/testing/selftests/pidfd/pidfd_setattr_test.c |  69 ++++
 tools/testing/selftests/pidfd/pidfd_xattr_test.c   | 132 +++++++
 26 files changed, 894 insertions(+), 382 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_setattr_test.c
 create mode 100644 tools/testing/selftests/pidfd/pidfd_xattr_test.c

