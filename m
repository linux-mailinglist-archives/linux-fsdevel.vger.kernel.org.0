Return-Path: <linux-fsdevel+bounces-23607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F162492FBE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 15:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30AD3B22763
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D58171644;
	Fri, 12 Jul 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrPwU5Z1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A526AFF;
	Fri, 12 Jul 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792407; cv=none; b=kSkNJUc55Q/ZY6kIkxnA114efKduK/w8yY5OSSPaGDn9i/j06or/pS613B+Ubsw39y+dEQUqbxWciainhBr08wfRBIj3eI4a1B8A4ga1che0C5B8Krtq365HMCJDT8+Q8fKf516NtMne0q4OzhgcCJ9XDOho1dMk70qGdBfd8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792407; c=relaxed/simple;
	bh=60wSl/LCqerIR63hFWz9UxaousNhI6XtvAhmqdf3tuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmzK7No7CY79NLY1uOOhQDguM+k5lxDBstXBvEEA+CFSHNEzWZnj9BPds26TyaDqBXZtXLyiSYq3qS031+AUv9dYtA1XNHtAKRML/h7GusaqnW98yPj+l9Nc2GDmfEVxZoIA8vlaHLAF4fxXgbeinnZUD0zHUiHDBbDBw2oH3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrPwU5Z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793F1C4AF07;
	Fri, 12 Jul 2024 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792407;
	bh=60wSl/LCqerIR63hFWz9UxaousNhI6XtvAhmqdf3tuE=;
	h=From:To:Cc:Subject:Date:From;
	b=hrPwU5Z14vE30xK/TLbg5TDpPCYkurLL4+eUZ6dR7McWhUzJvt1kb6GSUY+8hM1ip
	 OxixCqcnEjBFGyhNafvjtt8IMJC9vVkNNhxrxiWwODDcdXjs0rVK7VyU3oD2hz0Bsa
	 D3wxBRZ2iMcosqvUDFobakMp2WseXYwDyPhZJX29rCT9RnW7+I/WORY34dgOr4Z0Ki
	 6gQSf2FX2A1EmnBfjocxdMv7XU48cYBRnnfKe8zUretxenRFzz88tZNZxGYqFMPB8+
	 pr91OEhg0z16dmXzqANzuFJJJs0RRQ79mQBmCouYpygzxqjgEP+yGB8lFeYfIFuFtp
	 X/V0hIQdFJ3qw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs misc
Date: Fri, 12 Jul 2024 15:50:34 +0200
Message-ID: <20240712-vfs-misc-c1dbbc5eaf82@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6754; i=brauner@kernel.org; h=from:subject:message-id; bh=60wSl/LCqerIR63hFWz9UxaousNhI6XtvAhmqdf3tuE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNFn3SPeLz/S3d946fV/z5YzDMfMzsX13Svief9I8u 3dRaOAx7o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJZAsx/PfsdfNZU88rePRF 0fza/2bLFz/9fXDh2krfzyz8YsU9hs4MPxnPqshkPueQq+lhFfqvsDWtSvWvVZj//6X7N7Getuz u4gcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
Features:

- Support passing NULL along AT_EMPTY_PATH for statx(). NULL paths with any
  flag value other than AT_EMPTY_PATH go the usual route and end up with
  -EFAULT to retain compatibility (Rust is abusing calls of the sort to detect
  availability of statx).

  This avoids path lookup code, lockref management, memory allocation and in
  case of NULL path userspace memory access (which can be quite expensive with
  SMAP on x86_64).

- Don't block i_writecount during exec. Remove the deny_write_access()
  mechanism for executables.

- Relax open_by_handle_at() permissions in specific cases where we can prove
  that the caller had sufficient privileges to open a file.

- Switch timespec64 fields in struct inode to discrete integers freeing up 4
  bytes.

Fixes:

- Fix false positive circular locking warning in hfsplus.

- Initialize hfs_inode_info after hfs_alloc_inode() in hfs.

- Avoid accidental overflows in vfs_fallocate().

- Don't interrupt fallocate with EINTR in tmpfs to avoid constantly restarting
  shmem_fallocate().

- Add missing quote in comment in fs/readdir.

Cleanups:
- Don't assign and test in an if statement in mqueue. Move the assignment out
  of the if statement.

- Reflow the logic in may_create_in_sticky().

- Remove the usage of the deprecated ida_simple_xx() API from procfs.

- Reject FSCONFIG_CMD_CREATE_EXCL requets that depend on the new mount api early.

- Rename variables in copy_tree() to make it easier to understand.

- Replace WARN(down_read_trylock, ...) abuse with proper asserts in various
  places in the VFS.

- Get rid of user_path_at_empty() and drop the empty argument from
  getname_flags().

- Check for error while copying and no path in one branch in getname_flags().

- Avoid redundant smp_mb() for THP handling in do_dentry_open().

