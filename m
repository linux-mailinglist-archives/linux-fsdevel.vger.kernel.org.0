Return-Path: <linux-fsdevel+bounces-39580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464D1A15D0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE9166504
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6818B482;
	Sat, 18 Jan 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhj6Q6/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4914A4E9;
	Sat, 18 Jan 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205156; cv=none; b=PSherPnxBeEWrP9ttSXcqwYi4kEF2+bCp/QhBK7Tf+st8zhYZ2S4jliKA+MGJxtDeWfDbT1XWU8fYRXvHBDa/KclFC3iFBW6snBzB2dHJx0D52jpFByK6S2qAXxFL1azejycHhhBM2qbqnUXDv+FZAcs8XDj46jHU6A6F9Q7/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205156; c=relaxed/simple;
	bh=yVRnRTD/5w62vtfHLSd5YwhGYWYzyz3HIX2SB1Pt8H4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thVi+qIBY/m3BT8l31FX26rCy/ANLhB561/0fKqr5CMJ4X1KQzuT4OLPWQviU2diXrvZF6ueugh5xOehfLzZHbNYE2E2de86YL2GIkDWHR/2Mwdd3tBaOYLJP+2TxyD5EMEAuG3W/kfWgXR6V7vLkwMAYt7wY40hGWW18uZDnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhj6Q6/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF39C4CED1;
	Sat, 18 Jan 2025 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737205156;
	bh=yVRnRTD/5w62vtfHLSd5YwhGYWYzyz3HIX2SB1Pt8H4=;
	h=From:To:Cc:Subject:Date:From;
	b=Jhj6Q6/8E+TrA/1gkWV6yA6xt+OM50alvwEYbPyRorsTpuvwfPVzRCRblNG5YmkT5
	 nG9/JkvgdhSc1Vkiw25C8sB5fGlhsiqh9KcOUK+yw6kSZ9whObYp/sjnKHbDgnO1IW
	 KKMzsgvvw1us905i9MF10vkx+aIDYlXftB5eG9YANsjCoNT/jVLIxCi41yG2ZMgwpd
	 1DYO3JnvOYDekrDoKjn5ACUlg2T3D2i9hK0HA7fFP8+GQjJFpGvre338RNqmJFTYPk
	 LY4SQsQ9DRPqAFWC00ovZDmkPNqf/8uKklKs3tZ/DyKYk+8oedk/tG/HAckpP00Ac7
	 NF1w0U3bNka9w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs misc
Date: Sat, 18 Jan 2025 13:58:51 +0100
Message-ID: <20250118-vfs-misc-84fb5265d102@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7734; i=brauner@kernel.org; h=from:subject:message-id; bh=yVRnRTD/5w62vtfHLSd5YwhGYWYzyz3HIX2SB1Pt8H4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3L5274t3DmSWPAnNFZdp+pFoEbz1ZvWHNy8XOjJ2vi mJYXLZodZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk14/hn11jhaTlpOXqLmlL VGud/8rJP+icWXckynTWoq3Rs39/283I0Lb4tfD0MqHa+iif2VGeObk5OonlrheLUt8n5X0K0T7 EAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Features:

- Support caching symlink lengths in inodes.

  The size is stored in a new union utilizing the same space as
  i_devices, thus avoiding growing the struct or taking up any more
  space.

  When utilized it dodges strlen() in vfs_readlink(), giving about 1.5%
  speed up when issuing readlink on /initrd.img on ext4.

- Add RWF_DONTCACHE iocb and FOP_DONTCACHE file_operations flag.

  If a file system supports uncached buffered IO, it may set
  FOP_DONTCACHE and enable support for RWF_DONTCACHE. If RWF_DONTCACHE
  is attempted without the file system supporting it, it'll get errored
  with -EOPNOTSUPP.

- Enable VBOXGUEST and VBOXSF_FS on ARM64

  Now that VirtualBox is able to run as a host on arm64 (e.g. the Apple
  M3 processors) we can enable VBOXSF_FS (and in turn VBOXGUEST) for
  this architecture. Tested with various runs of bonnie++ and dbench on
  an Apple MacBook Pro with the latest Virtualbox 7.1.4 r165100
  installed.

Cleanups:

- Delay sysctl_nr_open check in expand_files().

- Use kernel-doc includes in fiemap docbook.

- Use page->private instead of page->index in watch_queue.

- Use a consume fence in mnt_idmap() as it's heavily used in
  link_path_walk().

- Replace magic number 7 with ARRAY_SIZE() in fc_log.

- Sort out a stale comment about races between fd alloc and dup2().

- Fix return type of do_mount() from long to int.

- Various cosmetic cleanups for the lockref code.

Fixes:

