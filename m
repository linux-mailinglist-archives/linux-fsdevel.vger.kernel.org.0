Return-Path: <linux-fsdevel+bounces-12027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953B685A6D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 16:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BFD1F218E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8A138389;
	Mon, 19 Feb 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF/pbAKl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F2381AB;
	Mon, 19 Feb 2024 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355092; cv=none; b=YZeaITLQKblozU/2srlJKogNGZjI4x9TMgE8OTfh+poO0cUJy0UXJukgHl/wggF3a0kkf06iDISKLlzPgEoYVdPPFn3a90n+Ic+OTSNz5av1o3pwwFbn0mLyGWH3dErEmNCrquEP4ifjt/+OJQktYlc8gWHYmMgttuUgh7B5yhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355092; c=relaxed/simple;
	bh=eZ3HWDpezrY0KFAZANvuBx9JlcELMR41Z7btSvybG9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FTyCLlsNgeqtGluXTe+MvWuvZ1qomb7uhj1Tyo5/Bn3W+C/BEM0cX5XmmOVKtbvkiOEEDjfDFFBqSfOMOrtlOdTMtOQKzg35XKHLE6W80HftQbmbEWXJz3cV5LRGl6KNgeCBn0nMQz5PltLv0jn0HesZ18Arq+UN5tehbCW25fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF/pbAKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B499FC433F1;
	Mon, 19 Feb 2024 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708355092;
	bh=eZ3HWDpezrY0KFAZANvuBx9JlcELMR41Z7btSvybG9s=;
	h=From:To:Cc:Subject:Date:From;
	b=LF/pbAKlwL+3mG78luGmxy/orTvEe90grZSOMOVDABydD8Nd6xihahAurAb3zkKuO
	 yQakoyJfphrsJ2llItRLPVf8aQ6Atd9QVud1zA12h6D534zKRyNE1H9Cr1tVkyeAk7
	 a4L4wov5kf258lBYaLe/KGEx1dSf8NKQLopxJAEy0xlQgK2Xy9szV+zmTmxwaKuwie
	 82NDfYWq4LGx4ZCzr5kNgIRTi9S047v7PTy0PxVXVMLptdnJqyzcABGIdYib9rFjvu
	 m6BxHZLZUvWFUb0FF6hxtANIlqxRzHX1Cc40wJEe1NCHTBHztYrcC9IW6Smc08A7YV
	 scKXv/LNe931g==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: cmaiolino@redhat.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,kch@nvidia.com,leo.lilong@huawei.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,sshegde@linux.ibm.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 49c379d3a72a
Date: Mon, 19 Feb 2024 20:28:33 +0530
Message-ID: <87edd8wl4f.fsf@debian-BULLSEYE-live-builder-AMD64>
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

49c379d3a72a xfs: use kvfree for buf in xfs_ioc_getbmap

I have now dropped previously merged "put the xfs xfile abstraction on a diet"
patchset.

16 new commits:

Christoph Hellwig (1):
      [49c379d3a72a] xfs: use kvfree for buf in xfs_ioc_getbmap

Darrick J. Wong (1):
      [1149314a16f7] xfs: disable sparse inode chunk alignment check when there is no alignment

Dave Chinner (12):
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

Long Li (1):
      [e4c3b72a6ea9] xfs: ensure submit buffers on LSN boundaries in error handlers

Shrikanth Hegde (1):
      [0164defd0d86] xfs: remove duplicate ifdefs

Code Diffstat:

 fs/xfs/Makefile                   |   3 +-
 fs/xfs/kmem.c                     |  30 ------
 fs/xfs/kmem.h                     |  83 ---------------
 fs/xfs/libxfs/xfs_ag.c            |  10 +-
 fs/xfs/libxfs/xfs_attr.c          |   3 +-
 fs/xfs/libxfs/xfs_attr_leaf.c     |  18 ++--
 fs/xfs/libxfs/xfs_bmap.c          |   2 +-
 fs/xfs/libxfs/xfs_btree.c         |   2 +-
 fs/xfs/libxfs/xfs_btree.h         |   4 +-
 fs/xfs/libxfs/xfs_btree_staging.c |  10 +-
 fs/xfs/libxfs/xfs_da_btree.c      |  22 ++--
 fs/xfs/libxfs/xfs_defer.c         |  23 ++---
 fs/xfs/libxfs/xfs_dir2.c          |  48 ++++-----
 fs/xfs/libxfs/xfs_dir2_block.c    |   6 +-
 fs/xfs/libxfs/xfs_dir2_sf.c       |  16 +--
 fs/xfs/libxfs/xfs_iext_tree.c     |  26 +++--
 fs/xfs/libxfs/xfs_inode_fork.c    |  29 +++---
 fs/xfs/libxfs/xfs_refcount.c      |   2 +-
 fs/xfs/libxfs/xfs_rmap.c          |   2 +-
 fs/xfs/scrub/cow_repair.c         |   2 +-
 fs/xfs/scrub/ialloc_repair.c      |   2 +-
 fs/xfs/xfs_acl.c                  |   4 +-
 fs/xfs/xfs_attr_item.c            |  14 +--
 fs/xfs/xfs_attr_list.c            |   6 +-
 fs/xfs/xfs_bmap_item.c            |   7 +-
 fs/xfs/xfs_bmap_util.c            |   2 +-
 fs/xfs/xfs_buf.c                  |  48 +++++----
 fs/xfs/xfs_buf_item.c             |   8 +-
 fs/xfs/xfs_buf_item_recover.c     |   8 +-
 fs/xfs/xfs_discard.c              |  17 +++-
 fs/xfs/xfs_dquot.c                |   2 +-
 fs/xfs/xfs_error.c                |   8 +-
 fs/xfs/xfs_extent_busy.c          |   5 +-
 fs/xfs/xfs_extfree_item.c         |   8 +-
 fs/xfs/xfs_filestream.c           |   6 +-
 fs/xfs/xfs_icache.c               |   5 +-
 fs/xfs/xfs_icreate_item.c         |   2 +-
 fs/xfs/xfs_inode.c                |   4 +-
 fs/xfs/xfs_inode_item.c           |   2 +-
 fs/xfs/xfs_inode_item_recover.c   |   5 +-
 fs/xfs/xfs_ioctl.c                |   8 +-
 fs/xfs/xfs_iops.c                 |   2 +-
 fs/xfs/xfs_itable.c               |  12 +--
 fs/xfs/xfs_iwalk.c                |   9 +-
 fs/xfs/xfs_linux.h                |  14 ++-
 fs/xfs/xfs_log.c                  |  20 ++--
 fs/xfs/xfs_log_cil.c              |  31 ++++--
 fs/xfs/xfs_log_recover.c          | 101 ++++++++++++-------
 fs/xfs/xfs_mount.c                |   2 +-
 fs/xfs/xfs_mru_cache.c            |  17 ++--
 fs/xfs/xfs_qm.c                   |  18 ++--
 fs/xfs/xfs_refcount_item.c        |  12 +--
 fs/xfs/xfs_rmap_item.c            |  11 +-
 fs/xfs/xfs_rtalloc.c              |  10 +-
 fs/xfs/xfs_super.c                |   4 +-
 fs/xfs/xfs_sysfs.c                |   4 -
 fs/xfs/xfs_trace.h                |  25 -----
 fs/xfs/xfs_trans_ail.c            |   7 +-
 58 files changed, 373 insertions(+), 438 deletions(-)
 delete mode 100644 fs/xfs/kmem.c
 delete mode 100644 fs/xfs/kmem.h

