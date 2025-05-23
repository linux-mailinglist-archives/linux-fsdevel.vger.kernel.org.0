Return-Path: <linux-fsdevel+bounces-49767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E2AC22C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2654E7DA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC229408;
	Fri, 23 May 2025 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg3tJd7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97422338;
	Fri, 23 May 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004033; cv=none; b=T0PgERPdxM11GrQEkTBN/xe9dVyBMtF4/7gggPG3QLY1v/VIPx74PNy96G9cbCS/OuBx1/6Beo0i9hmcOMG8DbOqRJmu5qZZymbWabXqTLGrZ4luz/qanVZDYWIxsKu0lmE1mFsi3UZZ1a/DNKwbFz4uk76yyR1FWsFAdTfYIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004033; c=relaxed/simple;
	bh=fF+vi/ZJYg9zV+u9eX7xmuQO6ZZBAO4jnx5M3Mhc/bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtOrM76D79lkbUxMySQy5h9sCsgeloQDyt8rZRZCCGVUqGIjpqswd7mJiv3Jbnvb8vQ80mQprxjuw391BaXxrOyyzqZdwLWxdDLjFuVJHAci6JRFXPFw3VsRINm4RVqNdgJZuk8/gG4Q+gyjbsm6Txm2n9vad8lWbBbDuaylwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg3tJd7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800EEC4CEF2;
	Fri, 23 May 2025 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004032;
	bh=fF+vi/ZJYg9zV+u9eX7xmuQO6ZZBAO4jnx5M3Mhc/bY=;
	h=From:To:Cc:Subject:Date:From;
	b=Zg3tJd7GofaGMzUefTrUGWXEVEl2Sx87Zxez0I3ohctHa0HfuKiMN+FEXUdpxrKRs
	 k6UERm64bste1VBeEBCMC2KjKhdDp1/TgLSY67fnMswBIx6m1Q0e7E5l9B4xojNu/z
	 hhzPTngRu8aS3ztqKIJa9MdAn/hRu7DNinB+TI04wK/7WoWnnVjF/T3IKQbH/dzGkM
	 CLwKY0v4HAS26ULlzweIVZP2vSo39vrNPyQwv8yVtJ7RPXrJbwW69YM/I/mMG3sK9t
	 l3llkkcrSF7m8+NCIohHUCBzg80U/RunjbfvJJy6B7fDWM4x0QMnLXsdEbi9picKJi
	 ehiDtBMhCw/4Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs misc
Date: Fri, 23 May 2025 14:40:22 +0200
Message-ID: <20250523-vfs-misc-bd367f758841@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12411; i=brauner@kernel.org; h=from:subject:message-id; bh=fF+vi/ZJYg9zV+u9eX7xmuQO6ZZBAO4jnx5M3Mhc/bY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQY5OxOiL/zg7u2QNC4s/7ii4/zKk4funvi/IwlR99Od Yo9M+eLdEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEDE4yMszODvq3LijnRYXL /kSDX9G3ncuVnZZfWG0R9JDTLmJ+JTfDf6cbPeYykp/nMDS8nBAj5bJMXvXp9S9h0vwSCvOOK92 0YgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the usual selections of misc updates for this cycle.

Features:

- Use folios for symlinks in the page cache

  FUSE already uses folios for its symlinks. Mirror that conversion in
  the generic code and the NFS code. That lets us get rid of a few
  folio->page->folio conversions in this path, and some of the few
  remaining users of read_cache_page() / read_mapping_page().

- Try and make a few filesystem operations killable on the VFS
  inode->i_mutex level.

- Add sysctl vfs_cache_pressure_denom for bulk file operations

  Some workloads need to preserve more dentries than we currently allow
  through out sysctl interface.

  A HDFS servers with 12 HDDs per server, on a HDFS datanode startup
  involves scanning all files and caching their metadata (including
  dentries and inodes) in memory. Each HDD contains approximately 2
  million files, resulting in a total of ~20 million cached dentries
  after initialization.

  To minimize dentry reclamation, they set vfs_cache_pressure to 1.
  Despite this configuration, memory pressure conditions can still
  trigger reclamation of up to 50% of cached dentries, reducing the
  cache from 20 million to approximately 10 million entries. During the
  subsequent cache rebuild period, any HDFS datanode restart operation
  incurs substantial latency penalties until full cache recovery
  completes.

  To maintain service stability, more dentries need to be preserved
  during memory reclamation. The current minimum reclaim ratio (1/100 of
  total dentries) remains too aggressive for such workload. This patch
  introduces vfs_cache_pressure_denom for more granular cache pressure
  control. The configuration [vfs_cache_pressure=1,
  vfs_cache_pressure_denom=10000] effectively maintains the full 20
  million dentry cache under memory pressure, preventing datanode
  restart performance degradation.

