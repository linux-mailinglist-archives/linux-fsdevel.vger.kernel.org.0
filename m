Return-Path: <linux-fsdevel+bounces-12765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6B086704B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3BBB211BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3215F551;
	Mon, 26 Feb 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVD++ZH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC45F49E;
	Mon, 26 Feb 2024 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940407; cv=none; b=iLD/a3DugRqDv8lt07edio8HQBTN70E8ZDMig2OtAcNNptgGus4JGYjfZKZ0Oduma1DBe8PuxzP8Sg5CgQk9233p2CNeAXC559pSA/kwejTUWg+h4f/L3T2Q2t1rF9KCCHQSQO8+d2ZZHDMpwUhEVTpkGLSaMdvcd3e4rxnk6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940407; c=relaxed/simple;
	bh=EC/Ms/3TzNHvkB7w68ecW1WAIrf7qCM91zgTWe8Yzdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QnimYJuyQWs+4FBBCly0h73WOiyHaW4grUIDQo2mKUroIDLYDrrVhri2LeE3T/Ba0zZ/vVEXNR6SJ2fUSzMnFiVICNiM28DxXB+YWaSQZTz1bYvXLN5Hub0fAqXNWb2GDuCeYnTvuVME++JIzaMafBV2joFwCd90NF46yXHDWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVD++ZH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1834CC433F1;
	Mon, 26 Feb 2024 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940406;
	bh=EC/Ms/3TzNHvkB7w68ecW1WAIrf7qCM91zgTWe8Yzdw=;
	h=From:To:Cc:Subject:Date:From;
	b=OVD++ZH6tPxgyRQR/6bYs228JgoSeln/fl3kvHxB/L7B0txXUQkAfX2nVB7fWTAUw
	 EZ7YLuLt0OAqTkmQ/6NN8iSH+El3kJU3gRJlwgqZ3x0bSfNKhiSPrceDzZCgMhGb9H
	 iN2SpG6acSuJURsNg5HYxcCZncXTCa1TQ0IMKzNXiLA7+qeJSkp7BPuekLThChpOWl
	 N6GDcyen7rZcl3XtS3wrUBWWx6JlAsniynuiyR+gB4/DLRm6kvAp0FWlmbhda/fQoX
	 Pf5RVsN/KIBSBtUFz4bRbn6NLLM90bpQ0QD5XxoYW4SutYs8VKY4X0isnMre/wj/iU
	 yRxfuF7bmQMmQ==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: cmaiolino@redhat.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,hughd@google.com,kch@nvidia.com,kent.overstreet@linux.dev,leo.lilong@huawei.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,longman@redhat.com,peterz@infradead.org,ruansy.fnst@fujitsu.com,sshegde@linux.ibm.com,willy@infradead.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 8a800a1e9004
Date: Mon, 26 Feb 2024 15:08:28 +0530
Message-ID: <87bk835zta.fsf@debian-BULLSEYE-live-builder-AMD64>
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

8a800a1e9004 Merge tag 'xfs-6.8-fixes-3' into xfs-for-next

197 new commits:

Chandan Babu R (19):
      [8e3ef44f9bcd] Merge tag 'repair-inode-mode-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [aa03f524a2e3] Merge tag 'repair-quotacheck-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [128d0fd1ab09] Merge tag 'scrub-nlinks-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [6fe1910e8557] Merge tag 'corruption-health-reports-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [f10775795302] Merge tag 'indirect-health-reporting-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [5d1bd19d8305] Merge tag 'repair-fscounters-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [681cb87b6a0c] Merge tag 'btree-geometry-in-ops-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [ee138217c32c] Merge tag 'btree-remove-btnum-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [169c030a95d5] Merge tag 'btree-check-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [a7ade7e13db5] Merge tag 'btree-readahead-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [aa8fb4bb7d03] Merge tag 'buftarg-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [8394a97c4b5a] Merge tag 'in-memory-btrees-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [fd43925cad85] Merge tag 'repair-rmap-btree-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [74acb705354c] Merge tag 'repair-refcount-scalability-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [10ea6158b4cb] Merge tag 'bmap-intent-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [4e3f7e7ab854] Merge tag 'realtime-bmap-intents-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [6723ca9997a1] Merge tag 'expand-bmap-intent-usage_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [e6469b22bd99] Merge tag 'symlink-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
      [8a800a1e9004] Merge tag 'xfs-6.8-fixes-3' into xfs-for-next

