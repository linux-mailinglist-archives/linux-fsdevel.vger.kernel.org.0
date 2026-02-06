Return-Path: <linux-fsdevel+bounces-76610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N7DJ9odhmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:59:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA0100A65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A12C302F687
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9878A3D902B;
	Fri,  6 Feb 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbBA9aTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CB3A9624;
	Fri,  6 Feb 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396703; cv=none; b=qOFVSlL/5It0vWBL3IXcT7qhrnOMLmnMHldKW/UpiN6uqBS6fmUzHKHS0AkuHUXW6mYCmvPZhMY2LnWZEu1sCB20R4Id0G7w6qv+sQgyZxg2uF7usXimwOlV0P3xAo9y9pWYDfQ37G7oXhsGgNI5SSx9LqZOK7SUICiO9O+LB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396703; c=relaxed/simple;
	bh=bqgTgqNAmH4Q8qZxmhiBfgoITvaKgrpWrmXx5wn5tEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFtySxSFwFy8pQIimYotyJ5Pi/mZXg8xbRx6b0MNTuRfeYOFwRfQ4W+fzmsPEbykWv0jGYfNv9r7EMJJQpNOD+Wf9JNRGc3qq2Rxqj0sA+CSrmUuuo28B1A5PQLhsryvpukthpH6uC5qw701PxyiV+lM23SZ+iPg7b+rzJLLN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbBA9aTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B40C19422;
	Fri,  6 Feb 2026 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396702;
	bh=bqgTgqNAmH4Q8qZxmhiBfgoITvaKgrpWrmXx5wn5tEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbBA9aTTZljRbJ184SbZg2f0Zb/k7JojcHnIAHfCDaPL8wYDQGYtZXcLRcdUjAujr
	 dv/Xcohkd8H7RxLsuGo72jQEgYCovjzluJBMXUc6xCqKo4nezojv8BKR3vsLUNxVV2
	 WuYQNdZdDBa0lx3wrn9whUbnAcWQOYtOEYXPUGzy7xKiqYlDIdg3JZkpeVNOUNGZ3D
	 IzAXEc7QCZYn728+c1ZO/rNbU9TKaaVnkgHkYEV8vJtI+3DHwJnFkItVcxhYmsbXCQ
	 +FswfKS98bK+E6ZtXnr2T43bkhnoev8ezPpylNI/uqRtEbBn85N2C9MWuEOENgBmRH
	 6l1GXjpoWpEMw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 12/12 for v7.0] vfs misc
Date: Fri,  6 Feb 2026 17:50:08 +0100
Message-ID: <20260206-vfs-misc-v70-be6f713f9fa9@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8812; i=brauner@kernel.org; h=from:subject:message-id; bh=bqgTgqNAmH4Q8qZxmhiBfgoITvaKgrpWrmXx5wn5tEI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se/uTvEzDeFq/Ca/Vda7/FbtTqW0rEuBDAunJHHeD bygc/lZRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQinBj+l3erfli3mU0+uDCJ 71H5YdbXhUcuHs1aLWPZ5CXqWVA9heGv3B6ZMxkCE5P9lGe2bvIsNhP/X/pv8r1FJWpJss579j3 hBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76610-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AAA0100A65
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains a mix of VFS cleanups, performance improvements, API fixes,
documentation, and a deprecation notice.

Scalability and performance:

 - Rework pid allocation to only take pidmap_lock once instead of twice
   during alloc_pid(), improving thread creation/teardown throughput by
   10-16% depending on false-sharing luck. Pad the namespace refcount to
   reduce false-sharing.

 - Track file lock presence via a flag in ->i_opflags instead of reading
   ->i_flctx, avoiding false-sharing with ->i_readcount on open/close
   hot paths. Measured 4-16% improvement on 24-core open-in-a-loop
   benchmarks.

 - Use a consume fence in locks_inode_context() to match the
   store-release/load-consume idiom, eliminating a hardware fence on
   some architectures.

 - Annotate cdev_lock with __cacheline_aligned_in_smp to prevent
   false-sharing.

 - Remove a redundant DCACHE_MANAGED_DENTRY check in
   __follow_mount_rcu() that never fires since the caller already
   verifies it, eliminating a 100% mispredicted branch.

 - Fix a 100% mispredicted likely() hint in devcgroup_inode_permission()
   that became wrong after a prior code reorder.

Bug fixes and correctness:

 - Make insert_inode_locked() wait for inode destruction instead of
   skipping, fixing a corner case where two matching inodes could exist
   in the hash.

 - Move f_mode initialization before file_ref_init() in alloc_file() to
   respect the SLAB_TYPESAFE_BY_RCU ordering contract.

 - Add a WARN_ON_ONCE guard in try_to_free_buffers() for folios with no
   buffers attached, preventing a null pointer dereference when
   AS_RELEASE_ALWAYS is set but no release_folio op exists.

 - Fix select restart_block to store end_time as timespec64, avoiding
   truncation of tv_sec on 32-bit architectures.

 - Make dump_inode() use get_kernel_nofault() to safely access inode and
   superblock fields, matching the dump_mapping() pattern.

API modernization:

 - Make posix_acl_to_xattr() allocate the buffer internally since every
   single caller was doing it anyway. Reduces boilerplate and
   unnecessary error checking across ~15 filesystems.

 - Replace deprecated simple_strtoul() with kstrtoul() for the
   ihash_entries, dhash_entries, mhash_entries, and mphash_entries boot
   parameters, adding proper error handling.

 - Convert chardev code to use guard(mutex) and __free(kfree) cleanup
   patterns.

 - Replace min_t() with min() or umin() in VFS code to avoid silently
   truncating unsigned long to unsigned int.

 - Gate LOOKUP_RCU assertions behind CONFIG_DEBUG_VFS since callers
   already check the flag.

