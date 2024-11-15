Return-Path: <linux-fsdevel+bounces-34907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDB9CE0BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9C5284241
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA651CDA0D;
	Fri, 15 Nov 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDKU36J5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F221DA23;
	Fri, 15 Nov 2024 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678982; cv=none; b=mr9mSlfTKXR+Efywu5lDvWm2CEvCXN4Ek3/u3YxpE9A3NgPBVfYzrmHjLQ7fQ38pDu+ShCTEx42NH0MfHE4HMgYWP8GvrSpnsbSbPvgmW8k9+Y+k44rswzhZA+YuhluKAnFqAgXirb4wr38s0GcS+KFAiBeYvdQ/jKO6LeHiY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678982; c=relaxed/simple;
	bh=/cevQFwDTvNo+uJkwYE0n872P1XEhsk8uP72d1/YrcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDoVkPW0Zu4RPDfiok9iZvYfWMNx9zaiqG2R/gaqFRDdMAr1at98A4DDeOsHb5bPe+a6tT+JA+mRqSp8gZflirAzGQdUhZdpBBW2xZWHysv8eylWMdjgcKgFuBKsJjiO/oml36v2ZgLODC5XaGnuYdR5qKS/EA2lnS0oxA/JxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDKU36J5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFAAC4CECF;
	Fri, 15 Nov 2024 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731678981;
	bh=/cevQFwDTvNo+uJkwYE0n872P1XEhsk8uP72d1/YrcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=eDKU36J5r9zgOhZK/TspavATQri3KSi8r5R60CW1i3XnHfVE2pB80VEMzARFkAuDL
	 gQn/Hcf6vEpNk9DN731Ged/0Lvlw/Pjebv+y5eJRUrn+An3tJGjZjwkTNcwhhdVL4C
	 qqZVGtJ9IL2YcGGmf1+TvlHFcGZbdziVtiCf0wTuT2rCiBrv5/Gpf6qkwLk43065if
	 l5VeqG5TxTYRIcFqxvOIGCsxGFu6yNFc8G2SI+I7XVcs2qhg72DR1G0HLExQ20Fswe
	 jb8HSbgaFgwk0gz/bsfcJlbc3CtLiP3l+t94VQw+JyJs5v6D7Y8wuhYTdQXTkDw/GL
	 kVT+xm8N50JPA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs misc
