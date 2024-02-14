Return-Path: <linux-fsdevel+bounces-11512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CACB854319
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 07:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864571F21C7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 06:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE0911CA9;
	Wed, 14 Feb 2024 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUJG+TQa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74111715;
	Wed, 14 Feb 2024 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893599; cv=none; b=DT9LaxQGKcgQbQmnBoUhvkb/JVyWI9E0vtGhqNNKXaEoHTh5D1L5JS/7x95dnSc1hW9j8DrM0OimUdq1tbBILx22/54AIt097jjI14WcUJ2jcOR/NosIMDXzU0WXmr2eko04fRZisoy6aAROCqifTMei1K7P35vUAMXOxGExH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893599; c=relaxed/simple;
	bh=COzQrxMmJlOiXvpd5hv3+40JrOFh6HYrrF+QUeF/abU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hb63Oh+bkIZDrhWPhyOdFXflM0zPInxHOKLUa0ZVbSmMBXgNuLpzWuV4trVfp6aysYdEvfGnSce4iznJJUFHkVVro77t+7VKh58v44ZCjn43c5RYapI+XLHm7YDKnnnjwcnLcG+CH6u1IhnqNDGpXQCl1PiRakRkM5vYLQ8Px8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUJG+TQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CC2C43399;
	Wed, 14 Feb 2024 06:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707893599;
	bh=COzQrxMmJlOiXvpd5hv3+40JrOFh6HYrrF+QUeF/abU=;
	h=From:To:Cc:Subject:Date:From;
	b=EUJG+TQa5Rv5tXPxXwwPuKN/fE0RlxHHk6ntLekwYelVgk7FPpoH9LmKaMRY9W/Mq
	 wsSlLVO3CmVbU3psPJIHMqjcvR4rMpTV0oR9VgJmyzB/p5QoLyiFWtARUvsI9dSW88
	 kW7YEAgKZmfr6dEWkqrEiXneu298jR5EI9UavwFJKixBU/B+bRRZ4mU4Z+HKilJg4e
	 DF0PqA10DY4jerS3vMoLC1IaUArhZE7MjIzyGhPjg7sSGhKuqjjp8GHImG+VnXeeQ9
	 GyjKoIjsq34uCYcim/sIqjm1wF+GVPE1q3W5gqWoGv2HujpcBfFSppqiTpV1SJRWi2
	 rC7fhI8IuNnag==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: dchinner@redhat.com,djwong@kernel.org,hch@lst.de,kent.overstreet@linux.dev,leo.lilong@huawei.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,sshegde@linux.ibm.com,willy@infradead.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 9ee85f235efe
Date: Wed, 14 Feb 2024 12:18:41 +0530
Message-ID: <87frxva65g.fsf@debian-BULLSEYE-live-builder-AMD64>
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

9ee85f235efe xfs: ensure submit buffers on LSN boundaries in error handlers

35 new commits:

Christoph Hellwig (17):
      [f23e079e024c] mm: move mapping_set_update out of <linux/swap.h>
      [604ee858a8c8] shmem: move shmem_mapping out of line
      [8481cd645af6] shmem: set a_ops earlier in shmem_symlink
      [9b4ec2cf0154] shmem: move the shmem_mapping assert into shmem_get_folio_gfp
      [36e3263c623a] shmem: export shmem_get_folio
      [74f6fd19195a] shmem: export shmem_kernel_file_setup
      [eb84b86441e3] shmem: document how to "persist" data when using shmem_*file_setup
      [7712a852890f] xfs: remove xfile_stat
      [c6fcb46eb7ae] xfs: remove the xfile_pread/pwrite APIs
      [8672b3a8172c] xfs: don't try to handle non-update pages in xfile_obj_load
      [7391e9df8844] xfs: shmem_file_setup can't return NULL
      [2ac41afb75c3] xfs: don't modify file and inode flags for shmem files
      [6d8b3f1209e4] xfs: don't allow highmem pages in xfile mappings
      [509f2f9bb384] xfs: use shmem_get_folio in xfile_obj_store
      [ae2bb8c31c36] xfs: use shmem_get_folio in in xfile_load
      [167db3241ef0] xfs: remove xfarray_sortinfo.page_kaddr
      [97456c5eb256] xfs: fix a comment in xfarray.c

Darrick J. Wong (4):
      [513911e94428] xfs: add file_{get,put}_folio
      [cca31e401b4a] xfs: convert xfarray_pagesort to deal with large folios
      [42461a423bfe] xfs: remove xfile_{get,put}_page
      [6ef2978cfed8] xfs: disable sparse inode chunk alignment check when there is no alignment

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
      [9ee85f235efe] xfs: ensure submit buffers on LSN boundaries in error handlers

Shrikanth Hegde (1):
      [4d6933c1c21a] xfs: remove duplicate ifdefs

