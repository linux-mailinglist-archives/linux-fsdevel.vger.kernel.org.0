Return-Path: <linux-fsdevel+bounces-19266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035DE8C23D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823411F258B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0F016EBEA;
	Fri, 10 May 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlxZ66GO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD11649A7;
	Fri, 10 May 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341596; cv=none; b=P88w+4G22q453LsYlxorNWw7qB2kGoZJ7AQFQMGVhINkJzpaHLoKJpR4NenewNTC+nppO/v2t1a674kdalW+mHmks4nDFrD5/Zpy1eDdSGzLix7pWoVILVHG+lnkgMacRkCv3Bw+vD0roXPmSk4zSaceWxjWRAl9+ICCngm/WeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341596; c=relaxed/simple;
	bh=3hDaJB8aykcCQWNtqDeoWWXyIYsRtRwTOot/8wrBLnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ksj6U5cI+utw11U0jC83bQIJliiW/p6G4om0JdhMOVnD3V2WbLshPi2TOlQz/6Ih+Kt75PzkrDTOWObvd9JgGGpRIMTTifT9Vhiu8zadpiqRFz9GEvvx8dzpsMWFlmzGOqrYGsSkfUu+JsfqZddvdu3WG2cK/cbxFv4uf0Ca5FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlxZ66GO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63192C113CC;
	Fri, 10 May 2024 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715341595;
	bh=3hDaJB8aykcCQWNtqDeoWWXyIYsRtRwTOot/8wrBLnA=;
	h=From:To:Cc:Subject:Date:From;
	b=JlxZ66GOG8N1tQpwRayULiIDrhk1QocKYsLuOj2rh8Cg51jDAFkTEHsLN6TVf/fUL
	 gw2lz63bdxnpnbkzTnTv9mTZd67AsE2LCXtQj12VZ22YB72tn/BkaOADbWFvW/ZPBK
	 QP2SuJO3Quy0tHiE/GTWwnHQT/qDFgsVOGIb+uBK4NgDbQr/Yi9Inlp2bQsEINXcmP
	 KLVe+FBgKvGyOF1FCokmyEWRC6Kb+WDIKvSRaT75UqvbxQ405bSjpcDg88nJk0V2Xb
	 TTwJDvJQwKXnIMn9ECxt81OZlou48sFX9qRAm97f23Nple1Kj33PrJFnob/lx8IGzl
	 KcecGs/cZrqMA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs misc
Date: Fri, 10 May 2024 13:46:24 +0200
Message-ID: <20240510-vfs-misc-22ed27ba6cd7@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11949; i=brauner@kernel.org; h=from:subject:message-id; bh=3hDaJB8aykcCQWNtqDeoWWXyIYsRtRwTOot/8wrBLnA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTZcYotubNK7LLwz99P9APuts9KLDmxTFRa+/9rY/knf zdfi+yU6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIRzMjwxFbyz93P7PILrJP an8lxji/58P/aLWpllKZLpM8X1nJ+TD8L4vas2P19I3M/04f2Oq93Dfj5asLhfOWsvSaX21/NHm iHDsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the usual miscellaneous features, cleanups, and fixes for
vfs and individual fses.

Features
========

* Free up FMODE_* bits. I've freed up bits 6, 7, 8, and 24. That means
  we now have six free FMODE_* bits in total.

* Add FOP_HUGE_PAGES flag (follow-up to FMODE_* cleanup).

* Add fd_raw cleanup class so we can make use of automatic cleanup
  provided by CLASS(fd_raw, f)(fd) for O_PATH fds as well.

* Optimize seq_puts().

* Simplify __seq_puts().

* Add new anon_inode_getfile_fmode() api to allow specifying f_mode
  instead of open-coding it in multiple places.

* Annotate struct file_handle with __counted_by() and use struct_size().

* Warn in get_file() whether f_count resurrection from zero is
  attempted (epoll/drm discussion).

* Folio-sophize aio.

* Export the subvolume id in statx() for both btrfs and bcachefs.

* Relax linkat(AT_EMPTY_PATH) requirements.

* Add F_DUPFD_QUERY fcntl() allowing to compare two file descriptors for
  dup*() equality replacing kcmp().

Cleanups
========

* Compile out swapfile inode checks when swap isn't enabled.

* Use (0 << n) notation for FMODE_* bitshifts for clarity.

* Remove redundant variable assignment in fs/direct-io

* Cleanup uses of strncpy in orangefs.

* Speed up and cleanup writeback.

* Move fsparam_string_empty() helper into header since it's currently
  open-coded in multiple places.

* Add kernel-doc comments to proc_create_net_data_write().

* Don't needlessly read dentry->d_flags twice.

Fixes
=====

* Fix out-of-range warning in nilfs2.

* Fix ecryptfs overflow due to wrong encryption packet size calculation.

* Fix overly long line in xfs file_operations.
  (follow-up to FMODE_* cleanup)

