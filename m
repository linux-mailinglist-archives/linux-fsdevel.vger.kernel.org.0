Return-Path: <linux-fsdevel+bounces-13987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAAD87618C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241441F23265
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA6A54799;
	Fri,  8 Mar 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgIfvY78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B0535DA;
	Fri,  8 Mar 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892587; cv=none; b=e35T97jny2E2knx+1d9jIEGCjY8kyw12/QfJnjZwzWc1lsKKuDsjW3kHm2sWlAMFvDBqxrwhWZebfIGLL/xnvLM7p5QgRxjozdkGQJTqrZkpxtnKAy51ekiZ2cuAdvO7QESZsFES4F1A6Rsy+VjCbDPpK+CH0orLPf2rMO7g1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892587; c=relaxed/simple;
	bh=4PxntLPNtz8agd+ceR6TCMkEKuqFoOzypV8NU1oyKk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q1Dn2aj0q2n1zoIGGzaPN7/3YU3sZO4XO9iXY5ATop/KLmC09i0YWzzGkb2KkF06KQcG/DHHkwsZjUgztwi/KS8jJ+QxmabPs1TVKlf1tH/3bmDsBvyz7zogr+d01wNHBtIMUmk/9WlddzlJS9zQTsJOSsXVQfgdz/BWWzII9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgIfvY78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2CCC43330;
	Fri,  8 Mar 2024 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892586;
	bh=4PxntLPNtz8agd+ceR6TCMkEKuqFoOzypV8NU1oyKk8=;
	h=From:To:Cc:Subject:Date:From;
	b=CgIfvY78ff3FC1b3pnI2HTrQ6ywttEDj/+G1Az43MKONtwRdr/kP/rwHrGjahkUtl
	 cVpgxzfrvVUH2vfsj6t8Ya91KExqIJUszHY7M9+J0bzF2yBul0CTLU2yJEv8+fMqGA
	 Fw+k5JseUuxJUOyiywF6M8a9jC5rMLylfJIKHs+CuqhXCJYREGfg7ZqlNkrztlIB2k
	 14XDxDiIsvjfFuESKBxb7e+lLLIc9FxmpQrcGYvaMs0Be49znqLi5TOfGugAUZ4boV
	 0iuDDjI6pj60hZT/H4bFhsPCe/ThVpdZqV+KydKSK161pX/QRT8kB8k23PLNHfopxh
	 yoRlarXWdbQ5w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs misc
Date: Fri,  8 Mar 2024 11:09:08 +0100
Message-ID: <20240308-vfs-misc-a4e7c50ce769@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14587; i=brauner@kernel.org; h=from:subject:message-id; bh=4PxntLPNtz8agd+ceR6TCMkEKuqFoOzypV8NU1oyKk8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+enzrVAiDsWsl35qJs/5JHLZs81G99Wl+g7jZzpmex pLytVmyHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZs5qR4cZW+3eaHK2ystxT 354P+fNWRDlTb+3S+Ak5fjqvoi/HcDEyfJ9zQKak48v8eps5SfklpmFeVyXCtf684p2+N/LzJsO TvAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the usual miscellaneous features, cleanups, and fixes for vfs and
individual fses.

Features
========

* Support idmapped mounts for hugetlbfs.

* Add RWF_NOAPPEND flag for pwritev2(). This allows to fix a bug where
  the passed offset is ignored if the file is O_APPEND. The new flag
  allows a caller to enforce that the offset is honored to conform to
  posix even if the file was opened in append mode.

* Move i_mmap_rwsem in struct address_space to avoid false sharing
  between i_mmap and i_mmap_rwsem.

* Convert efs, qnx4, and coda to use the new mount api.

* Add a generic is_dot_dotdot() helper that's used by various
  filesystems and the VFS code instead of open-coding it mutliple times.

* Recently we've added stable offsets which allows stable ordering
  when iterating directories exported through NFS on e.g., tmpfs
  filesystems. Originally an xarray was used for the offset map but that
  caused slab fragmentation issues over time. Tis switches the offset
  map to the maple tree which has a dense mode that handles this
  scenario a lot better. Includes tests.

