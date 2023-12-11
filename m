Return-Path: <linux-fsdevel+bounces-5476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0213980C9E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 13:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFE01F21719
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358A3C064;
	Mon, 11 Dec 2023 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfbcP42k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DFC3B7BE;
	Mon, 11 Dec 2023 12:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6F8C433C8;
	Mon, 11 Dec 2023 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702297971;
	bh=Mw1EUVNDAUwdkxNqkxuXxBZ6ow+p09cfpzEayt+0N+s=;
	h=From:To:Cc:Subject:Date:From;
	b=MfbcP42kqkZd7SS+WZE4EySv/GzZCf6I7vdWQyuyMMcCs8yEy0QPcKxm1ZKfKf+Nk
	 heH3nnSrbn7uQ0lvw/RMO06d8VHOXnWAS8OWNmXaiBFiYBUw2fVTP8tIQwp6PMRh54
	 yddlTWqJOMnuLHBdXd57+YsiLLdVyx97pbTQGCKHxHE87IgFqDudQWv3iVrBstlNhy
	 VCJM6MDwApULobF0xmx2KkXc7SWL0GPsKcdqB7jrXbt+RT5hvnywEBJm+jwEx0JJ+X
	 Hd3KumV2K0FlGaZ91EkQKfxauKAmIhdh75b8YHuNhpmPl1U757sfPcW5I+lxbbfIAV
	 pNswqR0N7Jc+A==
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: bagasdotme@gmail.com,bodonnel@redhat.com,cmaiolino@redhat.com,dan.j.williams@intel.com,david@fromorbit.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,ruansy.fnst@fujitsu.com,zhangjiachen.jaycee@bytedance.com,zhangtianci.1997@bytedance.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 18793e050504
Date: Mon, 11 Dec 2023 17:59:54 +0530
Message-ID: <87fs08q5qp.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

18793e050504 xfs: move xfs_ondisk.h to libxfs/

48 new commits:

Bagas Sanjaya (1):
      [011f129fee4b] Documentation: xfs: consolidate XFS docs into its own subdirectory

Chandan Babu R (6):
      [6b4ffe97e913] Merge tag 'reconstruct-defer-work-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      [34d386666819] Merge tag 'reconstruct-defer-cleanups-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      [47c460efc467] Merge tag 'fix-rtmount-overflows-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      [9f334526ee0a] Merge tag 'defer-elide-create-done-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      [dec0224bae8b] Merge tag 'scrub-livelock-prevention-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA
      [49391d1349da] Merge tag 'repair-auto-reap-space-reservations-6.8_2023-12-06' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.8-mergeA

Christoph Hellwig (6):
      [64f08b152a3b] xfs: clean up the XFS_IOC_{GS}ET_RESBLKS handler
      [c2c2620de757] xfs: clean up the XFS_IOC_FSCOUNTS handler
      [646ddf0c4df5] xfs: clean up the xfs_reserve_blocks interface
      [08e54ca42d6a] xfs: clean up xfs_fsops.h
      [c12c50393c1f] xfs: use static_assert to check struct sizes and offsets
      [18793e050504] xfs: move xfs_ondisk.h to libxfs/

Darrick J. Wong (31):
      [07bcbdf020c9] xfs: don't leak recovered attri intent items
      [03f7767c9f61] xfs: use xfs_defer_pending objects to recover intent items
      [a050acdfa800] xfs: pass the xfs_defer_pending object to iop_recover
      [deb4cd8ba87f] xfs: transfer recovered intent item ownership in ->iop_recover
      [e70fb328d527] xfs: recreate work items when recovering intent items
      [a51489e140d3] xfs: dump the recovered xattri log item if corruption happens
      [172538beba82] xfs: don't set XFS_TRANS_HAS_INTENT_DONE when there's no ATTRD log item
      [e5f1a5146ec3] xfs: use xfs_defer_finish_one to finish recovered work items
      [3dd75c8db1c1] xfs: hoist intent done flag setting to ->finish_item callsite
      [db7ccc0bac2a] xfs: move ->iop_recover to xfs_defer_op_type
      [e6e5299fcbf0] xfs: collapse the ->finish_item helpers
      [f3fd7f6fce1c] xfs: hoist ->create_intent boilerplate to its callsite
      [bd3a88f6b71c] xfs: use xfs_defer_create_done for the relogging operation
      [3e0958be2156] xfs: clean out XFS_LI_DIRTY setting boilerplate from ->iop_relog
      [b28852a5bd08] xfs: hoist xfs_trans_add_item calls to defer ops functions
      [8a9aa763e17c] xfs: collapse the ->create_done functions
      [a6a38f309afc] xfs: make rextslog computation consistent with mkfs
      [cf8f0e6c1429] xfs: fix 32-bit truncation in xfs_compute_rextslog
      [94da54d582e6] xfs: document what LARP means
      [a49c708f9a44] xfs: move ->iop_relog to struct xfs_defer_op_type
      [e14293803f4e] xfs: don't allow overly small or large realtime volumes
      [9c07bca793b4] xfs: elide ->create_done calls for unlogged deferred work
      [3f113c2739b1] xfs: make xchk_iget safer in the presence of corrupt inode btrees
      [6b126139401a] xfs: don't append work items to logged xfs_defer_pending objects
      [4dffb2cbb483] xfs: allow pausing of pending deferred work items
      [4c88fef3af4a] xfs: remove __xfs_free_extent_later
      [e3042be36c34] xfs: automatic freeing of freshly allocated unwritten space
      [4c8ecd1cfdd0] xfs: remove unused fields from struct xbtree_ifakeroot
      [be4084176304] xfs: implement block reservation accounting for btrees we're staging
      [6bb9ea8ecd2c] xfs: log EFIs for all btree blocks being used to stage a btree
      [3f3cec031099] xfs: force small EFIs for reaping btree extents

