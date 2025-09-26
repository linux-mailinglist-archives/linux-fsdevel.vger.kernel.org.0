Return-Path: <linux-fsdevel+bounces-62880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D27BA417E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE1D17C192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1B1CDFAC;
	Fri, 26 Sep 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODoUhL8V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008681C7009;
	Fri, 26 Sep 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896346; cv=none; b=mRL0GahHxm/14VTEHkr3hBEZa9Aj9wBthRBLj9R2i6T8PcBGOlUany/5LiNQV7GwDWyGYu9aPj4QF6Udu0y5loNOJtNJuNw3E+eAIvGN8/MGudgpMswE/85tULmis4m72Ch6V3WD41OlB9H5p4XLLltJ+RAG5/gq5RwR31bKRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896346; c=relaxed/simple;
	bh=soEV80ofEpW+LZrtVKg5rrUACFD8uXXcryPZYYXVEq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFaVxbDRKgX2QV1PMJ/uwCqb8TRRDLAAMYwejPbUT0rXbws5lGb2EWT0LLrebEKxFTApmhJvCnSePCuicQnLR2L9yh4ACi+g1CCC8ECyVkZyuTOzZ4w9SxI4UeMf1Ck7bInUVgmRC+lIXYaiD67JgRfqUeJvcTzZgk4brXidCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODoUhL8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4371C4CEF7;
	Fri, 26 Sep 2025 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896345;
	bh=soEV80ofEpW+LZrtVKg5rrUACFD8uXXcryPZYYXVEq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODoUhL8V2KhOscBhe+YVRZ+/BbyAQ0SfRB3UEEzkOFa9o7Tp48YF2TUDTTiAfbNYo
	 58Bcn2QCuRMdwHLkAa0jLto3925lQk+FO7NOH22y5fSsiRQCqb5NSr8MVJEMuPf3BM
	 4g0L+48lDP5IBMYu2tTCSy4fkCyYo8UV4PWp+bsq7onD8SJ/edPvucpoyD9Bgkp5UN
	 3uSMCjJnmLVeo3mfkvIszc0DCv/FJt8La8pzoEGz8axwN2fMdZLVqF2vfV+2La7Mvj
	 FL/4iCpRJlpyRpfkdOpsJ2KUyMaQ8i9F4SistQIOIKrlcKgcBKYCma1lH5QBIxUm4P
	 yuHzPKZhRuXZg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 01/12 for v6.18] misc
Date: Fri, 26 Sep 2025 16:18:55 +0200
Message-ID: <20250926-vfs-misc-fdd0c7318e6a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12283; i=brauner@kernel.org; h=from:subject:message-id; bh=soEV80ofEpW+LZrtVKg5rrUACFD8uXXcryPZYYXVEq4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3De5UCgym5ZnXX76t7rLp/O+C07bKWY6emT6uziJ Vz93vyvO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYitJ6R4fsrtTl1axnXiR1R NavzUSvP+/Snp4yd9/zbr7qnk68ERzEyzDqQkv2aXenFyRcfOi7JuottbApU8GlJF9lVXTtxt5Y JKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the usual selections of misc updates for this cycle.

Features:

- Add "initramfs_options" parameter to set initramfs mount options. This
  allows to add specific mount options to the rootfs to e.g., limit the
  memory size.

- Add RWF_NOSIGNAL flag for pwritev2()

  Add RWF_NOSIGNAL flag for pwritev2. This flag prevents the SIGPIPE
  signal from being raised when writing on disconnected pipes or
  sockets. The flag is handled directly by the pipe filesystem and
  converted to the existing MSG_NOSIGNAL flag for sockets.

- Allow to pass pid namespace as procfs mount option

  Ever since the introduction of pid namespaces, procfs has had very
  implicit behaviour surrounding them (the pidns used by a procfs mount
  is auto-selected based on the mounting process's active pidns, and the
  pidns itself is basically hidden once the mount has been constructed).

  This implicit behaviour has historically meant that userspace was
  required to do some special dances in order to configure the pidns of
  a procfs mount as desired. Examples include:

  * In order to bypass the mnt_too_revealing() check, Kubernetes creates
    a procfs mount from an empty pidns so that user namespaced
    containers can be nested (without this, the nested containers would
    fail to mount procfs). But this requires forking off a helper
    process because you cannot just one-shot this using mount(2).

  * Container runtimes in general need to fork into a container before
    configuring its mounts, which can lead to security issues in the
    case of shared-pidns containers (a privileged process in the pidns
    can interact with your container runtime process).
    While SUID_DUMP_DISABLE and user namespaces make this less of an
    issue, the strict need for this due to a minor uAPI wart is kind of
    unfortunate.

    Things would be much easier if there was a way for userspace to just
    specify the pidns they want. So this pull request contains changes
    to implement a new "pidns" argument which can be set using
    fsconfig(2):

        fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
        fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0);

    or classic mount(2) / mount(8):

        // mount -t proc -o pidns=/proc/self/ns/pid proc /tmp/proc
        mount("proc", "/tmp/proc", "proc", MS_..., "pidns=/proc/self/ns/pid");

