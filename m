Return-Path: <linux-fsdevel+bounces-56026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C24B11D8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8C0AE1D52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820A2EBDD8;
	Fri, 25 Jul 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ+vu/Bb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732D2EBB97;
	Fri, 25 Jul 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442861; cv=none; b=JBAk8RiGGr4nvIyoDu+A1y0L+yw+6smVxukAk1XJ5i6Fv+2bOvCt7TdlnK7A0BsQWaWRng+2eoT+wpdOB+F53SKoIBOJyfLswlCRncwpuJKkdU/eu7tJAiZ9AnUGgHc6VVnbRdqqvRggOA/qKbpDm4/jupkRIH1lgyJXOfghV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442861; c=relaxed/simple;
	bh=gFKxhW8iA1j4ehsAOr2GRkrzHzX48JxWOxPTQzQT6Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhLjTBQk71FoFDN8njaIJiau0QDEUmgqFyuOkWaCg501YbzlQPYxWric+imyNzYFSClFARK5s3EuUZ5JlEeE3vNBchY1vVbT4IkF1ahAge6DuO4pkz7C8UMLRNngHMbEa8mhKnF/YrudheKM4b4LdE/RBg51gbiN4j08JC4xAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ+vu/Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB51C4CEEF;
	Fri, 25 Jul 2025 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442861;
	bh=gFKxhW8iA1j4ehsAOr2GRkrzHzX48JxWOxPTQzQT6Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQ+vu/BbD0yvt8oAjEAg0WUuJKuRY5grQlDDKMQcHlV2gH08bcuuiVtly5T5tao7p
	 ydnI3ChpAC+CKEayaZ0TBaylV5pEnTKTKSfH6r7BhWOlqzllx6icl1xaSol2nRS2/H
	 1LQNVfTbOiGKrec/ZUukZW5hocEJvj5eh/EOVpajhSp3GLgbddTYnLA7C2xvUAPT9W
	 F8osdzfOkSFk7FiECv1I5czWk37jI/3/rlprS5c53l7HoGe1ucZSbe7da7zhsqjEYd
	 yPYhN2dmaMfGBsLjC5fyZLpRVo2xZb2aA8Wsis22jQ/A77CAlCd05ws3M0rXgUOSRD
	 ZCIt/SVrCMj7g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 01/14 for v6.17] vfs misc
Date: Fri, 25 Jul 2025 13:27:21 +0200
Message-ID: <20250725-vfs-misc-599b4aef8eaa@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9856; i=brauner@kernel.org; h=from:subject:message-id; bh=gFKxhW8iA1j4ehsAOr2GRkrzHzX48JxWOxPTQzQT6Jo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4nd5DN6u2L6ga5nkyXf6z/8Prv/atisrx+8bnyrW /J2hoe0WkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE+I0Y/qevn3LWxbOo+dJD afstjVf39XobPZXwcYnRPb367ZEVdZMZGc7wf7gefTWv3cFgIZMfl9J1iW3sRhP0Zs9lYH907En yRU4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the usual selections of misc updates for this cycle.

Features:

- Add ext4 IOCB_DONTCACHE support

  This refactors the address_space_operations write_begin() and
  write_end() callbacks to take const struct kiocb * as their first
  argument, allowing IOCB flags such as IOCB_DONTCACHE to propagate to
  the filesystem's buffered I/O path.

  Ext4 is updated to implement handling of the IOCB_DONTCACHE flag and
  advertises support via the FOP_DONTCACHE file operation flag.

  Additionally, the i915 driver's shmem write paths are updated to
  bypass the legacy write_begin/write_end interface in favor of directly
  calling write_iter() with a constructed synchronous kiocb. Another
  i915 change replaces a manual write loop with kernel_write() during
  GEM shmem object creation.

Cleanups:

- don't duplicate vfs_open() in kernel_file_open()

- proc_fd_getattr(): don't bother with S_ISDIR() check

- fs/ecryptfs: replace snprintf with sysfs_emit in show function

- vfs: Remove unnecessary list_for_each_entry_safe() from evict_inodes()

- filelock: add new locks_wake_up_waiter() helper