- Avoid some jumps in inode_permission() using likely()/unlikely().

- Avid a memory access which is most likely a cache miss when descending
  into devcgroup_inode_permission().

- Add fastpath predicts for stat() and fdput().

- Anonymous inodes currently don't come with a proper mode causing
  issues in the kernel when we want to add useful VFS debug assert. Fix
  that by giving them a proper mode and masking it off when we report it
  to userspace which relies on them not having any mode.

- Anonymous inodes currently allow to change inode attributes because
  the VFS falls back to simple_setattr() if i_op->setattr isn't
  implemented. This means the ownership and mode for every single user
  of anon_inode_inode can be changed. Block that as it's either useless
  or actively harmful. If specific ownership is needed the respective
  subsystem should allocate anonymous inodes from their own private
  superblock.

- Raise SB_I_NODEV and SB_I_NOEXEC on the anonymous inode superblock.

- Add proper tests for anonymous inode behavior.

- Make it easy to detect proper anonymous inodes and to ensure that we
  can detect them in codepaths such as readahead().

Cleanups:

- Port pidfs to the new anon_inode_{g,s}etattr() helpers.

- Try to remove the uselib() system call.

- Add unlikely branch hint return path for poll.

- Add unlikely branch hint on return path for core_sys_select.

- Don't allow signals to interrupt getdents copying for fuse.

- Provide a size hint to dir_context for during readdir().

- Use writeback_iter directly in mpage_writepages.

- Update compression and mtime descriptions in initramfs documentation.

- Update main netfs API document.

- Remove useless plus one in super_cache_scan().

- Remove unnecessary NULL-check guards during setns().

- Add separate separate {get,put}_cgroup_ns no-op cases.

Fixes:

- Fix typo in root= kernel parameter description.

- Use KERN_INFO for infof()|info_plog()|infofc().

- Correct comments of fs_validate_description()

- Mark an unlikely if condition with unlikely() in vfs_parse_monolithic_sep().

- Delete macro fsparam_u32hex()

- Remove unused and problematic validate_constant_table().

- Fix potential unsigned integer underflow in fs_name().

- Make file-nr output the total allocated file handles.

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

This will have a merge conflict with the vfs freeze pull request sent as:

https://lore.kernel.org/20250523-vfs-freeze-8e3934479cba@brauner

that can be resolved as follows:

diff --cc fs/internal.h
index 8800e1bb23e3,f545400ce607..000000000000
--- a/fs/internal.h
+++ b/fs/internal.h
@@@ -344,4 -343,8 +344,9 @@@ static inline bool path_mounted(const s
  void file_f_owner_release(struct file *file);
  bool file_seek_cur_needs_f_lock(struct file *file);
  int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_map);
 +struct dentry *find_next_child(struct dentry *parent, struct dentry *prev);
+ int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
+                      struct kstat *stat, u32 request_mask,
+                      unsigned int query_flags);
+ int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+                      struct iattr *attr);

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.misc