- Rename parent_ino to d_parent_ino and make it use RCU.

- Remove unused header include in fs/readdir.

- Export in_group_capable() helper and switch f2fs and fuse over to it instead
  of open-coding the logic in both places.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with other trees
================================

[1]: linux-next: manual merge of the block tree with the vfs-brauner tree
     https://lore.kernel.org/linux-next/Zn76C70F9QB_Z0bw@sirena.org.uk

[2]: linux-next: manual merge of the block tree with the vfs-brauner tree
     https://lore.kernel.org/linux-next/Zn76HPyBbHbnmGmw@sirena.org.uk

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.misc

for you to fetch changes up to b80cc4df1124702c600fd43b784e423a30919204:

  ipc: mqueue: remove assignment from IS_ERR argument (2024-07-09 06:47:40 +0200)

Please consider pulling these changes from the signed vfs-6.11.misc tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.misc

----------------------------------------------------------------
Chao Yu (2):
      hfsplus: fix to avoid false alarm of circular locking
      hfs: fix to initialize fields of hfs_inode_info after hfs_alloc_inode()

Chen Ni (1):
      ipc: mqueue: remove assignment from IS_ERR argument

Christian Brauner (5):
      fhandle: relax open_by_handle_at() permission checks
      fs: don't block i_writecount during exec
      fs: reflow may_create_in_sticky()
      fs: new helper vfs_empty_path()
      stat: use vfs_empty_path() helper

Christophe JAILLET (1):
      proc: Remove usage of the deprecated ida_simple_xx() API

Hongbo Li (1):
      fs: fsconfig: intercept non-new mount API in advance for FSCONFIG_CMD_CREATE_EXCL command

Jeff Layton (1):
      fs: switch timespec64 fields in inode to discrete integers

Jemmy (1):
      Improve readability of copy_tree

Justin Stitt (1):
      fs: remove accidental overflow during wraparound check

Mateusz Guzik (8):
      vfs: replace WARN(down_read_trylock, ...) abuse with proper asserts
      vfs: stop using user_path_at_empty in do_readlinkat
      vfs: retire user_path_at_empty and drop empty arg from getname_flags
      vfs: shave a branch in getname_flags
      vfs: reorder checks in may_create_in_sticky
      vfs: remove redundant smp_mb for thp handling in do_dentry_open
      vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
      vfs: rename parent_ino to d_parent_ino and make it use RCU

Mikulas Patocka (1):
      tmpfs: don't interrupt fallocate with EINTR

Thorsten Blum (2):
      readdir: Remove unused header include
      readdir: Add missing quote in macro comment

Youling Tang (3):
      fs: Export in_group_or_capable()
      f2fs: Use in_group_or_capable() helper
      fuse: Use in_group_or_capable() helper

 fs/attr.c                |   2 -
 fs/binfmt_elf.c          |   2 -
 fs/binfmt_elf_fdpic.c    |   5 +-
 fs/binfmt_misc.c         |   7 +-
 fs/dcache.c              |  30 +++++++-
 fs/exec.c                |  14 +---
 fs/exportfs/expfs.c      |   9 ++-
 fs/f2fs/acl.c            |   3 +-
 fs/f2fs/file.c           |   6 +-
 fs/fhandle.c             | 178 +++++++++++++++++++++++++++++++++++++----------
 fs/fsopen.c              |   7 +-
 fs/fuse/acl.c            |   4 +-
 fs/hfs/inode.c           |   3 +
 fs/hfsplus/bfind.c       |  15 +---
 fs/hfsplus/extents.c     |   9 ++-
 fs/hfsplus/hfsplus_fs.h  |  21 ++++++
 fs/hfsplus/ioctl.c       |   4 +-
 fs/inode.c               |   1 +
 fs/internal.h            |  14 ++++
 fs/mount.h               |   1 +
 fs/namei.c               |  98 ++++++++++++++++----------
 fs/namespace.c           |  74 +++++++++-----------
 fs/nfsd/nfsfh.c          |   2 +-
 fs/open.c                |  17 +++--
 fs/proc/generic.c        |   6 +-
 fs/quota/dquot.c         |   8 +--
 fs/readdir.c             |   4 +-
 fs/stat.c                | 172 +++++++++++++++++++++++++++++----------------
 include/linux/dcache.h   |   2 +
 include/linux/exportfs.h |   2 +
 include/linux/fs.h       |  85 +++++++++++++---------
 include/linux/namei.h    |   8 +--
 io_uring/statx.c         |   3 +-
 io_uring/xattr.c         |   4 +-
 ipc/mqueue.c             |   3 +-
 kernel/fork.c            |  26 +------
 mm/khugepaged.c          |  10 +--
 mm/shmem.c               |   9 ++-
 38 files changed, 539 insertions(+), 329 deletions(-)