* Don't raise FOP_BUFFER_{R,W}ASYNC for directories in xfs.
  (follow-up to FMODE_* cleanup)

* Don't call xfs_file_open from xfs_dir_open (follow-up to FMODE_* cleanup)

* Fix stable offset api to prevent endless loops.

* Fix afs file server rotations.

* Prevent xattr node from overflowing the eraseblock in jffs2.

* Move fdinfo PTRACE_MODE_READ procfs check into the inode .permission operation
  instead of open operation since this causes userspace regressions.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.9-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the vfs-brauner tree with the ext4 tree
    https://lore.kernel.org/linux-next/20240508103436.589bb440@canb.auug.org.au

[2] linux-next: manual merge of the block tree with the vfs-brauner, vfs trees
    https://lore.kernel.org/linux-next/20240416124426.624cfaf9@canb.auug.org.au

[3] linux-next: manual merge of the block tree with the vfs-brauner tree
    https://lore.kernel.org/linux-next/20240402112137.1ee85957@canb.auug.org.au

Merge conflicts with mainline
=============================

There'll be a merge conflict with mainline stemming from the addition of
FMODE_WRITE_RESTRICTED and the conversion of FMODE_* flags to (1 << n)
bit shitfs. The conflict can be resolved as follows:

diff --cc include/linux/fs.h
index 8dfd53b52744,5b351c1e6f58..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -110,23 -110,24 +110,26 @@@ typedef int (dio_iodone_t)(struct kioc
   */

  /* file is open for reading */
- #define FMODE_READ            ((__force fmode_t)0x1)
+ #define FMODE_READ            ((__force fmode_t)(1 << 0))
  /* file is open for writing */
- #define FMODE_WRITE           ((__force fmode_t)0x2)
+ #define FMODE_WRITE           ((__force fmode_t)(1 << 1))
  /* file is seekable */
- #define FMODE_LSEEK           ((__force fmode_t)0x4)
+ #define FMODE_LSEEK           ((__force fmode_t)(1 << 2))
  /* file can be accessed using pread */
- #define FMODE_PREAD           ((__force fmode_t)0x8)
+ #define FMODE_PREAD           ((__force fmode_t)(1 << 3))
  /* file can be accessed using pwrite */
- #define FMODE_PWRITE          ((__force fmode_t)0x10)
+ #define FMODE_PWRITE          ((__force fmode_t)(1 << 4))
  /* File is opened for execution with sys_execve / sys_uselib */
- #define FMODE_EXEC            ((__force fmode_t)0x20)
+ #define FMODE_EXEC            ((__force fmode_t)(1 << 5))
 +/* File writes are restricted (block device specific) */
- #define FMODE_WRITE_RESTRICTED  ((__force fmode_t)0x40)
++#define FMODE_WRITE_RESTRICTED  ((__force fmode_t)(1 << 6))
+
 -/* FMODE_* bits 6 to 8 */
++/* FMODE_* bits 7 to 8 */
+
  /* 32bit hashes as llseek() offset (for directories) */
- #define FMODE_32BITHASH         ((__force fmode_t)0x200)
+ #define FMODE_32BITHASH         ((__force fmode_t)(1 << 9))
  /* 64bit hashes as llseek() offset (for directories) */
- #define FMODE_64BITHASH         ((__force fmode_t)0x400)
+ #define FMODE_64BITHASH         ((__force fmode_t)(1 << 10))

  /*
   * Don't update ctime and mtime.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.misc

for you to fetch changes up to da0e01cc7079124cb1e86a2c35dd90ba12897e1a:

  afs: Fix fileserver rotation getting stuck (2024-05-10 08:49:17 +0200)

Please consider pulling these changes from the signed vfs-6.10.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10.misc

----------------------------------------------------------------
Alexey Dobriyan (1):
      vfs, swap: compile out IS_SWAPFILE() on swapless configs

Arnd Bergmann (1):
      nilfs2: fix out-of-range warning

Brian Kubisiak (1):
      ecryptfs: Fix buffer size for tag 66 packet

Christian Brauner (7):
      Merge series 'Fixes and cleanups to fs-writeback' of https://lore.kernel.org/r/20240228091958.288260-1-shikemeng@huaweicloud.com
      Merge patch series 'fs: aio: more folio conversion' of https://lore.kernel.org/r/20240321131640.948634-1-wangkefeng.wang@huawei.com
      fs: claw back a few FMODE_* bits
      fs: use bit shifts for FMODE_* flags
      Merge patch series 'Fix shmem_rename2 directory offset calculation' of https://lore.kernel.org/r/20240415152057.4605-1-cel@kernel.org
      file: add fd_raw cleanup class
      selftests: add F_DUPDFD_QUERY selftests

Christoph Hellwig (3):
      xfs: fix overly long line in the file_operations
      xfs: drop fop_flags for directories
      xfs: don't call xfs_file_open from xfs_dir_open

Christophe JAILLET (2):
      seq_file: Optimize seq_puts()
      seq_file: Simplify __seq_puts()

Chuck Lever (3):
      libfs: Fix simple_offset_rename_exchange()
      libfs: Add simple_offset_rename() API
      shmem: Fix shmem_rename2()

Colin Ian King (1):
      fs/direct-io: remove redundant assignment to variable retval

David Howells (1):
      afs: Fix fileserver rotation getting stuck

Dawid Osuchowski (1):
      fs: Create anon_inode_getfile_fmode()

Gustavo A. R. Silva (1):
      fs: Annotate struct file_handle with __counted_by() and use struct_size()

Ilya Denisyev (1):
      jffs2: prevent xattr node from overflowing the eraseblock

Justin Stitt (1):
      orangefs: cleanup uses of strncpy

Kees Cook (1):
      fs: WARN when f_count resurrection is attempted

Kefeng Wang (3):
      fs: aio: use a folio in aio_setup_ring()
      fs: aio: use a folio in aio_free_ring()
      fs: aio: convert to ring_folios and internal_folios

Kemeng Shi (6):
      fs/writeback: avoid to writeback non-expired inode in kupdate writeback
      fs/writeback: bail out if there is no more inodes for IO and queued once
      fs/writeback: remove unused parameter wb of finish_writeback_work
      fs/writeback: only calculate dirtied_before when b_io is empty
      fs/writeback: correct comment of __wakeup_flusher_threads_bdi
      fs/writeback: remove unnecessary return in writeback_inodes_sb

Kent Overstreet (1):
      statx: stx_subvol

Linus Torvalds (2):
      vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
      fcntl: add F_DUPFD_QUERY fcntl()

Luis Henriques (SUSE) (1):
      fs_parser: move fsparam_string_empty() helper into header

Matthew Wilcox (Oracle) (1):
      fs: Add FOP_HUGE_PAGES

Tyler Hicks (Microsoft) (1):
      proc: Move fdinfo PTRACE_MODE_READ check into the inode .permission operation

Yang Li (1):
      fs: Add kernel-doc comments to proc_create_net_data_write()

linke li (1):
      fs/dcache: Re-use value stored to dentry->d_flags instead of re-reading

 block/bdev.c                                    |  2 +-
 block/fops.c                                    |  1 +
 drivers/dax/device.c                            |  2 +-
 fs/afs/rotate.c                                 |  8 ++-
 fs/aio.c                                        | 91 ++++++++++++------------
 fs/anon_inodes.c                                | 33 +++++++++
 fs/bcachefs/fs.c                                |  3 +
 fs/btrfs/file.c                                 |  4 +-
 fs/btrfs/inode.c                                |  3 +
 fs/dcache.c                                     |  2 +-
 fs/direct-io.c                                  |  1 -
 fs/ecryptfs/keystore.c                          |  4 +-
 fs/ext4/file.c                                  |  6 +-
 fs/ext4/super.c                                 |  4 --
 fs/f2fs/file.c                                  |  3 +-
 fs/fcntl.c                                      | 20 ++++++
 fs/fhandle.c                                    |  6 +-
 fs/fs-writeback.c                               | 57 ++++++++-------
 fs/hugetlbfs/inode.c                            |  5 +-
 fs/jffs2/xattr.c                                |  3 +
 fs/libfs.c                                      | 55 +++++++++++++--
 fs/namei.c                                      | 19 +++--
 fs/nilfs2/ioctl.c                               |  2 +-
 fs/orangefs/dcache.c                            |  4 +-
 fs/orangefs/namei.c                             | 26 +++----
 fs/orangefs/super.c                             | 17 ++---
 fs/overlayfs/params.c                           |  4 --
 fs/proc/fd.c                                    | 42 ++++++-----
 fs/proc/proc_net.c                              |  1 +
 fs/read_write.c                                 |  2 +-
 fs/seq_file.c                                   | 13 +---
 fs/stat.c                                       |  1 +
 fs/xfs/xfs_file.c                               | 10 +--
 include/linux/anon_inodes.h                     |  5 ++
 include/linux/file.h                            |  1 +
 include/linux/fs.h                              | 92 +++++++++++++++----------
 include/linux/fs_parser.h                       |  4 ++
 include/linux/hugetlb.h                         |  8 +--
 include/linux/namei.h                           |  1 +
 include/linux/seq_file.h                        | 13 +++-
 include/linux/shm.h                             |  5 --
 include/linux/stat.h                            |  1 +
 include/uapi/linux/fcntl.h                      | 14 ++--
 include/uapi/linux/stat.h                       |  4 +-
 io_uring/io_uring.c                             |  2 +-
 io_uring/rw.c                                   |  9 +--
 ipc/shm.c                                       | 10 +--
 mm/mmap.c                                       |  4 +-
 mm/shmem.c                                      |  3 +-
 tools/testing/selftests/core/close_range_test.c | 55 ++++++++++++++-
 50 files changed, 437 insertions(+), 248 deletions(-)

