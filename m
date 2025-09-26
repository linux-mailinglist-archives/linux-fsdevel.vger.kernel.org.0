Return-Path: <linux-fsdevel+bounces-62887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72672BA41B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D96C3BBA92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829F22192EA;
	Fri, 26 Sep 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUBy3sGv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FD215F5C;
	Fri, 26 Sep 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896357; cv=none; b=NVyEY3uiIKn3Q4++b2JvHwnwZ6aPLOIwoC0lZdMwlwcbKkSrEGBvEb/4cKSj7OSI+AkyaTUkFKgaYX6d8WFW3WFur4ZFxhKDXKwo1fEyXQrRTV0R11I7/LzWC+UZc7TleZU6uZlECTl9mLEJQLpykxUjXEHsZvSnhcDNnufETHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896357; c=relaxed/simple;
	bh=Y3L3SliP2J1hOEX1EQMNQaidnIJQIhq3emoAtln3ojQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F21BJbolt5tIk85bRyaE93BsVvMlDb/K2kS7NpEOmij/LtOoNVmv3J+N/+zQTXRwj4ne/4Pw91lkA3INMCArZRnnlq6t59XQGY8lmu8w27EntEObHfypvoFx2+0pfWDj7SU4UZWE9fG0O7Qwq1FZVs9+9FSW0DuNEtW2FcsTZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUBy3sGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D177C116B1;
	Fri, 26 Sep 2025 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896356;
	bh=Y3L3SliP2J1hOEX1EQMNQaidnIJQIhq3emoAtln3ojQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUBy3sGvt9QGU2ElB4Z6JESmRXdEUUCF0sAQS8KsaqQHtVi7pVvR7VOiuC/SMCzT5
	 l8b0apN6pfUYhY/RPWsYXT1Cf9pyJouAasaNhX4el6c1lafvvBtquBtVrwltj5mik0
	 Q/bSQ7ueXTegcTpw7kWkqCu1m5pk6phkToav5Rc/ZruJEz1zJzfzthZtqx4wMsWPhY
	 reOnpcI9wy2Q1fEK4q2u4cMBR6PDGSQ7nsBXf4m+z+vughWpG0ulmYD3GeuLRBQB82
	 /ynsmg9YqP+5ogpELAYGiMV4hkbHWqGFpkTP0lWTR5SYja1JEDbVZrlTH2sVeAPbda
	 ih9oWo62gHQaA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 08/12 for v6.18] core kernel
Date: Fri, 26 Sep 2025 16:19:02 +0200
Message-ID: <20250926-vfs-core-kernel-eab0f97f9342@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4801; i=brauner@kernel.org; h=from:subject:message-id; bh=Y3L3SliP2J1hOEX1EQMNQaidnIJQIhq3emoAtln3ojQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3ChQzv/uMXxcKcSEUHVh/t5/DM1vAX2tn054ZGVF XNpw/P/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN528nIsOC89o+5a4s7Sma/ Pcyz+b3rEuusKwzcOZFSNS+Za1oSpBn+R+Q679mz/OhW/rrHnG8/bekKLmjtmcv8W1IzpayJtSC JBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Testing */
This contains the changes to enable support for clone3() on nios2 which
apparently is still a thing. The more exciting part of this is that it
cleans up the inconsistency in how the 64-bit flag argument is passed
from copy_process() into the various other copy_*() helpers.

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.18-rc1.clone3

for you to fetch changes up to 76cea30ad520238160bf8f5e2f2803fcd7a08d22:

  Merge patch series "nios2: Add architecture support for clone3" (2025-09-01 15:31:40 +0200)

Please consider pulling these changes from the signed kernel-6.18-rc1.clone3 tag.

Thanks!
Christian

----------------------------------------------------------------
kernel-6.18-rc1.clone3

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "nios2: Add architecture support for clone3"

