Return-Path: <linux-fsdevel+bounces-12420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F55785F180
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 07:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB81C2138B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 06:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E52317743;
	Thu, 22 Feb 2024 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxl+cVBv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14B10A19;
	Thu, 22 Feb 2024 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708583254; cv=none; b=BOqO0pPmtJMdz0cOVYfyibPlpbqbNvej9jYGXhmvgHFSmpsuHM318Bss91MI5vBQHSFDf0lxpuw7QbVZsg0sPYwuscprsNEHsUhHJNCnVmO5zrUVapOgk0raaZWolh8uUcewDbxyongftiBFSvapTyPASFsjbgCxWY5dZMQDBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708583254; c=relaxed/simple;
	bh=hhnScpidmd3ZYOskmlZQo6jQR4y1uMF1N2mQkT1JuIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QMAFaGkowzQf0YwjYptkjpygHLQ6tnTOVtEh2UqAYwiDqiux7DHg8Bzas+fWuLJV9fYI9iJoP4dCB71Z4D7ljJaXbNDA+zw2XTznkazIn1k85ar2wB9S9VKsaiGtw58hNFOcpmrjB3Mw2ehd2jca3Uu4crmTOZzVqDGQxA97LGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxl+cVBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D70C433F1;
	Thu, 22 Feb 2024 06:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708583253;
	bh=hhnScpidmd3ZYOskmlZQo6jQR4y1uMF1N2mQkT1JuIE=;
	h=From:To:Cc:Subject:Date:From;
	b=bxl+cVBvVIHw1Ku92G1N5EeeVd/g9gGCUWmg+nKxEQtc3T+ZNhiPUqn7XKJobDt6L
	 /g3P780ECb+eqkoAuEq1CdAxfayIihBfe3NBxwJPDeMBhx3Vt2w0NetyLSwk6WsVA/
	 mdhkeOnFvpC/hu0ljMzYzTwnHU/2dttL3jDAnoaoHnWmvrN+wmyiSqZJ4M0KcTDZH6
	 Lu6QCNr2ZU6PR4d5S3Ctuk2jDBS87ofreUXENHWZqt1zqnNQcQ5IKhYb4FT8o4aPje
	 TdCjQSX4kgzUBtDrqEr26eIovJfGnx94/Z7OPLXuM1MafThiglIJVs8spbMV7faVoP
	 yxg+62cAGZHDA==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: cmaiolino@redhat.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,hughd@google.com,kch@nvidia.com,kent.overstreet@linux.dev,leo.lilong@huawei.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,longman@redhat.com,peterz@infradead.org,sshegde@linux.ibm.com,willy@infradead.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 4b2f459d8625
Date: Thu, 22 Feb 2024 11:56:03 +0530
Message-ID: <871q9557zh.fsf@debian-BULLSEYE-live-builder-AMD64>
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

4b2f459d8625 xfs: fix SEEK_HOLE/DATA for regions with active COW extents

44 new commits:

Christoph Hellwig (20):
      [49c379d3a72a] xfs: use kvfree for buf in xfs_ioc_getbmap
      [b64e74e95aa6] mm: move mapping_set_update out of <linux/swap.h>
      [aefacb2041f7] shmem: move shmem_mapping out of line
      [e11381d83d72] shmem: set a_ops earlier in shmem_symlink
      [1cd81faaf61b] shmem: move the shmem_mapping assert into shmem_get_folio_gfp
      [d7468609ee0f] shmem: export shmem_get_folio
      [be9d93661d54] shmem: export shmem_kernel_file_setup
      [9d8b36744935] shmem: document how to "persist" data when using shmem_*file_setup
      [b44c0eb8ae9c] xfs: use VM_NORESERVE in xfile_create
      [1b07ea2ab3dc] xfs: shmem_file_setup can't return NULL
      [efc9dc096399] xfs: use shmem_kernel_file_setup in xfile_create
      [a2078df025d9] xfs: don't modify file and inode flags for shmem files
      [0473635d46e2] xfs: remove xfile_stat
      [e47e2e0ba910] xfs: remove the xfile_pread/pwrite APIs
      [0e2a24afb992] xfs: don't try to handle non-update pages in xfile_obj_load
      [e62e26acc9ab] xfs: don't allow highmem pages in xfile mappings
      [fd2634e2dd45] xfs: use shmem_get_folio in xfile_obj_store
      [e97d70a57370] xfs: use shmem_get_folio in in xfile_load
      [fd3d46e63040] xfs: remove xfarray_sortinfo.page_kaddr
      [b2fdfe19dfd7] xfs: fix a comment in xfarray.c

