Return-Path: <linux-fsdevel+bounces-12209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5037285D032
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38941F2574A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 06:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02B3A1D7;
	Wed, 21 Feb 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZr2wFSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881B3A1C4;
	Wed, 21 Feb 2024 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495282; cv=none; b=ZjNv6ojkO0NF+oBcBr3tVIjk2//eknuphOFOCKZj1Kekign9ko8klHFiaMk4bIMvNprXDKhEMe13PclqbD1I5b6FrPb6oLig1YvfSo6+xB0OY0H3yAA+OO2Usa8uZwaYmIMrp95FbaUl9Dke7eih4g2zCthEXNRPdg6j+DinNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495282; c=relaxed/simple;
	bh=TJ97kyoiqChTlR8KmPwFcBRgyqvwb9dminaw9Q/iUfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=opVaV7vg4zCc4iZULJVK9lSjNzeEDXHrqEOBjU0q51l1t6NMdiZsgnKrMPf8SwiL9bee+pn7T7yimmfjnx84wM654Wsw8V5gdD3kRZ2w7r8M1HAgt+Ov8rnfL9uYN3zyov8m+Zs/5YvVxe0aF16YUIPzLswGHdiQk9+4FF8aL38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZr2wFSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F5EC433F1;
	Wed, 21 Feb 2024 06:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708495282;
	bh=TJ97kyoiqChTlR8KmPwFcBRgyqvwb9dminaw9Q/iUfQ=;
	h=From:To:Cc:Subject:Date:From;
	b=VZr2wFSfNhDGy/uA06lQIPeYYS5A1uHy0DcQThEd7znaRNLvF8zynV1n3+wZDaCi3
	 47B69kdt+AOQMad9UhddqH+HSE5OSUIcygvLZQMQIxW3aKLSk9Oxzo7F4zf3sTWhog
	 IIH4FMeUCax0005ScXEmPLqnYCyUYA30eCqM877KYdHR/B4YmuVy8/u6gCViBM2Rd0
	 BRGPQkBfb65Is/u6K+AIQ52a8Ly+lahunjtC5umfNsQglNfsKzU0yo1NKjdCJg94t3
	 Gd4gsX+m7Xjeox7CwqwZQa9Qaz0cGXBqG377zL+wBQrcTVEUtvEDeY51GnVRyDoTLy
	 4vz7QKjvdr+VQ==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: cmaiolino@redhat.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,kch@nvidia.com,leo.lilong@huawei.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,longman@redhat.com,peterz@infradead.org,sshegde@linux.ibm.com,willy@infradead.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 7d5ba7ca6a45
Date: Wed, 21 Feb 2024 11:30:20 +0530
Message-ID: <874je2iceq.fsf@debian-BULLSEYE-live-builder-AMD64>
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

7d5ba7ca6a45 xfs: use kvfree in xfs_ioc_getfsmap()

21 new commits:

Christoph Hellwig (1):
      [49c379d3a72a] xfs: use kvfree for buf in xfs_ioc_getbmap

Darrick J. Wong (1):
      [1149314a16f7] xfs: disable sparse inode chunk alignment check when there is no alignment

Dave Chinner (14):
      [10634530f7ba] xfs: convert kmem_zalloc() to kzalloc()
      [f078d4ea8276] xfs: convert kmem_alloc() to kmalloc()
      [afdc115559c5] xfs: move kmem_to_page()
      [49292576136f] xfs: convert kmem_free() for kvmalloc users to kvfree()
      [d4c75a1b40cd] xfs: convert remaining kmem_free() to kfree()
      [178231af2bdc] xfs: use an empty transaction for fstrim
      [94a69db2367e] xfs: use __GFP_NOLOCKDEP instead of GFP_NOFS
      [0b3a76e955eb] xfs: use GFP_KERNEL in pure transaction contexts
      [2c1e31ed5c88] xfs: place intent recovery under NOFS allocation context
      [c704ecb2410e] xfs: place the CIL under nofs allocation context
      [204fae32d5f7] xfs: clean up remaining GFP_NOFS users
      [57b98393b812] xfs: use xfs_defer_alloc a bit more
      [661723c3bdaf] xfs: use kvfree() in xfs_ioc_attr_list()
      [7d5ba7ca6a45] xfs: use kvfree in xfs_ioc_getfsmap()

Long Li (1):
      [e4c3b72a6ea9] xfs: ensure submit buffers on LSN boundaries in error handlers

Matthew Wilcox (Oracle) (3):
      [f70405afc99b] locking: Add rwsem_assert_held() and rwsem_assert_held_write()
      [3fed24fffc76] xfs: Replace xfs_isilocked with xfs_assert_ilocked
      [785dd1315250] xfs: Remove mrlock wrapper

Shrikanth Hegde (1):
      [0164defd0d86] xfs: remove duplicate ifdefs

