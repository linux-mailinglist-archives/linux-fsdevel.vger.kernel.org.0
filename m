Return-Path: <linux-fsdevel+bounces-70154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77876C92A07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D9E3AB647
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99EF2D594B;
	Fri, 28 Nov 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poLHR2oS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74D2D3A6A;
	Fri, 28 Nov 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348678; cv=none; b=kHNBmqD58aUzSIFaKDlZrSwe2iSEq3uaIJpUjUETI1fTe07hx4ki9dFnmwtBM4TvWWGG4/sioGCDfpAz5msL3bC5yVhOWdnvAu9xuRlRBPWMnmupFP5ft3dSPvO9b7FujhPYjwXAqM6HotqgL0kUola2W+10KaiuSr4rRrCcXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348678; c=relaxed/simple;
	bh=TMbr815QBI4pCiLyonIbVKH24cnkzcNJh4bpQgUMUZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC/fdfsST8veZc64AtYQncEDjR85iPTdxbDIWcZFj58obU/B6JhM9/uTTskMJcL2Qh2B9ko+blz4rG4G1l9NYQrlkhH3W7PJR6O/P8QU5GZHWJ/kKUNoAw+jTadOCNaYp18fXwM2e02uK28EHCzj2XVie8jdDr4abH3tUvFAU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poLHR2oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01966C116B1;
	Fri, 28 Nov 2025 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348678;
	bh=TMbr815QBI4pCiLyonIbVKH24cnkzcNJh4bpQgUMUZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poLHR2oST6cJoDiHn24qmcvg0oelGEJaJA2Mo9GxC2Nki+f/Ob2RlPYd7zKYJfplX
	 MglRMF0KMpMJ3OLOoAQF0z8jz75vijiUlXb86DZTXqYHV1aKH8vEDPwr/wP7XEqhsh
	 /PNGmLxdx+ZGDQwrpmzaj8tnG0rqO3sQRvy+aTssyUeyd6paWGN8s1Zxn4ahC6STVK
	 vCcdUNo7U7uIDjB21GXlCgAK+UB3aZAx14yz6P/b++EqhwO71P2GvnrBBnRt4v4lf5
	 uugfbbXgtgHUDJKSl1GLBvJZ0kqS+ADjhW+UN2pdMD2dYjqDLQLLiIjR9P0loEAfMr
	 sDz0TKzAJz1Cw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 05/17 for v6.19] namespaces
Date: Fri, 28 Nov 2025 17:48:16 +0100
Message-ID: <20251128-kernel-namespaces-v619-28629f3fc911@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19084; i=brauner@kernel.org; h=from:subject:message-id; bh=TMbr815QBI4pCiLyonIbVKH24cnkzcNJh4bpQgUMUZs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnq05Ou/9slz7M6eMLZbMMflq2cPq3s71yr2o/0rN 3wxub8kv6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAit/cx/DPI4G3l0jh74EMz 06Qbzp9dPkx4V/JqP0/Z6wN/2DzXpy5h+O+iof+mq4BnxZ55K3/0n9t9uPnrYtkezUzVa/8iP8v 7dTIAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains substantial namespace infrastructure changes including a new
system call, active reference counting, and extensive header cleanups.
The branch depends on the shared kbuild branch for -fms-extensions support.

Features

- listns() System Call

  Add a new listns() system call that allows userspace to iterate through
  namespaces in the system. This provides a programmatic interface to
  discover and inspect namespaces, addressing longstanding limitations:

  Currently, there is no direct way for userspace to enumerate namespaces.
  Applications must resort to scanning /proc//ns/ across all processes,
  which is:

  1. Inefficient - requires iterating over all processes
  2. Incomplete - misses namespaces not attached to any running process but
     kept alive by file descriptors, bind mounts, or parent references
  3. Permission-heavy - requires access to /proc for many processes
  4. No ordering or ownership information
  5. No filtering per namespace type

  The listns() system call solves these problems:

  ssize_t listns(const struct ns_id_req *req, u64 *ns_ids,
                 size_t nr_ns_ids, unsigned int flags);

  struct ns_id_req {
          __u32 size;
          __u32 spare;
          __u64 ns_id;
          struct /* listns */ {
                  __u32 ns_type;
                  __u32 spare2;
                  __u64 user_ns_id;
          };
  };

  Features include:

  - Pagination support for large namespace sets

  - Filtering by namespace type (MNT_NS, NET_NS, USER_NS, etc.)

  - Filtering by owning user namespace

  - Permission checks respecting namespace isolation

