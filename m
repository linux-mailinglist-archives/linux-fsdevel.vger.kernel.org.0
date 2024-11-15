Return-Path: <linux-fsdevel+bounces-34911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECE9CE10C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E22B2625D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C31CDA18;
	Fri, 15 Nov 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZktOkXjr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A716BE2A;
	Fri, 15 Nov 2024 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679333; cv=none; b=rQKkllH9fv+y4LdbnHYJhNVVqlaZOBGuF4D2mwQ/AFPpxkw++YpyHLvnJCi9PQ7YApm9xauA33kUeKZll1zWb7ZZ0/vDRPx4a2To9WG2LQo3RqSqbei2YXQ6VWQN5eJFFSrg+NXsuNm21XLULRO4ijgrY2itpy0kMof5J2FJfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679333; c=relaxed/simple;
	bh=8y2DTZJKy25mhaYTt6kYcAfdNM3Tk420IrRbpKJVUsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QaE0dFeCTo7yzjuu597km4RargHOTbo1jWoQcajSyyqummrGJ5IWFa7MSQyZI2vAaycS3bV73mQBpZ45tEu+1dWRdQQz6+MQABo7z+lLjctzZYBzcjjL2fmjVHP9NbHWAxjASN1GbuOSvbkfWlSNwwjXjLdODde9yLwTqna2F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZktOkXjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4C1C4CECF;
	Fri, 15 Nov 2024 14:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679333;
	bh=8y2DTZJKy25mhaYTt6kYcAfdNM3Tk420IrRbpKJVUsk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZktOkXjr+9kAfufO7P3ICyZ0o6QrvvEWVrKpoP+nxdLpAo2/u45j3EegYPLFEiyuD
	 drVQGy2vrClwlln7MRamK+vIu2M9Qjw3buDPj58mN1iqh1KOC80E5NF7j6RFJ2EBLD
	 dZCIa+fK3OmS/Vuhk9/RxMF/M95nHII8RIQor4OmG9jjMIeIDytaldoZFjkmf///N1
	 nj4pcmCYiVdyyoqPgl4Ru8HOi9FiAjP/DWxoGQZZ1w1O1Xu1X/A5XlwKorIW1ojTyE
	 F0C6LLstqweZwrhJn+P2CbVIj0geWILrkphGNfeVYHiBrFqklQVCO0YdVE4qea97c5
	 7pHfdRngXKgvw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs file
Date: Fri, 15 Nov 2024 15:02:02 +0100
Message-ID: <20241115-vfs-file-f2297d7c58ee@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6675; i=brauner@kernel.org; h=from:subject:message-id; bh=8y2DTZJKy25mhaYTt6kYcAfdNM3Tk420IrRbpKJVUsk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbh8Td9PhqseT+szU9ylxlolJXz69e5TuJo/JL5pZJB o8Mvos3dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkTxAjw4VPS+4cFLmy+/7+ BVNl+2qnveD9fGdpywG34wLn+Aum5BxmZHjFdXrDqTi/lrV7Vl746WPA/794Y0Q/75ZVPqG+TVx zH7MDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains changes the changes for files for this cycle:

- Introduce a new reference counting mechanism for files.

  As atomic_inc_not_zero() is implemented with a try_cmpxchg() loop it
  has O(N^2) behaviour under contention with N concurrent operations and
  it is in a hot path in __fget_files_rcu().

  The rcuref infrastructures remedies this problem by using an
  unconditional increment relying on safe- and dead zones to make this
  work and requiring rcu protection for the data structure in question.
  This not just scales better it also introduces overflow protection.

  However, in contrast to generic rcuref, files require a memory barrier
  and thus cannot rely on *_relaxed() atomic operations and also require
  to be built on atomic_long_t as having massive amounts of reference
  isn't unheard of even if it is just an attack.

  This adds a file specific variant instead of making this a generic
  library.

  This has been tested by various people and it gives consistent
  improvement up to 3-5% on workloads with loads of threads.

- Add a fastpath for find_next_zero_bit(). Skip 2-levels searching via
  find_next_zero_bit() when there is a free slot in the word that contains
  the next fd. This improves pts/blogbench-1.1.0 read by 8% and write by
  4% on Intel ICX 160.