- fs: Remove three arguments from block_write_end()

- VFS: change old_dir and new_dir in struct renamedata to dentrys

- netfs: Remove unused declaration netfs_queue_write_request()

Fixes:

- eventpoll: Fix semi-unbounded recursion

- eventpoll: fix sphinx documentation build warning

- fs/read_write: Fix spelling typo

- fs: annotate data race between poll_schedule_timeout() and pollwake()

- fs/pipe: set FMODE_NOWAIT in create_pipe_files()

- docs/vfs: update references to i_mutex to i_rwsem

- fs/buffer: remove comment about hard sectorsize

- fs/buffer: remove the min and max limit checks in __getblk_slow()

- fs/libfs: don't assume blocksize <= PAGE_SIZE in generic_check_addressable

- fs_context: fix parameter name in infofc() macro

- fs: Prevent file descriptor table allocations exceeding INT_MAX

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

No known conflicts.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.misc

for you to fetch changes up to 4e8fc4f7208b032674ef8a4977b96484c328515c:

  netfs: Remove unused declaration netfs_queue_write_request() (2025-07-23 15:08:36 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.misc

----------------------------------------------------------------
Al Viro (2):
      don't duplicate vfs_open() in kernel_file_open()
      proc_fd_getattr(): don't bother with S_ISDIR() check

Andy Shevchenko (1):
      fs/read_write: Fix spelling typo

Ankit Chauhan (1):
      fs/ecryptfs: replace snprintf with sysfs_emit in show function

Christian Brauner (1):
      Merge patch series "fs: refactor write_begin/write_end and add ext4 IOCB_DONTCACHE support"

Dmitry Antipov (1):
      fs: annotate suspected data race between poll_schedule_timeout() and pollwake()

Jan Kara (1):
      vfs: Remove unnecessary list_for_each_entry_safe() from evict_inodes()

Jann Horn (2):
      eventpoll: Fix semi-unbounded recursion
      eventpoll: fix sphinx documentation build warning

Jeff Layton (1):
      filelock: add new locks_wake_up_waiter() helper

Jens Axboe (1):
      fs/pipe: set FMODE_NOWAIT in create_pipe_files()

Junxuan Liao (1):
      docs/vfs: update references to i_mutex to i_rwsem

Matthew Wilcox (Oracle) (1):
      fs: Remove three arguments from block_write_end()

NeilBrown (1):
      VFS: change old_dir and new_dir in struct renamedata to dentrys

Pankaj Raghav (3):
      fs/buffer: remove comment about hard sectorsize
      fs/buffer: remove the min and max limit checks in __getblk_slow()
      fs/libfs: don't assume blocksize <= PAGE_SIZE in generic_check_addressable

RubenKelevra (1):
      fs_context: fix parameter name in infofc() macro

Sasha Levin (1):
      fs: Prevent file descriptor table allocations exceeding INT_MAX

Taotao Chen (5):
      drm/i915: Use kernel_write() in shmem object create
      drm/i915: Refactor shmem_pwrite() to use kiocb and write_iter
      fs: change write_begin/write_end interface to take struct kiocb *
      mm/pagemap: add write_begin_get_folio() helper function
      ext4: support uncached buffered I/O

Yue Haibing (1):
      netfs: Remove unused declaration netfs_queue_write_request()

 Documentation/filesystems/locking.rst     |   4 +-
 Documentation/filesystems/vfs.rst         |  11 +--
 block/fops.c                              |  15 ++--
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 115 ++++++++----------------------
 fs/adfs/inode.c                           |   9 +--
 fs/affs/file.c                            |  26 ++++---
 fs/attr.c                                 |  10 +--
 fs/bcachefs/fs-io-buffered.c              |   4 +-
 fs/bcachefs/fs-io-buffered.h              |   4 +-
 fs/bfs/file.c                             |   7 +-
 fs/buffer.c                               |  47 ++++++------
 fs/cachefiles/namei.c                     |   4 +-
 fs/ceph/addr.c                            |  10 ++-
 fs/dcache.c                               |  10 +--
 fs/direct-io.c                            |   8 +--
 fs/ecryptfs/inode.c                       |   4 +-
 fs/ecryptfs/main.c                        |   3 +-
 fs/ecryptfs/mmap.c                        |  10 +--
 fs/eventpoll.c                            |  58 +++++++++++----
 fs/exfat/file.c                           |  11 ++-
 fs/exfat/inode.c                          |  16 +++--
 fs/ext2/dir.c                             |   2 +-
 fs/ext2/inode.c                           |  11 +--
 fs/ext4/file.c                            |   3 +-
 fs/ext4/inode.c                           |  35 ++++-----
 fs/f2fs/data.c                            |   8 ++-
 fs/fat/inode.c                            |  18 ++---
 fs/file.c                                 |  15 ++++
 fs/fuse/file.c                            |  14 ++--
 fs/hfs/hfs_fs.h                           |   2 +-
 fs/hfs/inode.c                            |   4 +-
 fs/hfsplus/hfsplus_fs.h                   |   6 +-
 fs/hfsplus/inode.c                        |   8 ++-
 fs/hostfs/hostfs_kern.c                   |   8 ++-
 fs/hpfs/file.c                            |  18 ++---
 fs/hugetlbfs/inode.c                      |   9 +--
 fs/inode.c                                |  13 ++--
 fs/iomap/buffered-io.c                    |   3 +-
 fs/jffs2/file.c                           |  28 ++++----
 fs/jfs/inode.c                            |  16 +++--
 fs/libfs.c                                |  26 ++++---
 fs/locks.c                                |   4 +-
 fs/minix/dir.c                            |   2 +-
 fs/minix/inode.c                          |   7 +-
 fs/namei.c                                |  29 ++++----
 fs/namespace.c                            |   2 +-
 fs/nfs/file.c                             |   8 ++-
 fs/nfsd/vfs.c                             |   7 +-
 fs/nilfs2/dir.c                           |   2 +-
 fs/nilfs2/inode.c                         |   8 ++-
 fs/nilfs2/recovery.c                      |   3 +-
 fs/ntfs3/file.c                           |   4 +-
 fs/ntfs3/inode.c                          |   7 +-
 fs/ntfs3/ntfs_fs.h                        |  10 +--
 fs/ocfs2/aops.c                           |   6 +-
 fs/omfs/file.c                            |   7 +-
 fs/open.c                                 |   5 +-
 fs/orangefs/inode.c                       |  16 +++--
 fs/overlayfs/copy_up.c                    |   6 +-
 fs/overlayfs/dir.c                        |  16 ++---
 fs/overlayfs/overlayfs.h                  |  16 ++---
 fs/overlayfs/readdir.c                    |   2 +-
 fs/overlayfs/super.c                      |   2 +-
 fs/overlayfs/util.c                       |   2 +-
 fs/pipe.c                                 |   8 ++-
 fs/proc/fd.c                              |  11 +--
 fs/read_write.c                           |   2 +-
 fs/select.c                               |   4 +-
 fs/smb/server/vfs.c                       |   4 +-
 fs/stack.c                                |   4 +-
 fs/ubifs/file.c                           |   8 ++-
 fs/udf/inode.c                            |  11 +--
 fs/ufs/dir.c                              |   2 +-
 fs/ufs/inode.c                            |  16 +++--
 fs/vboxsf/file.c                          |   5 +-
 fs/xattr.c                                |   2 +-
 include/linux/buffer_head.h               |   8 +--
 include/linux/exportfs.h                  |   4 +-
 include/linux/filelock.h                  |   7 +-
 include/linux/fs.h                        |  25 +++----
 include/linux/fs_context.h                |   2 +-
 include/linux/fs_stack.h                  |   2 +-
 include/linux/netfs.h                     |   1 -
 include/linux/pagemap.h                   |  27 +++++++
 include/linux/quotaops.h                  |   2 +-
 io_uring/openclose.c                      |   2 -
 mm/filemap.c                              |   4 +-
 mm/shmem.c                                |  12 ++--
 88 files changed, 520 insertions(+), 457 deletions(-)