Cleanups:

- Remove the last references to EXPORT_OP_ASYNC_LOCK.

- Make file_remove_privs_flags() static.

- Remove redundant __GFP_NOWARN when GFP_NOWAIT is used.

- Use try_cmpxchg() in start_dir_add().

- Use try_cmpxchg() in sb_init_done_wq().

- Replace offsetof() with struct_size() in ioctl_file_dedupe_range().

- Remove vfs_ioctl() export.

- Replace rwlock() with spinlock in epoll code as rwlock causes priority
  inversion on preempt rt kernels.

- Make ns_entries in fs/proc/namespaces const.

- Use a switch() statement() in init_special_inode() just like we do in
  may_open().

- Use struct_size() in dir_add() in the initramfs code.

- Use str_plural() in rd_load_image().

- Replace strcpy() with strscpy() in find_link().

- Rename generic_delete_inode() to inode_just_drop() and
  generic_drop_inode() to inode_generic_drop().

- Remove unused arguments from fcntl_{g,s}et_rw_hint().

Fixes:

- Document @name parameter for name_contains_dotdot() helper.

- Fix spelling mistake.

- Always return zero from replace_fd() instead of the file descriptor number.

- Limit the size for copy_file_range() in compat mode to prevent a signed
  overflow.

- Fix debugfs mount options not being applied.

- Verify the inode mode when loading it from disk in minixfs.

- Verify the inode mode when loading it from disk in cramfs.

- Don't trigger automounts with RESOLVE_NO_XDEV

  If openat2() was called with RESOLVE_NO_XDEV it didn't traverse
  through automounts, but could still trigger them.

- Add FL_RECLAIM flag to show_fl_flags() macro so it appears in tracepoints.

- Fix unused variable warning in rd_load_image() on s390.

- Make INITRAMFS_PRESERVE_MTIME depend on BLK_DEV_INITRD.

- Use ns_capable_noaudit() when determining net sysctl permissions.

- Don't call path_put() under namespace semaphore in listmount() and statmount().

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.misc