- Annotate spinning as unlikely() in __read_seqcount_begin.

  The annotation already used to be there, but got lost in
  52ac39e5db5148f7 ("seqlock: seqcount_t: Implement all read APIs as
  statement expressions").

- Fix proc_handler for sysctl_nr_open.

- Flush delayed work in delayed fput().

- Fix grammar and spelling in propagate_umount().

- Fix ESP not readable during coredump.

  In /proc/PID/stat, there is the kstkesp field which is the stack
  pointer of a thread. While the thread is active, this field reads
  zero. But during a coredump, it should have a valid value.

  However, at the moment, kstkesp is zero even during coredump.

- Don't wake up the writer if the pipe is still full.

- Fix unbalanced user_access_end() in select code.

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

No known conflicts.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.misc

for you to fetch changes up to c859df526b203497227b2b16c9bebcede67221e4:

  Merge patch series "lockref cleanups" (2025-01-16 11:48:12 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc1.misc

----------------------------------------------------------------
Christian Brauner (4):
      Merge patch series "symlink length caching"
      Merge branch 'vfs-6.14.uncached_buffered_io'
      Merge patch series "fix reading ESP during coredump"
      Merge patch series "lockref cleanups"

Christian Kujau (1):
      vbox: Enable VBOXGUEST and VBOXSF_FS on ARM64

Christoph Hellwig (8):
      lockref: remove lockref_put_not_zero
      lockref: improve the lockref_get_not_zero description
      lockref: use bool for false/true returns
      lockref: drop superfluous externs
      lockref: add a lockref_init helper
      dcache: use lockref_init for d_lockref
      erofs: use lockref_init for pcl->lockref
      gfs2: use lockref_init for qd_lockref

Christophe Leroy (1):
      select: Fix unbalanced user_access_end()

Guo Weikang (1):
      fs: fc_log replace magic number 7 with ARRAY_SIZE()

Jens Axboe (1):
      fs: add RWF_DONTCACHE iocb and FOP_DONTCACHE file_operations flag

Jinliang Zheng (1):
      fs: fix proc_handler for sysctl_nr_open

Mateusz Guzik (7):
      fs: delay sysctl_nr_open check in expand_files()
      vfs: support caching symlink lengths in inodes
      seqlock: annotate spinning as unlikely() in __read_seqcount_begin
      ext4: use inode_set_cached_link()
      tmpfs: use inode_set_cached_link()
      fs: use a consume fence in mnt_idmap()
      fs: sort out a stale comment about races between fd alloc and dup2

Matthew Wilcox (Oracle) (1):
      watch_queue: Use page->private instead of page->index

Nam Cao (2):
      fs/proc: do_task_stat: Fix ESP not readable during coredump
      selftests: coredump: Add stackdump test

Oleg Nesterov (1):
      pipe_read: don't wake up the writer if the pipe is still full

Randy Dunlap (1):
      fiemap: use kernel-doc includes in fiemap docbook

Sentaro Onizuka (1):
      fs: Fix return type of do_mount() from long to int

Zhu Jun (1):
      fs: Fix grammar and spelling in propagate_umount()

shao mingyin (1):
      file: flush delayed work in delayed fput()

 Documentation/filesystems/fiemap.rst              |  49 +++----
 drivers/virt/vboxguest/Kconfig                    |   2 +-
 fs/dcache.c                                       |   3 +-
 fs/erofs/zdata.c                                  |   3 +-
 fs/ext4/inode.c                                   |   3 +-
 fs/ext4/namei.c                                   |   4 +-
 fs/file.c                                         |  22 +---
 fs/file_table.c                                   |   7 +-
 fs/fs_context.c                                   |   2 +-
 fs/gfs2/quota.c                                   |   3 +-
 fs/namei.c                                        |  34 ++---
 fs/namespace.c                                    |   2 +-
 fs/pipe.c                                         |  19 +--
 fs/pnode.c                                        |   8 +-
 fs/proc/array.c                                   |   2 +-
 fs/proc/namespaces.c                              |   2 +-
 fs/select.c                                       |   4 +-
 fs/vboxsf/Kconfig                                 |   2 +-
 include/linux/fiemap.h                            |  16 ++-
 include/linux/fs.h                                |  29 ++++-
 include/linux/lockref.h                           |  26 ++--
 include/linux/mount.h                             |   4 +-
 include/linux/seqlock.h                           |   2 +-
 include/uapi/linux/fiemap.h                       |  47 +++++--
 include/uapi/linux/fs.h                           |   6 +-
 kernel/watch_queue.c                              |   4 +-
 lib/lockref.c                                     |  60 +++------
 mm/shmem.c                                        |   6 +-
 security/apparmor/apparmorfs.c                    |   2 +-
 tools/testing/selftests/coredump/Makefile         |   7 +
 tools/testing/selftests/coredump/README.rst       |  50 +++++++
 tools/testing/selftests/coredump/stackdump        |  14 ++
 tools/testing/selftests/coredump/stackdump_test.c | 151 ++++++++++++++++++++++
 33 files changed, 415 insertions(+), 180 deletions(-)
 create mode 100644 tools/testing/selftests/coredump/Makefile
 create mode 100644 tools/testing/selftests/coredump/README.rst
 create mode 100755 tools/testing/selftests/coredump/stackdump
 create mode 100644 tools/testing/selftests/coredump/stackdump_test.c

