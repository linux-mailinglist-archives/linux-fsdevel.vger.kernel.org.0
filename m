Return-Path: <linux-fsdevel+bounces-70166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5519BC92AAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF41F3B00A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D923081B5;
	Fri, 28 Nov 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/ogoE2Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BF2FB968;
	Fri, 28 Nov 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348696; cv=none; b=X31VPyTh+6+xWRcA6uojz2D/zUojCXYMXu3vzB9lKkPAgS9q471WgPz4mH+KYwkNfAzC7pFaWoFVnzuEBK4NsmLKGJcsybgkkBJlmrREWYh9nutTCvyI0r176S1hY4LAkF2m+3pDBNGgdbtLE3Qt9+b/iUFTEX10ORl+pS4JXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348696; c=relaxed/simple;
	bh=UQPRM0vbJq3sp9wXd7GaroMyYeft72bM2Mg44nk9lf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myplxCipC3RTdA6Zl2quDqmaJkb8biOQwG++2xPV8o3eLGHhDFrWYd8JYTdk9StYZXoAj/ZPmgEbEj4WOB9GkKfWzfMVnF7Wz7rHl9t+EQtKs2zDE700mVg0Z+BhjhUyHcz5tfjW/aQxI6nIRGjbFCBSrv0Th39E9C2fx2brSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/ogoE2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CFFC4CEF1;
	Fri, 28 Nov 2025 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348696;
	bh=UQPRM0vbJq3sp9wXd7GaroMyYeft72bM2Mg44nk9lf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/ogoE2ZW71nCNFBbgabJFD19qGXNzfz5FvePvkXPUqXIb+fSUSeiUdddELtlQR3H
	 YGQq3QhHlppg2apNXAx6MuFEeD2tNJkFH9RJlJGCk9rK+eKHgSP+rcnqbM4Ghg4VXg
	 uMeD+5M7ngRnZ8i2kzzgs5XLB9BZ6J698YTKj9ZVtFdSg1zTh/XHDqgrOwUUz+9wCI
	 gCuaTDlUDZhlr3z/ywaOcWBhE44JpM0TnuSuOw+6BvfFZcxSh2+4XS3ZY7+F/S1Rnc
	 DSdLXTGc3yJWxc2JG0y6xZJb50bTwOkxAY0asKNWbtn5n/0Ekei9S7KSPsXnU3pxDW
	 QmLOBCEegqq7g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 16/17 for v6.19] vfs fd prepare
Date: Fri, 28 Nov 2025 17:48:27 +0100
Message-ID: <20251128-vfs-fd-prepare-v619-e23be0b7a0c5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13720; i=brauner@kernel.org; h=from:subject:message-id; bh=UQPRM0vbJq3sp9wXd7GaroMyYeft72bM2Mg44nk9lf0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnrCMk/mtOr1BdyrL6Yf8Oh8+/PnviQepSdeQtenz fi+qT9zdUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEuo4xMqw75mlcpDv/cf02 1xmlDv6xezLSd0o+Sgub9Fo3XW2r8gRGhgd+P3a3nz+h6KBwqkU0/qHzF7Wm3Y/P7PthIpWhdF+ RnxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
Note: This work came late in the cycle but the series is quite nice and
worth doing. It removes roughly double the code that it adds and
eliminates a lot of convoluted cleanup logic across the kernel.

An alternative pull request (vfs-6.19-rc1.fd_prepare.fs) is available
that contains only the more simple filesystem-focused conversions in
case you'd like to pull something more conservative.

Note this branch also contains two reverts for the KVM FD_PREPARE()
conversions as the KVM maintainers have indicated they would like to
take those changes through the KVM tree in the next cycle. Also gets rid
of a merge conflict. I chose a revert to not rebase the branch
unnecessarily so close to the merge window.

This adds the FD_ADD() and FD_PREPARE() primitive. They simplify the
common pattern of get_unused_fd_flags() + create file + fd_install()
that is used extensively throughout the kernel and currently requires
cumbersome cleanup paths.

FD_ADD() - For simple cases where a file is installed immediately:

  fd = FD_ADD(O_CLOEXEC, vfio_device_open_file(device));
  if (fd < 0)
          vfio_device_put_registration(device);
  return fd;