Christoph Hellwig (70):
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
      [e9e66df8bfa4] xfs: remove bc_ino.flags
      [73a8fd93c421] xfs: consolidate the xfs_alloc_lookup_* helpers
      [b20775ed644a] xfs: turn the allocbt cursor active field into a btree flag
      [07b7f2e3172b] xfs: move the btree stats offset into struct btree_ops
      [4f0cd5a55507] xfs: split out a btree type from the btree ops geometry flags
      [88ee2f484911] xfs: split the per-btree union in struct xfs_btree_cur
      [72c2070f3f52] xfs: move comment about two 2 keys per pointer in the rmap btree
      [f9c18129e57d] xfs: add a xfs_btree_init_ptr_from_cur
      [2b9e7f2668c5] xfs: don't override bc_ops for staging btrees
      [fb518f8eeb90] xfs: fold xfs_allocbt_init_common into xfs_allocbt_init_cursor
      [91796b2eef8b] xfs: remove xfs_allocbt_stage_cursor
      [f6c98d921a9e] xfs: fold xfs_inobt_init_common into xfs_inobt_init_cursor
      [6234dee7e6f5] xfs: remove xfs_inobt_stage_cursor
      [4f2dc69e4bcb] xfs: fold xfs_refcountbt_init_common into xfs_refcountbt_init_cursor
      [a5c2194406f3] xfs: remove xfs_refcountbt_stage_cursor
      [c49a4b2f0ef0] xfs: fold xfs_rmapbt_init_common into xfs_rmapbt_init_cursor
      [1317813290be] xfs: remove xfs_rmapbt_stage_cursor
      [579d7022d1af] xfs: make full use of xfs_btree_stage_ifakeroot in xfs_bmbt_stage_cursor
      [802f91f7b1d5] xfs: fold xfs_bmbt_init_common into xfs_bmbt_init_cursor
      [02f7ebf5f99c] xfs: remove xfs_bmbt_stage_cursor
      [e45ea3645178] xfs: split the agf_roots and agf_levels arrays
      [77953b97bb19] xfs: add a name field to struct xfs_btree_ops
      [7f47734ad61a] xfs: add a sick_mask to struct xfs_btree_ops
      [480399261975] xfs: refactor the btree cursor allocation logic in xchk_ag_btcur_init
      [1c8b9fd278c0] xfs: split xfs_allocbt_init_cursor
      [3038fd812938] xfs: remove xfs_inobt_cur
      [4bfb028a4c00] xfs: remove the btnum argument to xfs_inobt_count_blocks
      [c81a01a74a67] xfs: remove the which variable in xchk_iallocbt
      [8541a7d9da2d] xfs: split xfs_inobt_insert_sprec
      [14dd46cf31f4] xfs: split xfs_inobt_init_cursor
      [fbeef4e061ab] xfs: pass a 'bool is_finobt' to xfs_inobt_insert
      [ec793e690f80] xfs: remove xfs_btnum_t
      [4bc94bf640e0] xfs: simplify xfs_btree_check_sblock_siblings
      [8b8ada973cac] xfs: simplify xfs_btree_check_lblock_siblings
      [fb0793f20670] xfs: open code xfs_btree_check_lptr in xfs_bmap_btree_to_extents
      [57982d6c835a] xfs: consolidate btree ptr checking
      [43be09192ce1] xfs: misc cleanups for __xfs_btree_check_sblock
      [bd45019d9aa9] xfs: remove the crc variable in __xfs_btree_check_lblock
      [d477f1749f00] xfs: tighten up validation of root block in inode forks
      [4ce0c711d9ab] xfs: consolidate btree block verification
      [5ef819c34f95] xfs: rename btree helpers that depends on the block number representation
      [79e72304dcba] xfs: factor out a __xfs_btree_check_lblock_hdr helper
      [5eec8fa30dfa] xfs: remove xfs_btree_reada_bufl
      [6324b00c9ecb] xfs: remove xfs_btree_reada_bufs
      [6a701eb8fbbb] xfs: move and rename xfs_btree_read_bufl
      [24f755e4854e] xfs: split xfs_buf_rele for cached vs uncached buffers
      [21e308e64855] xfs: remove the xfs_buftarg_t typedef
      [60335cc0fb5c] xfs: remove xfs_setsize_buftarg_early
      [1c51ac0998ed] xfs: move setting bt_logical_sectorsize out of xfs_setsize_buftarg
      [8c1771c45dfa] xfs: add a xfs_btree_ptrs_equal helper