- Conditionally clear full_fds_bits since it's very likely that a bit
  in full_fds_bits has been cleared during __clear_open_fds(). This
  improves pts/blogbench-1.1.0 read up to 13%, and write up to 5% on
  Intel ICX 160.

- Get rid of all lookup_*_fdget_rcu() variants. They were used to lookup
  files without taking a reference count. That became invalid once files
  were switched to SLAB_TYPESAFE_BY_RCU and now we're always taking a
  reference count. Switch to an already existing helper and remove the
  legacy variants.

- Remove pointless includes of <linux/fdtable.h>.

- Avoid cmpxchg() in close_files() as nobody else has a reference to the
  files_struct at that point.

- Move close_range() into fs/file.c and fold __close_range() into it.

- Cleanup calling conventions of alloc_fdtable() and expand_files().

- Merge __{set,clear}_close_on_exec() into one.

- Make __set_open_fd() set cloexec as well instead of doing it
  in two separate steps.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.file

for you to fetch changes up to aab154a442f9ba2a08fc130dbc8d178a33e10345:

  selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor (2024-10-30 09:58:02 +0100)

Please consider pulling these changes from the signed vfs-6.13.file tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.file

----------------------------------------------------------------
Al Viro (8):
      get rid of ...lookup...fdget_rcu() family
      remove pointless includes of <linux/fdtable.h>
      close_files(): don't bother with xchg()
      move close_range(2) into fs/file.c, fold __close_range() into it
      alloc_fdtable(): change calling conventions.
      file.c: merge __{set,clear}_close_on_exec()
      make __set_open_fd() set cloexec state as well
      expand_files(): simplify calling conventions

Christian Brauner (6):
      fs: protect backing files with rcu
      fs: add file_ref
      fs: port files to file_ref
      Merge patch series "fs: introduce file_ref_t"
      Merge branch 'work.fdtable' into vfs.file
      selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor

Yu Ma (3):
      fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
      fs/file.c: conditionally clear full_fds
      fs/file.c: add fast path in find_next_fd()

 arch/powerpc/platforms/cell/spufs/coredump.c       |   4 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c              |   2 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c                |   2 +-
 fs/eventpoll.c                                     |   2 +-
 fs/fcntl.c                                         |   1 -
 fs/file.c                                          | 281 +++++++++++----------
 fs/file_table.c                                    |  50 +++-
 fs/gfs2/glock.c                                    |  12 +-
 fs/notify/dnotify/dnotify.c                        |   5 +-
 fs/notify/fanotify/fanotify.c                      |   1 -
 fs/notify/fanotify/fanotify_user.c                 |   1 -
 fs/open.c                                          |  17 --
 fs/overlayfs/copy_up.c                             |   1 -
 fs/proc/base.c                                     |   1 -
 fs/proc/fd.c                                       |  12 +-
 include/linux/fdtable.h                            |   5 -
 include/linux/file.h                               |   1 +
 include/linux/file_ref.h                           | 177 +++++++++++++
 include/linux/fs.h                                 |  10 +-
 io_uring/io_uring.c                                |   1 -
 kernel/bpf/bpf_inode_storage.c                     |   1 -
 kernel/bpf/bpf_task_storage.c                      |   1 -
 kernel/bpf/task_iter.c                             |   6 +-
 kernel/bpf/token.c                                 |   1 -
 kernel/exit.c                                      |   1 -
 kernel/kcmp.c                                      |   4 +-
 kernel/module/dups.c                               |   1 -
 kernel/module/kmod.c                               |   1 -
 kernel/umh.c                                       |   1 -
 net/handshake/request.c                            |   1 -
 security/apparmor/domain.c                         |   1 -
 tools/testing/selftests/filesystems/.gitignore     |   1 +
 tools/testing/selftests/filesystems/Makefile       |   2 +-
 .../testing/selftests/filesystems/file_stressor.c  | 194 ++++++++++++++
 34 files changed, 576 insertions(+), 226 deletions(-)
 create mode 100644 include/linux/file_ref.h
 create mode 100644 tools/testing/selftests/filesystems/file_stressor.c