* Finally merge the case-insensitive improvement series Gabriel has been
  working on for a long time. This cleanly propagates case insensitive
  operations through ->s_d_op which in turn allows us to remove the
  quite ugly generic_set_encrypted_ci_d_ops() operations. It also
  improves performance by trying a case-sensitive comparison first and
  then fallback to case-insensitive lookup if that fails. This also
  fixes a bug where overlayfs would be able to be mounted over a case
  insensitive directory which would lead to all sort of odd behaviors.

Cleanups
========

* Make file_dentry() a simple accessor now that ->d_real() is
  simplified because of the backing file work we did the last two
  cycles.

* Use the dedicated file_mnt_idmap helper in ntfs3.

* Use smp_load_acquire/store_release() in the i_size_read/write helpers
  and thus remove the hack to handle i_size reads in the filemap code.

* The SLAB_MEM_SPREAD is a nop now. Remove it from various places in fs/

* It's no longer necessary to perform a second built-in initramfs unpack
  call because we retain the contents of the previous extraction. Remove it.

* Now that we have removed various allocators kfree_rcu() always works
  with kmem caches and kmalloc(). So simplify various places that only
  use an rcu callback in order to handle the kmem cache case.

* Convert the pipe code to use a lockdep comparison function instead of
  open-coding the nesting making lockdep validation easier.

* Move code into fs-writeback.c that was located in a header but can be
  made static as it's only used in that one file.

* Rewrite the alignment checking iterators for iovec and bvec to be
  easier to read, and also significantly more compact in terms of
  generated code. This saves 270 bytes of text on x86-64 (with clang-18)
  and 224 bytes on arm64 (with gcc-13). In profiles it also saves a bit
  of time for the same workload.

* Switch various places to use KMEM_CACHE instead of kmem_cache_create().

* Use inode_set_ctime_to_ts() in inode_set_ctime_current()

* Use kzalloc() in name_to_handle_at() to avoid kernel infoleak.

* Various smaller cleanups for eventfds.

Fixes
=====

* Fix various comments and typos, and unneeded initializations.

* Fix stack allocation hack for clang in the select code.

* Improve dump_mapping() debug code on a best-effort basis.

* Fix build errors in various selftests.

* Avoid wrap-around instrumentation in various places.

* Don't allow user namespaces without an an idmapping written to be used
  for idmapped mounts.

* Fix sysv sb_read() call.

* Fix fallback implementation of the get_name() export operation.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the scsi-mkp tree with the vfs-brauner tree
    https://lore.kernel.org/linux-next/20240227153716.43e5cbad@canb.auug.org.au

Merge conflicts with mainline
=============================

No known conflicts.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.misc

for you to fetch changes up to 09406ad8e5105729291a7639160e0cd51c9e0c6c:

  Merge tag 'for-next-6.9' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/krisman/unicode into vfs.misc (2024-03-07 11:55:41 +0100)

Please consider pulling these changes from the signed vfs-6.9.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9.misc

----------------------------------------------------------------
Alexander Mikhalitsyn (1):
      ntfs3: use file_mnt_idmap helper

Amir Goldstein (2):
      fs: make file_dentry() a simple accessor
      fs: remove the inode argument to ->d_real() method

Andreas Gruenbacher (1):
      fs: Wrong function name in comment

Arnd Bergmann (1):
      fs/select: rework stack allocation hack for clang

Baokun Li (3):
      fs: make the i_size_read/write helpers be smp_load_acquire/store_release()
      Revert "mm/filemap: avoid buffered read/write race to read inconsistent data"
      asm-generic: remove extra type checking in acquire/release for non-SMP case

Baolin Wang (1):
      fs: improve dump_mapping() robustness

Bill O'Donnell (2):
      efs: convert efs to use the new mount api
      qnx4: convert qnx4 to use the new mount api

Chen Hanxiao (1):
      __fs_parse: Correct a documentation comment