Darrick J. Wong (87):
      [1149314a16f7] xfs: disable sparse inode chunk alignment check when there is no alignment
      [6907e3c00a40] xfs: add file_{get,put}_folio
      [ee13fc67205b] xfs: convert xfarray_pagesort to deal with large folios
      [e5a2f47cff81] xfs: remove xfile_{get,put}_page
      [ae05eb117108] xfs: speed up xfs_iwalk_adjust_start a little bit
      [8660c7b74aea] xfs: implement live inode scan for scrub
      [4e98cc905c0f] xfs: allow scrub to hook metadata updates in other writers
      [c473a3320be3] xfs: stagger the starting AG of scrub iscans to reduce contention
      [a7a686cb0720] xfs: cache a bunch of inodes for repair scans
      [82334a79c6eb] xfs: iscan batching should handle unallocated inodes too
      [e99bfc9e687e] xfs: create a static name for the dot entry too
      [d9c077589714] xfs: create a predicate to determine if two xfs_names are the same
      [3c79e6a87221] xfs: create a macro for decoding ftypes in tracepoints
      [3d8f1426977f] xfs: report the health of quota counts
      [5385f1a60d4e] xfs: repair file modes by scanning for a dirent pointing to us
      [564fee6d2053] xfs: create a xchk_trans_alloc_empty helper for scrub
      [ebd610fe82c1] xfs: create a helper to count per-device inode block usage
      [5a3ab5849583] xfs: create a sparse load xfarray function
      [48dd9117a34f] xfs: implement live quotacheck inode scan
      [200491875ce1] xfs: track quota updates during live quotacheck
      [7038c6e5261e] xfs: repair cannot update the summary counters when logging quota flags
      [96ed2ae4a9b0] xfs: repair dquots based on live quotacheck results
      [93687ee2e374] xfs: report health of inode link counts
      [f1184081ac97] xfs: teach scrub to check file nlinks
      [86a1746eea91] xfs: track directory entry updates during live nlinks fsck
      [6b631c60c90a] xfs: teach repair to fix file nlinks
      [0b8686f19879] xfs: separate the marking of sick and checked metadata
      [50645ce8822d] xfs: report fs corruption errors to the health tracking system
      [de6077ec4198] xfs: report ag header corruption errors to the health tracking system
      [1196f3f5abf7] xfs: report block map corruption errors to the health tracking system
      [a78d10f45b23] xfs: report btree block corruption errors to the health system
      [ca14c0968c1f] xfs: report dir/attr block corruption errors to the health system
      [b280fb0cbf48] xfs: report symlink block corruption errors to the health system
      [baf44fa5c37a] xfs: report inode corruption errors to the health system
      [841a5f87e2d0] xfs: report quota block corruption errors to the health system
      [8368ad49aaf7] xfs: report realtime metadata corruption errors to the health system
      [989d5ec3175b] xfs: report XFS_IS_CORRUPT errors to the health system
      [4e587917ee1c] xfs: add secondary and indirect classes to the health tracking system
      [0e24ec3c56fb] xfs: remember sick inodes that get inactivated
      [a1f3e0cca410] xfs: update health status if we get a clean bill of health
      [4ed080cd7cb0] xfs: repair summary counters
      [78067b92b909] xfs: consolidate btree block freeing tracepoints
      [2ed0b2c7f331] xfs: consolidate btree block allocation tracepoints
      [056d22c87132] xfs: set the btree cursor bc_ops in xfs_btree_alloc_cursor
      [f9e325bf61d1] xfs: drop XFS_BTREE_CRC_BLOCKS
      [c0afba9a8363] xfs: fix imprecise logic in xchk_btree_check_block_owner
      [fd9c7f7722d8] xfs: encode the btree geometry flags in the btree ops structure
      [d8d6df4253ad] xfs: extern some btree ops structures
      [c87e3bf78024] xfs: initialize btree blocks using btree_ops structure
      [3c68858b264f] xfs: rename btree block/buffer init functions
      [7771f7030007] xfs: btree convert xfs_btree_init_block to xfs_btree_init_buf calls
      [11388f6581f4] xfs: remove the unnecessary daddr paramter to _init_block
      [ad065ef0d2fc] xfs: set btree block buffer ops in _init_buf
      [90cfae818dac] xfs: move lru refs to the btree ops structure
      [2054cf051698] xfs: factor out a xfs_btree_owner helper
      [186f20c00319] xfs: factor out a btree block owner check
      [1a9d26291c68] xfs: store the btree pointer length in struct xfs_btree_ops
      [f73def90a7cd] xfs: create predicate to determine if cursor is at inode root level
      [42e357c806c8] xfs: make staging file forks explicit
      [e7b58f7c1be2] xfs: teach buftargs to maintain their own buffer hashtable
      [5076a6040ca1] xfs: support in-memory buffer cache targets
      [a095686a2383] xfs: support in-memory btrees
      [5049ff4d140c] xfs: create a helper to decide if a file mapping targets the rt volume
      [0dc63c8a1ce3] xfs: launder in-memory btree buffers before transaction commit
      [e4fd1def3098] xfs: create agblock bitmap helper to count the number of set regions
      [32080a9b9b2e] xfs: repair the rmapbt
      [4787fc802752] xfs: create a shadow rmap btree during rmap repair
      [18a1e644b094] xfs: define an in-memory btree for storing refcount bag info during repairs
      [7e1b84b24d25] xfs: hook live rmap operations during a repair operation
      [7a2192ac1099] xfs: create refcount bag structure for btree repairs
      [7fbaab57a80f] xfs: port refcount repair to the new refcount bag structure
      [ef2d4a00df38] xfs: split tracepoint classes for deferred items
      [2a15e7686094] xfs: clean up bmap log intent item tracepoint callsites
      [372fe0b8ce4f] xfs: remove xfs_trans_set_bmap_flags
      [de47e4c9ad2d] xfs: add a bi_entry helper
      [5d3d0a6ad287] xfs: reuse xfs_bmap_update_cancel_item
      [80284115854e] xfs: move xfs_bmap_defer_add to xfs_bmap_item.c
      [2b6a5ec26887] xfs: fix xfs_bunmapi to allow unmapping of partial rt extents
      [c75f1a2c1549] xfs: add a xattr_entry helper
      [7302cda7f8b0] xfs: add a realtime flag to the bmap update log redo items
      [1b5453baed3a] xfs: support recovering bmap intent items targetting realtime extents
      [52f807067ba4] xfs: support deferred bmap updates on the attr fork
      [6c8127e93e3a] xfs: xfs_bmap_finish_one should map unwritten extents properly
      [622d88e2ad79] xfs: move xfs_symlink_remote.c declarations to xfs_symlink_remote.h
      [376b4f052248] xfs: move remote symlink target read function to libxfs
      [b8102b61f7b8] xfs: move symlink target write function to libxfs
      [1e5efd72a29e] xfs: fix log recovery erroring out on refcount recovery failure

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

