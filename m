Return-Path: <linux-fsdevel+bounces-23263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061A9296CB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2024 08:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A062827E2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2024 06:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7140BF4EB;
	Sun,  7 Jul 2024 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ffe4sbzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797ECA62;
	Sun,  7 Jul 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720332140; cv=none; b=aFrL736Y3rITuOdhwHQHN8mdCGgQZhxBFJxbidZNlPXyLftkQKLFVvRxNix73dPZXmGwqACNQRdf5Ns0MAEt6ob1GzIvMaeFIDJHvibDdk04QnPyGB2DjiX2+54sHF0g8obaV7sXh+0fCZ6EbMCWJsJ0qq8S3RFJ4oBljJ8/zLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720332140; c=relaxed/simple;
	bh=WZ9GVpGlCOrjQ8YeGvvjL98AKtIQaDRrWb13zCFW+q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=odIij8+YO5y7LulVJIjCzCB+cEG6BcPRDASjoFElAgmSkOfRZwNz6S/3rw34EQX67zR6KEdhQlOQOF1K7TOqEBHsv1CKJ92th2eZ4RLswaT1oWQyerQukHKTTCVEKpbdrbpP6ZV1VikFmXmCd5eJORJkFOA5GA1H2M812v7Ecpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ffe4sbzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D169FC3277B;
	Sun,  7 Jul 2024 06:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720332140;
	bh=WZ9GVpGlCOrjQ8YeGvvjL98AKtIQaDRrWb13zCFW+q0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ffe4sbztCzvv8Rg4lYToWBKp/hhgMyF3i4D+Of7tit77/rF2ci4nrwPazFTrZVykF
	 P8VYf0YqurHM8Ew6t8QSMFWdf0N98cXDuygyDo70o2K1tw0LvlVSgLTQO8pvk2vEJN
	 1mczRRoYD4jm0IO/nutEV5hHW9xfOpqip7HeXJ7FdhCM4LAcKeoCEeOaQLHHfgcUzj
	 1n9RJlLGvwHDbfFvmNbuhP0dzlr9ovmbMpb9PKciyid43+VK4W5W4en9CcOaJri8wZ
	 re5kqYhEXQ9Bce15E/DS3ifG0j6z5gb+EJjIg/7H1m7xAgHTXqBPxoutGnB8ejuz0X
	 f00Dy76NH+O5A==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: dchinner@redhat.com,djwong@kernel.org,hch@lst.de,leo.lilong@huawei.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,wozizhi@huawei.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 49cdc4e834e4
Date: Sun, 07 Jul 2024 11:31:30 +0530
Message-ID: <87a5it7n9y.fsf@debian-BULLSEYE-live-builder-AMD64>
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

49cdc4e834e4 xfs: get rid of xfs_ag_resv_rmapbt_alloc

70 new commits:

Chandan Babu R (4):
      [2f6ebd4cf5bc] Merge tag 'inode-refactor-6.11_2024-07-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.11-mergeB
      [06e4e940c57e] Merge tag 'extfree-intent-cleanups-6.11_2024-07-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.11-mergeB
      [584aa150d5b7] Merge tag 'rmap-intent-cleanups-6.11_2024-07-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.11-mergeB
      [4cdbfe457a32] Merge tag 'refcount-intent-cleanups-6.11_2024-07-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.11-mergeB

Christoph Hellwig (11):
      [62d597a197e3] xfs: pass the fsbno to xfs_perag_intent_get
      [649c0c2b86ee] xfs: add a xefi_entry helper
      [61665fae4e43] xfs: reuse xfs_extent_free_cancel_item
      [81927e6ec621] xfs: factor out a xfs_efd_add_extent helper
      [851a6781895a] xfs: remove duplicate asserts in xfs_defer_extent_free
      [7272f77c67c0] xfs: remove xfs_defer_agfl_block
      [f93963779b43] xfs: add a ri_entry helper
      [37f9d1db03ba] xfs: reuse xfs_rmap_update_cancel_item
      [8363b4361997] xfs: don't bother calling xfs_rmap_finish_one_cleanup in xfs_rmap_finish_one
      [905af72610d9] xfs: simplify usage of the rcur local variable in xfs_rmap_finish_one
      [9ff4490e2ab3] xfs: fix the contact address for the sysfs ABI documentation