for you to fetch changes up to 76145cb37ff0636fdf2a15320b2c2421915df32b:

  Merge patch series "Use folios for symlinks in the page cache" (2025-05-15 12:14:34 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.misc

----------------------------------------------------------------
Christian Brauner (17):
      anon_inode: use a proper mode internally
      pidfs: use anon_inode_getattr()
      anon_inode: explicitly block ->setattr()
      pidfs: use anon_inode_setattr()
      anon_inode: raise SB_I_NODEV and SB_I_NOEXEC
      selftests/filesystems: add chown() test for anonymous inodes
      selftests/filesystems: add chmod() test for anonymous inodes
      selftests/filesystems: add exec() test for anonymous inodes
      selftests/filesystems: add open() test for anonymous inodes
      Merge patch series "fs: harden anon inodes"
      Merge patch series "fs: sort out cosmetic differences between stat funcs and add predicts"
      fs: remove uselib() system call
      Merge patch series "two nits for path lookup"
      fs: add S_ANON_INODE
      Merge patch series "Minor namespace code simplication"
      Merge patch series "include/linux/fs.h: add inode_lock_killable()"
      Merge patch series "Use folios for symlinks in the page cache"

David Disseldorp (1):
      docs: initramfs: update compression and mtime descriptions

David Howells (1):
      netfs: Update main API document

Jinliang Zheng (1):
      fs: remove useless plus one in super_cache_scan()

Joel Savitz (2):
      kernel/nsproxy: remove unnecessary guards
      include/cgroup: separate {get,put}_cgroup_ns no-op case

Li RongQing (1):
      fs: Make file-nr output the total allocated file handles

Mateusz Guzik (6):
      fs: sort out cosmetic differences between stat funcs and add predicts
      fs: predict not having to do anything in fdput()
      fs: unconditionally use atime_needs_update() in pick_link()
      fs: improve codegen in link_path_walk()
      fs: touch up predicts in inode_permission()
      device_cgroup: avoid access to ->i_rdev in the common case in devcgroup_inode_permission()

Matthew Wilcox (Oracle) (3):
      fs: Convert __page_get_link() to use a folio
      nfs: Use a folio in nfs_get_link()
      fs: Pass a folio to page_put_link()

Max Kellermann (4):
      include/linux/fs.h: add inode_lock_killable()
      fs/open: make chmod_common() and chown_common() killable
      fs/open: make do_truncate() killable
      fs/read_write: make default_llseek() killable

Miklos Szeredi (2):
      fuse: don't allow signals to interrupt getdents copying
      readdir: supply dir_context.count as readdir buffer size hint

Petr Vaněk (1):
      Documentation: fix typo in root= kernel parameter description

Yafang Shao (1):
      vfs: Add sysctl vfs_cache_pressure_denom for bulk file operations

Zijun Hu (6):
      fs/fs_context: Use KERN_INFO for infof()|info_plog()|infofc()
      fs/fs_parse: Correct comments of fs_validate_description()
      fs/fs_context: Mark an unlikely if condition with unlikely() in vfs_parse_monolithic_sep()
      fs/filesystems: Fix potential unsigned integer underflow in fs_name()
      fs/fs_parse: Delete macro fsparam_u32hex()
      fs/fs_parse: Remove unused and problematic validate_constant_table()

 Documentation/admin-guide/kernel-parameters.txt    |    2 +-
 Documentation/admin-guide/sysctl/vm.rst            |   32 +-
 .../driver-api/early-userspace/buffer-format.rst   |   34 +-
 Documentation/filesystems/mount_api.rst            |   16 -
 Documentation/filesystems/netfs_library.rst        | 1016 ++++++++++++++------
 arch/m68k/configs/amcore_defconfig                 |    1 -
 arch/x86/configs/i386_defconfig                    |    1 -
 arch/xtensa/configs/cadence_csp_defconfig          |    1 -
 fs/anon_inodes.c                                   |   45 +
 fs/binfmt_elf.c                                    |   76 --
 fs/dcache.c                                        |   11 +-
 fs/exec.c                                          |   60 --
 fs/exportfs/expfs.c                                |    1 +
 fs/file_table.c                                    |    2 +-
 fs/filesystems.c                                   |   14 +-
 fs/fs_context.c                                    |    6 +-
 fs/fs_parser.c                                     |   55 +-
 fs/fuse/dir.c                                      |    2 +-
 fs/fuse/readdir.c                                  |    4 +-
 fs/internal.h                                      |    5 +
 fs/ioctl.c                                         |    7 +-
 fs/libfs.c                                         |   10 +-
 fs/mpage.c                                         |   13 +-
 fs/namei.c                                         |   79 +-
 fs/nfs/symlink.c                                   |   20 +-
 fs/open.c                                          |   14 +-
 fs/overlayfs/readdir.c                             |   12 +-
 fs/pidfs.c                                         |   28 +-
 fs/read_write.c                                    |    4 +-
 fs/readdir.c                                       |   47 +-
 fs/select.c                                        |    4 +-
 fs/stat.c                                          |   35 +-
 fs/super.c                                         |    2 +-
 include/linux/binfmts.h                            |    1 -
 include/linux/cgroup.h                             |   26 +-
 include/linux/device_cgroup.h                      |    7 +-
 include/linux/file.h                               |    2 +-
 include/linux/fs.h                                 |   22 +
 include/linux/fs_parser.h                          |    7 -
 init/Kconfig                                       |   10 -
 kernel/nsproxy.c                                   |   30 +-
 mm/readahead.c                                     |   20 +-
 tools/testing/selftests/bpf/config.aarch64         |    1 -
 tools/testing/selftests/bpf/config.s390x           |    1 -
 tools/testing/selftests/filesystems/.gitignore     |    1 +
 tools/testing/selftests/filesystems/Makefile       |    2 +-
 .../selftests/filesystems/anon_inode_test.c        |   69 ++
 47 files changed, 1164 insertions(+), 694 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/anon_inode_test.c

