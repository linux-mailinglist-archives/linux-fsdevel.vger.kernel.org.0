Return-Path: <linux-fsdevel+bounces-39670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73090A16C55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 13:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C807A13A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9801DFDA7;
	Mon, 20 Jan 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUtCVul2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C191B6CEC;
	Mon, 20 Jan 2025 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376012; cv=none; b=BDeWv7spKlkqF9rnmvhl+vndUTVTSPQC8W2l0H9qEyY50WTGN64pXdsqCVVPaBK02r74gnZOqJYsB3uzIX5Z5VxJdf+Jpp8/zTcpdDgGINW0RDbX92/hfs6WtJmqpcB6yg2kaVHeR4aaBCwthHDXQP+8R9xtudWHoN2D8rB1b/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376012; c=relaxed/simple;
	bh=jxBHHz5k43CrP4mrUh7VNmmhVx97L7CHCXcgWPqCJI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ct0b4OxsdkVvnWP18jeDtvI2b1ij80SYA00DE/boBwTDQU10/nUkQ+sMpmYYzF24IvnldrKZZy+0B+0dc8vw88yXkheiol8Nvf8QSZE9IU89wCyDGN7MonPLr8TGpCg2p6P19/6AZgXtcKlngO4ajv0rh1VYqopdvA0gYGyDFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUtCVul2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541C3C4CEDD;
	Mon, 20 Jan 2025 12:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737376012;
	bh=jxBHHz5k43CrP4mrUh7VNmmhVx97L7CHCXcgWPqCJI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUtCVul24UNVGjDMNeLXLDSpmWV0+dHMrVg3BR2VZNaDAdUoOr5Rr6RR/qL8ndrlu
	 D7VndI3t+hPGGG865eWvP4bt3meNTJDH6dqvGYqewIlz5M7kDSUrdkITlC3ACfLQnV
	 /m4vu9nR4vvuKv11yehPtu7pbvJqJb2/iRPbHQcacYPbke1swqGFpSjPe5sjrQ/Mu6
	 Drv+9ZMAZ0NTTae20cUzHRiulAmNU2Szm38D3N0f5a8Z7PWXf5xQU+Ea9ALWrjS791
	 t9Mx+eyN1UC6hBIjXOAOUsqj3TUrfs+evLUp1hnP490zdPLWT+CpAbxOoFT8RSV6Vm
	 Jn4Ff03iN7aKQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs mount v2
Date: Mon, 20 Jan 2025 13:26:39 +0100
Message-ID: <20250120-vfs-mount-9c3c337e453d@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250120-erahnen-sticken-b925f5490f46@brauner>
References: <20250120-erahnen-sticken-b925f5490f46@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7073; i=brauner@kernel.org; h=from:subject:message-id; bh=jxBHHz5k43CrP4mrUh7VNmmhVx97L7CHCXcgWPqCJI0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT3OTJ9E/7c3m344F3HuV/5yyQrt8nqfTX+c+JI+P9gX wHNZwwzOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi3cjIMEGd5+jh9+1fLVnZ WI/bJxy/2GO6Z7o+z99lWdZvvswuDmD4X95R6MyqvmTvvqlMFoz3nr+Vb1l254x6ctPSkmChK2f n8AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This is v2 of the vfs mount pull request to fix build warnings in the
newly added sample userspace programs, i.e., not in actual kernel code.
Still, it was unfortunately not noticed right away.

/* Summary */

This contains mount update for this cycle:

- Add a mountinfo program to demonstrate statmount()/listmount()

  Add a new "mountinfo" sample userland program that demonstrates how to
  use statmount() and listmount() to get at the same info that
  /proc/pid/mountinfo provides.

- Remove pointless nospec.h include.

- Prepend statmount.mnt_opts string with security_sb_mnt_opts()

  Currently these mount options aren't accessible via statmount().

- Add new mount namespaces to mount namespace rbtree outside of the
  namespace semaphore.

- Lockless mount namespace lookup

  Currently we take the read lock when looking for a mount namespace to
  list mounts in. We can make this lockless. The simple search case can
  just use a sequence counter to detect concurrent changes to the
  rbtree.

  For walking the list of mount namespaces sequentially via nsfs we keep
  a separate rcu list as rb_prev() and rb_next() aren't usable safely
  with rcu. Currently there is no primitive for retrieving the previous
  list member. To do this we need a new deletion primitive that doesn't
  poison the prev pointer and a corresponding retrieval helper.

  Since creating mount namespaces is a relatively rare event compared
  with querying mounts in a foreign mount namespace this is worth it.
  Once libmount and systemd pick up this mechanism to list mounts in
  foreign mount namespaces this will be used very frequently.

  - Add extended selftests for lockless mount namespace iteration.

  - Add a sample program to list all mounts on the system, i.e., in all
    mount namespaces.

