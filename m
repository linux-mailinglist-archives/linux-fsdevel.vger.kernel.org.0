Return-Path: <linux-fsdevel+bounces-44764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E73A6C8FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7211D3B726F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364B1F4E59;
	Sat, 22 Mar 2025 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i77fH80k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F51F03F0;
	Sat, 22 Mar 2025 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638427; cv=none; b=mEPrR4gsC6IrruHi3eqGBQDSxbD7OXJoulJ9nezdy67Gq/C9ch+2qcelrITbBYwWsuedIjuu+B3ZDVbdJN2z6WVVQUg8YAZ7ze6g7qm3I0hqqIZvWnY1g/R8QDqMdTzFzgVvpCuFhvis1AJzP0btSCc3uToyRwgu9vTGpSD2aTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638427; c=relaxed/simple;
	bh=Vz2jTopUYHoJt4MK27LQmSfFRQaUIZUZJM45kRAzQ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csgOMNHnqiQEg/XxJZNIOrSrhA6Y4v/8mEh6eCYfKuLB5To7DWEENrzad5/TxALBm28tv8V8fWH2sRx1X5r3NwhuWxX2cFxif+xxlDLnh0WoSgSJuUMtL40DTXvObMepGKMoGX2mNCJG3XZH4i4XXCLMiFP8yjGb6Y1NsWOoHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i77fH80k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05846C4CEDD;
	Sat, 22 Mar 2025 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638427;
	bh=Vz2jTopUYHoJt4MK27LQmSfFRQaUIZUZJM45kRAzQ/I=;
	h=From:To:Cc:Subject:Date:From;
	b=i77fH80kYWmT6OGLFjW+/YTeLOqP17RrNmhGLv4JlGW+HyHVJMZYcEDpGkEN6CW7S
	 zzu4gwVQM2uJdmOFXPZji28rfVRpuoJDS2XKLcWO4GFlMcVJuXS/S3zlLTQxxQT3b1
	 zICdWlnuFB3NfSV5+JtCQSlKo5mgWooAIDgLNJ9T3EtXYMzGRsUiQoU5bFDG42Netx
	 hdYEbf3Uu7ZF6zKmlI/phe399OhrA9lh4gOyaZOgXzEdC9o6LP9RVJXB4CroNJ0fLo
	 1NPJdwM6Eky3jXgXF3D/V+MrMacCpNh90MfQmr2xfoo7C/BYoHKUIupu6nQNJMBUqz
	 L9aCfF8qKxl2A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs pidfs
Date: Sat, 22 Mar 2025 11:13:37 +0100
Message-ID: <20250322-vfs-pidfs-99964e3e4c66@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7160; i=brauner@kernel.org; h=from:subject:message-id; bh=Vz2jTopUYHoJt4MK27LQmSfFRQaUIZUZJM45kRAzQ/I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf6w3JSD/LfztvB//p7xO7mxjenLlz9tOqgrXuPBs33 2AKqVPQ7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5WxGhuVebV5fFlwIrrGt 75NcfeDE8Zaa0kR7VsY35hVtft6PljMy3Fvrem7b1V9Z31slX26c80X+x5zjYvOvRWi4LLzXpP7 zPCMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains updates for pidfs:

- Allow retrieving exit information after a process has been reaped
  through pidfds via the new PIDFD_INTO_EXIT extension for the
  PIDFD_GET_INFO ioctl. Various tools need access to information about a
  process/task even after it has already been reaped.

  Pidfd polling allows waiting on either task exit or for a task to have
  been reaped. The contract for PIDFD_INFO_EXIT is simply that EPOLLHUP
  must be observed before exit information can be retrieved, i.e., exit
  information is only provided once the task has been reaped and then
  can be retrieved as long as the pidfd is open.

- Add PIDFD_SELF_{THREAD,THREAD_GROUP} sentinels allowing userspace to forgo
  allocating a file descriptor for their own process. This is useful in
  scenarios where users want to act on their own process through pidfds and is
  akin to AT_FDCWD.