Chengming Zhou (10):
      vfs: remove SLAB_MEM_SPREAD flag usage
      sysv: remove SLAB_MEM_SPREAD flag usage
      romfs: remove SLAB_MEM_SPREAD flag usage
      reiserfs: remove SLAB_MEM_SPREAD flag usage
      qnx6: remove SLAB_MEM_SPREAD flag usage
      proc: remove SLAB_MEM_SPREAD flag usage
      openpromfs: remove SLAB_MEM_SPREAD flag usage
      minix: remove SLAB_MEM_SPREAD flag usage
      jfs: remove SLAB_MEM_SPREAD flag usage
      efs: remove SLAB_MEM_SPREAD flag usage

Christian Brauner (3):
      Merge tag 'exportfs-6.9' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/cel/linux
      Merge series 'Use Maple Trees for simple_offset utilities' of https://lore.kernel.org/r/170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net
      Merge tag 'for-next-6.9' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/krisman/unicode into vfs.misc

Chuck Lever (6):
      fs: Create a generic is_dot_dotdot() utility
      libfs: Re-arrange locking in offset_iterate_dir()
      libfs: Define a minimum directory offset
      libfs: Add simple_offset_empty()
      maple_tree: Add mtree_alloc_cyclic()
      libfs: Convert simple directory offsets to use a Maple Tree

David Disseldorp (1):
      initramfs: remove duplicate built-in __initramfs_start unpacking

David Howells (1):
      Convert coda to use the new mount API

Dmitry Antipov (2):
      fs: prefer kfree_rcu() in fasync_remove_entry()
      eventpoll: prefer kfree_rcu() in __ep_remove()

Gabriel Krisman Bertazi (11):
      libfs: Attempt exact-match comparison first during casefolded lookup
      ovl: Always reject mounting over case-insensitive directories
      fscrypt: Factor out a helper to configure the lookup dentry
      fscrypt: Drop d_revalidate for valid dentries during lookup
      fscrypt: Drop d_revalidate once the key is added
      libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
      libfs: Add helper to choose dentry operations at mount-time
      ext4: Configure dentry operations at dentry-creation time
      f2fs: Configure dentry operations at dentry-creation time
      ubifs: Configure dentry operations at dentry-creation time
      libfs: Drop generic_set_encrypted_ci_d_ops

Giuseppe Scrivano (1):
      hugetlbfs: support idmapped mounts

Hu Yadi (1):
      selftests/filesystems:fix build error in overlayfs

Hu.Yadi (1):
      selftests/move_mount_set_group:Make tests build with old libc

Huang Xiaojia (1):
      epoll: Remove ep_scan_ready_list() in comments

Jay (1):
      fs: fix a typo in attr.c

Jens Axboe (1):
      iov_iter: streamline iovec/bvec alignment iteration

JonasZhou (1):
      fs/address_space: move i_mmap_rwsem to mitigate a false sharing with i_mmap.

Kees Cook (2):
      iov_iter: Avoid wrap-around instrumentation in copy_compat_iovec_from_user()
      select: Avoid wrap-around instrumentation in do_sys_poll()

Kemeng Shi (1):
      writeback: move wb_wakeup_delayed defination to fs-writeback.c

Kent Overstreet (1):
      fs/pipe: Convert to lockdep_cmp_fn

Kunwu Chan (3):
      buffer: Use KMEM_CACHE instead of kmem_cache_create()
      fs: Use KMEM_CACHE instead of kmem_cache_create
      mbcache: Simplify the allocation of slab caches

Li zeming (1):
      libfs: Remove unnecessary ‘0’ values from ret

Liam R. Howlett (1):
      test_maple_tree: testing the cyclic allocation

Nguyen Dinh Phi (1):
      fs: use inode_set_ctime_to_ts to set inode ctime to current time

Nikita Zhandarovich (1):
      do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak

Randy Dunlap (1):
      fs/hfsplus: use better @opf description

Rich Felker (1):
      vfs: add RWF_NOAPPEND flag for pwritev2

Taylor Jackson (1):
      fs/mnt_idmapping.c: Return -EINVAL when no map is written

Tetsuo Handa (1):
      sysv: don't call sb_bread() with pointers_lock held

