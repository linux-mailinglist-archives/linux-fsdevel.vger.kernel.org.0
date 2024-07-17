Return-Path: <linux-fsdevel+bounces-23798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8289335DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 05:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7F228451F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 03:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D9B8493;
	Wed, 17 Jul 2024 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXEjsoCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217D6FB6;
	Wed, 17 Jul 2024 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188173; cv=none; b=t9Mzv9+9gysJwm4OkldIzTNJ3KdLBsYaFAXJbPsU0TKXJUKzSqnojBnnDaj+LGA/xypnxm7fO9sm5OAcn8FGKcGJtm3tE1E+qoSRho1buG7ekZc0hLH4bfgnGJFrv7nz6vV3qkcFJwv6TezhUKW0yw3KX7xCoseHXQfmV5LA/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188173; c=relaxed/simple;
	bh=eyyxX2J44xYKrJS7pyc4O8ajIVQgp1ln36wjZIj6Wxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IvEZ/C422sizDcsOvJSp3BqjW+vh+NVGgYc4vbXdWrJR18yuI4sAFbipmeUkCluxmjFvDMRfCm/DUwNawqh77hIZVUnKa2cpHv9UqkkIHSR8QEHAX57/dop0DyFnTIvoA225yWNeyFIcpSoX2D8ttZ1dlzhAFC+b6OAhVKhycLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXEjsoCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B540C32782;
	Wed, 17 Jul 2024 03:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721188173;
	bh=eyyxX2J44xYKrJS7pyc4O8ajIVQgp1ln36wjZIj6Wxo=;
	h=From:To:Cc:Subject:Date:From;
	b=YXEjsoCibK807s+20MbEr5uxSrYuURAV6k+BlRBsHao29ss7Ff+vtfN7qCYbVrsK7
	 Oas9k6de+7ca8jdxZt4ol6RuDZVE8aW762YvZZGxvzSBAQCGCxBpKlJ7F2ddIF+lxz
	 /jfsoLCNqF81ziISdfNXKFbmPVCn4jheJocSYBEhW+0TXQilXC6vIsv0uWLylh7nkN
	 QCl8Wi50JW0jpBsZEOeXMru17u7nsqTbASKCnNmymiVzQl7bTy/Q71dyTK0dG7LgZG
	 SSajbm3KBy6dqdL8TTYQCMZPDENnY64Pey+i1JvQVpYsHyhme9P5ftXbslTwHEtKL+
	 GDHgkuVRXWTxQ==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: new code for 6.11
Date: Wed, 17 Jul 2024 09:14:02 +0530
Message-ID: <871q3sison.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch with changes for XFS for 6.11-rc1.

Major changes in this release are limited to enabling FITRIM on realtime
devices and Byte-based grant head log reservation tracking. The remaining
changes are limited to fixes and cleanups included in this pull request.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.11-merge-3

for you to fetch changes up to 2bf6e353542d233486195953dc9c346331f82dcb:

  xfs: fix rtalloc rotoring when delalloc is in use (2024-07-09 09:08:28 +0530)

----------------------------------------------------------------
New code for 6.11:

  * Enable FITRIM on the realtime device.
  * Introduce byte-based grant head log reservation tracking instead of
    physical log location tracking.
    This allows grant head to track a full 64 bit bytes space and hence
    overcome the limit of 4GB indexing that has been present until now.
  * Fixes
    - xfs_flush_unmap_range() and xfs_prepare_shift() should consider RT extents
      in the flush unmap range.
    - Implement bounds check when traversing log operations during log replay.
    - Prevent out of bounds access when traversing a directory data block.
    - Prevent incorrect ENOSPC when concurrently performing file creation and
      file writes.
    - Fix rtalloc rotoring when delalloc is in use
  * Cleanups
    - Clean up I/O path inode locking helpers and the page fault handler.
    - xfs: hoist inode operations to libxfs in anticipation of the metadata
      inode directory feature, which maintains a directory tree of metadata
      inodes. This will be necessary for further enhancements to the realtime
      feature, subvolume support.
    - Clean up some warts in the extent freeing log intent code.
    - Clean up the refcount and rmap intent code before adding support for
      realtime devices.
    - Provide the correct email address for sysfs ABI documentation.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Chandan Babu R (4):
      Merge tag 'inode-refactor-6.11_2024-07-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.11-mergeB
      Merge tag 'extfree-intent-cleanups-6.11_2024-07-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.11-mergeB
      Merge tag 'rmap-intent-cleanups-6.11_2024-07-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.11-mergeB
      Merge tag 'refcount-intent-cleanups-6.11_2024-07-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.11-mergeB