Darrick J. Wong (43):
      [150bb10a28b9] xfs: verify buffer, inode, and dquot items every tx commit
      [24a4e1cb322e] xfs: use consistent uid/gid when grabbing dquots for inodes
      [d76e137057ae] xfs: move inode copy-on-write predicates to xfs_inode.[ch]
      [acdddbe16804] xfs: hoist extent size helpers to libxfs
      [b7c477be3969] xfs: hoist inode flag conversion functions to libxfs
      [fcea5b35f362] xfs: hoist project id get/set functions to libxfs
      [ba4b39fe4c01] xfs: pack icreate initialization parameters into a separate structure
      [3d1dfb6df9b7] xfs: implement atime updates in xfs_trans_ichgtime
      [a7b12718cb90] xfs: use xfs_trans_ichgtime to set times when allocating inode
      [38fd3d6a956f] xfs: split new inode creation into two pieces
      [e9d2b35bb9d3] xfs: hoist new inode initialization functions to libxfs
      [dfaf884233ba] xfs: push xfs_icreate_args creation out of xfs_create*
      [c0223b8d66d2] xfs: wrap inode creation dqalloc calls
      [b8a6107921ca] xfs: hoist xfs_iunlink to libxfs
      [a9e583d34fac] xfs: hoist xfs_{bump,drop}link to libxfs
      [b11b11e3b7a7] xfs: separate the icreate logic around INIT_XATTRS
      [1fa2e81957cf] xfs: create libxfs helper to link a new inode into a directory
      [c1f0bad4232f] xfs: create libxfs helper to link an existing inode into a directory
      [1964435d19d9] xfs: hoist inode free function to libxfs
      [90636e4531a8] xfs: create libxfs helper to remove an existing inode/name from a directory
      [a55712b35c06] xfs: create libxfs helper to exchange two directory entries
      [28d0d8134446] xfs: create libxfs helper to rename two directory entries
      [62bbf50bea21] xfs: move dirent update hooks to xfs_dir2.c
      [47d4d5961fb9] xfs: get rid of trivial rename helpers
      [ac3a0275165b] xfs: don't use the incore struct xfs_sb for offsets into struct xfs_dsb
      [4e0e2c0fe35b] xfs: clean up extent free log intent item tracepoint callsites
      [980faece91a6] xfs: convert "skip_discard" to a proper flags bitset
      [71f5a17e5267] xfs: give rmap btree cursor error tracepoints their own class
      [47492ed12421] xfs: pass btree cursors to rmap btree tracepoints
      [fbe8c7e167a6] xfs: clean up rmap log intent item tracepoint callsites
      [84a3c1576c5a] xfs: move xfs_extent_free_defer_add to xfs_extfree_item.c
      [c9099a28c264] xfs: remove xfs_trans_set_rmap_flags
      [7cf2663ff1cf] xfs: give refcount btree cursor error tracepoints their own class
      [bb0efb0d0a28] xfs: create specialized classes for refcount tracepoints
      [8fbac2f1a094] xfs: pass btree cursors to refcount btree tracepoints
      [ea7b0820d960] xfs: move xfs_rmap_update_defer_add to xfs_rmap_item.c
      [886f11c79772] xfs: clean up refcount log intent item tracepoint callsites
      [e69682e5a12d] xfs: remove xfs_trans_set_refcount_flags
      [0e9254861f98] xfs: add a ci_entry helper
      [8aef79928b3d] xfs: reuse xfs_refcount_update_cancel_item
      [bac3f7849252] xfs: don't bother calling xfs_refcount_finish_one_cleanup in xfs_refcount_finish_one
      [e51987a12cb5] xfs: simplify usage of the rcur local variable in xfs_refcount_finish_one
      [783e8a7c9cab] xfs: move xfs_refcount_update_defer_add to xfs_refcount_item.c

Dave Chinner (10):
      [613e2fdbbc7b] xfs: move and rename xfs_trans_committed_bulk
      [9adf40249e6c] xfs: AIL doesn't need manual pushing
      [b50b4c49d8d7] xfs: background AIL push should target physical space
      [a07776ab814d] xfs: ensure log tail is always up to date
      [0dcd5a10d987] xfs: l_last_sync_lsn is really AIL state
      [be5abd323bf4] xfs: collapse xlog_state_set_callback in caller
      [551bf13ba8b2] xfs: track log space pinned by the AIL
      [de302cea1e3b] xfs: pass the full grant head to accounting functions
      [c1220522ef40] xfs: grant heads track byte counts, not LSNs
      [f3f7ae68a4ea] xfs: skip flushing log items during push

Long Li (1):
      [49cdc4e834e4] xfs: get rid of xfs_ag_resv_rmapbt_alloc

Zizhi Wo (1):
      [94a0333b9212] xfs: Avoid races with cnt_btree lastrec updates