for you to fetch changes up to 28986dd7e38fb5ba2f180f9eb3ff330798719369:

  fcntl: trim arguments (2025-09-26 10:21:23 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.misc

----------------------------------------------------------------
Aleksa Sarai (3):
      pidns: move is-ancestor logic to helper
      procfs: add "pidns" mount option
      selftests/proc: add tests for new pidns APIs

Askar Safin (4):
      namei: move cross-device check to traverse_mounts
      namei: remove LOOKUP_NO_XDEV check from handle_mounts
      namei: move cross-device check to __traverse_mounts
      openat2: don't trigger automounts with RESOLVE_NO_XDEV

Charalampos Mitrodimas (1):
      debugfs: fix mount options not being applied

Christian Brauner (5):
      Merge patch series "vfs: if RESOLVE_NO_XDEV passed to openat2, don't *trigger* automounts"
      Merge patch series "procfs: make reference pidns more user-visible"
      Merge patch "eventpoll: Fix priority inversion problem"
      statmount: don't call path_put() under namespace semaphore
      listmount: don't call path_put() under namespace semaphore

Christian Göttsche (1):
      pid: use ns_capable_noaudit() when determining net sysctl permissions

Christoph Hellwig (1):
      fs: mark file_remove_privs_flags static

Geert Uytterhoeven (1):
      init: INITRAMFS_PRESERVE_MTIME should depend on BLK_DEV_INITRD

Greg Kroah-Hartman (1):
      fs: remove vfs_ioctl export

Jeff Layton (1):
      filelock: add FL_RECLAIM to show_fl_flags() macro

Kanchan Joshi (1):
      fcntl: trim arguments

Kriish Sharma (1):
      fs: document 'name' parameter for name_contains_dotdot()

Lauri Vasama (1):
      Add RWF_NOSIGNAL flag for pwritev2

Lichen Liu (1):
      fs: Add 'initramfs_options' to set initramfs mount options

Mateusz Guzik (2):
      fs: use the switch statement in init_special_inode()
      fs: rename generic_delete_inode() and generic_drop_inode()

Max Kellermann (1):
      fs/proc/namespaces: make ns_entries const

Miklos Szeredi (1):
      copy_file_range: limit size if in compat mode

Nam Cao (1):
      eventpoll: Replace rwlock with spinlock

Qianfeng Rong (1):
      fs-writeback: Remove redundant __GFP_NOWARN

Tetsuo Handa (3):
      vfs: show filesystem name at dump_inode()
      minixfs: Verify inode mode when loading from disk
      cramfs: Verify inode mode when loading from disk

Thiago Becker (1):
      locks: Remove the last reference to EXPORT_OP_ASYNC_LOCK.

Thomas Weißschuh (1):
      fs: always return zero on success from replace_fd()

Thorsten Blum (4):
      initrd: Fix unused variable warning in rd_load_image() on s390
      initramfs: Use struct_size() helper to improve dir_add()
      initrd: Use str_plural() in rd_load_image()
      initramfs: Replace strcpy() with strscpy() in find_link()

Uros Bizjak (2):
      fs: Use try_cmpxchg() in start_dir_add()
      fs: Use try_cmpxchg() in sb_init_done_wq()

Xichao Zhao (2):
      fs: fix "writen"->"written"
      fs: Replace offsetof() with struct_size() in ioctl_file_dedupe_range()

 Documentation/admin-guide/kernel-parameters.txt |   3 +
 Documentation/filesystems/porting.rst           |   4 +-
 Documentation/filesystems/proc.rst              |   8 +
 Documentation/filesystems/vfs.rst               |   4 +-
 block/bdev.c                                    |   2 +-
 drivers/dax/super.c                             |   2 +-
 drivers/misc/ibmasm/ibmasmfs.c                  |   2 +-
 drivers/usb/gadget/function/f_fs.c              |   2 +-
 drivers/usb/gadget/legacy/inode.c               |   2 +-
 fs/9p/vfs_super.c                               |   2 +-
 fs/afs/inode.c                                  |   4 +-
 fs/btrfs/inode.c                                |   2 +-
 fs/ceph/super.c                                 |   2 +-
 fs/configfs/mount.c                             |   2 +-
 fs/cramfs/inode.c                               |  11 +-
 fs/dcache.c                                     |   4 +-
 fs/debugfs/inode.c                              |  11 +-
 fs/efivarfs/super.c                             |   2 +-
 fs/eventpoll.c                                  | 139 +++-------------
 fs/ext4/super.c                                 |   2 +-
 fs/f2fs/super.c                                 |   2 +-
 fs/fcntl.c                                      |  10 +-
 fs/file.c                                       |   5 +-
 fs/fs-writeback.c                               |   2 +-
 fs/fuse/inode.c                                 |   2 +-
 fs/gfs2/super.c                                 |   2 +-
 fs/hostfs/hostfs_kern.c                         |   2 +-
 fs/inode.c                                      |  30 ++--
 fs/ioctl.c                                      |   5 +-
 fs/kernfs/mount.c                               |   2 +-
 fs/locks.c                                      |   4 +-
 fs/minix/inode.c                                |   8 +-
 fs/namei.c                                      |  22 ++-
 fs/namespace.c                                  | 106 ++++++++----
 fs/nfs/inode.c                                  |   2 +-
 fs/ocfs2/dlmfs/dlmfs.c                          |   2 +-
 fs/orangefs/super.c                             |   2 +-
 fs/overlayfs/super.c                            |   2 +-
 fs/pidfs.c                                      |   2 +-
 fs/pipe.c                                       |   6 +-
 fs/proc/inode.c                                 |   2 +-
 fs/proc/namespaces.c                            |   6 +-
 fs/proc/root.c                                  |  98 ++++++++++-
 fs/pstore/inode.c                               |   2 +-
 fs/ramfs/inode.c                                |   2 +-
 fs/read_write.c                                 |  14 +-
 fs/smb/client/cifsfs.c                          |   2 +-
 fs/super.c                                      |   8 +-
 fs/ubifs/super.c                                |   2 +-
 fs/xfs/xfs_super.c                              |   2 +-
 include/linux/fs.h                              |  10 +-
 include/linux/pid_namespace.h                   |   9 +
 include/trace/events/filelock.h                 |   3 +-
 include/uapi/linux/fs.h                         |   5 +-
 init/Kconfig                                    |   1 +
 init/do_mounts_rd.c                             |  14 +-
 init/initramfs.c                                |   5 +-
 kernel/bpf/inode.c                              |   2 +-
 kernel/pid.c                                    |   2 +-
 kernel/pid_namespace.c                          |  22 ++-
 mm/shmem.c                                      |   2 +-
 net/socket.c                                    |   3 +
 tools/testing/selftests/proc/.gitignore         |   1 +
 tools/testing/selftests/proc/Makefile           |   1 +
 tools/testing/selftests/proc/proc-pidns.c       | 211 ++++++++++++++++++++++++
 65 files changed, 592 insertions(+), 265 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-pidns.c