FD_PREPARE() - For cases requiring access to the fd or file, or
additional work before publishing:

  FD_PREPARE(fdf, O_CLOEXEC, sync_file->file);
  if (fdf.err) {
          fput(sync_file->file);
          return fdf.err;
  }

  data.fence = fd_prepare_fd(fdf);
  if (copy_to_user((void __user *)arg, &data, sizeof(data)))
          return -EFAULT;

  return fd_publish(fdf);

The primitives are centered around struct fd_prepare. FD_PREPARE()
encapsulates all allocation and cleanup logic and must be followed by a
call to fd_publish() which associates the fd with the file and installs
it into the caller's fdtable. If fd_publish() isn't called, both are
deallocated automatically. FD_ADD() is a shorthand that does
fd_publish() immediately and never exposes the struct to the caller.

I've implemented this in a way that it's compatible with the cleanup
infrastructure while also being usable separately. IOW, it's centered
around struct fd_prepare which is aliased to class_fd_prepare_t and so
we can make use of all the basica guard infrastructure.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline or other vfs branches
===================================================

diff --cc include/linux/cleanup.h
index 19c7e475d3a4,361104bcfe92..b8bd2f15f91f
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@@ -290,16 -294,18 +294,19 @@@ static inline class_##_name##_t class_#
  	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
  		class_##_name##_constructor
  
+ #define CLASS_INIT(_name, _var, _init_expr)                             \
+         class_##_name##_t _var __cleanup(class_##_name##_destructor) = (_init_expr)
+ 
 -#define scoped_class(_name, var, args)                          \
 -	for (CLASS(_name, var)(args);                           \
 -	     __guard_ptr(_name)(&var) || !__is_cond_ptr(_name); \
 -	     ({ goto _label; }))                                \
 -		if (0) {                                        \
 -_label:                                                         \
 -			break;                                  \
 +#define __scoped_class(_name, var, _label, args...)        \
 +	for (CLASS(_name, var)(args); ; ({ goto _label; })) \
 +		if (0) {                                   \
 +_label:                                                    \
 +			break;                             \
  		} else
  
 +#define scoped_class(_name, var, args...) \
 +	__scoped_class(_name, var, __UNIQUE_ID(label), args)
 +
  /*
   * DEFINE_GUARD(name, type, lock, unlock):
   *	trivial wrapper around DEFINE_CLASS() above specifically
diff --cc ipc/mqueue.c
index 83d9466710d6,d3a588d0dcf6..c118ca2c377a
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@@ -892,15 -892,36 +892,34 @@@ static int prepare_open(struct dentry *
  	return inode_permission(&nop_mnt_idmap, d_inode(dentry), acc);
  }
  
+ static struct file *mqueue_file_open(struct filename *name,
+ 				     struct vfsmount *mnt, int oflag, bool ro,
+ 				     umode_t mode, struct mq_attr *attr)
+ {
 -	struct path path __free(path_put) = {};
+ 	struct dentry *dentry;
++	struct file *file;
+ 	int ret;
+ 
 -	dentry = lookup_noperm(&QSTR(name->name), mnt->mnt_root);
++	dentry = start_creating_noperm(mnt->mnt_root, &QSTR(name->name));
+ 	if (IS_ERR(dentry))
+ 		return ERR_CAST(dentry);
+ 
 -	path.dentry = dentry;
 -	path.mnt = mntget(mnt);
 -
 -	ret = prepare_open(path.dentry, oflag, ro, mode, name, attr);
++	ret = prepare_open(dentry, oflag, ro, mode, name, attr);
+ 	if (ret)
 -		return ERR_PTR(ret);
 -
 -	return dentry_open(&path, oflag, current_cred());
++		file = ERR_PTR(ret);
++	else
++		file = dentry_open(&(const struct path){ .mnt = mnt, .dentry = dentry },
++				   oflag, current_cred());
++	end_creating(dentry);
++	return file;
+ }
+ 
  static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
  		      struct mq_attr *attr)
  {
+ 	struct filename *name __free(putname) = NULL;;
  	struct vfsmount *mnt = current->nsproxy->ipc_ns->mq_mnt;
--	struct dentry *root = mnt->mnt_root;
- 	struct filename *name;
- 	struct path path;
- 	int fd, error;
 -	int fd;
--	int ro;
++	int fd, ro;
  
  	audit_mq_open(oflag, mode, attr);
  
@@@ -908,35 -929,12 +927,10 @@@
  	if (IS_ERR(name))
  		return PTR_ERR(name);
  
- 	fd = get_unused_fd_flags(O_CLOEXEC);
- 	if (fd < 0)
- 		goto out_putname;
- 
  	ro = mnt_want_write(mnt);	/* we'll drop it in any case */
- 	path.dentry = start_creating_noperm(root, &QSTR(name->name));
- 	if (IS_ERR(path.dentry)) {
- 		error = PTR_ERR(path.dentry);
- 		goto out_putfd;
- 	}
- 	path.mnt = mnt;
- 	error = prepare_open(path.dentry, oflag, ro, mode, name, attr);
- 	if (!error) {
- 		struct file *file = dentry_open(&path, oflag, current_cred());
- 		if (!IS_ERR(file))
- 			fd_install(fd, file);
- 		else
- 			error = PTR_ERR(file);
- 	}
- out_putfd:
- 	if (error) {
- 		put_unused_fd(fd);
- 		fd = error;
- 	}
- 	end_creating(path.dentry);
 -	inode_lock(d_inode(root));
+ 	fd = FD_ADD(O_CLOEXEC, mqueue_file_open(name, mnt, oflag, ro, mode, attr));
 -	inode_unlock(d_inode(root));
  	if (!ro)
  		mnt_drop_write(mnt);
- out_putname:
- 	putname(name);
  	return fd;
  }
  

