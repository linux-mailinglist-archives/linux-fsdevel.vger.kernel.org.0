Return-Path: <linux-fsdevel+bounces-70152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E031DC929E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162613AE622
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F382C0F79;
	Fri, 28 Nov 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax0jI5TE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1222C027C;
	Fri, 28 Nov 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348674; cv=none; b=a3NeGDNoWaoKcwojfh6HdQj/EwjTHW+1B6QQ9SeYCd4qbRfzlRBJcRO7PmBsM9QxjCAAo1TfIPyJUejib2FmKxyUsx/OxQcRIYpW/1NX6iM7hWltkmoCmQdTyiYJyidu4+aCRelwfm6xmDSFtm+aJzlMo8COUSh1wnQUGITLsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348674; c=relaxed/simple;
	bh=TxNXef8RsmyWs/+z7zCiFgLM/jtzy0B2yR4fcAtHfgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVFvMVqGxPtemPNegsOuLrmHwb1Oegc2jJqFX34p9ai5XFVGwBUtJ5GZJq933mXPSESUbwBVPVPENwL34bG6l7is76YXmMqRm1XnjsgrznKYid7DnA743fNxL2P2/afL7G3XCqWTSJFua1MsyUUQPzyOWeVDQfQBb7esv4UvuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax0jI5TE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157DFC4CEF1;
	Fri, 28 Nov 2025 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348673;
	bh=TxNXef8RsmyWs/+z7zCiFgLM/jtzy0B2yR4fcAtHfgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ax0jI5TEqUIupVXZDKcxvh1khL1jWC/rPjOpc7FRUJmUTfKJfmMqbK+Mk9xzKOtLa
	 U8q+S9Z3u273aCuFALnt+aXd22Gi6wG9naj3fE8t3bxl2exTYs2k7eiAZ/K23TT3bw
	 k+zO+Qw9b7DcImt08UeLJvF9m6pMnMvcP8tGg+QceXu7ELfgmEwZutn2uhFTr/oxQP
	 ssJo/akJBfyOY1/Ogwo0FMuxRgg/1uoEu49egQMDEQNN3O207SGca2AMtT7RYM5eaD
	 403ihkYawi3BSHjUuWIZiwz6i8L7cgCEXAEVYF4Xx9c4AZnOZd8A1kPm6TMMUYNOvB
	 wLud88FTO7nIw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 02/17 for v6.19] vfs misc
Date: Fri, 28 Nov 2025 17:48:13 +0100
Message-ID: <20251128-vfs-misc-v619-0a57215a07b7@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7904; i=brauner@kernel.org; h=from:subject:message-id; bh=TxNXef8RsmyWs/+z7zCiFgLM/jtzy0B2yR4fcAtHfgw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXno48+iVGqY/X3revyt+Wp8y/eTr9nmfftWwvPf64 3P4b/VyrY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJhKkw/E8v7pU/7F/kZNx4 MTDh/3G14pUdmr+PqFvXTDf+pvb8xjqGP5yiKx9vTtsl7rK176Tij8//9Tu3fHVrWR/17c6mBfs S9nMDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the usually miscellaneous vfs changes:

Note that this has the kbuild -fms-extensions support merged in as the
pipe changes depends on it.

Features

- Cheaper MAY_EXEC handling for path lookup. This elides MAY_WRITE
  permission checks during path lookup and adds the IOP_FASTPERM_MAY_EXEC
  flag so filesystems like btrfs can avoid expensive permission work.

- Hide dentry_cache behind runtime const machinery.

- Add German Maglione as virtiofs co-maintainer.

Cleanups

- Tidy up and inline step_into() and walk_component() for improved code
  generation.

- Re-enable IOCB_NOWAIT writes to files. This refactors file timestamp
  update logic, fixing a layering bypass in btrfs when updating timestamps
  on device files and improving FMODE_NOCMTIME handling in VFS now that
  nfsd started using it.

- Path lookup optimizations extracting slowpaths into dedicated routines
  and adding branch prediction hints for mntput_no_expire(), fd_install(),
  lookup_slow(), and various other hot paths.

- Enable clang's -fms-extensions flag, requiring a JFS rename to avoid
  conflicts.

- Remove spurious exports in fs/file_attr.c.

- Stop duplicating union pipe_index declaration. This depends on the
  shared kbuild branch that brings in -fms-extensions support which is
  merged into this branch.

- Use MD5 library instead of crypto_shash in ecryptfs.

- Use largest_zero_folio() in iomap_dio_zero().

- Replace simple_strtol/strtoul with kstrtoint/kstrtouint in init and
  initrd code.

- Various typo fixes.

Fixes

- Fix emergency sync for btrfs. Btrfs requires an explicit sync_fs() call
  with wait == 1 to commit super blocks. The emergency sync path never
  passed this, leaving btrfs data uncommitted during emergency sync.

- Use local kmap in watch_queue's post_one_notification().

- Add hint prints in sb_set_blocksize() for LBS dependency on THP.

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

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.misc