Darrick J. Wong (4):
      [1149314a16f7] xfs: disable sparse inode chunk alignment check when there is no alignment
      [6907e3c00a40] xfs: add file_{get,put}_folio
      [ee13fc67205b] xfs: convert xfarray_pagesort to deal with large folios
      [e5a2f47cff81] xfs: remove xfile_{get,put}_page

Dave Chinner (15):
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
      [4b2f459d8625] xfs: fix SEEK_HOLE/DATA for regions with active COW extents

Long Li (1):
      [e4c3b72a6ea9] xfs: ensure submit buffers on LSN boundaries in error handlers

Matthew Wilcox (Oracle) (3):
      [f70405afc99b] locking: Add rwsem_assert_held() and rwsem_assert_held_write()
      [3fed24fffc76] xfs: Replace xfs_isilocked with xfs_assert_ilocked
      [785dd1315250] xfs: Remove mrlock wrapper

Shrikanth Hegde (1):
      [0164defd0d86] xfs: remove duplicate ifdefs

Code Diffstat:

 Documentation/filesystems/xfs/xfs-online-fsck-design.rst |  25 ++---
 fs/xfs/Makefile                                          |   3 +-
 fs/xfs/kmem.c                                            |  30 ------
 fs/xfs/kmem.h                                            |  83 --------------
 fs/xfs/libxfs/xfs_ag.c                                   |  10 +-
 fs/xfs/libxfs/xfs_attr.c                                 |   5 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                            |  18 ++--
 fs/xfs/libxfs/xfs_attr_remote.c                          |   2 +-
 fs/xfs/libxfs/xfs_bmap.c                                 |  23 ++--
 fs/xfs/libxfs/xfs_btree.c                                |   2 +-
 fs/xfs/libxfs/xfs_btree.h                                |   4 +-
 fs/xfs/libxfs/xfs_btree_staging.c                        |  10 +-
 fs/xfs/libxfs/xfs_da_btree.c                             |  22 ++--
 fs/xfs/libxfs/xfs_defer.c                                |  25 ++---
 fs/xfs/libxfs/xfs_dir2.c                                 |  48 ++++-----
 fs/xfs/libxfs/xfs_dir2_block.c                           |   6 +-
 fs/xfs/libxfs/xfs_dir2_sf.c                              |  16 +--
 fs/xfs/libxfs/xfs_iext_tree.c                            |  26 +++--
 fs/xfs/libxfs/xfs_inode_fork.c                           |  31 +++---
 fs/xfs/libxfs/xfs_refcount.c                             |   2 +-
 fs/xfs/libxfs/xfs_rmap.c                                 |   2 +-
 fs/xfs/libxfs/xfs_rtbitmap.c                             |   2 +-
 fs/xfs/libxfs/xfs_trans_inode.c                          |   6 +-
 fs/xfs/mrlock.h                                          |  78 --------------
 fs/xfs/scrub/cow_repair.c                                |   2 +-
 fs/xfs/scrub/ialloc_repair.c                             |   2 +-
 fs/xfs/scrub/readdir.c                                   |   4 +-
 fs/xfs/scrub/rtsummary.c                                 |   6 +-
 fs/xfs/scrub/trace.h                                     |  81 +++++++++-----
 fs/xfs/scrub/xfarray.c                                   | 234 ++++++++++++++++++----------------------
 fs/xfs/scrub/xfarray.h                                   |  11 +-
 fs/xfs/scrub/xfile.c                                     | 345 +++++++++++++++++++++--------------------------------------
 fs/xfs/scrub/xfile.h                                     |  62 ++---------
 fs/xfs/xfs_acl.c                                         |   4 +-
 fs/xfs/xfs_attr_item.c                                   |  14 +--
 fs/xfs/xfs_attr_list.c                                   |   8 +-
 fs/xfs/xfs_bmap_item.c                                   |   7 +-
 fs/xfs/xfs_bmap_util.c                                   |  12 +--
 fs/xfs/xfs_buf.c                                         |  48 +++++----
 fs/xfs/xfs_buf_item.c                                    |   8 +-
 fs/xfs/xfs_buf_item_recover.c                            |   8 +-
 fs/xfs/xfs_dir2_readdir.c                                |   2 +-
 fs/xfs/xfs_discard.c                                     |  17 ++-
 fs/xfs/xfs_dquot.c                                       |   6 +-
 fs/xfs/xfs_error.c                                       |   8 +-
 fs/xfs/xfs_extent_busy.c                                 |   5 +-
 fs/xfs/xfs_extfree_item.c                                |   8 +-
 fs/xfs/xfs_file.c                                        |   4 +-
 fs/xfs/xfs_filestream.c                                  |   6 +-
 fs/xfs/xfs_icache.c                                      |   5 +-
 fs/xfs/xfs_icreate_item.c                                |   2 +-
 fs/xfs/xfs_inode.c                                       |  90 ++++++----------
 fs/xfs/xfs_inode.h                                       |   4 +-
 fs/xfs/xfs_inode_item.c                                  |   6 +-
 fs/xfs/xfs_inode_item_recover.c                          |   5 +-
 fs/xfs/xfs_ioctl.c                                       |   8 +-
 fs/xfs/xfs_iomap.c                                       |   4 +-
 fs/xfs/xfs_iops.c                                        |   9 +-
 fs/xfs/xfs_itable.c                                      |  12 +--
 fs/xfs/xfs_iwalk.c                                       |   9 +-
 fs/xfs/xfs_linux.h                                       |  16 ++-
 fs/xfs/xfs_log.c                                         |  20 ++--
 fs/xfs/xfs_log_cil.c                                     |  31 ++++--
 fs/xfs/xfs_log_recover.c                                 | 101 ++++++++++-------
 fs/xfs/xfs_mount.c                                       |   2 +-
 fs/xfs/xfs_mru_cache.c                                   |  17 +--
 fs/xfs/xfs_qm.c                                          |  28 ++---
 fs/xfs/xfs_refcount_item.c                               |  12 +--
 fs/xfs/xfs_reflink.c                                     |   2 +-
 fs/xfs/xfs_rmap_item.c                                   |  11 +-
 fs/xfs/xfs_rtalloc.c                                     |  12 +--
 fs/xfs/xfs_super.c                                       |   8 +-
 fs/xfs/xfs_symlink.c                                     |   2 +-
 fs/xfs/xfs_sysfs.c                                       |   4 -
 fs/xfs/xfs_trace.h                                       |  25 -----
 fs/xfs/xfs_trans.c                                       |   2 +-
 fs/xfs/xfs_trans_ail.c                                   |   7 +-
 fs/xfs/xfs_trans_dquot.c                                 |   2 +-
 include/linux/rwbase_rt.h                                |   9 +-
 include/linux/rwsem.h                                    |  46 +++++++-
 include/linux/shmem_fs.h                                 |   6 +-
 include/linux/swap.h                                     |  10 --
 mm/filemap.c                                             |   9 ++
 mm/internal.h                                            |   4 +
 mm/shmem.c                                               |  42 +++++++-
 mm/workingset.c                                          |   1 +
 86 files changed, 858 insertions(+), 1116 deletions(-)
 delete mode 100644 fs/xfs/kmem.c
 delete mode 100644 fs/xfs/kmem.h
 delete mode 100644 fs/xfs/mrlock.h