Date: Fri, 15 Nov 2024 14:56:11 +0100
Message-ID: <20241115-vfs-misc-aa344b85076a@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11649; i=brauner@kernel.org; h=from:subject:message-id; bh=/cevQFwDTvNo+uJkwYE0n872P1XEhsk8uP72d1/YrcQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbB/1lnfMgr6vp417W4BWl9+zaflnas+89lKY1ie3c+ 5Sjp0wnd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEO5CR4fzld8d60xYnLYrX 7rv1fr3I04CopB5jdq+/m6sULY1PsjIyTPy3MmZ6QIbWpp++5x9FLsoVuRvgYClnuK02sFXyYuF vFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Features:

    - Fixup and improve NLM and kNFSD file lock callbacks.

      Last year both GFS2 and OCFS2 had some work done to make their
      locking more robust when exported over NFS. Unfortunately, part of
      that work caused both NLM (for NFS v3 exports) and kNFSD (for
      NFSv4.1+ exports) to no longer send lock notifications to clients.

      This in itself is not a huge problem because most NFS clients will
      still poll the server in order to acquire a conflicted lock.

      Its important for NLM and kNFSD that they do not block their
      kernel threads inside filesystem's file_lock implementations
      because that can produce deadlocks. We used to make sure of this
      by only trusting that posix_lock_file() can correctly handle
      blocking lock calls asynchronously, so the lock managers would
      only setup their file_lock requests for async callbacks if the
      filesystem did not define its own lock() file operation.

      However, when GFS2 and OCFS2 grew the capability to correctly
      handle blocking lock requests asynchronously, they started
      signalling this behavior with EXPORT_OP_ASYNC_LOCK, and the check
      for also trusting posix_lock_file() was inadvertently dropped, so
      now most filesystems no longer produce lock notifications when
      exported over NFS.

      Fix this by using an fop_flag which greatly simplifies the problem
      and grooms the way for future uses by both filesystems and lock
      managers alike.

    -  Add a sysctl to delete the dentry when a file is removed instead
       of making it a negative dentry.

       Commit 681ce8623567 ("vfs: Delete the associated dentry when
       deleting a file") introduced an unconditional deletion of the
       associated dentry when a file is removed. However, this led to
       performance regressions in specific benchmarks, such as
       ilebench.sum_operations/s, prompting a revert in commit
       4a4be1ad3a6e ("Revert "vfs: Delete the associated dentry when
       deleting a file""). This reintroduces the concept conditionally
       through a sysctl.

    - Expand the statmount() system call:

	  * Report the filesystem subtype in a new fs_subtype field to
	    e.g., report fuse filesystem subtypes.

          * Report the superblock source in a new sb_source field.

	  * Add a new way to return filesystem specific mount options in
	    an option array that returns filesystem specific mount
	    options separated by zero bytes and unescaped. This allows
	    caller's to retrieve filesystem specific mount options and
	    immediately pass them to e.g., fsconfig() without having to
	    unescape or split them.

	  * Report security (LSM) specific mount options in a separate
	    security option array. We don't lump them together with
	    filesystem specific mount options as security mount options
	    are generic and most users aren't interested in them.

	    The format is the same as for the filesystem specific mount
	    option array.

    - Support relative paths in fsconfig()'s FSCONFIG_SET_STRING command.

    - Optimize acl_permission_check() to avoid costly {g,u}id ownership
      checks if possible.

    - Use smp_mb__after_spinlock() to avoid full smp_mb() in evict().

    - Add synchronous wakeup support for ep_poll_callback.
      Currently, epoll only uses wake_up() to wake up task. But
      sometimes there are epoll users which want to use
      the synchronous wakeup flag to give a hint to the scheduler, e.g.,
      the Android binder driver. So add a wake_up_sync() define, and use
      wake_up_sync() when sync is true in ep_poll_callback().

Fixes:

    - Fix kernel documentation for inode_insert5() and iget5_locked().

    - Annotate racy epoll check on file->f_ep.

    - Make F_DUPFD_QUERY associative.

    - Avoid filename buffer overrun in initramfs.

    - Don't let statmount() return empty strings.

    - Add a cond_resched() to dump_user_range() to avoid hogging the CPU.

    - Don't query the device logical blocksize multiple times for hfsplus.

    - Make filemap_read() check that the offset is positive or zero.

Cleanups:

    - Various typo fixes.

    - Cleanup wbc_attach_fdatawrite_inode().

    - Add __releases annotation to wbc_attach_and_unlock_inode().

    - Add hugetlbfs tracepoints.

    - Fix various vfs kernel doc parameters.

    - Remove obsolete TODO comment from io_cancel().

    - Convert wbc_account_cgroup_owner() to take a folio.

    - Fix comments for BANDWITH_INTERVAL and wb_domain_writeout_add().

    - Reorder struct posix_acl to save 8 bytes.

    - Annotate struct posix_acl with __counted_by().

    - Replace one-element array with flexible array member in freevxfs.

    - Use idiomatic atomic64_inc_return() in alloc_mnt_ns().

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

(1) linux-next: manual merge of the vfs-brauner tree with the nfsd tree
    https://lore.kernel.org/r/20241024081515.1cd254a0@canb.auug.org.au

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.misc

for you to fetch changes up to aefff51e1c2986e16f2780ca8e4c97b784800ab5:

  statmount: retrieve security mount options (2024-11-14 17:03:25 +0100)

Please consider pulling these changes from the signed vfs-6.13.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.misc

----------------------------------------------------------------
Andreas Gruenbacher (1):
      vfs: inode insertion kdoc corrections

Andrew Kreimer (1):
      fs/inode: Fix a typo

Benjamin Coddington (4):
      fs: Introduce FOP_ASYNC_LOCK
      gfs2/ocfs2: set FOP_ASYNC_LOCK
      NLM/NFSD: Fix lock notifications for async-capable filesystems
      exportfs: Remove EXPORT_OP_ASYNC_LOCK

Christian Brauner (7):
      Merge patch series "Fixup NLM and kNFSD file lock callbacks"
      Merge patch series "Introduce tracepoint for hugetlbfs"
      epoll: annotate racy check
      fcntl: make F_DUPFD_QUERY associative
      Merge patch series "fs: allow statmount to fetch the fs_subtype and sb_source"
      Merge patch series "two little writeback cleanups v2"
      statmount: retrieve security mount options

Christoph Hellwig (2):
      writeback: add a __releases annoation to wbc_attach_and_unlock_inode
      writeback: wbc_attach_fdatawrite_inode out of line

David Disseldorp (1):
      initramfs: avoid filename buffer overrun

Hongbo Li (3):
      hugetlbfs: support tracepoint
      hugetlbfs: use tracepoints in hugetlbfs functions.
      fs: support relative paths with FSCONFIG_SET_STRING

Jeff Layton (3):
      fs: don't let statmount return empty strings
      fs: add the ability for statmount() to report the fs_subtype
      fs: add the ability for statmount() to report the sb_source

Julia Lawall (1):
      fs: Reorganize kerneldoc parameter names

Linus Torvalds (1):
      fs: optimize acl_permission_check()

Mateusz Guzik (1):
      vfs: make evict() use smp_mb__after_spinlock instead of smp_mb

Miklos Szeredi (1):
      statmount: add flag to retrieve unescaped options

Mohammed Anees (1):
      fs:aio: Remove TODO comment suggesting hash or array usage in io_cancel()

Pankaj Raghav (1):
      fs/writeback: convert wbc_account_cgroup_owner to take a folio

Rik van Riel (1):
      coredump: add cond_resched() to dump_user_range

Tang Yizhou (2):
      mm/page-writeback.c: Update comment for BANDWIDTH_INTERVAL
      mm/page-writeback.c: Fix comment of wb_domain_writeout_add()

Thadeu Lima de Souza Cascardo (1):
      hfsplus: don't query the device logical block size multiple times

Thorsten Blum (3):
      acl: Realign struct posix_acl to save 8 bytes
      acl: Annotate struct posix_acl with __counted_by()
      freevxfs: Replace one-element array with flexible array member

Trond Myklebust (1):
      filemap: filemap_read() should check that the offset is positive or zero

Uros Bizjak (1):
      namespace: Use atomic64_inc_return() in alloc_mnt_ns()

Xuewen Yan (1):
      epoll: Add synchronous wakeup support for ep_poll_callback

Yafang Shao (1):
      vfs: Add a sysctl for automated deletion of dentry

 Documentation/admin-guide/cgroup-v2.rst     |   2 +-
 Documentation/admin-guide/sysctl/fs.rst     |   5 +
 Documentation/filesystems/nfs/exporting.rst |   7 --
 MAINTAINERS                                 |   1 +
 fs/aio.c                                    |   1 -
 fs/btrfs/extent_io.c                        |   7 +-
 fs/btrfs/inode.c                            |   2 +-
 fs/buffer.c                                 |   4 +-
 fs/char_dev.c                               |   2 +-
 fs/coredump.c                               |   1 +
 fs/dcache.c                                 |  16 ++-
 fs/eventpoll.c                              |  11 +-
 fs/ext4/page-io.c                           |   2 +-
 fs/f2fs/data.c                              |   9 +-
 fs/fcntl.c                                  |   3 +
 fs/freevxfs/vxfs_dir.h                      |   2 +-
 fs/fs-writeback.c                           |  40 +++++--
 fs/fs_parser.c                              |   1 +
 fs/gfs2/export.c                            |   1 -
 fs/gfs2/file.c                              |   2 +
 fs/hfsplus/hfsplus_fs.h                     |   3 +-
 fs/hfsplus/wrapper.c                        |   2 +
 fs/hugetlbfs/inode.c                        |  17 ++-
 fs/inode.c                                  |  29 +++--
 fs/iomap/buffered-io.c                      |   2 +-
 fs/lockd/svclock.c                          |   7 +-
 fs/mpage.c                                  |   2 +-
 fs/namei.c                                  |  41 +++++++
 fs/namespace.c                              | 161 ++++++++++++++++++++++++++--
 fs/nfsd/nfs4state.c                         |  19 +---
 fs/ocfs2/export.c                           |   1 -
 fs/ocfs2/file.c                             |   2 +
 fs/posix_acl.c                              |  13 ++-
 fs/seq_file.c                               |   2 +-
 include/linux/eventpoll.h                   |   2 +-
 include/linux/exportfs.h                    |  13 ---
 include/linux/filelock.h                    |   5 +
 include/linux/fs.h                          |   2 +
 include/linux/posix_acl.h                   |   6 +-
 include/linux/wait.h                        |   1 +
 include/linux/writeback.h                   |  32 +-----
 include/trace/events/hugetlbfs.h            | 156 +++++++++++++++++++++++++++
 include/uapi/linux/mount.h                  |  14 ++-
 init/initramfs.c                            |  15 +++
 mm/filemap.c                                |   2 +
 mm/page-writeback.c                         |   4 +-
 46 files changed, 531 insertions(+), 141 deletions(-)
 create mode 100644 include/trace/events/hugetlbfs.h