Code Diffstat:

 .../filesystems/xfs/xfs-online-fsck-design.rst    |  25 +-
 fs/xfs/Makefile                                   |   3 +-
 fs/xfs/kmem.c                                     |  30 --
 fs/xfs/kmem.h                                     |  83 -----
 fs/xfs/libxfs/xfs_ag.c                            |  10 +-
 fs/xfs/libxfs/xfs_attr.c                          |   3 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                     |  18 +-
 fs/xfs/libxfs/xfs_bmap.c                          |   2 +-
 fs/xfs/libxfs/xfs_btree.c                         |   2 +-
 fs/xfs/libxfs/xfs_btree.h                         |   4 +-
 fs/xfs/libxfs/xfs_btree_staging.c                 |  10 +-
 fs/xfs/libxfs/xfs_da_btree.c                      |  22 +-
 fs/xfs/libxfs/xfs_defer.c                         |  23 +-
 fs/xfs/libxfs/xfs_dir2.c                          |  48 ++-
 fs/xfs/libxfs/xfs_dir2_block.c                    |   6 +-
 fs/xfs/libxfs/xfs_dir2_sf.c                       |  16 +-
 fs/xfs/libxfs/xfs_iext_tree.c                     |  26 +-
 fs/xfs/libxfs/xfs_inode_fork.c                    |  29 +-
 fs/xfs/libxfs/xfs_refcount.c                      |   2 +-
 fs/xfs/libxfs/xfs_rmap.c                          |   2 +-
 fs/xfs/scrub/cow_repair.c                         |   2 +-
 fs/xfs/scrub/ialloc_repair.c                      |   2 +-
 fs/xfs/scrub/rtsummary.c                          |   6 +-
 fs/xfs/scrub/trace.h                              |  81 +++--
 fs/xfs/scrub/xfarray.c                            | 234 ++++++-------
 fs/xfs/scrub/xfarray.h                            |  11 +-
 fs/xfs/scrub/xfile.c                              | 345 +++++++------------
 fs/xfs/scrub/xfile.h                              |  62 +---
 fs/xfs/xfs_acl.c                                  |   4 +-
 fs/xfs/xfs_attr_item.c                            |  14 +-
 fs/xfs/xfs_attr_list.c                            |   6 +-
 fs/xfs/xfs_bmap_item.c                            |   7 +-
 fs/xfs/xfs_bmap_util.c                            |   2 +-
 fs/xfs/xfs_buf.c                                  |  48 +--
 fs/xfs/xfs_buf_item.c                             |   8 +-
 fs/xfs/xfs_buf_item_recover.c                     |   8 +-
 fs/xfs/xfs_discard.c                              |  17 +-
 fs/xfs/xfs_dquot.c                                |   2 +-
 fs/xfs/xfs_error.c                                |   8 +-
 fs/xfs/xfs_extent_busy.c                          |   5 +-
 fs/xfs/xfs_extfree_item.c                         |   8 +-
 fs/xfs/xfs_filestream.c                           |   6 +-
 fs/xfs/xfs_icache.c                               |   5 +-
 fs/xfs/xfs_icreate_item.c                         |   2 +-
 fs/xfs/xfs_inode.c                                |   4 +-
 fs/xfs/xfs_inode_item.c                           |   2 +-
 fs/xfs/xfs_inode_item_recover.c                   |   5 +-
 fs/xfs/xfs_ioctl.c                                |   8 +-
 fs/xfs/xfs_iops.c                                 |   2 +-
 fs/xfs/xfs_itable.c                               |  12 +-
 fs/xfs/xfs_iwalk.c                                |   9 +-
 fs/xfs/xfs_linux.h                                |  14 +-
 fs/xfs/xfs_log.c                                  |  20 +-
 fs/xfs/xfs_log_cil.c                              |  31 +-
 fs/xfs/xfs_log_recover.c                          | 101 ++++--
 fs/xfs/xfs_mount.c                                |   2 +-
 fs/xfs/xfs_mru_cache.c                            |  17 +-
 fs/xfs/xfs_qm.c                                   |  18 +-
 fs/xfs/xfs_refcount_item.c                        |  12 +-
 fs/xfs/xfs_rmap_item.c                            |  11 +-
 fs/xfs/xfs_rtalloc.c                              |  10 +-
 fs/xfs/xfs_super.c                                |   4 +-
 fs/xfs/xfs_sysfs.c                                |   4 -
 fs/xfs/xfs_trace.h                                |  25 --
 fs/xfs/xfs_trans_ail.c                            |   7 +-
 include/linux/shmem_fs.h                          |   6 +-
 include/linux/swap.h                              |  10 -
 mm/filemap.c                                      |   9 +
 mm/internal.h                                     |   4 +
 mm/shmem.c                                        |  37 +-
 mm/workingset.c                                   |   1 +
 71 files changed, 722 insertions(+), 920 deletions(-)
 delete mode 100644 fs/xfs/kmem.c
 delete mode 100644 fs/xfs/kmem.h

