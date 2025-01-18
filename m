Return-Path: <linux-fsdevel+bounces-39581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E1CA15D12
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20DF7A3532
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B08B18B470;
	Sat, 18 Jan 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbbMulDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C27A95C;
	Sat, 18 Jan 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205245; cv=none; b=KBpKjXKrc017QM1+XGUGrW1Nm5VdpKJNEHj8exb0nctRIesHExZRUxbLmBmEC6uCloWMLqfermzzvnA8wDRy7AK6MffYow9TPcZ+v0wKdfcSkOiLS+ZcBRwaji+iH231ZL7G1wyFaPp4eTCAAIOqRVE715D/ehrJU2y55AM7Y1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205245; c=relaxed/simple;
	bh=BImomlb+n2yeWHLsd/iBV1DaF+YMHibxXssMxC5eGfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8jPycOXZN32kRqS+O4hTIRXxA0qnzle2sgfkia3ImXkHizAiAcJRmRD2X80NdojyuYVZN3lsW083oBYy9srpbuXEcoFyuyNzhl5f7ROUy+G/DqVsamc4o/yoEtTkW561cJfbRGq78q6jZcHjqroSFAP6GPecLDtipVRYDromqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbbMulDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB049C4CED1;
	Sat, 18 Jan 2025 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737205245;
	bh=BImomlb+n2yeWHLsd/iBV1DaF+YMHibxXssMxC5eGfU=;
	h=From:To:Cc:Subject:Date:From;
	b=WbbMulDjOCCA003iRKbPr/khksnpMymsiC5RWNpNKPmSzIO7GHIW0gsmlLfRrsnP2
	 WUnNGxcZY3NWH09C1xr7GIOYu8+kdJCzbf3MGEgLI/hVFxu3OjETM3XJKx1CXVzH3v
	 c2hwyv0SCJgXI3yZxCe65sTC4G0gKg9avUupWv3P9luagg1UqbiDTEAI8Yeg4jwFp0
	 qkCQhl1avoPyQgcwrgVYEQzbxiY1s6uYQfaIwNj740cnOHUtPyf82cjCsU6DEnq2Ms
	 wk4uP4lP7p4C0snZTE8q4DGuSXeRZfhxgq1HI80mJFnZtGvf1tT8dokMJj+85GRQbU
	 0kIyNE2skEKMA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs pidfs
Date: Sat, 18 Jan 2025 14:00:30 +0100
Message-ID: <20250118-vfs-pidfs-5921bfa5632a@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6154; i=brauner@kernel.org; h=from:subject:message-id; bh=BImomlb+n2yeWHLsd/iBV1DaF+YMHibxXssMxC5eGfU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3L/2iVzhldedt+WIVB/8rhz6mOuftYNP+VSrqKl56O 9g02kmyo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIm0Qz/NJZ1TH3DqXNJz7g5 v9U1oE54/ovknZ2WdkulH/BPWyj8leGf1etnCztVnfONjfib6vNUGiZWpDKI7zr+m3lJYJCs5A9 mAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains pidfs updates for this cycle:

- Rework inode number allocation

  Recently we received a patchset that aims to enable file handle
  encoding and decoding via name_to_handle_at(2) and
  open_by_handle_at(2).

  A crucical step in the patch series is how to go from inode number to
  struct pid without leaking information into unprivileged contexts. The
  issue is that in order to find a struct pid the pid number in the
  initial pid namespace must be encoded into the file handle via
  name_to_handle_at(2).

  This can be used by containers using a separate pid namespace to learn
  what the pid number of a given process in the initial pid namespace
  is. While this is a weak information leak it could be used in various
  exploits and in general is an ugly wart in the design.

  To solve this problem a new way is needed to lookup a struct pid based
  on the inode number allocated for that struct pid. The other part is
  to remove the custom inode number allocation on 32bit systems that is
  also an ugly wart that should go away.

  Allocate unique identifiers for struct pid by simply incrementing a 64
  bit counter and insert each struct pid into the rbtree so it can be
  looked up to decode file handles avoiding to leak actual pids across
  pid namespaces in file handles.

  On both 64 bit and 32 bit the same 64 bit identifier is used to lookup
  struct pid in the rbtree. On 64 bit the unique identifier for struct pid
  simply becomes the inode number. Comparing two pidfds continues to be as
  simple as comparing inode numbers.

  On 32 bit the 64 bit number assigned to struct pid is split into two 32
  bit numbers. The lower 32 bits are used as the inode number and the
  upper 32 bits are used as the inode generation number. Whenever a
  wraparound happens on 32 bit the 64 bit number will be incremented by 2
  so inode numbering starts at 2 again.

  When a wraparound happens on 32 bit multiple pidfds with the same inode
  number are likely to exist. This isn't a problem since before pidfs
  pidfds used the anonymous inode meaning all pidfds had the same inode
  number. On 32 bit sserspace can thus reconstruct the 64 bit identifier
  by retrieving both the inode number and the inode generation number to
  compare, or use file handles. This gives the same guarantees on both 32
  bit and 64 bit.

- Implement file handle support

  This is based on custom export operation methods which allows pidfs to
  implement permission checking and opening of pidfs file handles
  cleanly without hacking around in the core file handle code too much.

- Support bind-mounts

  Allow bind-mounting pidfds. Similar to nsfs let's allow bind-mounts
  for pidfds. This allows pidfds to be safely recovered and checked for
  process recycling.

  Instead of checking d_ops for both nsfs and pidfs we could in a
  follow-up patch add a flag argument to struct dentry_operations that
  functions similar to file_operations->fop_flags.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.pidfs

for you to fetch changes up to 3781680fba3eab0b34b071cb9443fd5ad92d23cf:

  Merge patch series "pidfs: support bind-mounts" (2024-12-22 11:03:19 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc1.pidfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc1.pidfs

----------------------------------------------------------------
Christian Brauner (16):
      pidfs: rework inode number allocation
      pidfs: remove 32bit inode number handling
      pidfs: support FS_IOC_GETVERSION
      Merge patch series "pidfs: file handle preliminaries"
      fhandle: simplify error handling
      exportfs: add open method
      fhandle: pull CAP_DAC_READ_SEARCH check into may_decode_fh()
      exportfs: add permission method
      pidfs: implement file handle support
      Merge patch series "pidfs: implement file handle support"
      pidfs: check for valid ioctl commands
      selftests/pidfd: add pidfs file handle selftests
      pidfs: lookup pid through rbtree
      pidfs: allow bind-mounts
      selftests: add pidfd bind-mount tests
      Merge patch series "pidfs: support bind-mounts"

Erin Shepherd (1):
      pseudofs: add support for export_ops

 fs/fhandle.c                                       | 115 +++--
 fs/libfs.c                                         |   1 +
 fs/namespace.c                                     |  10 +-
 fs/pidfs.c                                         | 298 ++++++++++--
 include/linux/exportfs.h                           |  20 +
 include/linux/pid.h                                |   2 +
 include/linux/pidfs.h                              |   3 +
 include/linux/pseudo_fs.h                          |   1 +
 kernel/pid.c                                       |  14 +-
 tools/testing/selftests/pidfd/.gitignore           |   2 +
 tools/testing/selftests/pidfd/Makefile             |   3 +-
 tools/testing/selftests/pidfd/pidfd.h              |  39 ++
 tools/testing/selftests/pidfd/pidfd_bind_mount.c   | 188 ++++++++
 .../selftests/pidfd/pidfd_file_handle_test.c       | 503 +++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_setns_test.c   |  47 +-
 tools/testing/selftests/pidfd/pidfd_wait.c         |  47 +-
 16 files changed, 1110 insertions(+), 183 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_bind_mount.c
 create mode 100644 tools/testing/selftests/pidfd/pidfd_file_handle_test.c