- Improve premature thread-group leader and subthread exec behavior when
  polling on pidfds:

  (1) During a multi-threaded exec by a subthread, i.e., non-thread-group
      leader thread, all other threads in the thread-group including the
      thread-group leader are killed and the struct pid of the
      thread-group leader will be taken over by the subthread that called
      exec. IOW, two tasks change their TIDs.

  (2) A premature thread-group leader exit means that the thread-group
      leader exited before all of the other subthreads in the thread-group
      have exited.

  Both cases lead to inconsistencies for pidfd polling with PIDFD_THREAD.
  Any caller that holds a PIDFD_THREAD pidfd to the current thread-group
  leader may or may not see an exit notification on the file descriptor
  depending on when poll is performed. If the poll is performed before the
  exec of the subthread has concluded an exit notification is generated
  for the old thread-group leader. If the poll is performed after the exec
  of the subthread has concluded no exit notification is generated for the
  old thread-group leader.

  The correct behavior is to simply not generate an exit notification on
  the struct pid of a subhthread exec because the struct pid is taken
  over by the subthread and thus remains alive.

  But this is difficult to handle because a thread-group may exit
  premature as mentioned in (2). In that case an exit notification is
  reliably generated but the subthreads may continue to run for an
  indeterminate amount of time and thus also may exec at some point.

  After this pull no exit notifications will be generated for a
  PIDFD_THREAD pidfd for a thread-group leader until all subthreads have
  been reaped. If a subthread should exec before no exit notification
  will be generated until that task exits or it creates subthreads and
  repeates the cycle.

  This means an exit notification indicates the ability for the father
  to reap the child.

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

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.pidfs

for you to fetch changes up to d40dc30c7b7c80db2100b73ac26d39c362643a39:

  Merge patch series "pidfs: handle multi-threaded exec and premature thread-group leader exit" (2025-03-20 15:32:51 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.pidfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.pidfs

----------------------------------------------------------------
Christian Brauner (25):
      selftests/pidfd: add new PIDFD_SELF* defines
      Merge patch series "introduce PIDFD_SELF* sentinels"
      pidfs: switch to copy_struct_to_user()
      pidfd: rely on automatic cleanup in __pidfd_prepare()
      pidfs: move setting flags into pidfs_alloc_file()
      pidfs: use private inode slab cache
      pidfs: record exit code and cgroupid at exit
      pidfs: allow to retrieve exit information
      selftests/pidfd: fix header inclusion
      pidfs/selftests: ensure correct headers for ioctl handling
      selftests/pidfd: expand common pidfd header
      selftests/pidfd: add first PIDFD_INFO_EXIT selftest
      selftests/pidfd: add second PIDFD_INFO_EXIT selftest
      selftests/pidfd: add third PIDFD_INFO_EXIT selftest
      selftests/pidfd: add fourth PIDFD_INFO_EXIT selftest
      selftests/pidfd: add fifth PIDFD_INFO_EXIT selftest
      selftests/pidfd: add sixth PIDFD_INFO_EXIT selftest
      selftests/pidfd: add seventh PIDFD_INFO_EXIT selftest
      Merge patch series "pidfs: provide information after task has been reaped"
      pidfs: ensure that PIDFS_INFO_EXIT is available
      pidfs: improve multi-threaded exec and premature thread-group leader exit polling
      selftests/pidfd: first test for multi-threaded exec polling
      selftests/pidfd: second test for multi-threaded exec polling
      selftests/pidfd: third test for multi-threaded exec polling
      Merge patch series "pidfs: handle multi-threaded exec and premature thread-group leader exit"

Lorenzo Stoakes (3):
      pidfd: add PIDFD_SELF* sentinels to refer to own thread/process
      selftests/pidfd: add tests for PIDFD_SELF_*
      selftests/mm: use PIDFD_SELF in guard pages test

 fs/internal.h                                     |   1 +
 fs/libfs.c                                        |   4 +-
 fs/pidfs.c                                        | 247 +++++++-
 include/linux/pidfs.h                             |   1 +
 include/uapi/linux/pidfd.h                        |  31 +-
 kernel/exit.c                                     |   8 +-
 kernel/fork.c                                     |  22 +-
 kernel/pid.c                                      |  24 +-
 kernel/signal.c                                   | 108 ++--
 tools/testing/selftests/mm/guard-pages.c          |  16 +-
 tools/testing/selftests/pidfd/.gitignore          |   2 +
 tools/testing/selftests/pidfd/Makefile            |   4 +-
 tools/testing/selftests/pidfd/pidfd.h             | 109 ++++
 tools/testing/selftests/pidfd/pidfd_exec_helper.c |  12 +
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c |   1 +
 tools/testing/selftests/pidfd/pidfd_info_test.c   | 692 ++++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_open_test.c   |  30 +-
 tools/testing/selftests/pidfd/pidfd_setns_test.c  |  45 --
 tools/testing/selftests/pidfd/pidfd_test.c        |  76 ++-
 19 files changed, 1241 insertions(+), 192 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_exec_helper.c
 create mode 100644 tools/testing/selftests/pidfd/pidfd_info_test.c