Code Diffstat:

 fs/xfs/Makefile                   |   3 +--
 fs/xfs/kmem.c                     |  30 -------------------------
 fs/xfs/kmem.h                     |  83 -------------------------------------------------------------------
 fs/xfs/libxfs/xfs_ag.c            |  10 ++++-----
 fs/xfs/libxfs/xfs_attr.c          |   5 +++--
 fs/xfs/libxfs/xfs_attr_leaf.c     |  18 +++++++--------
 fs/xfs/libxfs/xfs_attr_remote.c   |   2 +-
 fs/xfs/libxfs/xfs_bmap.c          |  23 +++++++++----------
 fs/xfs/libxfs/xfs_btree.c         |   2 +-
 fs/xfs/libxfs/xfs_btree.h         |   4 +++-
 fs/xfs/libxfs/xfs_btree_staging.c |  10 ++++-----
 fs/xfs/libxfs/xfs_da_btree.c      |  22 ++++++++++--------
 fs/xfs/libxfs/xfs_defer.c         |  25 +++++++++------------
 fs/xfs/libxfs/xfs_dir2.c          |  48 +++++++++++++++++----------------------
 fs/xfs/libxfs/xfs_dir2_block.c    |   6 ++---
 fs/xfs/libxfs/xfs_dir2_sf.c       |  16 ++++++-------
 fs/xfs/libxfs/xfs_iext_tree.c     |  26 +++++++++++++--------
 fs/xfs/libxfs/xfs_inode_fork.c    |  31 +++++++++++++------------
 fs/xfs/libxfs/xfs_refcount.c      |   2 +-
 fs/xfs/libxfs/xfs_rmap.c          |   2 +-
 fs/xfs/libxfs/xfs_rtbitmap.c      |   2 +-
 fs/xfs/libxfs/xfs_trans_inode.c   |   6 ++---
 fs/xfs/mrlock.h                   |  78 ---------------------------------------------------------------
 fs/xfs/scrub/cow_repair.c         |   2 +-
 fs/xfs/scrub/ialloc_repair.c      |   2 +-
 fs/xfs/scrub/readdir.c            |   4 ++--
 fs/xfs/xfs_acl.c                  |   4 ++--
 fs/xfs/xfs_attr_item.c            |  14 ++++++------
 fs/xfs/xfs_attr_list.c            |   8 +++----
 fs/xfs/xfs_bmap_item.c            |   7 +++---
 fs/xfs/xfs_bmap_util.c            |  12 +++++-----
 fs/xfs/xfs_buf.c                  |  48 ++++++++++++++++++++++-----------------
 fs/xfs/xfs_buf_item.c             |   8 +++----
 fs/xfs/xfs_buf_item_recover.c     |   8 +++----
 fs/xfs/xfs_dir2_readdir.c         |   2 +-
 fs/xfs/xfs_discard.c              |  17 +++++++++-----
 fs/xfs/xfs_dquot.c                |   6 ++---
 fs/xfs/xfs_error.c                |   8 +++----
 fs/xfs/xfs_extent_busy.c          |   5 +++--
 fs/xfs/xfs_extfree_item.c         |   8 +++----
 fs/xfs/xfs_file.c                 |   4 ++--
 fs/xfs/xfs_filestream.c           |   6 ++---
 fs/xfs/xfs_icache.c               |   5 ++---
 fs/xfs/xfs_icreate_item.c         |   2 +-
 fs/xfs/xfs_inode.c                |  90 ++++++++++++++++++++++++++++---------------------------------------------
 fs/xfs/xfs_inode.h                |   4 ++--
 fs/xfs/xfs_inode_item.c           |   6 ++---
 fs/xfs/xfs_inode_item_recover.c   |   5 +++--
 fs/xfs/xfs_ioctl.c                |   8 +++----
 fs/xfs/xfs_iops.c                 |   9 ++++----
 fs/xfs/xfs_itable.c               |  12 +++++-----
 fs/xfs/xfs_iwalk.c                |   9 ++++----
 fs/xfs/xfs_linux.h                |  16 ++++++++++---
 fs/xfs/xfs_log.c                  |  20 +++++++++--------
 fs/xfs/xfs_log_cil.c              |  31 ++++++++++++++++---------
 fs/xfs/xfs_log_recover.c          | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 fs/xfs/xfs_mount.c                |   2 +-
 fs/xfs/xfs_mru_cache.c            |  17 +++++++-------
 fs/xfs/xfs_qm.c                   |  28 ++++++++++++-----------
 fs/xfs/xfs_refcount_item.c        |  12 +++++-----
 fs/xfs/xfs_reflink.c              |   2 +-
 fs/xfs/xfs_rmap_item.c            |  11 ++++-----
 fs/xfs/xfs_rtalloc.c              |  12 +++++-----
 fs/xfs/xfs_super.c                |   8 +++----
 fs/xfs/xfs_symlink.c              |   2 +-
 fs/xfs/xfs_sysfs.c                |   4 ----
 fs/xfs/xfs_trace.h                |  25 ---------------------
 fs/xfs/xfs_trans.c                |   2 +-
 fs/xfs/xfs_trans_ail.c            |   7 +++---
 fs/xfs/xfs_trans_dquot.c          |   2 +-
 include/linux/rwbase_rt.h         |   9 ++++++--
 include/linux/rwsem.h             |  46 ++++++++++++++++++++++++++++++++-----
 72 files changed, 502 insertions(+), 632 deletions(-)
 delete mode 100644 fs/xfs/kmem.c
 delete mode 100644 fs/xfs/kmem.h
 delete mode 100644 fs/xfs/mrlock.h

