Return-Path: <linux-fsdevel+bounces-44763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DC2A6C8FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE5F189B1A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7148F1F541E;
	Sat, 22 Mar 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJEls845"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A91F4CB2;
	Sat, 22 Mar 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638411; cv=none; b=kdRRtFNTwpXo/1CW3fzztSTHkH+t9PZuQQPiMaeRiwYYVOZjahEtp/AtkCx9U8hk9wVeesVUDfnSITWo3v39Xsth9PIvaY02+5lWJH4GXKOhAlLUUvfhYBGPIc/RxPqH/YiM/Igkz88hi5je/vsvR4XV/QRTpsBAjgt7qRGZTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638411; c=relaxed/simple;
	bh=89AYU/xAeTeR9C/BovNZcKwZN3LB7vFVd3U8Ftm2ydY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m33R8Cqjnv159XSkkRUABsq4sUNoXtat7zEuMZGMJ35HnsfXjCG34/37wClwqaM7krEWUHjRw9H0buBoJBncV7CYtZlvCVzY4OVhzwvaihmGZrc/iOF3zr/CjBCYkO+ny0u8ypGGJtrZDKfE+hsnyEqo0U+pOa9pWuMkrxA1ht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJEls845; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D28C4CEDD;
	Sat, 22 Mar 2025 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638411;
	bh=89AYU/xAeTeR9C/BovNZcKwZN3LB7vFVd3U8Ftm2ydY=;
	h=From:To:Cc:Subject:Date:From;
	b=qJEls845B9AzR+tiPWu4UaVSnmQDaCMKcScUIsxUKbufB2tsZgUbEBqzCif3Aaxam
	 gRFH3vP7ygErDKSaNBvnKROTE8JMd/bxIbKEw2IajWOh5FHGzCEY/kVViuTBlTCEfY
	 BZhLWDXs1R2lHwjfQC4AHJ47s3BNqBzi+GqLYGFsZK+7U/f+GFZRTsUoGCrSmGvxSx
	 Kl5zPv4hmdfDXkR3JyoWPvA2GOaGmV45Mfs8Sgco2DMw5Jpe77BQpY1+fuLA8r+CWW
	 NDXW92mu8UB9D54t9wQGdly4Cbxtl6QTELpWCmewYgOCKphQc4Y6EwzEY3VFlOOSki
	 GCv/6Tk6PExZA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs mount
Date: Sat, 22 Mar 2025 11:13:18 +0100
Message-ID: <20250322-vfs-mount-b08c842965f4@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8992; i=brauner@kernel.org; h=from:subject:message-id; bh=89AYU/xAeTeR9C/BovNZcKwZN3LB7vFVd3U8Ftm2ydY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf63VQObBle8nUsu1fp7ZuzXl3N3+WZpPG2wvcnyUkJ 7jYsBhf6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIEk1GhsvvJiaLRfBOm59S d8KmePGiuHDuhemhBX/0jUo29J1Kbmf4p2cunTWDadGhgt/PF1pXKfxQeKsVfXCV6/+dsn8rt7B k8wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the first batch of mount updates for this cycle:

- Mount notifications

  The day has come where we finally provide a new api to listen for
  mount topology changes outside of /proc/<pid>/mountinfo. A mount
  namespace file descriptor can be supplied and registered with fanotify
  to listen for mount topology changes.

  Currently notifications for mount, umount and moving mounts are
  generated. The generated notification record contains the unique mount
  id of the mount.

  The listmount() and statmount() api can be used to query detailed
  information about the mount using the received unique mount id.

  This allows userspace to figure out exactly how the mount topology
  changed without having to generating diffs of /proc/<pid>/mountinfo in
  userspace.

- Support O_PATH file descriptors with FSCONFIG_SET_FD in the new mount api.

- Support detached mounts in overlayfs.

  Since last cycle we support specifying overlayfs layers via file
  descriptors. However, we don't allow detached mounts which means
  userspace cannot user file descriptors received via
  open_tree(OPEN_TREE_CLONE) and fsmount() directly. They have to attach
  them to a mount namespace via move_mount() first. This is cumbersome
  and means they have to undo mounts via umount(). This allows them to
  directly use detached mounts.

- Allow to retrieve idmappings with statmount.

  Currently it isn't possible to figure out what idmapping has been
  attached to an idmapped mount. Add an extension to statmount() which
  allows to read the idmapping from the mount.

- Allow creating idmapped mounts from mounts that are already idmapped.

  So far it isn't possible to allow the creation of idmapped mounts from
  already idmapped mounts as this has significant lifetime implications.
  Make the creation of idmapped mounts atomic by allow to pass struct
  mount_attr together with the open_tree_attr() system call allowing to
  solve these issues without complicating VFS lookup in any way.

  The system call has in general the benefit that creating a detached
  mount and applying mount attributes to it becomes an atomic operation
  for userspace.

- Add a way to query statmount() for supported options.

  Allow userspace to query which mount information can be retrieved
  through statmount().