- Active Reference Counting

  Introduce an active reference count that tracks namespace visibility to
  userspace. A namespace is visible in the following cases:

  1. The namespace is in use by a task
  2. The namespace is persisted through a VFS object (namespace file
     descriptor or bind-mount)
  3. The namespace is a hierarchical type and is the parent of child
     namespaces

  The active reference count does not regulate lifetime (that's still done
  by the normal reference count) - it only regulates visibility to namespace
  file handles and listns().

  This prevents resurrection of namespaces that are pinned only for internal
  kernel reasons (e.g., user namespaces held by file->f_cred, lazy TLB
  references on idle CPUs, etc.) which should not be accessible via (1)-(3).

- Unified Namespace Tree

  Introduce a unified tree structure for all namespaces with:

  - Fixed IDs assigned to initial namespaces

  - Lookup based solely on inode number

  - Maintained list of owned namespaces per user namespace

  - Simplified rbtree comparison helpers

Cleanups

- Header Reorganization

  - Move namespace types into separate header (ns_common_types.h)

  - Decouple nstree from ns_common header

  - Move nstree types into separate header

  - Switch to new ns_tree_{node,root} structures with helper functions

  - Use guards for ns_tree_lock

- Initial Namespace Reference Count Optimization

  - Make all reference counts on initial namespaces a nop to avoid
    pointless cacheline ping-pong for namespaces that can never go away

  - Drop custom reference count initialization for initial namespaces

  - Add NS_COMMON_INIT() macro and use it for all namespaces

  - pid: rely on common reference count behavior

- Miscellaneous Cleanups

  - Rename exit_task_namespaces() to exit_nsproxy_namespaces()

  - Rename is_initial_namespace() and make argument const

  - Use boolean to indicate anonymous mount namespace

  - Simplify owner list iteration in nstree

  - nsfs: raise SB_I_NODEV, SB_I_NOEXEC, and DCACHE_DONTCACHE explicitly

  - nsfs: use inode_just_drop()

  - pidfs: raise DCACHE_DONTCACHE explicitly

  - pidfs: simplify PIDFD_GET__NAMESPACE ioctls

  - libfs: allow to specify s_d_flags

  - cgroup: add cgroup namespace to tree after owner is set

  - nsproxy: fix free_nsproxy() and simplify create_new_namespaces()

Fixes

- setns(pidfd, ...) Race Condition

  Fix a subtle race when using pidfds with setns(). When the target task
  exits after prepare_nsset() but before commit_nsset(), the namespace's
  active reference count might have been dropped. If setns() then installs
  the namespaces, it would bump the active reference count from zero without
  taking the required reference on the owner namespace, leading to underflow
  when later decremented.

  The fix resurrects the ownership chain if necessary - if the caller
  succeeded in grabbing passive references, the setns() should succeed even
  if the target task exits or gets reaped.

- Return EFAULT on put_user() error instead of success

- Make sure references are dropped outside of RCU lock (some namespaces
  like mount namespace sleep when putting the last reference)

- Don't skip active reference count initialization for network namespace

- Add asserts for active refcount underflow

- Add asserts for initial namespace reference counts (both passive and
  active)

- ipc: enable is_ns_init_id() assertions

- Fix kernel-doc comments for internal nstree functions

- Selftests

  - 15 active reference count tests

  - 9 listns() functionality tests

  - 7 listns() permission tests

  - 12 inactive namespace resurrection tests

  - 3 threaded active reference count tests

  - commit_creds() active reference tests

  - Pagination and stress tests

  - EFAULT handling test

  - nsid tests fixes

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

