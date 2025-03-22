Return-Path: <linux-fsdevel+bounces-44762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86503A6C8FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C19189B0B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D3A1F55F2;
	Sat, 22 Mar 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVX84hZu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D61F470E;
	Sat, 22 Mar 2025 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638386; cv=none; b=Juf+Sr4uNbXOUenDSB63/VoNdBSPX2wYPCOkO8GN1HyAlR7sJp6hGqvWMDh9vzTH+TeHDlybq4RsCkqJVhUaug76ZLZW8B2l9PdnjQ6HUM+mKWssJCWrGcpuV1bSWWKrybD9gRmzO4Ab51YbqT6KoCHbUX/+tWYAVwbSVwLP0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638386; c=relaxed/simple;
	bh=FtWLPPYkc4muKNiBnLETV2x7rIqOjQB+RYyy36PdXRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UR4QsVjmUO904PJPVOv8vFkKXrdH/tzyzOW/V1R6b0usNPQFdgWeAlBkZEE1acbxWM38xigu+OZC+cEAyw0IZ1Vpt1T9SClg0iDFiGmGNGVphN8KEzcSDj4qcuB6A6bTg8uZYoLvys/rU8lWdpdzHoT0/YOnr4LD0c64WgZPjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVX84hZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67760C4CEDD;
	Sat, 22 Mar 2025 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638385;
	bh=FtWLPPYkc4muKNiBnLETV2x7rIqOjQB+RYyy36PdXRA=;
	h=From:To:Cc:Subject:Date:From;
	b=JVX84hZul78b04DIFsCDIYUKbMVZSkCCvHG5GgxyflK8YQZLMx4ED7u7vAQcEb4GV
	 IlgJM6EzOl/Feb62oHvk4Wx8pfF/cWrod8q7bmgj4ptudBFG4XHdMFK75+JXwpFEEi
	 xwrNQZC5/0UbxBWsCGRJNk8U+ToXInKx1glGg0sWhpBVKXRsEfZKbSJEHojunqOogH
	 eYtg0QSNLa7kTGA1JfqcAgUrl6FMPFlqfiuA0yRTbVQtr3Uh6mYyNiHGwsj6jlPuS0
	 ztEVTyeO5hv1zLoEUgd3606ge0A9okwqz+s+NMFTENBK86XKOf48dD6SkSI5s5HVBK
	 qawSpOppH9WaQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs misc
Date: Sat, 22 Mar 2025 11:12:49 +0100
Message-ID: <20250321-vfs-misc-77bd9633b854@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7152; i=brauner@kernel.org; h=from:subject:message-id; bh=FtWLPPYkc4muKNiBnLETV2x7rIqOjQB+RYyy36PdXRA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf61X7byO5X+OZ9N97BS2q/Lskj++VUDb2cT/1PzCYX fnV2u5/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNR1mBk+DEnYMaWf7v7bLd4 PEns7Mzis60/E1b8OXDG0x8rRXy36DP8d12U+W9107HHj3gXGSupVa+Z+mWCW9eZOzLr94ds85d 6xAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Features:

- Add CONFIG_DEBUG_VFS infrastucture:

  - Catch invalid modes in open.

  - Use the new debug macros in inode_set_cached_link().

  - Use debug-only asserts around fd allocation and install.

- Place f_ref to 3rd cache line in struct file to resolve false sharing.

Cleanups:

- Start using anon_inode_getfile_fmode() helper in various places.

- Don't take f_lock during SEEK_CUR if exclusion is guaranteed by f_pos_lock.

- Add unlikely() to kcmp().

- Remove legacy ->remount_fs method from ecryptfs after port to the new mount api.

- Remove invalidate_inodes() in favour of evict_inodes().

- Simplify ep_busy_loopER by removing unused argument.

- Avoid mmap sem relocks when coredumping with many missing pages.

- Inline getname().

- Inline new_inode_pseudo() and de-staticize alloc_inode().

- Dodge an atomic in putname if ref == 1.

- Consistently deref the files table with rcu_dereference_raw().

- Dedup handling of struct filename init and refcounts bumps.

- Use wq_has_sleeper() in end_dir_add().

- Drop the lock trip around I_NEW wake up in evict().

- Load the ->i_sb pointer once in inode_sb_list_{add,del}.

- Predict not reaching the limit in alloc_empty_file().

- Tidy up do_sys_openat2() with likely/unlikely.

- Call inode_sb_list_add() outside of inode hash lock.

- Sort out fd allocation vs dup2 race commentary.

- Turn page_offset() into a wrapper around folio_pos().

- Remove locking in exportfs around ->get_parent() call.

- try_lookup_one_len() does not need any locks in autofs.

- Fix return type of several functions from long to int in open.