- Allow superblock owners to force unmount.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This contains a merge conflict with the vfs-6.15.misc pull request:

diff --cc fs/internal.h
index 82127c69e641,db6094d5cb0b..000000000000
--- a/fs/internal.h
+++ b/fs/internal.h
@@@ -337,4 -338,4 +337,5 @@@ static inline bool path_mounted(const s
        return path->mnt->mnt_root == path->dentry;
  }
  void file_f_owner_release(struct file *file);
 +bool file_seek_cur_needs_f_lock(struct file *file);
+ int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_map);

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount

for you to fetch changes up to e1ff7aa34dec7e650159fd7ca8ec6af7cc428d9f:

  umount: Allow superblock owners to force umount (2025-03-19 09:19:04 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.mount tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.mount

----------------------------------------------------------------
Arnd Bergmann (1):
      samples/vfs: fix printf format string for size_t

Christian Brauner (18):
      Merge patch series "mount notification"
      fs: support O_PATH fds with FSCONFIG_SET_FD
      selftests/overlayfs: test specifying layers as O_PATH file descriptors
      Merge patch series "ovl: allow O_PATH file descriptor when specifying layers"
      fs: allow detached mounts in clone_private_mount()
      uidgid: add map_id_range_up()
      statmount: allow to retrieve idmappings
      samples/vfs: check whether flag was raised
      selftests: add tests for using detached mount with overlayfs
      samples/vfs: add STATMOUNT_MNT_{G,U}IDMAP
      Merge patch series "fs: allow detached mounts in clone_private_mount()"
      fs: add vfs_open_tree() helper
      fs: add copy_mount_setattr() helper
      fs: add open_tree_attr()
      fs: add kflags member to struct mount_kattr
      fs: allow changing idmappings
      Merge patch series "statmount: allow to retrieve idmappings"
      Merge patch series "fs: allow changing idmappings"

Jeff Layton (1):
      statmount: add a new supported_mask field

Miklos Szeredi (5):
      fsnotify: add mount notification infrastructure
      fanotify: notify on mount attach and detach
      vfs: add notifications for mount attach and detach
      selinux: add FILE__WATCH_MOUNTNS
      selftests: add tests for mount notification

Trond Myklebust (1):
      umount: Allow superblock owners to force umount

 arch/alpha/kernel/syscalls/syscall.tbl             |   1 +
 arch/arm/tools/syscall.tbl                         |   1 +
 arch/arm64/tools/syscall_32.tbl                    |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl              |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl            |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl           |   1 +
 arch/s390/kernel/syscalls/syscall.tbl              |   1 +
 arch/sh/kernel/syscalls/syscall.tbl                |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl             |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |   1 +
 fs/autofs/autofs_i.h                               |   2 +
 fs/fsopen.c                                        |   2 +-
 fs/internal.h                                      |   1 +
 fs/mnt_idmapping.c                                 |  51 ++
 fs/mount.h                                         |  26 ++
 fs/namespace.c                                     | 485 ++++++++++++++-----
 fs/notify/fanotify/fanotify.c                      |  38 +-
 fs/notify/fanotify/fanotify.h                      |  18 +
 fs/notify/fanotify/fanotify_user.c                 |  89 +++-
 fs/notify/fdinfo.c                                 |   5 +
 fs/notify/fsnotify.c                               |  47 +-
 fs/notify/fsnotify.h                               |  11 +
 fs/notify/mark.c                                   |  14 +-
 fs/pnode.c                                         |   4 +-
 include/linux/fanotify.h                           |  12 +-
 include/linux/fsnotify.h                           |  20 +
 include/linux/fsnotify_backend.h                   |  42 ++
 include/linux/mnt_idmapping.h                      |   5 +
 include/linux/syscalls.h                           |   4 +
 include/linux/uidgid.h                             |   6 +
 include/uapi/asm-generic/unistd.h                  |   4 +-
 include/uapi/linux/fanotify.h                      |  10 +
 include/uapi/linux/mount.h                         |  10 +-
 kernel/user_namespace.c                            |  26 +-
 samples/vfs/samples-vfs.h                          |  14 +-
 samples/vfs/test-list-all-mounts.c                 |  35 +-
 scripts/syscall.tbl                                |   1 +
 security/selinux/hooks.c                           |   3 +
 security/selinux/include/classmap.h                |   2 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/mount-notify/.gitignore  |   2 +
 .../selftests/filesystems/mount-notify/Makefile    |   6 +
 .../filesystems/mount-notify/mount-notify_test.c   | 516 +++++++++++++++++++++
 .../filesystems/overlayfs/set_layers_via_fds.c     | 195 ++++++++
 .../selftests/filesystems/overlayfs/wrappers.h     |  17 +
 .../selftests/filesystems/statmount/statmount.h    |   2 +-
 52 files changed, 1567 insertions(+), 175 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/mount-notify/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/mount-notify/Makefile
 create mode 100644 tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c