for you to fetch changes up to ebf8538979101ef879742dcfaf04b684f5461e12:

  MAINTAINERS: add German Maglione as virtiofs co-maintainer (2025-11-27 10:00:09 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.misc

----------------------------------------------------------------
Askar Safin (2):
      fs/splice.c: trivial fix: pipes -> pipe's
      include/linux/fs.h: trivial fix: regualr -> regular

Baokun Li (1):
      bdev: add hint prints in sb_set_blocksize() for LBS dependency on THP

Christian Brauner (6):
      Merge patch series "fs: fully sync all fsese even for an emergency sync"
      Merge patch "kbuild: Add '-fms-extensions' to areas with dedicated CFLAGS"
      Merge branch 'kbuild-6.19.fms.extension'
      Merge patch series "cheaper MAY_EXEC handling for path lookup"
      Merge patch series "re-enable IOCB_NOWAIT writes to files v2"
      Merge patch series "fs: tidy up step_into() & friends before inlining"

Christoph Hellwig (7):
      fs: remove spurious exports in fs/file_attr.c
      fs: refactor file timestamp update logic
      fs: lift the FMODE_NOCMTIME check into file_update_time_flags
      fs: export vfs_utimes
      btrfs: use vfs_utimes to update file timestamps
      btrfs: fix the comment on btrfs_update_time
      orangefs: use inode_update_timestamps directly

Davidlohr Bueso (1):
      watch_queue: Use local kmap in post_one_notification()

Eric Biggers (1):
      ecryptfs: Use MD5 library instead of crypto_shash

Kaushlendra Kumar (1):
      init: Replace simple_strtoul() with kstrtouint() in root_delay_setup()

Mateusz Guzik (13):
      fs: touch up predicts in putname()
      fs: speed up path lookup with cheaper handling of MAY_EXEC
      btrfs: utilize IOP_FASTPERM_MAY_EXEC
      fs: retire now stale MAY_WRITE predicts in inode_permission()
      fs: touch predicts in do_dentry_open()
      fs: hide dentry_cache behind runtime const machinery
      fs: move fd_install() slowpath into a dedicated routine and provide commentary
      fs: touch up predicts in path lookup
      fs: move mntput_no_expire() slowpath into a dedicated routine
      fs: add predicts based on nd->depth
      fs: mark lookup_slow() as noinline
      fs: tidy up step_into() & friends before inlining
      fs: inline step_into() and walk_component()

Nathan Chancellor (2):
      jfs: Rename _inline to avoid conflict with clang's '-fms-extensions'
      kbuild: Add '-fms-extensions' to areas with dedicated CFLAGS

Pankaj Raghav (1):
      iomap: use largest_zero_folio() in iomap_dio_zero()

Qu Wenruo (2):
      fs: do not pass a parameter for sync_inodes_one_sb()
      fs: fully sync all fses even for an emergency sync

Rasmus Villemoes (2):
      Kbuild: enable -fms-extensions
      fs/pipe: stop duplicating union pipe_index declaration

Stefan Hajnoczi (1):
      MAINTAINERS: add German Maglione as virtiofs co-maintainer

Thorsten Blum (1):
      initrd: Replace simple_strtol with kstrtoint to improve ramdisk_start_setup

 MAINTAINERS                           |   1 +
 Makefile                              |   3 +
 arch/arm64/kernel/vdso32/Makefile     |   3 +-
 arch/loongarch/vdso/Makefile          |   2 +-
 arch/parisc/boot/compressed/Makefile  |   2 +-
 arch/powerpc/boot/Makefile            |   3 +-
 arch/s390/Makefile                    |   3 +-
 arch/s390/purgatory/Makefile          |   3 +-
 arch/x86/Makefile                     |   4 +-
 arch/x86/boot/compressed/Makefile     |   7 +-
 block/bdev.c                          |  19 ++++-
 drivers/firmware/efi/libstub/Makefile |   4 +-
 fs/btrfs/inode.c                      |  16 +++-
 fs/btrfs/volumes.c                    |  11 +--
 fs/dcache.c                           |   6 +-
 fs/ecryptfs/Kconfig                   |   2 +-
 fs/ecryptfs/crypto.c                  |  90 +++------------------
 fs/ecryptfs/ecryptfs_kernel.h         |  13 +---
 fs/ecryptfs/inode.c                   |   7 +-
 fs/ecryptfs/keystore.c                |  65 +++-------------
 fs/ecryptfs/main.c                    |   7 ++
 fs/ecryptfs/super.c                   |   5 +-
 fs/file.c                             |  35 +++++++--
 fs/file_attr.c                        |   4 -
 fs/inode.c                            |  58 +++++---------
 fs/iomap/direct-io.c                  |  38 ++++-----
 fs/jfs/jfs_incore.h                   |   6 +-
 fs/namei.c                            | 142 +++++++++++++++++++++++++---------
 fs/namespace.c                        |  38 +++++----
 fs/open.c                             |   6 +-
 fs/orangefs/inode.c                   |   4 +-
 fs/splice.c                           |   2 +-
 fs/sync.c                             |   7 +-
 fs/utimes.c                           |   1 +
 include/asm-generic/vmlinux.lds.h     |   3 +-
 include/linux/fs.h                    |  15 ++--
 include/linux/pipe_fs_i.h             |  23 ++----
 init/do_mounts.c                      |   3 +-
 init/do_mounts_rd.c                   |   3 +-
 kernel/watch_queue.c                  |   4 +-
 scripts/Makefile.extrawarn            |   4 +-
 41 files changed, 329 insertions(+), 343 deletions(-)