Merge conflicts with other trees
================================

[1]: https://lore.kernel.org/linux-next/20251125122934.36f75838@canb.auug.org.au

[2]: https://lore.kernel.org/linux-next/20251125171130.67ba74e1@canb.auug.org.au

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.fd_prepare

for you to fetch changes up to 65c2c221846eeb157ab7cecf5a26f24d42faafcc:

  Revert "kvm: FD_PREPARE() conversions" (2025-11-28 11:23:08 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.fd_prepare tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.fd_prepare

----------------------------------------------------------------
Christian Brauner (57):
      file: add FD_{ADD,PREPARE}()
      anon_inodes: convert to FD_ADD()
      eventfd: convert do_eventfd() to FD_PREPARE()
      fhandle: convert do_handle_open() to FD_ADD()
      namespace: convert open_tree() to FD_ADD()
      namespace: convert open_tree_attr() to FD_PREPARE()
      namespace: convert fsmount() to FD_PREPARE()
      fanotify: convert fanotify_init() to FD_PREPARE()
      nsfs: convert open_namespace() to FD_PREPARE()
      nsfs: convert ns_ioctl() to FD_PREPARE()
      autofs: convert autofs_dev_ioctl_open_mountpoint() to FD_ADD()
      eventpoll: convert do_epoll_create() to FD_PREPARE()
      open: convert do_sys_openat2() to FD_ADD()
      signalfd: convert do_signalfd4() to FD_ADD()
      timerfd: convert timerfd_create() to FD_ADD()
      userfaultfd: convert new_userfaultfd() to FD_PREPARE()
      xfs: convert xfs_open_by_handle() to FD_PREPARE()
      dma: convert dma_buf_fd() to FD_ADD()
      af_unix: convert unix_file_open() to FD_ADD()
      dma: convert sync_file_ioctl_merge() to FD_PREPARE()
      exec: convert begin_new_exec() to FD_PREPARE()
      ipc: convert do_mq_open() to FD_ADD()
      bpf: convert bpf_iter_new_fd() to FD_PREPARE()
      bpf: convert bpf_token_create() to FD_PREPARE()
      memfd: convert memfd_create() to FD_ADD()
      secretmem: convert memfd_secret() to FD_ADD()
      net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()
      net/kcm: convert kcm_ioctl() to FD_PREPARE()
      net/sctp: convert sctp_getsockopt_peeloff_common() to FD_PREPARE()
      net/socket: convert sock_map_fd() to FD_ADD()
      net/socket: convert __sys_accept4_file() to FD_ADD()
      spufs: convert spufs_context_open() to FD_PREPARE()
      papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()
      spufs: convert spufs_gang_open() to FD_PREPARE()
      pseries: convert papr_platform_dump_create_handle() to FD_ADD()
      pseries: port papr_rtas_setup_file_interface() to FD_ADD()
      dma: port sw_sync_ioctl_create_fence() to FD_PREPARE()
      gpio: convert linehandle_create() to FD_PREPARE()
      hv: convert mshv_ioctl_create_partition() to FD_ADD()
      media: convert media_request_alloc() to FD_PREPARE()
      ntsync: convert ntsync_obj_get_fd() to FD_PREPARE()
      tty: convert ptm_open_peer() to FD_ADD()
      vfio: convert vfio_group_ioctl_get_device_fd() to FD_ADD()
      file: convert replace_fd() to FD_PREPARE()
      io_uring: convert io_create_mock_file() to FD_PREPARE()
      kvm: convert kvm_arch_supports_gmem_init_shared() to FD_PREPARE()
      kvm: convert kvm_vcpu_ioctl_get_stats_fd() to FD_PREPARE()
      Merge patch series "file: FD_{ADD,PREPARE}()"
      ipc: preserve original file opening pattern
      devpts: preserve original file opening pattern
      dma: return zero after fd_publish()
      exec: switch to FD_ADD()
      handshake: return zero after fd_publish()
      ntsync: only install fd on success
      io_uring: return zero after fd_publish()
      file: make struct fd_prepare a first-class citizen
      Revert "kvm: FD_PREPARE() conversions"

Deepanshu Kartikey (1):
      namespace: fix mntput of ERR_PTR in fsmount error path

Kuniyuki Iwashima (1):
      fanotify: Don't call fsnotify_destroy_group() when fsnotify_alloc_group() fails.

 arch/powerpc/platforms/cell/spufs/inode.c          |  42 ++-----
 arch/powerpc/platforms/pseries/papr-hvpipe.c       |  39 ++-----
 .../powerpc/platforms/pseries/papr-platform-dump.c |  30 ++---
 arch/powerpc/platforms/pseries/papr-rtas-common.c  |  27 +----
 drivers/dma-buf/dma-buf.c                          |  10 +-
 drivers/dma-buf/sw_sync.c                          |  39 +++----
 drivers/dma-buf/sync_file.c                        |  53 +++------
 drivers/gpio/gpiolib-cdev.c                        |  66 ++++-------
 drivers/hv/mshv_root_main.c                        |  30 +----
 drivers/media/mc/mc-request.c                      |  34 ++----
 drivers/misc/ntsync.c                              |  21 +---
 drivers/tty/pty.c                                  |  51 +++------
 drivers/vfio/group.c                               |  28 +----
 fs/anon_inodes.c                                   |  23 +---
 fs/autofs/dev-ioctl.c                              |  30 +----
 fs/eventfd.c                                       |  31 ++---
 fs/eventpoll.c                                     |  32 ++----
 fs/exec.c                                          |   3 +-
 fs/fhandle.c                                       |  30 +++--
 fs/file.c                                          |  19 ++--
 fs/namespace.c                                     | 103 ++++++-----------
 fs/notify/fanotify/fanotify_user.c                 |  60 ++++------
 fs/nsfs.c                                          |  47 +++-----
 fs/open.c                                          |  17 +--
 fs/signalfd.c                                      |  29 ++---
 fs/timerfd.c                                       |  29 ++---
 fs/userfaultfd.c                                   |  30 ++---
 fs/xfs/xfs_handle.c                                |  56 +++------
 include/linux/cleanup.h                            |   7 ++
 include/linux/file.h                               | 126 +++++++++++++++++++++
 io_uring/mock_file.c                               |  43 +++----
 ipc/mqueue.c                                       |  54 ++++-----
 kernel/bpf/bpf_iter.c                              |  29 ++---
 kernel/bpf/token.c                                 |  47 +++-----
 mm/memfd.c                                         |  29 +----
 mm/secretmem.c                                     |  20 +---
 net/handshake/netlink.c                            |  38 +++----
 net/kcm/kcmsock.c                                  |  22 ++--
 net/sctp/socket.c                                  |  90 ++++-----------
 net/socket.c                                       |  34 +-----
 net/unix/af_unix.c                                 |  16 +--
 41 files changed, 564 insertions(+), 1000 deletions(-)

