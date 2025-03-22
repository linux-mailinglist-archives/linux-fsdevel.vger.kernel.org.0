Return-Path: <linux-fsdevel+bounces-44776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B91E8A6C91E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADE0189F523
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7D1F7902;
	Sat, 22 Mar 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVwObaEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365F1EB5F7;
	Sat, 22 Mar 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638590; cv=none; b=OB9wwtl0Tt0Vjoav9xfkV1C4vmJDd9n2WUPJak7dr3n14frX0jUPr8avec1yxm09yJkj4kim70a/ACo0iPJnLYkPql1qYxxVd4qZSubPMvv47xl+JFeXqYcCv7Nwi0TslClywSEpVMiNn2YZPXElBQxZZywD8PUOdjArGUvYBBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638590; c=relaxed/simple;
	bh=UF9g7sS9/CgDxtCNh4ZKqcIRf/hR71CyTpkw6RA0YaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6xEu+0YDpctqmv9WJnDtxtjq0+ZTBoBaesIWatNvh3tERtA5m9lxS3zYj0nYw784OGC7aP47J2dYWQiUgpc49sAMVGz/VRx9G8bdg/aHvkqj2cpemwKJ9ZQGaNzFE7uPI4OJj3l1LlKHXT/eqOlbMR/nS8rramsVfWrom1mSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVwObaEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61687C4CEDD;
	Sat, 22 Mar 2025 10:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742638589;
	bh=UF9g7sS9/CgDxtCNh4ZKqcIRf/hR71CyTpkw6RA0YaM=;
	h=From:To:Cc:Subject:Date:From;
	b=SVwObaEvc8l93/DPUF3EWY5nWy6n0+1KSMCtbiJdsMe4T5M5Mte5f1/R/vQpd78kX
	 gsx9+JoLixhjk5heADW8C6KydHDhP6+1CqOQujM/beGEQYUXcILiuojlcbLQB9Wcuq
	 OELVt5GUkr8eSIYCPpXijt7p+SdDA0Pn68lF8JOsmCKk2ezxC2shfWnsieOAjUwUiT
	 MGtIBVkpSKbibroxMQrQRbPoSMWsGG6aGIipr4QI+st7vyiQ2OEn5l89jUZphz0W9V
	 OTHBZ33oN91cU6rEzWoJ7JXNetC32CotFJ6tYpfpuz0qrc9SJOsI511sOS4d4OsyST
	 VrWb/TnIo4Z/A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs namespace
Date: Sat, 22 Mar 2025 11:16:21 +0100
Message-ID: <20250322-vfs-namespace-09ebc48e2c4c@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13985; i=brauner@kernel.org; h=from:subject:message-id; bh=UF9g7sS9/CgDxtCNh4ZKqcIRf/hR71CyTpkw6RA0YaM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf6/2WpbjkhuZWg4J99/fc5jLSE9zSy69x9/kDlgMRN TNLNsRrd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE6yzDP9v196/2d3YLhzWF LP1qff5Pqbhj/80Or/sey9dVertyiDD8Ytp/uun8ui7OsOjNsb/mJYpHTdGV9tm4Zu3tQ+omIav PsAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This expands the ability of anonymous mount namespaces:

- Creating detached mounts from detached mounts

  Currently, detached mounts can only be created from attached mounts.
  This limitaton prevents various use-cases. For example, the ability to
  mount a subdirectory without ever having to make the whole filesystem
  visible first.

  The current permission modelis:

  (1) Check that the caller is privileged over the owning user namespace
      of it's current mount namespace.

  (2) Check that the caller is located in the mount namespace of the mount
      it wants to create a detached copy of.

  While it is not strictly necessary to do it this way it is consistently
  applied in the new mount api. This model will also be used when allowing
  the creation of detached mount from another detached mount.

  The (1) requirement can simply be met by performing the same check as
  for the non-detached case, i.e., verify that the caller is privileged
  over its current mount namespace.

  To meet the (2) requirement it must be possible to infer the origin
  mount namespace that the anonymous mount namespace of the detached mount
  was created from.

  The origin mount namespace of an anonymous mount is the mount namespace
  that the mounts that were copied into the anonymous mount namespace
  originate from.

  In order to check the origin mount namespace of an anonymous mount
  namespace the sequence number of the original mount namespace is
  recorded in the anonymous mount namespace.

  With this in place it is possible to perform an equivalent check (2') to
  (2). The origin mount namespace of the anonymous mount namespace must be
  the same as the caller's mount namespace. To establish this the sequence
  number of the caller's mount namespace and the origin sequence number of
  the anonymous mount namespace are compared.

  The caller is always located in a non-anonymous mount namespace since
  anonymous mount namespaces cannot be setns()ed into. The caller's mount
  namespace will thus always have a valid sequence number.

  The owning namespace of any mount namespace, anonymous or non-anonymous,
  can never change. A mount attached to a non-anonymous mount namespace
  can never change mount namespace.

  If the sequence number of the non-anonymous mount namespace and the
  origin sequence number of the anonymous mount namespace match, the
  owning namespaces must match as well.

  Hence, the capability check on the owning namespace of the caller's
  mount namespace ensures that the caller has the ability to copy the
  mount tree.

- Allow mount detached mounts on detached mounts

  Currently, detached mounts can only be mounted onto attached mounts.
  This limitation makes it impossible to assemble a new private rootfs
  and move it into place. Instead, a detached tree must be created,
  attached, then mounted open and then either moved or detached again.
  Lift this restriction.

  In order to allow mounting detached mounts onto other detached mounts
  the same permission model used for creating detached mounts from
  detached mounts can be used (cf. above).

  Allowing to mount detached mounts onto detached mounts leaves three
  cases to consider:

  (1) The source mount is an attached mount and the target mount is a
      detached mount. This would be equivalent to moving a mount between
      different mount namespaces. A caller could move an attached mount to
      a detached mount. The detached mount can now be freely attached to
      any mount namespace. This changes the current delegatioh model
      significantly for no good reason. So this will fail.

  (2) Anonymous mount namespaces are always attached fully, i.e., it is
      not possible to only attach a subtree of an anoymous mount
      namespace. This simplifies the implementation and reasoning.

      Consequently, if the anonymous mount namespace of the source
      detached mount and the target detached mount are the identical the
      mount request will fail.

  (3) The source mount's anonymous mount namespace is different from the
      target mount's anonymous mount namespace.

      In this case the source anonymous mount namespace of the source
      mount tree must be freed after its mounts have been moved to the
      target anonymous mount namespace. The source anonymous mount
      namespace must be empty afterwards.

  By allowing to mount detached mounts onto detached mounts a caller may
  do the following:

  fd_tree1 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE)
  fd_tree2 = open_tree(-EBADF, "/tmp", OPEN_TREE_CLONE)

  fd_tree1 and fd_tree2 refer to two different detached mount trees that
  belong to two different anonymous mount namespace.

  It is important to note that fd_tree1 and fd_tree2 both refer to the
  root of their respective anonymous mount namespaces.

  By allowing to mount detached mounts onto detached mounts the caller
  may now do:

      move_mount(fd_tree1, "", fd_tree2, "",
                 MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH)

  This will cause the detached mount referred to by fd_tree1 to be
  mounted on top of the detached mount referred to by fd_tree2.

  Thus, the detached mount fd_tree1 is moved from its separate anonymous
  mount namespace into fd_tree2's anonymous mount namespace.

  It also means that while fd_tree2 continues to refer to the root of
  its respective anonymous mount namespace fd_tree1 doesn't anymore.

  This has the consequence that only fd_tree2 can be moved to another
  anonymous or non-anonymous mount namespace. Moving fd_tree1 will now
  fail as fd_tree1 doesn't refer to the root of an anoymous mount
  namespace anymore.

  Now fd_tree1 and fd_tree2 refer to separate detached mount trees
  referring to the same anonymous mount namespace.

  This is conceptually fine. The new mount api does allow for this to
  happen already via:

  mount -t tmpfs tmpfs /mnt
  mkdir -p /mnt/A
  mount -t tmpfs tmpfs /mnt/A

  fd_tree3 = open_tree(-EBADF, "/mnt", OPEN_TREE_CLONE | AT_RECURSIVE)
  fd_tree4 = open_tree(-EBADF, "/mnt/A", 0)

  Both fd_tree3 and fd_tree4 refer to two different detached mount trees
  but both detached mount trees refer to the same anonymous mount
  namespace. An as with fd_tree1 and fd_tree2, only fd_tree3 may be
  moved another mount namespace as fd_tree3 refers to the root of the
  anonymous mount namespace just while fd_tree4 doesn't.

  However, there's an important difference between the fd_tree3/fd_tree4
  and the fd_tree1/fd_tree2 example.

  Closing fd_tree4 and releasing the respective struct file will have no
  further effect on fd_tree3's detached mount tree.

  However, closing fd_tree3 will cause the mount tree and the respective
  anonymous mount namespace to be destroyed causing the detached mount
  tree of fd_tree4 to be invalid for further mounting.

  By allowing to mount detached mounts on detached mounts as in the
  fd_tree1/fd_tree2 example both struct files will affect each other.

  Both fd_tree1 and fd_tree2 refer to struct files that have
  FMODE_NEED_UNMOUNT set.

  To handle this we use the fact that @fd_tree1 will have a parent mount
  once it has been attached to @fd_tree2.

  When dissolve_on_fput() is called the mount that has been passed in
  will refer to the root of the anonymous mount namespace. If it doesn't
  it would mean that mounts are leaked. So before allowing to mount
  detached mounts onto detached mounts this would be a bug.

  Now that detached mounts can be mounted onto detached mounts it just
  means that the mount has been attached to another anonymous mount
  namespace and thus dissolve_on_fput() must not unmount the mount tree
  or free the anonymous mount namespace as the file referring to the
  root of the namespace hasn't been closed yet.

  If it had been closed yet it would be obvious because the mount
  namespace would be NULL, i.e., the @fd_tree1 would have already been
  unmounted. If @fd_tree1 hasn't been unmounted yet and has a parent
  mount it is safe to skip any cleanup as closing @fd_tree2 will take
  care of all cleanup operations.