- Fix return type of several functions from long to int in ioctls.

Fixes:

- Fix watch queue accounting mismatch.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This contains a minor merge conflict for include/linux/fs.h.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.misc

for you to fetch changes up to 4dec4f91359c456a5eea26817ea151b42953432e:

  fs: sort out fd allocation vs dup2 race commentary, take 2 (2025-03-20 15:17:56 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.misc

----------------------------------------------------------------
Al Viro (1):
      make use of anon_inode_getfile_fmode()

Christian Brauner (3):
      Merge patch series "CONFIG_DEBUG_VFS at last"
      Merge patch series "Fix the return type of several functions from long to int"
      fs: don't needlessly acquire f_lock

Colin Ian King (1):
      kcmp: improve performance adding an unlikely hint to task comparisons

Eric Sandeen (2):
      watch_queue: fix pipe accounting mismatch
      ecryptfs: remove NULL remount_fs from super_operations

Jan Kara (1):
      vfs: Remove invalidate_inodes()

Lin Feng (1):
      epoll: simplify ep_busy_loop by removing always 0 argument

Mateusz Guzik (17):
      vfs: add initial support for CONFIG_DEBUG_VFS
      vfs: catch invalid modes in may_open()
      vfs: use the new debug macros in inode_set_cached_link()
      fs: avoid mmap sem relocks when coredumping with many missing pages
      vfs: inline getname()
      vfs: inline new_inode_pseudo() and de-staticize alloc_inode()
      fs: dodge an atomic in putname if ref == 1
      fs: use debug-only asserts around fd allocation and install
      fs: consistently deref the files table with rcu_dereference_raw()
      fs: dedup handling of struct filename init and refcounts bumps
      fs: use wq_has_sleeper() in end_dir_add()
      fs: drop the lock trip around I_NEW wake up in evict()
      fs: load the ->i_sb pointer once in inode_sb_list_{add,del}
      fs: predict not reaching the limit in alloc_empty_file()
      fs: tidy up do_sys_openat2() with likely/unlikely
      fs: call inode_sb_list_add() outside of inode hash lock
      fs: sort out fd allocation vs dup2 race commentary, take 2

Matthew Wilcox (Oracle) (1):
      fs: Turn page_offset() into a wrapper around folio_pos()

NeilBrown (2):
      exportfs: remove locking around ->get_parent() call.
      VFS/autofs: try_lookup_one_len() does not need any locks

Pan Deng (1):
      fs: place f_ref to 3rd cache line in struct file to resolve false sharing

Yuichiro Tsuji (2):
      open: Fix return type of several functions from long to int
      ioctl: Fix return type of several functions from long to int

 Documentation/filesystems/porting.rst     |   5 ++
 arch/arm64/kernel/elfcore.c               |   3 +-
 arch/powerpc/platforms/pseries/papr-vpd.c |   7 +-
 drivers/vfio/group.c                      |  16 +---
 fs/autofs/dev-ioctl.c                     |   3 -
 fs/cachefiles/ondemand.c                  |   7 +-
 fs/coredump.c                             |  38 +++++++--
 fs/dcache.c                               |   3 +-
 fs/ecryptfs/super.c                       |   1 -
 fs/eventfd.c                              |   5 +-
 fs/eventpoll.c                            |   8 +-
 fs/exportfs/expfs.c                       |   2 -
 fs/file.c                                 |  81 +++++++++++++------
 fs/file_table.c                           |   3 +-
 fs/inode.c                                | 127 +++++++++++-------------------
 fs/internal.h                             |   6 +-
 fs/ioctl.c                                |  10 +--
 fs/namei.c                                |  42 +++++-----
 fs/open.c                                 |  29 +++----
 fs/read_write.c                           |  13 ++-
 fs/signalfd.c                             |   7 +-
 fs/smb/client/file.c                      |   2 +-
 fs/super.c                                |   2 +-
 fs/timerfd.c                              |   6 +-
 include/linux/fs.h                        |  36 ++++++---
 include/linux/mm.h                        |   2 +-
 include/linux/pagemap.h                   |  20 ++---
 include/linux/syscalls.h                  |   4 +-
 include/linux/vfsdebug.h                  |  45 +++++++++++
 kernel/auditsc.c                          |  12 ++-
 kernel/kcmp.c                             |   2 +-
 kernel/watch_queue.c                      |   9 +++
 lib/Kconfig.debug                         |   9 +++
 mm/gup.c                                  |   6 +-
 security/landlock/fs.c                    |   2 +-
 virt/kvm/kvm_main.c                       |  11 +--
 36 files changed, 339 insertions(+), 245 deletions(-)
 create mode 100644 include/linux/vfsdebug.h