diff --cc fs/namespace.c
index a7fd9682bcf9,25289b869be1..000000000000
--- a/fs/namespace.c
+++ b/fs/namespace.c

Merge conflicts with other trees
================================

[1] https://lore.kernel.org/linux-next/20251118110822.72e36c15@canb.auug.org.au

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/namespace-6.19-rc1

for you to fetch changes up to a71e4f103aed69e7a11ea913312726bb194c76ee:

  pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls (2025-11-17 16:23:13 +0100)

Please consider pulling these changes from the signed namespace-6.19-rc1 tag.

Thanks!
Christian

----------------------------------------------------------------
namespace-6.19-rc1

----------------------------------------------------------------
Christian Brauner (107):
      libfs: allow to specify s_d_flags
      nsfs: use inode_just_drop()
      nsfs: raise DCACHE_DONTCACHE explicitly
      pidfs: raise DCACHE_DONTCACHE explicitly
      nsfs: raise SB_I_NODEV and SB_I_NOEXEC
      cgroup: add cgroup namespace to tree after owner is set
      nstree: simplify return
      ns: add missing authorship
      ns: add NS_COMMON_INIT()
      ns: use NS_COMMON_INIT() for all namespaces
      ns: initialize ns_list_node for initial namespaces
      ns: add __ns_ref_read()
      ns: rename to exit_nsproxy_namespaces()
      ns: add active reference count
      ns: use anonymous struct to group list member
      nstree: introduce a unified tree
      nstree: allow lookup solely based on inode
      nstree: assign fixed ids to the initial namespaces
      nstree: maintain list of owned namespaces
      nstree: simplify rbtree comparison helpers
      nstree: add unified namespace list
      nstree: add listns()
      arch: hookup listns() system call
      nsfs: update tools header
      selftests/filesystems: remove CLONE_NEWPIDNS from setup_userns() helper
      selftests/namespaces: first active reference count tests
      selftests/namespaces: second active reference count tests
      selftests/namespaces: third active reference count tests
      selftests/namespaces: fourth active reference count tests
      selftests/namespaces: fifth active reference count tests
      selftests/namespaces: sixth active reference count tests
      selftests/namespaces: seventh active reference count tests
      selftests/namespaces: eigth active reference count tests
      selftests/namespaces: ninth active reference count tests
      selftests/namespaces: tenth active reference count tests
      selftests/namespaces: eleventh active reference count tests
      selftests/namespaces: twelth active reference count tests
      selftests/namespaces: thirteenth active reference count tests
      selftests/namespaces: fourteenth active reference count tests
      selftests/namespaces: fifteenth active reference count tests
      selftests/namespaces: add listns() wrapper
      selftests/namespaces: first listns() test
      selftests/namespaces: second listns() test
      selftests/namespaces: third listns() test
      selftests/namespaces: fourth listns() test
      selftests/namespaces: fifth listns() test
      selftests/namespaces: sixth listns() test
      selftests/namespaces: seventh listns() test
      selftests/namespaces: eigth listns() test
      selftests/namespaces: ninth listns() test
      selftests/namespaces: first listns() permission test
      selftests/namespaces: second listns() permission test
      selftests/namespaces: third listns() permission test
      selftests/namespaces: fourth listns() permission test
      selftests/namespaces: fifth listns() permission test
      selftests/namespaces: sixth listns() permission test
      selftests/namespaces: seventh listns() permission test
      selftests/namespaces: first inactive namespace resurrection test
      selftests/namespaces: second inactive namespace resurrection test
      selftests/namespaces: third inactive namespace resurrection test
      selftests/namespaces: fourth inactive namespace resurrection test
      selftests/namespaces: fifth inactive namespace resurrection test
      selftests/namespaces: sixth inactive namespace resurrection test
      selftests/namespaces: seventh inactive namespace resurrection test
      selftests/namespaces: eigth inactive namespace resurrection test
      selftests/namespaces: ninth inactive namespace resurrection test
      selftests/namespaces: tenth inactive namespace resurrection test
      selftests/namespaces: eleventh inactive namespace resurrection test
      selftests/namespaces: twelth inactive namespace resurrection test
      selftests/namespace: first threaded active reference count test
      selftests/namespace: second threaded active reference count test
      selftests/namespace: third threaded active reference count test
      selftests/namespace: commit_creds() active reference tests
      selftests/namespace: add stress test
      selftests/namespace: test listns() pagination
      Merge patch series "nstree: listns()"
      ns: don't skip active reference count initialization
      ns: don't increment or decrement initial namespaces
      ns: make sure reference are dropped outside of rcu lock
      ns: return EFAULT on put_user() error
      ns: handle setns(pidfd, ...) cleanly
      ns: add asserts for active refcount underflow
      selftests/namespaces: add active reference count regression test
      Merge patch "kbuild: Add '-fms-extensions' to areas with dedicated CFLAGS"
      selftests/namespaces: test for efault
      Merge patch series "ns: fixes for namespace iteration and active reference counting"
      Merge branch 'kbuild-6.19.fms.extension'
      ns: move namespace types into separate header
      nstree: decouple from ns_common header
      nstree: move nstree types into separate header
      nstree: add helper to operate on struct ns_tree_{node,root}
      nstree: switch to new structures
      nstree: simplify owner list iteration
      nstree: use guards for ns_tree_lock
      ns: make is_initial_namespace() argument const
      ns: rename is_initial_namespace()
      fs: use boolean to indicate anonymous mount namespace
      ipc: enable is_ns_init_id() assertions
      ns: make all reference counts on initial namespace a nop
      ns: add asserts for initial namespace reference counts
      ns: add asserts for initial namespace active reference counts
      pid: rely on common reference count behavior
      ns: drop custom reference count initialization for initial namespaces
      selftests/namespaces: fix nsid tests
      Merge patch series "ns: header cleanups and initial namespace reference count improvements"
      nsproxy: fix free_nsproxy() and simplify create_new_namespaces()
      pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls

Kriish Sharma (1):
      nstree: fix kernel-doc comments for internal functions

Nathan Chancellor (2):
      jfs: Rename _inline to avoid conflict with clang's '-fms-extensions'
      kbuild: Add '-fms-extensions' to areas with dedicated CFLAGS

Rasmus Villemoes (1):
      Kbuild: enable -fms-extensions

 Makefile                                           |    3 +
 arch/alpha/kernel/syscalls/syscall.tbl             |    1 +
 arch/arm/tools/syscall.tbl                         |    1 +
 arch/arm64/kernel/vdso32/Makefile                  |    3 +-
 arch/arm64/tools/syscall_32.tbl                    |    1 +
 arch/loongarch/vdso/Makefile                       |    2 +-
 arch/m68k/kernel/syscalls/syscall.tbl              |    1 +
 arch/microblaze/kernel/syscalls/syscall.tbl        |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl          |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    1 +
 arch/parisc/boot/compressed/Makefile               |    2 +-
 arch/parisc/kernel/syscalls/syscall.tbl            |    1 +
 arch/powerpc/boot/Makefile                         |    3 +-
 arch/powerpc/kernel/syscalls/syscall.tbl           |    1 +
 arch/s390/Makefile                                 |    3 +-
 arch/s390/kernel/syscalls/syscall.tbl              |    1 +
 arch/s390/purgatory/Makefile                       |    3 +-
 arch/sh/kernel/syscalls/syscall.tbl                |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl             |    1 +
 arch/x86/Makefile                                  |    4 +-
 arch/x86/boot/compressed/Makefile                  |    7 +-
 arch/x86/entry/syscalls/syscall_32.tbl             |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl            |    1 +
 drivers/firmware/efi/libstub/Makefile              |    4 +-
 fs/jfs/jfs_incore.h                                |    6 +-
 fs/libfs.c                                         |    1 +
 fs/mount.h                                         |    3 +-
 fs/namespace.c                                     |   12 +-
 fs/nsfs.c                                          |  101 +-
 fs/pidfs.c                                         |   76 +-
 include/linux/ns/ns_common_types.h                 |  196 ++
 include/linux/ns/nstree_types.h                    |   55 +
 include/linux/ns_common.h                          |  233 +-
 include/linux/nsfs.h                               |    3 +
 include/linux/nsproxy.h                            |    9 +-
 include/linux/nstree.h                             |   52 +-
 include/linux/pid_namespace.h                      |    3 +-
 include/linux/pseudo_fs.h                          |    1 +
 include/linux/syscalls.h                           |    4 +
 include/linux/user_namespace.h                     |    4 +-
 include/uapi/asm-generic/unistd.h                  |    4 +-
 include/uapi/linux/nsfs.h                          |   58 +
 init/version-timestamp.c                           |    7 +-
 ipc/msgutil.c                                      |    7 +-
 ipc/namespace.c                                    |    3 +-
 kernel/cgroup/cgroup.c                             |   11 +-
 kernel/cgroup/namespace.c                          |    2 +-
 kernel/cred.c                                      |    6 +
 kernel/exit.c                                      |    3 +-
 kernel/fork.c                                      |    3 +-
 kernel/nscommon.c                                  |  246 +-
 kernel/nsproxy.c                                   |   57 +-
 kernel/nstree.c                                    |  782 +++++-
 kernel/pid.c                                       |   12 +-
 kernel/pid_namespace.c                             |    2 +-
 kernel/time/namespace.c                            |    5 +-
 kernel/user.c                                      |    7 +-
 net/core/net_namespace.c                           |    2 +-
 scripts/Makefile.extrawarn                         |    4 +-
 scripts/syscall.tbl                                |    1 +
 tools/include/uapi/linux/nsfs.h                    |   70 +
 tools/testing/selftests/filesystems/utils.c        |    2 +-
 tools/testing/selftests/namespaces/.gitignore      |    9 +
 tools/testing/selftests/namespaces/Makefile        |   24 +-
 .../selftests/namespaces/cred_change_test.c        |  814 ++++++
 .../selftests/namespaces/listns_efault_test.c      |  530 ++++
 .../selftests/namespaces/listns_pagination_bug.c   |  138 +
 .../selftests/namespaces/listns_permissions_test.c |  759 ++++++
 tools/testing/selftests/namespaces/listns_test.c   |  679 +++++
 .../selftests/namespaces/ns_active_ref_test.c      | 2672 ++++++++++++++++++++
 tools/testing/selftests/namespaces/nsid_test.c     |  107 +-
 .../namespaces/regression_pidfd_setns_test.c       |  113 +
 .../testing/selftests/namespaces/siocgskns_test.c  | 1824 +++++++++++++
 tools/testing/selftests/namespaces/stress_test.c   |  626 +++++
 tools/testing/selftests/namespaces/wrappers.h      |   35 +
 77 files changed, 9997 insertions(+), 436 deletions(-)
 create mode 100644 include/linux/ns/ns_common_types.h
 create mode 100644 include/linux/ns/nstree_types.h
 create mode 100644 tools/testing/selftests/namespaces/cred_change_test.c
 create mode 100644 tools/testing/selftests/namespaces/listns_efault_test.c
 create mode 100644 tools/testing/selftests/namespaces/listns_pagination_bug.c
 create mode 100644 tools/testing/selftests/namespaces/listns_permissions_test.c
 create mode 100644 tools/testing/selftests/namespaces/listns_test.c
 create mode 100644 tools/testing/selftests/namespaces/ns_active_ref_test.c
 create mode 100644 tools/testing/selftests/namespaces/regression_pidfd_setns_test.c
 create mode 100644 tools/testing/selftests/namespaces/siocgskns_test.c
 create mode 100644 tools/testing/selftests/namespaces/stress_test.c
 create mode 100644 tools/testing/selftests/namespaces/wrappers.h