Christoph Hellwig (18):
      xfs: move the dio write relocking out of xfs_ilock_for_iomap
      xfs: cleanup xfs_ilock_iocb_for_write
      xfs: simplify xfs_dax_fault
      xfs: refactor __xfs_filemap_fault
      xfs: always take XFS_MMAPLOCK shared in xfs_dax_read_fault
      xfs: fold xfs_ilock_for_write_fault into xfs_write_fault
      xfs: pass the fsbno to xfs_perag_intent_get
      xfs: add a xefi_entry helper
      xfs: reuse xfs_extent_free_cancel_item
      xfs: factor out a xfs_efd_add_extent helper
      xfs: remove duplicate asserts in xfs_defer_extent_free
      xfs: remove xfs_defer_agfl_block
      xfs: add a ri_entry helper
      xfs: reuse xfs_rmap_update_cancel_item
      xfs: don't bother calling xfs_rmap_finish_one_cleanup in xfs_rmap_finish_one
      xfs: simplify usage of the rcur local variable in xfs_rmap_finish_one
      xfs: fix the contact address for the sysfs ABI documentation
      xfs: fix rtalloc rotoring when delalloc is in use

Darrick J. Wong (44):
      xfs: enable FITRIM on the realtime device
      xfs: verify buffer, inode, and dquot items every tx commit
      xfs: use consistent uid/gid when grabbing dquots for inodes
      xfs: move inode copy-on-write predicates to xfs_inode.[ch]
      xfs: hoist extent size helpers to libxfs
      xfs: hoist inode flag conversion functions to libxfs
      xfs: hoist project id get/set functions to libxfs
      xfs: pack icreate initialization parameters into a separate structure
      xfs: implement atime updates in xfs_trans_ichgtime
      xfs: use xfs_trans_ichgtime to set times when allocating inode
      xfs: split new inode creation into two pieces
      xfs: hoist new inode initialization functions to libxfs
      xfs: push xfs_icreate_args creation out of xfs_create*
      xfs: wrap inode creation dqalloc calls
      xfs: hoist xfs_iunlink to libxfs
      xfs: hoist xfs_{bump,drop}link to libxfs
      xfs: separate the icreate logic around INIT_XATTRS
      xfs: create libxfs helper to link a new inode into a directory
      xfs: create libxfs helper to link an existing inode into a directory
      xfs: hoist inode free function to libxfs
      xfs: create libxfs helper to remove an existing inode/name from a directory
      xfs: create libxfs helper to exchange two directory entries
      xfs: create libxfs helper to rename two directory entries
      xfs: move dirent update hooks to xfs_dir2.c
      xfs: get rid of trivial rename helpers
      xfs: don't use the incore struct xfs_sb for offsets into struct xfs_dsb
      xfs: clean up extent free log intent item tracepoint callsites
      xfs: convert "skip_discard" to a proper flags bitset
      xfs: give rmap btree cursor error tracepoints their own class
      xfs: pass btree cursors to rmap btree tracepoints
      xfs: clean up rmap log intent item tracepoint callsites
      xfs: move xfs_extent_free_defer_add to xfs_extfree_item.c
      xfs: remove xfs_trans_set_rmap_flags
      xfs: give refcount btree cursor error tracepoints their own class
      xfs: create specialized classes for refcount tracepoints
      xfs: pass btree cursors to refcount btree tracepoints
      xfs: move xfs_rmap_update_defer_add to xfs_rmap_item.c
      xfs: clean up refcount log intent item tracepoint callsites
      xfs: remove xfs_trans_set_refcount_flags
      xfs: add a ci_entry helper
      xfs: reuse xfs_refcount_update_cancel_item
      xfs: don't bother calling xfs_refcount_finish_one_cleanup in xfs_refcount_finish_one
      xfs: simplify usage of the rcur local variable in xfs_refcount_finish_one
      xfs: move xfs_refcount_update_defer_add to xfs_refcount_item.c

Dave Chinner (10):
      xfs: move and rename xfs_trans_committed_bulk
      xfs: AIL doesn't need manual pushing
      xfs: background AIL push should target physical space
      xfs: ensure log tail is always up to date
      xfs: l_last_sync_lsn is really AIL state
      xfs: collapse xlog_state_set_callback in caller
      xfs: track log space pinned by the AIL
      xfs: pass the full grant head to accounting functions
      xfs: grant heads track byte counts, not LSNs
      xfs: skip flushing log items during push

Gao Xiang (1):
      xfs: avoid redundant AGFL buffer invalidation

John Garry (2):
      xfs: Fix xfs_flush_unmap_range() range for RT
      xfs: Fix xfs_prepare_shift() range for RT

Long Li (1):
      xfs: get rid of xfs_ag_resv_rmapbt_alloc

Wenchao Hao (1):
      xfs: Remove header files which are included more than once

Zizhi Wo (1):
      xfs: Avoid races with cnt_btree lastrec updates