- Improve mount namespace iteration performance

  Make finding the last or first mount to start iterating the mount
  namespace from an O(1) operation and add selftests for iterating the
  mount table starting from the first and last mount.

- Use an xarray for the old mount id

  While the ida does use the xarray internally we can use it explicitly
  which allows us to increment the unique mount id under the xa lock.
  This allows us to remove the atomic as we're now allocating both ids
  in one go.

- Use a shared header for vfs sample programs.

- Fix build warnings for new sample program to list all mounts.

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

This will have a merge conflict with vfs-6.14.mount pull request sent in
https://lore.kernel.org/r/20250118-vfs-pidfs-5921bfa5632a@brauner
and it can be resolved as follows:

diff --cc fs/namespace.c
index 64deda6f5b2c,371c860f49de..000000000000
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@@ -32,8 -32,6 +32,7 @@@
  #include <linux/fs_context.h>
  #include <linux/shmem_fs.h>
  #include <linux/mnt_idmapping.h>
 +#include <linux/pidfs.h>
- #include <linux/nospec.h>

  #include "pnode.h"
  #include "internal.h"

The following changes since commit 344bac8f0d73fe970cd9f5b2f132906317d29e8b:

  fs: kill MNT_ONRB (2025-01-09 16:58:50 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.mount.v2

for you to fetch changes up to 68e6b7d98bc64bbf1a54d963ca85111432f3a0b4:

  samples/vfs: fix build warnings (2025-01-20 13:14:21 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc1.mount.v2 tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc1.mount.v2

----------------------------------------------------------------
Christian Brauner (19):
      mount: remove inlude/nospec.h include
      fs: add mount namespace to rbtree late
      Merge patch series "fs: listmount()/statmount() fix and sample program"
      fs: lockless mntns rbtree lookup
      rculist: add list_bidir_{del,prev}_rcu()
      fs: lockless mntns lookup for nsfs
      fs: simplify rwlock to spinlock
      seltests: move nsfs into filesystems subfolder
      selftests: add tests for mntns iteration
      selftests: remove unneeded include
      samples: add test-list-all-mounts
      Merge patch series "fs: lockless mntns lookup"
      fs: cache first and last mount
      selftests: add listmount() iteration tests
      Merge patch series "fs: tweak mntns iteration"
      fs: use xarray for old mount id
      fs: remove useless lockdep assertion
      samples/vfs: use shared header
      samples/vfs: fix build warnings

Geert Uytterhoeven (1):
      samples/vfs/mountinfo: Use __u64 instead of uint64_t

Jeff Layton (2):
      samples: add a mountinfo program to demonstrate statmount()/listmount()
      fs: prepend statmount.mnt_opts string with security_sb_mnt_opts()

 fs/mount.h                                         |  31 ++-
 fs/namespace.c                                     | 200 +++++++++------
 fs/nsfs.c                                          |   5 +-
 include/linux/rculist.h                            |  44 ++++
 samples/vfs/.gitignore                             |   2 +
 samples/vfs/Makefile                               |   2 +-
 samples/vfs/mountinfo.c                            | 274 +++++++++++++++++++++
 samples/vfs/samples-vfs.h                          | 241 ++++++++++++++++++
 samples/vfs/test-list-all-mounts.c                 | 150 +++++++++++
 .../selftests/{ => filesystems}/nsfs/.gitignore    |   1 +
 .../selftests/{ => filesystems}/nsfs/Makefile      |   4 +-
 .../selftests/{ => filesystems}/nsfs/config        |   0
 .../selftests/filesystems/nsfs/iterate_mntns.c     | 149 +++++++++++
 .../selftests/{ => filesystems}/nsfs/owner.c       |   0
 .../selftests/{ => filesystems}/nsfs/pidns.c       |   0
 .../selftests/filesystems/statmount/Makefile       |   2 +-
 .../filesystems/statmount/listmount_test.c         |  66 +++++
 tools/testing/selftests/pidfd/pidfd.h              |   1 -
 18 files changed, 1075 insertions(+), 97 deletions(-)
 create mode 100644 samples/vfs/mountinfo.c
 create mode 100644 samples/vfs/samples-vfs.h
 create mode 100644 samples/vfs/test-list-all-mounts.c
 rename tools/testing/selftests/{ => filesystems}/nsfs/.gitignore (78%)
 rename tools/testing/selftests/{ => filesystems}/nsfs/Makefile (50%)
 rename tools/testing/selftests/{ => filesystems}/nsfs/config (100%)
 create mode 100644 tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
 rename tools/testing/selftests/{ => filesystems}/nsfs/owner.c (100%)
 rename tools/testing/selftests/{ => filesystems}/nsfs/pidns.c (100%)
 create mode 100644 tools/testing/selftests/filesystems/statmount/listmount_test.c

