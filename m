Return-Path: <linux-fsdevel+bounces-17486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7748AE1F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2805F282C4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7D60ED3;
	Tue, 23 Apr 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkZX5Mbe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8FF5FB9B;
	Tue, 23 Apr 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867448; cv=none; b=D9bt/b1qx2PyE3011DRE8AmYeiQfbnTVwLreMvY01wlTWYf0XmRuIi6HxMQrcWYj/QtiHpLCJigwcAUEKEczWnpyqTDMHDI6akIuHvGNTWV6/MgrTYYg+iTulQgy6R0GAT8UkCC8ofNOgsT02TFks5skVKbBBgTG4R3NsgsX2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867448; c=relaxed/simple;
	bh=g97Q5WKTti1lvGYjtaVYb1xsYis+AkbzMbtB6NWEOBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sQDlANmnuNJaMg3ODiY5mB/Ak+OR4A4nHnxXMfalYuO1hSt5cqnmHAT4L0HXYUSyglAzi8txtRwxQdoC6AK8wfTeQDg14mDx7bhFIP5q7N6E5thN8J77kKQd8bjPwPcxmlt+4YMI6rTjT9J07VdHdoywbK92x5E4fa94nXe8BXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkZX5Mbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D231DC3277B;
	Tue, 23 Apr 2024 10:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867448;
	bh=g97Q5WKTti1lvGYjtaVYb1xsYis+AkbzMbtB6NWEOBo=;
	h=From:To:Cc:Subject:Date:From;
	b=GkZX5Mbe+DcfBnNpYb4lSxBDtXqoBKsSrv5XoV1ENL9c1t/ltmOMxslfjjH0rrzHB
	 gAhZcUP/l04g12oYhP3mM8VVIKHNP1/LK2G4N371h73irnMebtbuSej6z06DLn0yuX
	 CVcqoKqgPmBsy6gUBGjrkRZelw0d+DgEfDYN1Tn+iUEHMEy/3nhdg2XdXN0VTibH0E
	 Zmpcvl6Ijh4Qp+0E+5kpI90kHwfenHZGZJgfy7w4vaUJWWOfO7EfeWVCuXrXaB+/r0
	 GAas/3FHd4wqOIDgnjsX0FKLQZsJDjUH4qZrQ/r154wiBALZl2gC0KLcwXG/5W+6+G
	 9s8CspQHoARKw==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: dchinner@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 6a94b1acda7e
Date: Tue, 23 Apr 2024 15:46:24 +0530
Message-ID: <87bk60z8lm.fsf@debian-BULLSEYE-live-builder-AMD64>
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

6a94b1acda7e xfs: reinstate delalloc for RT inodes (if sb_rextsize == 1)

17 new commits:

Christoph Hellwig (17):
      [e78a3ce28331] xfs: move more logic into xfs_extent_busy_clear_one
      [c37d6ed87462] xfs: unwind xfs_extent_busy_clear
      [c0ac6cb251bd] xfs: remove the unused xfs_extent_busy_enomem trace event
      [4887e5316382] xfs: compile out v4 support if disabled
      [330c4f94b0d7] xfs: make XFS_TRANS_LOWMODE match the other XFS_TRANS_ definitions
      [b7e23c0e2e3b] xfs: refactor realtime inode locking
      [9871d0963751] xfs: free RT extents after updating the bmap btree
      [de37dbd0ccc6] xfs: move RT inode locking out of __xfs_bunmapi
      [5e1e4d4fc79c] xfs: block deltas in xfs_trans_unreserve_and_mod_sb must be positive
      [f30f656e25eb] xfs: split xfs_mod_freecounter
      [dc1b17a25c32] xfs: reinstate RT support in xfs_bmapi_reserve_delalloc
      [7e77d57a1fea] xfs: cleanup fdblock/frextent accounting in xfs_bmap_del_extent_delay
      [7099bd0f243f] xfs: support RT inodes in xfs_mod_delalloc
      [727f8431638f] xfs: look at m_frextents in xfs_iomap_prealloc_size for RT allocations
      [da2b9c3a8d2c] xfs: rework splitting of indirect block reservations
      [bd1753d8c42b] xfs: stop the steal (of data blocks for RT indirect blocks)
      [6a94b1acda7e] xfs: reinstate delalloc for RT inodes (if sb_rextsize == 1)

Please note that the patch "xfs: fix sparse warning in xfs_extent_busy_clear"
has been dropped now.

Code Diffstat:

 fs/xfs/libxfs/xfs_ag.c           |   4 +--
 fs/xfs/libxfs/xfs_ag_resv.c      |  24 ++++-----------
 fs/xfs/libxfs/xfs_ag_resv.h      |   2 +-
 fs/xfs/libxfs/xfs_alloc.c        |   4 +--
 fs/xfs/libxfs/xfs_bmap.c         | 152 +++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------
 fs/xfs/libxfs/xfs_rtbitmap.c     |  57 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_rtbitmap.h     |  17 +++++++++++
 fs/xfs/libxfs/xfs_shared.h       |   6 ++--
 fs/xfs/scrub/common.c            |   1 +
 fs/xfs/scrub/fscounters.c        |  12 +++++---
 fs/xfs/scrub/fscounters.h        |   1 +
 fs/xfs/scrub/fscounters_repair.c |  12 +++++++-
 fs/xfs/scrub/repair.c            |   5 +--
 fs/xfs/xfs_extent_busy.c         |  80 ++++++++++++++++++++++--------------------------
 fs/xfs/xfs_fsmap.c               |   4 +--
 fs/xfs/xfs_fsops.c               |  29 +++++-------------
 fs/xfs/xfs_fsops.h               |   2 +-
 fs/xfs/xfs_inode.c               |   3 +-
 fs/xfs/xfs_iomap.c               |  45 ++++++++++++++++++---------
 fs/xfs/xfs_iops.c                |   2 +-
 fs/xfs/xfs_mount.c               |  87 +++++++++++++++++++++++++++++++----------------------
 fs/xfs/xfs_mount.h               |  76 +++++++++++++++++++++++++++++++++++-----------
 fs/xfs/xfs_rtalloc.c             |  22 +++++---------
 fs/xfs/xfs_super.c               |  39 +++++++++++++++---------
 fs/xfs/xfs_trace.h               |   2 --
 fs/xfs/xfs_trans.c               |  63 ++++++++++++++++++++------------------
 26 files changed, 439 insertions(+), 312 deletions(-)