Code Diffstat:

 Documentation/ABI/testing/sysfs-fs-xfs |   26 +-
 fs/xfs/Kconfig                         |   12 +
 fs/xfs/Makefile                        |    1 +
 fs/xfs/libxfs/xfs_ag.c                 |    2 +-
 fs/xfs/libxfs/xfs_ag_resv.h            |   19 --
 fs/xfs/libxfs/xfs_alloc.c              |  207 ++++++++----
 fs/xfs/libxfs/xfs_alloc.h              |   12 +-
 fs/xfs/libxfs/xfs_alloc_btree.c        |   64 ----
 fs/xfs/libxfs/xfs_bmap.c               |   55 +++-
 fs/xfs/libxfs/xfs_bmap.h               |    3 +
 fs/xfs/libxfs/xfs_bmap_btree.c         |    2 +-
 fs/xfs/libxfs/xfs_btree.c              |   51 ---
 fs/xfs/libxfs/xfs_btree.h              |   16 +-
 fs/xfs/libxfs/xfs_defer.c              |    4 +-
 fs/xfs/libxfs/xfs_dir2.c               |  661 +++++++++++++++++++++++++++++++++++++-
 fs/xfs/libxfs/xfs_dir2.h               |   49 ++-
 fs/xfs/libxfs/xfs_format.h             |    9 +-
 fs/xfs/libxfs/xfs_ialloc.c             |   20 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c       |    2 +-
 fs/xfs/libxfs/xfs_inode_util.c         |  749 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_util.h         |   62 ++++
 fs/xfs/libxfs/xfs_ondisk.h             |    1 +
 fs/xfs/libxfs/xfs_refcount.c           |  156 +++------
 fs/xfs/libxfs/xfs_refcount.h           |   11 +-
 fs/xfs/libxfs/xfs_refcount_btree.c     |    2 +-
 fs/xfs/libxfs/xfs_rmap.c               |  268 ++++++----------
 fs/xfs/libxfs/xfs_rmap.h               |   15 +-
 fs/xfs/libxfs/xfs_rmap_btree.c         |    7 +-
 fs/xfs/libxfs/xfs_shared.h             |    7 -
 fs/xfs/libxfs/xfs_trans_inode.c        |    2 +
 fs/xfs/scrub/common.c                  |    1 +
 fs/xfs/scrub/newbt.c                   |    5 +-
 fs/xfs/scrub/reap.c                    |    7 +-
 fs/xfs/scrub/tempfile.c                |   21 +-
 fs/xfs/xfs.h                           |    4 +
 fs/xfs/xfs_bmap_item.c                 |    6 +-
 fs/xfs/xfs_buf_item.c                  |   32 ++
 fs/xfs/xfs_dquot_item.c                |   31 ++
 fs/xfs/xfs_drain.c                     |    8 +-
 fs/xfs/xfs_drain.h                     |    5 +-
 fs/xfs/xfs_extfree_item.c              |  115 ++++---
 fs/xfs/xfs_extfree_item.h              |    6 +
 fs/xfs/xfs_inode.c                     | 1484 ++++++++++---------------------------------------------------------------------------
 fs/xfs/xfs_inode.h                     |   70 ++--
 fs/xfs/xfs_inode_item.c                |   38 ++-
 fs/xfs/xfs_ioctl.c                     |   60 ----
 fs/xfs/xfs_iops.c                      |   51 +--
 fs/xfs/xfs_linux.h                     |    2 -
 fs/xfs/xfs_log.c                       |  511 +++++++----------------------
 fs/xfs/xfs_log.h                       |    1 -
 fs/xfs/xfs_log_cil.c                   |  177 ++++++++++-
 fs/xfs/xfs_log_priv.h                  |   61 ++--
 fs/xfs/xfs_log_recover.c               |   23 +-
 fs/xfs/xfs_qm.c                        |    7 +-
 fs/xfs/xfs_refcount_item.c             |  110 +++----
 fs/xfs/xfs_refcount_item.h             |    5 +
 fs/xfs/xfs_reflink.c                   |    2 +-
 fs/xfs/xfs_reflink.h                   |   10 -
 fs/xfs/xfs_rmap_item.c                 |  161 +++++-----
 fs/xfs/xfs_rmap_item.h                 |    4 +
 fs/xfs/xfs_symlink.c                   |   70 ++--
 fs/xfs/xfs_sysfs.c                     |   29 +-
 fs/xfs/xfs_trace.c                     |    3 +
 fs/xfs/xfs_trace.h                     |  502 ++++++++++++++++-------------
 fs/xfs/xfs_trans.c                     |  129 --------
 fs/xfs/xfs_trans.h                     |    5 +-
 fs/xfs/xfs_trans_ail.c                 |  244 +++++++-------
 fs/xfs/xfs_trans_priv.h                |   44 ++-
 68 files changed, 3306 insertions(+), 3233 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_inode_util.c
 create mode 100644 fs/xfs/libxfs/xfs_inode_util.h