Deprecation:

 - Begin deprecating legacy BSD process accounting (acct(2)). The
   interface has numerous footguns and better alternatives exist (eBPF).

Documentation:

 - Fix and complete kernel-doc for struct export_operations, removing
   duplicated documentation between ReST and source.

 - Fix kernel-doc warnings for __start_dirop() and ilookup5_nowait().

Testing:

 - Add a kunit test for initramfs cpio handling of entries with
   filesize > PATH_MAX.

Misc:

 - Add missing <linux/init_task.h> include in fs_struct.c.

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

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.misc

for you to fetch changes up to 6cbfdf89470ef3c2110f376a507d135e7a7a7378:

  posix_acl: make posix_acl_to_xattr() alloc the buffer (2026-01-16 10:51:12 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.misc

Please consider pulling these changes from the signed vfs-7.0-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Amir Goldstein (1):
      fs: move initializing f_mode before file_ref_init()

André Almeida (4):
      exportfs: Fix kernel-doc output for get_name()
      exportfs: Mark struct export_operations functions at kernel-doc
      exportfs: Complete kernel-doc for struct export_operations
      docs: exportfs: Use source code struct documentation

Bagas Sanjaya (2):
      fs: Describe @isnew parameter in ilookup5_nowait()
      VFS: fix __start_dirop() kernel-doc warnings

Ben Dooks (1):
      fs: add <linux/init_task.h> for 'init_fs'

Breno Leitao (2):
      fs/namei: Remove redundant DCACHE_MANAGED_DENTRY check in __follow_mount_rcu
      device_cgroup: remove branch hint after code refactor

Christian Brauner (3):
      Merge patch series "further damage-control lack of clone scalability"
      Merge patch series "vfs kernel-doc fixes for 6.19"
      Merge patch series "exportfs: Some kernel-doc fixes"

David Disseldorp (1):
      initramfs_test: kunit test for cpio.filesize > PATH_MAX

David Laight (1):
      fs: use min() or umin() instead of min_t()

Deepakkumar Karn (1):
      fs/buffer: add alert in try_to_free_buffers() for folios without buffers

Jeff Layton (1):
      acct(2): begin the deprecation of legacy BSD process accounting

Mateusz Guzik (7):
      fs: annotate cdev_lock with __cacheline_aligned_in_smp
      ns: pad refcount
      filelock: use a consume fence in locks_inode_context()
      pid: only take pidmap_lock once on alloc
      fs: track the inode having file locks with a flag in ->i_opflags
      fs: only assert on LOOKUP_RCU when built with CONFIG_DEBUG_VFS
      fs: make insert_inode_locked() wait for inode destruction

Miklos Szeredi (1):
      posix_acl: make posix_acl_to_xattr() alloc the buffer

Thomas Weißschuh (1):
      select: store end_time as timespec64 in restart block

Thorsten Blum (3):
      fs: Replace simple_strtoul with kstrtoul in set_ihash_entries
      dcache: Replace simple_strtoul with kstrtoul in set_dhash_entries
      namespace: Replace simple_strtoul with kstrtoul to parse boot params

Yuto Ohnuki (1):
      fs: improve dump_inode() to safely access inode fields

chen zhang (1):
      chardev: Switch to guard(mutex) and __free(kfree)

 Documentation/filesystems/nfs/exporting.rst |  42 ++-------
 fs/9p/acl.c                                 |  16 +---
 fs/btrfs/acl.c                              |  10 +--
 fs/buffer.c                                 |   6 +-
 fs/ceph/acl.c                               |  50 +++++------
 fs/char_dev.c                               |  19 ++--
 fs/dcache.c                                 |   5 +-
 fs/exec.c                                   |   2 +-
 fs/ext4/mballoc.c                           |   3 +-
 fs/ext4/resize.c                            |   2 +-
 fs/ext4/super.c                             |   2 +-
 fs/fat/dir.c                                |   4 +-
 fs/fat/file.c                               |   3 +-
 fs/file_table.c                             |  10 +--
 fs/fs_struct.c                              |   1 +
 fs/fuse/acl.c                               |  12 +--
 fs/fuse/dev.c                               |   2 +-
 fs/fuse/file.c                              |   8 +-
 fs/gfs2/acl.c                               |  13 +--
 fs/inode.c                                  |  96 ++++++++++++--------
 fs/jfs/acl.c                                |   9 +-
 fs/locks.c                                  |  14 ++-
 fs/namei.c                                  |  11 ++-
 fs/namespace.c                              |  10 +--
 fs/ntfs3/xattr.c                            |   6 +-
 fs/orangefs/acl.c                           |   8 +-
 fs/posix_acl.c                              |  21 ++---
 fs/select.c                                 |  12 +--
 fs/splice.c                                 |   2 +-
 include/linux/device_cgroup.h               |   2 +-
 include/linux/exportfs.h                    |  33 ++++---
 include/linux/filelock.h                    |  18 +++-
 include/linux/fs.h                          |   1 +
 include/linux/ns/ns_common_types.h          |   4 +-
 include/linux/posix_acl_xattr.h             |   5 +-
 include/linux/restart_block.h               |   4 +-
 init/Kconfig                                |   7 +-
 init/initramfs_test.c                       |  48 ++++++++++
 kernel/pid.c                                | 131 ++++++++++++++++++----------
 39 files changed, 357 insertions(+), 295 deletions(-)