Trond Myklebust (1):
      exportfs: fix the fallback implementation of the get_name export operation

Vincenzo Mezzela (1):
      docs: filesystems: fix typo in docs

Wen Yang (3):
      eventfd: add a BUILD_BUG_ON() to ensure consistency between EFD_SEMAPHORE and the uapi
      eventfd: move 'eventfd-count' printing out of spinlock
      eventfd: strictly check the count parameter of eventfd_write to avoid inputting illegal strings

 Documentation/filesystems/files.rst                |   2 +-
 Documentation/filesystems/locking.rst              |   2 +-
 Documentation/filesystems/vfs.rst                  |  16 +-
 fs/attr.c                                          |   2 +-
 fs/backing-file.c                                  |   4 +-
 fs/buffer.c                                        |  10 +-
 fs/coda/inode.c                                    | 143 ++++++++++-----
 fs/crypto/fname.c                                  |   8 +-
 fs/crypto/hooks.c                                  |  15 +-
 fs/dcache.c                                        |   2 +-
 fs/ecryptfs/crypto.c                               |  10 --
 fs/efs/super.c                                     | 118 ++++++++----
 fs/eventfd.c                                       |  16 +-
 fs/eventpoll.c                                     |  16 +-
 fs/exportfs/expfs.c                                |   2 +-
 fs/ext4/namei.c                                    |   1 -
 fs/ext4/super.c                                    |   1 +
 fs/f2fs/f2fs.h                                     |  11 --
 fs/f2fs/namei.c                                    |   1 -
 fs/f2fs/super.c                                    |   1 +
 fs/fcntl.c                                         |   8 +-
 fs/fhandle.c                                       |   2 +-
 fs/fs-writeback.c                                  |  25 +++
 fs/fs_parser.c                                     |   4 +-
 fs/hfsplus/wrapper.c                               |   2 +-
 fs/hugetlbfs/inode.c                               |  23 ++-
 fs/inode.c                                         |   7 +-
 fs/jfs/super.c                                     |   2 +-
 fs/libfs.c                                         | 200 +++++++++++----------
 fs/mbcache.c                                       |   4 +-
 fs/minix/inode.c                                   |   2 +-
 fs/mnt_idmapping.c                                 |   2 +-
 fs/namei.c                                         |   6 +-
 fs/ntfs3/namei.c                                   |   2 +-
 fs/openpromfs/inode.c                              |   2 +-
 fs/overlayfs/params.c                              |  14 +-
 fs/overlayfs/super.c                               |  52 +++---
 fs/pipe.c                                          |  81 ++++-----
 fs/proc/inode.c                                    |   2 +-
 fs/qnx4/inode.c                                    |  47 +++--
 fs/qnx6/inode.c                                    |   2 +-
 fs/reiserfs/super.c                                |   1 -
 fs/romfs/super.c                                   |   4 +-
 fs/select.c                                        |  15 +-
 fs/sysv/inode.c                                    |   2 +-
 fs/sysv/itree.c                                    |  10 +-
 fs/ubifs/dir.c                                     |   1 -
 fs/ubifs/super.c                                   |   1 +
 include/asm-generic/barrier.h                      |   2 -
 include/linux/backing-dev.h                        |   1 -
 include/linux/dcache.h                             |  18 +-
 include/linux/fs.h                                 |  61 ++++++-
 include/linux/fscrypt.h                            |  66 ++++++-
 include/linux/maple_tree.h                         |   7 +
 include/linux/poll.h                               |   4 -
 include/uapi/linux/fs.h                            |   5 +-
 init/initramfs.c                                   |   2 -
 lib/iov_iter.c                                     |  60 ++++---
 lib/maple_tree.c                                   |  93 ++++++++++
 lib/test_maple_tree.c                              |  44 +++++
 mm/backing-dev.c                                   |  25 ---
 mm/filemap.c                                       |   9 -
 mm/shmem.c                                         |   4 +-
 .../selftests/filesystems/overlayfs/dev_in_maps.c  |  10 +-
 .../move_mount_set_group_test.c                    |   4 +-
 65 files changed, 816 insertions(+), 503 deletions(-)