- Allow mount propagation for detached mount trees

  In commit ee2e3f50629f ("mount: fix mounting of detached mounts onto
  targets that reside on shared mounts") I fixed a bug where propagating
  the source mount tree of an anonymous mount namespace into a target
  mount tree of a non-anonymous mount namespace could be used to trigger
  an integer overflow in the non-anonymous mount namespace causing any new
  mounts to fail.

  The cause of this was that the propagation algorithm was unable to
  recognize mounts from the source mount tree that were already propagated
  into the target mount tree and then reappeared as propagation targets
  when walking the destination propagation mount tree.

  When fixing this I disabled mount propagation into anonymous mount
  namespaces. Make it possible for anonymous mount namespace to receive
  mount propagation events correctly. This is no also a correctness issue
  now that we allow mounting detached mount trees onto detached mount
  trees.

  Mark the source anonymous mount namespace with MNTNS_PROPAGATING
  indicating that all mounts belonging to this mount namespace are
  currently in the process of being propagated and make the propagation
  algorithm discard those if they appear as propagation targets.

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

This contains a merge conflict with the vfs-6.15.mount pull request:

diff --cc fs/mount.h
index 946dc8b792d7,96862eba2246..000000000000
--- a/fs/mount.h
+++ b/fs/mount.h
@@@ -22,11 -26,8 +26,12 @@@ struct mnt_namespace
                wait_queue_head_t       poll;
                struct rcu_head         mnt_ns_rcu;
        };
+       u64                     seq_origin; /* Sequence number of origin mount namespace */
        u64 event;
 +#ifdef CONFIG_FSNOTIFY
 +      __u32                   n_fsnotify_mask;
 +      struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
 +#endif
        unsigned int            nr_mounts; /* # of mounts in the namespace */
        unsigned int            pending_mounts;
        struct rb_node          mnt_ns_tree_node; /* node in the mnt_ns_tree */

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc1.mount.namespace

for you to fetch changes up to 06b1ce966e3f8bfef261c111feb3d4b33ede0cd8:

  Merge patch series "mount: handle mount propagation for detached mount trees" (2025-03-04 09:29:55 +0100)

Please consider pulling these changes from the signed vfs-6.15-rc1.mount.namespace tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc1.mount.namespace

----------------------------------------------------------------
Arnd Bergmann (1):
      fs: namespace: fix uninitialized variable use

Christian Brauner (23):
      Merge patch series "CONFIG_DEBUG_VFS at last"
      fs: record sequence number of origin mount namespace
      fs: add mnt_ns_empty() helper
      fs: add assert for move_mount()
      fs: add fastpath for dissolve_on_fput()
      fs: add may_copy_tree()
      fs: create detached mounts from detached mounts
      selftests: create detached mounts from detached mounts
      fs: support getname_maybe_null() in move_mount()
      fs: mount detached mounts onto detached mounts
      selftests: first test for mounting detached mounts onto detached mounts
      selftests: second test for mounting detached mounts onto detached mounts
      selftests: third test for mounting detached mounts onto detached mounts
      selftests: fourth test for mounting detached mounts onto detached mounts
      selftests: fifth test for mounting detached mounts onto detached mounts
      selftests: sixth test for mounting detached mounts onto detached mounts
      selftests: seventh test for mounting detached mounts onto detached mounts
      Merge patch series "fs: expand abilities of anonymous mount namespaces"
      fs: allow creating detached mounts from fsmount() file descriptors
      mount: handle mount propagation for detached mount trees
      selftests: add test for detached mount tree propagation
      selftests: test subdirectory mounting
      Merge patch series "mount: handle mount propagation for detached mount trees"

Mateusz Guzik (3):
      vfs: add initial support for CONFIG_DEBUG_VFS
      vfs: catch invalid modes in may_open()
      vfs: use the new debug macros in inode_set_cached_link()

 fs/inode.c                                         |  15 +
 fs/mount.h                                         |  13 +
 fs/namei.c                                         |   2 +
 fs/namespace.c                                     | 367 ++++++++++--
 fs/pnode.c                                         |  10 +-
 fs/pnode.h                                         |   2 +-
 include/linux/fs.h                                 |   4 +
 include/linux/vfsdebug.h                           |  45 ++
 lib/Kconfig.debug                                  |   9 +
 .../selftests/mount_setattr/mount_setattr_test.c   | 652 +++++++++++++++++++++
 10 files changed, 1053 insertions(+), 66 deletions(-)
 create mode 100644 include/linux/vfsdebug.h