Jiachen Zhang (1):
      [e6af9c98cbf0] xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real

Shiyang Ruan (1):
      [fa422b353d21] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind

Zhang Tianci (2):
      [5759aa4f9560] xfs: update dir3 leaf block metadata after swap
      [fd45ddb9dd60] xfs: extract xfs_da_buf_copy() helper function

Code Diffstat:

 Documentation/filesystems/index.rst     |   5 +-
 Documentation/filesystems/xfs/index.rst |  14 +
 .../xfs-delayed-logging-design.rst      |   0
 .../xfs-maintainer-entry-profile.rst    |   0
 .../xfs-online-fsck-design.rst          |   2 +-
 .../xfs-self-describing-metadata.rst    |   0
 .../maintainer-entry-profile.rst        |   2 +-
 MAINTAINERS                             |   4 +-
 drivers/dax/super.c                     |   3 +-
 fs/xfs/Makefile                         |   1 +
 fs/xfs/libxfs/xfs_ag.c                  |   2 +-
 fs/xfs/libxfs/xfs_alloc.c               | 104 ++-
 fs/xfs/libxfs/xfs_alloc.h               |  22 +-
 fs/xfs/libxfs/xfs_attr_leaf.c           |  12 +-
 fs/xfs/libxfs/xfs_bmap.c                |  77 +-
 fs/xfs/libxfs/xfs_bmap_btree.c          |   2 +-
 fs/xfs/libxfs/xfs_btree_staging.h       |   6 -
 fs/xfs/libxfs/xfs_da_btree.c            |  69 +-
 fs/xfs/libxfs/xfs_da_btree.h            |   2 +
 fs/xfs/libxfs/xfs_defer.c               | 445 +++++++++--
 fs/xfs/libxfs/xfs_defer.h               |  42 +-
 fs/xfs/libxfs/xfs_ialloc.c              |   5 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c        |   2 +-
 fs/xfs/libxfs/xfs_log_recover.h         |   7 +
 fs/xfs/{ => libxfs}/xfs_ondisk.h        |   8 +-
 fs/xfs/libxfs/xfs_refcount.c            |   6 +-
 fs/xfs/libxfs/xfs_refcount_btree.c      |   2 +-
 fs/xfs/libxfs/xfs_rtbitmap.c            |  14 +
 fs/xfs/libxfs/xfs_rtbitmap.h            |  16 +
 fs/xfs/libxfs/xfs_sb.c                  |   6 +-
 fs/xfs/scrub/common.c                   |   6 +-
 fs/xfs/scrub/common.h                   |  25 +
 fs/xfs/scrub/inode.c                    |   4 +-
 fs/xfs/scrub/newbt.c                    | 513 +++++++++++++
 fs/xfs/scrub/newbt.h                    |  65 ++
 fs/xfs/scrub/reap.c                     |   7 +-
 fs/xfs/scrub/trace.h                    |  37 +
 fs/xfs/xfs_attr_item.c                  | 252 +++---
 fs/xfs/xfs_bmap_item.c                  | 199 ++---
 fs/xfs/xfs_extfree_item.c               | 330 +++-----
 fs/xfs/xfs_fsops.c                      |  50 +-
 fs/xfs/xfs_fsops.h                      |  14 +-
 fs/xfs/xfs_ioctl.c                      | 115 +--
 fs/xfs/xfs_log.c                        |   1 +
 fs/xfs/xfs_log_priv.h                   |   1 +
 fs/xfs/xfs_log_recover.c                | 131 ++--
 fs/xfs/xfs_mount.c                      |   8 +-
 fs/xfs/xfs_notify_failure.c             | 108 ++-
 fs/xfs/xfs_refcount_item.c              | 233 ++----
 fs/xfs/xfs_reflink.c                    |   2 +-
 fs/xfs/xfs_rmap_item.c                  | 256 +++---
 fs/xfs/xfs_rtalloc.c                    |   6 +-
 fs/xfs/xfs_super.c                      |   6 +-
 fs/xfs/xfs_sysfs.c                      |   9 +
 fs/xfs/xfs_trace.h                      |  13 +-
 fs/xfs/xfs_trans.h                      |  12 -
 include/linux/mm.h                      |   1 +
 mm/memory-failure.c                     |  21 +-
 58 files changed, 2092 insertions(+), 1213 deletions(-)
 create mode 100644 Documentation/filesystems/xfs/index.rst
 rename Documentation/filesystems/{ => xfs}/xfs-delayed-logging-design.rst (100%)
 rename Documentation/filesystems/{ => xfs}/xfs-maintainer-entry-profile.rst (100%)
 rename Documentation/filesystems/{ => xfs}/xfs-online-fsck-design.rst (99%)
 rename Documentation/filesystems/{ => xfs}/xfs-self-describing-metadata.rst (100%)
 rename fs/xfs/{ => libxfs}/xfs_ondisk.h (97%)
 create mode 100644 fs/xfs/scrub/newbt.c
 create mode 100644 fs/xfs/scrub/newbt.h