Simon Schuster (4):
      copy_sighand: Handle architectures where sizeof(unsigned long) < sizeof(u64)
      copy_process: pass clone_flags as u64 across calltree
      arch: copy_thread: pass clone_flags as u64
      nios2: implement architecture-specific portion of sys_clone3

 arch/alpha/kernel/process.c       |  2 +-
 arch/arc/kernel/process.c         |  2 +-
 arch/arm/kernel/process.c         |  2 +-
 arch/arm64/kernel/process.c       |  2 +-
 arch/csky/kernel/process.c        |  2 +-
 arch/hexagon/kernel/process.c     |  2 +-
 arch/loongarch/kernel/process.c   |  2 +-
 arch/m68k/kernel/process.c        |  2 +-
 arch/microblaze/kernel/process.c  |  2 +-
 arch/mips/kernel/process.c        |  2 +-
 arch/nios2/include/asm/syscalls.h |  1 +
 arch/nios2/include/asm/unistd.h   |  2 --
 arch/nios2/kernel/entry.S         |  6 ++++++
 arch/nios2/kernel/process.c       |  2 +-
 arch/nios2/kernel/syscall_table.c |  1 +
 arch/openrisc/kernel/process.c    |  2 +-
 arch/parisc/kernel/process.c      |  2 +-
 arch/powerpc/kernel/process.c     |  2 +-
 arch/riscv/kernel/process.c       |  2 +-
 arch/s390/kernel/process.c        |  2 +-
 arch/sh/kernel/process_32.c       |  2 +-
 arch/sparc/kernel/process_32.c    |  2 +-
 arch/sparc/kernel/process_64.c    |  2 +-
 arch/um/kernel/process.c          |  2 +-
 arch/x86/include/asm/fpu/sched.h  |  2 +-
 arch/x86/include/asm/shstk.h      |  4 ++--
 arch/x86/kernel/fpu/core.c        |  2 +-
 arch/x86/kernel/process.c         |  2 +-
 arch/x86/kernel/shstk.c           |  2 +-
 arch/xtensa/kernel/process.c      |  2 +-
 block/blk-ioc.c                   |  2 +-
 fs/namespace.c                    |  2 +-
 include/linux/cgroup.h            |  4 ++--
 include/linux/cred.h              |  2 +-
 include/linux/iocontext.h         |  6 +++---
 include/linux/ipc_namespace.h     |  4 ++--
 include/linux/lsm_hook_defs.h     |  2 +-
 include/linux/mnt_namespace.h     |  2 +-
 include/linux/nsproxy.h           |  2 +-
 include/linux/pid_namespace.h     |  4 ++--
 include/linux/rseq.h              |  4 ++--
 include/linux/sched/task.h        |  2 +-
 include/linux/security.h          |  4 ++--
 include/linux/sem.h               |  4 ++--
 include/linux/time_namespace.h    |  4 ++--
 include/linux/uprobes.h           |  4 ++--
 include/linux/user_events.h       |  4 ++--
 include/linux/utsname.h           |  4 ++--
 include/net/net_namespace.h       |  4 ++--
 include/trace/events/task.h       |  6 +++---
 ipc/namespace.c                   |  2 +-
 ipc/sem.c                         |  2 +-
 kernel/cgroup/namespace.c         |  2 +-
 kernel/cred.c                     |  2 +-
 kernel/events/uprobes.c           |  2 +-
 kernel/fork.c                     | 10 +++++-----
 kernel/nsproxy.c                  |  4 ++--
 kernel/pid_namespace.c            |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/fair.c               |  2 +-
 kernel/sched/sched.h              |  4 ++--
 kernel/time/namespace.c           |  2 +-
 kernel/utsname.c                  |  2 +-
 net/core/net_namespace.c          |  2 +-
 security/apparmor/lsm.c           |  2 +-
 security/security.c               |  2 +-
 security/selinux/hooks.c          |  2 +-
 security/tomoyo/tomoyo.c          |  2 +-
 68 files changed, 95 insertions(+), 89 deletions(-)