lei lu (2):
      xfs: add bounds checking to xlog_recover_process_data
      xfs: don't walk off the end of a directory data block

 Documentation/ABI/testing/sysfs-fs-xfs |   26 +-
 fs/xfs/Kconfig                         |   12 +
 fs/xfs/Makefile                        |    1 +
 fs/xfs/libxfs/xfs_ag.c                 |    2 +-
 fs/xfs/libxfs/xfs_ag_resv.h            |   19 -
 fs/xfs/libxfs/xfs_alloc.c              |  235 ++---
 fs/xfs/libxfs/xfs_alloc.h              |   18 +-
 fs/xfs/libxfs/xfs_alloc_btree.c        |   64 --
 fs/xfs/libxfs/xfs_bmap.c               |   55 +-
 fs/xfs/libxfs/xfs_bmap.h               |    3 +
 fs/xfs/libxfs/xfs_bmap_btree.c         |    2 +-
 fs/xfs/libxfs/xfs_btree.c              |   51 --
 fs/xfs/libxfs/xfs_btree.h              |   16 +-
 fs/xfs/libxfs/xfs_defer.c              |    4 +-
 fs/xfs/libxfs/xfs_dir2.c               |  661 +++++++++++++-
 fs/xfs/libxfs/xfs_dir2.h               |   49 +-
 fs/xfs/libxfs/xfs_dir2_data.c          |   31 +-
 fs/xfs/libxfs/xfs_dir2_priv.h          |    7 +
 fs/xfs/libxfs/xfs_format.h             |    9 +-
 fs/xfs/libxfs/xfs_ialloc.c             |   20 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c       |    2 +-
 fs/xfs/libxfs/xfs_inode_util.c         |  749 ++++++++++++++++
 fs/xfs/libxfs/xfs_inode_util.h         |   62 ++
 fs/xfs/libxfs/xfs_ondisk.h             |    1 +
 fs/xfs/libxfs/xfs_refcount.c           |  156 ++--
 fs/xfs/libxfs/xfs_refcount.h           |   11 +-
 fs/xfs/libxfs/xfs_refcount_btree.c     |    2 +-
 fs/xfs/libxfs/xfs_rmap.c               |  268 ++----
 fs/xfs/libxfs/xfs_rmap.h               |   15 +-
 fs/xfs/libxfs/xfs_rmap_btree.c         |    7 +-
 fs/xfs/libxfs/xfs_shared.h             |    7 -
 fs/xfs/libxfs/xfs_trans_inode.c        |    2 +
 fs/xfs/libxfs/xfs_trans_resv.c         |    1 -
 fs/xfs/scrub/common.c                  |    1 +
 fs/xfs/scrub/newbt.c                   |    5 +-
 fs/xfs/scrub/quota_repair.c            |    1 -
 fs/xfs/scrub/reap.c                    |    7 +-
 fs/xfs/scrub/tempfile.c                |   21 +-
 fs/xfs/xfs.h                           |    4 +
 fs/xfs/xfs_bmap_item.c                 |    6 +-
 fs/xfs/xfs_bmap_util.c                 |   22 +-
 fs/xfs/xfs_buf_item.c                  |   32 +
 fs/xfs/xfs_discard.c                   |  303 ++++++-
 fs/xfs/xfs_dquot_item.c                |   31 +
 fs/xfs/xfs_drain.c                     |    8 +-
 fs/xfs/xfs_drain.h                     |    5 +-
 fs/xfs/xfs_extfree_item.c              |  119 ++-
 fs/xfs/xfs_extfree_item.h              |    6 +
 fs/xfs/xfs_file.c                      |  141 +--
 fs/xfs/xfs_handle.c                    |    1 -
 fs/xfs/xfs_inode.c                     | 1484 ++++----------------------------
 fs/xfs/xfs_inode.h                     |   70 +-
 fs/xfs/xfs_inode_item.c                |   38 +-
 fs/xfs/xfs_ioctl.c                     |   60 --
 fs/xfs/xfs_iomap.c                     |   71 +-
 fs/xfs/xfs_iops.c                      |   51 +-
 fs/xfs/xfs_linux.h                     |    2 -
 fs/xfs/xfs_log.c                       |  511 +++--------
 fs/xfs/xfs_log.h                       |    1 -
 fs/xfs/xfs_log_cil.c                   |  177 +++-
 fs/xfs/xfs_log_priv.h                  |   61 +-
 fs/xfs/xfs_log_recover.c               |   28 +-
 fs/xfs/xfs_qm.c                        |    7 +-
 fs/xfs/xfs_qm_bhv.c                    |    1 -
 fs/xfs/xfs_refcount_item.c             |  110 +--
 fs/xfs/xfs_refcount_item.h             |    5 +
 fs/xfs/xfs_reflink.c                   |    2 +-
 fs/xfs/xfs_reflink.h                   |   10 -
 fs/xfs/xfs_rmap_item.c                 |  161 ++--
 fs/xfs/xfs_rmap_item.h                 |    4 +
 fs/xfs/xfs_rtalloc.c                   |    3 +-
 fs/xfs/xfs_symlink.c                   |   70 +-
 fs/xfs/xfs_sysfs.c                     |   29 +-
 fs/xfs/xfs_trace.c                     |    4 +-
 fs/xfs/xfs_trace.h                     |  531 +++++++-----
 fs/xfs/xfs_trans.c                     |  129 ---
 fs/xfs/xfs_trans.h                     |    5 +-
 fs/xfs/xfs_trans_ail.c                 |  244 +++---
 fs/xfs/xfs_trans_priv.h                |   44 +-
 79 files changed, 3784 insertions(+), 3410 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_inode_util.c
 create mode 100644 fs/xfs/libxfs/xfs_inode_util.h