Shiyang Ruan (1):
      [94ccb6288ea3] xfs: drop experimental warning for FSDAX

Shrikanth Hegde (1):
      [0164defd0d86] xfs: remove duplicate ifdefs

Code Diffstat:

 Documentation/filesystems/xfs/xfs-online-fsck-design.rst |   30 +-
 fs/xfs/Kconfig                                           |   13 +
 fs/xfs/Makefile                                          |   15 +-
 fs/xfs/kmem.c                                            |   30 --
 fs/xfs/kmem.h                                            |   83 -----
 fs/xfs/libxfs/xfs_ag.c                                   |   68 ++--
 fs/xfs/libxfs/xfs_ag.h                                   |   18 +-
 fs/xfs/libxfs/xfs_alloc.c                                |  258 ++++++++------
 fs/xfs/libxfs/xfs_alloc_btree.c                          |  191 ++++++-----
 fs/xfs/libxfs/xfs_alloc_btree.h                          |   10 +-
 fs/xfs/libxfs/xfs_attr.c                                 |    5 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                            |   22 +-
 fs/xfs/libxfs/xfs_attr_remote.c                          |   37 +-
 fs/xfs/libxfs/xfs_bmap.c                                 |  365 +++++++++++++-------
 fs/xfs/libxfs/xfs_bmap.h                                 |   19 +-
 fs/xfs/libxfs/xfs_bmap_btree.c                           |  152 ++++----
 fs/xfs/libxfs/xfs_bmap_btree.h                           |    5 +-
 fs/xfs/libxfs/xfs_btree.c                                | 1098 ++++++++++++++++++++++++++++++++++------------------------
 fs/xfs/libxfs/xfs_btree.h                                |  274 +++++++--------
 fs/xfs/libxfs/xfs_btree_mem.c                            |  347 +++++++++++++++++++
 fs/xfs/libxfs/xfs_btree_mem.h                            |   75 ++++
 fs/xfs/libxfs/xfs_btree_staging.c                        |  133 +------
 fs/xfs/libxfs/xfs_btree_staging.h                        |   10 +-
 fs/xfs/libxfs/xfs_da_btree.c                             |   59 +++-
 fs/xfs/libxfs/xfs_da_format.h                            |   11 +
 fs/xfs/libxfs/xfs_defer.c                                |   25 +-
 fs/xfs/libxfs/xfs_dir2.c                                 |   59 ++--
 fs/xfs/libxfs/xfs_dir2.h                                 |   13 +
 fs/xfs/libxfs/xfs_dir2_block.c                           |    8 +-
 fs/xfs/libxfs/xfs_dir2_data.c                            |    3 +
 fs/xfs/libxfs/xfs_dir2_leaf.c                            |    3 +
 fs/xfs/libxfs/xfs_dir2_node.c                            |    7 +
 fs/xfs/libxfs/xfs_dir2_sf.c                              |   16 +-
 fs/xfs/libxfs/xfs_format.h                               |   21 +-
 fs/xfs/libxfs/xfs_fs.h                                   |    8 +-
 fs/xfs/libxfs/xfs_health.h                               |   95 ++++-
 fs/xfs/libxfs/xfs_ialloc.c                               |  240 ++++++++-----
 fs/xfs/libxfs/xfs_ialloc_btree.c                         |  159 ++++-----
 fs/xfs/libxfs/xfs_ialloc_btree.h                         |   11 +-
 fs/xfs/libxfs/xfs_iext_tree.c                            |   26 +-
 fs/xfs/libxfs/xfs_inode_buf.c                            |   12 +-
 fs/xfs/libxfs/xfs_inode_fork.c                           |   49 ++-
 fs/xfs/libxfs/xfs_inode_fork.h                           |    1 +
 fs/xfs/libxfs/xfs_log_format.h                           |    4 +-
 fs/xfs/libxfs/xfs_refcount.c                             |   69 +++-
 fs/xfs/libxfs/xfs_refcount_btree.c                       |   80 ++---
 fs/xfs/libxfs/xfs_refcount_btree.h                       |    2 -
 fs/xfs/libxfs/xfs_rmap.c                                 |  284 ++++++++++++---
 fs/xfs/libxfs/xfs_rmap.h                                 |   31 +-
 fs/xfs/libxfs/xfs_rmap_btree.c                           |  239 ++++++++++---
 fs/xfs/libxfs/xfs_rmap_btree.h                           |    8 +-
 fs/xfs/libxfs/xfs_rtbitmap.c                             |   11 +-
 fs/xfs/libxfs/xfs_sb.c                                   |    2 +
 fs/xfs/libxfs/xfs_shared.h                               |   67 +++-
 fs/xfs/libxfs/xfs_symlink_remote.c                       |  155 ++++++++-
 fs/xfs/libxfs/xfs_symlink_remote.h                       |   26 ++
 fs/xfs/libxfs/xfs_trans_inode.c                          |    6 +-
 fs/xfs/libxfs/xfs_types.h                                |   26 +-
 fs/xfs/mrlock.h                                          |   78 -----
 fs/xfs/scrub/agb_bitmap.h                                |    5 +
 fs/xfs/scrub/agheader.c                                  |   12 +-
 fs/xfs/scrub/agheader_repair.c                           |   47 +--
 fs/xfs/scrub/alloc_repair.c                              |   27 +-
 fs/xfs/scrub/bitmap.c                                    |   14 +
 fs/xfs/scrub/bitmap.h                                    |    2 +
 fs/xfs/scrub/bmap.c                                      |    2 +-
 fs/xfs/scrub/bmap_repair.c                               |    8 +-
 fs/xfs/scrub/btree.c                                     |   58 ++--
 fs/xfs/scrub/common.c                                    |  133 ++++---
 fs/xfs/scrub/common.h                                    |   13 +
 fs/xfs/scrub/cow_repair.c                                |    2 +-
 fs/xfs/scrub/dir.c                                       |    4 +-
 fs/xfs/scrub/fscounters.c                                |   29 +-
 fs/xfs/scrub/fscounters.h                                |   20 ++
 fs/xfs/scrub/fscounters_repair.c                         |   72 ++++
 fs/xfs/scrub/health.c                                    |  140 +++++---
 fs/xfs/scrub/health.h                                    |    5 +-
 fs/xfs/scrub/ialloc.c                                    |   20 +-
 fs/xfs/scrub/ialloc_repair.c                             |   10 +-
 fs/xfs/scrub/inode_repair.c                              |  237 ++++++++++++-
 fs/xfs/scrub/iscan.c                                     |  767 +++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/iscan.h                                     |   84 +++++
 fs/xfs/scrub/newbt.c                                     |   14 +-
 fs/xfs/scrub/newbt.h                                     |    7 +
 fs/xfs/scrub/nlinks.c                                    |  930 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/nlinks.h                                    |  102 ++++++
 fs/xfs/scrub/nlinks_repair.c                             |  223 ++++++++++++
 fs/xfs/scrub/quotacheck.c                                |  867 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/quotacheck.h                                |   76 ++++
 fs/xfs/scrub/quotacheck_repair.c                         |  261 ++++++++++++++
 fs/xfs/scrub/rcbag.c                                     |  307 +++++++++++++++++
 fs/xfs/scrub/rcbag.h                                     |   28 ++
 fs/xfs/scrub/rcbag_btree.c                               |  370 ++++++++++++++++++++
 fs/xfs/scrub/rcbag_btree.h                               |   81 +++++
 fs/xfs/scrub/readdir.c                                   |    4 +-
 fs/xfs/scrub/reap.c                                      |    2 +-
 fs/xfs/scrub/refcount.c                                  |   12 +
 fs/xfs/scrub/refcount_repair.c                           |  177 ++++------
 fs/xfs/scrub/repair.c                                    |  120 ++++++-
 fs/xfs/scrub/repair.h                                    |   23 +-
 fs/xfs/scrub/rmap.c                                      |   26 +-
 fs/xfs/scrub/rmap_repair.c                               | 1697 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/rtsummary.c                                 |    6 +-
 fs/xfs/scrub/scrub.c                                     |   37 +-
 fs/xfs/scrub/scrub.h                                     |   18 +-
 fs/xfs/scrub/stats.c                                     |    2 +
 fs/xfs/scrub/symlink.c                                   |    3 +-
 fs/xfs/scrub/trace.c                                     |    8 +-
 fs/xfs/scrub/trace.h                                     |  637 ++++++++++++++++++++++++++++++----
 fs/xfs/scrub/xfarray.c                                   |  234 ++++++-------
 fs/xfs/scrub/xfarray.h                                   |   30 +-
 fs/xfs/scrub/xfile.c                                     |  345 +++++++------------
 fs/xfs/scrub/xfile.h                                     |   62 +---
 fs/xfs/xfs_acl.c                                         |    4 +-
 fs/xfs/xfs_attr_inactive.c                               |    4 +
 fs/xfs/xfs_attr_item.c                                   |   25 +-
 fs/xfs/xfs_attr_list.c                                   |   26 +-
 fs/xfs/xfs_bmap_item.c                                   |  119 ++++---
 fs/xfs/xfs_bmap_item.h                                   |    4 +
 fs/xfs/xfs_bmap_util.c                                   |   20 +-
 fs/xfs/xfs_buf.c                                         |  320 ++++++++++-------
 fs/xfs/xfs_buf.h                                         |   21 +-
 fs/xfs/xfs_buf_item.c                                    |    8 +-
 fs/xfs/xfs_buf_item_recover.c                            |    8 +-
 fs/xfs/xfs_buf_mem.c                                     |  270 +++++++++++++++
 fs/xfs/xfs_buf_mem.h                                     |   34 ++
 fs/xfs/xfs_dir2_readdir.c                                |    8 +-
 fs/xfs/xfs_discard.c                                     |   19 +-
 fs/xfs/xfs_dquot.c                                       |   36 +-
 fs/xfs/xfs_error.c                                       |    8 +-
 fs/xfs/xfs_extent_busy.c                                 |    5 +-
 fs/xfs/xfs_extfree_item.c                                |    8 +-
 fs/xfs/xfs_file.c                                        |    4 +-
 fs/xfs/xfs_filestream.c                                  |    6 +-
 fs/xfs/xfs_fsmap.c                                       |    4 +-
 fs/xfs/xfs_health.c                                      |  202 ++++++++++-
 fs/xfs/xfs_hooks.c                                       |   52 +++
 fs/xfs/xfs_hooks.h                                       |   65 ++++
 fs/xfs/xfs_icache.c                                      |   14 +-
 fs/xfs/xfs_icreate_item.c                                |    2 +-
 fs/xfs/xfs_inode.c                                       |  274 +++++++++++----
 fs/xfs/xfs_inode.h                                       |   37 +-
 fs/xfs/xfs_inode_item.c                                  |    6 +-
 fs/xfs/xfs_inode_item_recover.c                          |    5 +-
 fs/xfs/xfs_ioctl.c                                       |    8 +-
 fs/xfs/xfs_iomap.c                                       |   19 +-
 fs/xfs/xfs_iops.c                                        |    9 +-
 fs/xfs/xfs_itable.c                                      |   12 +-
 fs/xfs/xfs_iwalk.c                                       |   41 +--
 fs/xfs/xfs_linux.h                                       |   17 +-
 fs/xfs/xfs_log.c                                         |   34 +-
 fs/xfs/xfs_log_cil.c                                     |   31 +-
 fs/xfs/xfs_log_recover.c                                 |  102 ++++--
 fs/xfs/xfs_mount.c                                       |    2 +-
 fs/xfs/xfs_mount.h                                       |   12 +-
 fs/xfs/xfs_mru_cache.c                                   |   17 +-
 fs/xfs/xfs_qm.c                                          |   59 ++--
 fs/xfs/xfs_qm.h                                          |   16 +
 fs/xfs/xfs_qm_bhv.c                                      |    1 +
 fs/xfs/xfs_quota.h                                       |   46 +++
 fs/xfs/xfs_refcount_item.c                               |   12 +-
 fs/xfs/xfs_reflink.c                                     |   16 +-
 fs/xfs/xfs_rmap_item.c                                   |   11 +-
 fs/xfs/xfs_rtalloc.c                                     |   18 +-
 fs/xfs/xfs_stats.c                                       |    4 +-
 fs/xfs/xfs_stats.h                                       |    2 +
 fs/xfs/xfs_super.c                                       |   21 +-
 fs/xfs/xfs_symlink.c                                     |  158 +--------
 fs/xfs/xfs_symlink.h                                     |    1 -
 fs/xfs/xfs_sysfs.c                                       |    4 -
 fs/xfs/xfs_trace.c                                       |    3 +
 fs/xfs/xfs_trace.h                                       |  607 +++++++++++++++++++++++---------
 fs/xfs/xfs_trans.c                                       |    2 +-
 fs/xfs/xfs_trans.h                                       |    1 +
 fs/xfs/xfs_trans_ail.c                                   |    7 +-
 fs/xfs/xfs_trans_buf.c                                   |   42 +++
 fs/xfs/xfs_trans_dquot.c                                 |  171 ++++++++-
 include/linux/rwbase_rt.h                                |    9 +-
 include/linux/rwsem.h                                    |   46 ++-
 include/linux/shmem_fs.h                                 |    6 +-
 include/linux/swap.h                                     |   10 -
 mm/filemap.c                                             |    9 +
 mm/internal.h                                            |    4 +
 mm/shmem.c                                               |   42 ++-
 mm/workingset.c                                          |    1 +
 185 files changed, 13261 insertions(+), 3582 deletions(-)
 delete mode 100644 fs/xfs/kmem.c
 delete mode 100644 fs/xfs/kmem.h
 create mode 100644 fs/xfs/libxfs/xfs_btree_mem.c
 create mode 100644 fs/xfs/libxfs/xfs_btree_mem.h
 create mode 100644 fs/xfs/libxfs/xfs_symlink_remote.h
 delete mode 100644 fs/xfs/mrlock.h
 create mode 100644 fs/xfs/scrub/fscounters.h
 create mode 100644 fs/xfs/scrub/fscounters_repair.c
 create mode 100644 fs/xfs/scrub/iscan.c
 create mode 100644 fs/xfs/scrub/iscan.h
 create mode 100644 fs/xfs/scrub/nlinks.c
 create mode 100644 fs/xfs/scrub/nlinks.h
 create mode 100644 fs/xfs/scrub/nlinks_repair.c
 create mode 100644 fs/xfs/scrub/quotacheck.c
 create mode 100644 fs/xfs/scrub/quotacheck.h
 create mode 100644 fs/xfs/scrub/quotacheck_repair.c
 create mode 100644 fs/xfs/scrub/rcbag.c
 create mode 100644 fs/xfs/scrub/rcbag.h
 create mode 100644 fs/xfs/scrub/rcbag_btree.c
 create mode 100644 fs/xfs/scrub/rcbag_btree.h
 create mode 100644 fs/xfs/scrub/rmap_repair.c
 create mode 100644 fs/xfs/xfs_buf_mem.c
 create mode 100644 fs/xfs/xfs_buf_mem.h
 create mode 100644 fs/xfs/xfs_hooks.c
 create mode 100644 fs/xfs/xfs_hooks.h

