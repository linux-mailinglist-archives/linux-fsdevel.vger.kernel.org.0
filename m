Return-Path: <linux-fsdevel+bounces-14369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30B87B450
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC901F2294D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64FF5A0F7;
	Wed, 13 Mar 2024 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xVth5sI+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0F5A0F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368694; cv=none; b=NBc+Ik3hMpyWR/SYBICb+1DxrXyzkzJhe6ktZwdN88qIn273nka2tD+VNFnhTh2qsoS5Gi5uqxT1HGP/bIJEaWMxgiZ8HNiG8VApsQPVX9Kb+rUE0XY4h90y5xlQWRa9SJkipRuNcsk5LwKGhrGA2I1r/TqklLA4BaboB+6fBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368694; c=relaxed/simple;
	bh=29777ZnrBRCi5VyDHDgR8xcQp7GaAO/CdjTVkPZOc4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxemnQZUjSWd7gsrr1h824ccavbeJ104qRNGboHyY8L1skWfd9yB6QXyrdZlhBQxl0n1lrQQTkvgAkmf0fzHuU61i2CPi2qmgibX8thUAmNFo413mgTgI1SRzKWotJmwG75XYANrqpo4uhtYTxSVYDR9IGrQE/HWSnnqK9JrQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xVth5sI+; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Mar 2024 18:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710368688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jK5C+RJKsNEGc0qoyP04cAC/f/hzeArXmIF90CfTnac=;
	b=xVth5sI+IeJqwCZBJmchkuj0C9YDg5zHS5MxCwfQFy8Et/WNuB8CWRXKpIc9MvTZAHCodR
	2V7pxRY/rZ4VDrpjuMZ4NFvz6vZDWrhIeOb/MEwqZN78FjF2atraUzBu+PbYk7d7t3q62U
	zZVwmpURlWMDmncgtzN/JLrsoG/Fu9U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: torvalds@linux-foundation.org, akiyks@gmail.com, cmaiolino@redhat.com, 
	corbet@lwn.net, dan.carpenter@linaro.org, dchinner@redhat.com, djwong@kernel.org, 
	hch@lst.de, hsiangkao@linux.alibaba.com, hughd@google.com, kch@nvidia.com, 
	leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	longman@redhat.com, mchehab@kernel.org, peterz@infradead.org, sfr@canb.auug.org.au, 
	sshegde@linux.ibm.com, willy@infradead.org
Subject: Re: [GIT PULL] xfs: new code for 6.9
Message-ID: <doxpdtin3623b6xvlxzgraso463mpxwdcrj7sqy2zxmecdamza@v5twewvrxbl3>
References: <87sf0uhdh2.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf0uhdh2.fsf@debian-BULLSEYE-live-builder-AMD64>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 13, 2024 at 11:21:46AM +0530, Chandan Babu R wrote:
> Hi Linus,
> 
> Please pull this branch with changes for xfs for 6.9-rc1.
> 
> The major change involves expansion of online repair functionality.
> 
> A brief summary of remaining changes are provided in the section "New code for
>  6.9" below.
> 
> I did a test-merge with the main upstream branch as of a few minutes ago and
> noticed a trivial merge conflict. The following diff will resolve the
> resulting merge conflict.
> 
> diff --cc fs/xfs/xfs_buf.c
> index 01b41fabbe3c,7fc26e64368d..71f3dfae3357
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@@ -1951,9 -2030,8 +2030,9 @@@ xfs_free_buftarg
>   	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
>   	/* the main block device is closed by kill_block_super */
>   	if (btp->bt_bdev != btp->bt_mount->m_super->s_bdev)
>  -		bdev_release(btp->bt_bdev_handle);
>  +		fput(btp->bt_bdev_file);
>  +
> - 	kmem_free(btp);
> + 	kfree(btp);
>   }
>   
>   int
> @@@ -1994,20 -2095,20 +2096,20 @@@ out_destroy_lru
>   struct xfs_buftarg *
>   xfs_alloc_buftarg(
>   	struct xfs_mount	*mp,
>  -	struct bdev_handle	*bdev_handle)
>  +	struct file		*bdev_file)
>   {
> - 	xfs_buftarg_t		*btp;
> + 	struct xfs_buftarg	*btp;
>   	const struct dax_holder_operations *ops = NULL;
>   
>   #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
>   	ops = &xfs_dax_holder_operations;
>   #endif
> - 	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
> + 	btp = kzalloc(sizeof(*btp), GFP_KERNEL | __GFP_NOFAIL);
>   
>   	btp->bt_mount = mp;
>  -	btp->bt_bdev_handle = bdev_handle;
>  -	btp->bt_dev = bdev_handle->bdev->bd_dev;
>  -	btp->bt_bdev = bdev_handle->bdev;
>  +	btp->bt_bdev_file = bdev_file;
>  +	btp->bt_bdev = file_bdev(bdev_file);
>  +	btp->bt_dev = btp->bt_bdev->bd_dev;
>   	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
>   					    mp, ops);
>   
> diff --cc fs/xfs/xfs_buf.h
> index 304e858d04fb,73249abca968..b1580644501f
> --- a/fs/xfs/xfs_buf.h
> +++ b/fs/xfs/xfs_buf.h
> @@@ -96,11 -104,12 +104,12 @@@ void xfs_buf_cache_destroy(struct xfs_b
>    * The latter is derived from the underlying device, and controls direct IO
>    * alignment constraints.
>    */
> - typedef struct xfs_buftarg {
> + struct xfs_buftarg {
>   	dev_t			bt_dev;
>  -	struct bdev_handle	*bt_bdev_handle;
>  +	struct file		*bt_bdev_file;
>   	struct block_device	*bt_bdev;
>   	struct dax_device	*bt_daxdev;
> + 	struct file		*bt_file;
>   	u64			bt_dax_part_off;
>   	struct xfs_mount	*bt_mount;
>   	unsigned int		bt_meta_sectorsize;
> 
> Please let me know if you encounter any problems.
> 
> The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:
> 
>   Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-merge-8
> 
> for you to fetch changes up to 75bcffbb9e7563259b7aed0fa77459d6a3a35627:
> 
>   xfs: shrink failure needs to hold AGI buffer (2024-03-07 14:59:05 +0530)
> 
> ----------------------------------------------------------------
> New code for 6.9:
> 
>   * Online Repair;
>   ** New ondisk structures being repaired.
>      - Inode's mode field by trying to obtain file type value from the a
>        directory entry.
>      - Quota counters.
>      - Link counts of inodes.
>      - FS summary counters.
>      - rmap btrees.
>        Support for in-memory btrees has been added to support repair of rmap
>        btrees.
>   ** Misc changes
>      - Report corruption of metadata to the health tracking subsystem.
>      - Enable indirect health reporting when resources are scarce.
>      - Reduce memory usage while reparing refcount btree.
>      - Extend "Bmap update" intent item to support atomic extent swapping on
>        the realtime device.
>      - Extend "Bmap update" intent item to support extended attribute fork and
>        unwritten extents.
>   ** Code cleanups
>      - Bmap log intent.
>      - Btree block pointer checking.
>      - Btree readahead.
>      - Buffer target.
>      - Symbolic link code.
>   * Remove mrlock wrapper around the rwsem.
>   * Convert all the GFP_NOFS flag usages to use the scoped
>     memalloc_nofs_save() API instead of direct calls with the GFP_NOFS.
>   * Refactor and simplify xfile abstraction. Lower level APIs in
>     shmem.c are required to be exported in order to achieve this.
>   * Skip checking alignment constraints for inode chunk allocations when block
>     size is larger than inode chunk size.
>   * Do not submit delwri buffers collected during log recovery when an error
>     has been encountered.
>   * Fix SEEK_HOLE/DATA for file regions which have active COW extents.
>   * Fix lock order inversion when executing error handling path during
>     shrinking a filesystem.
>   * Remove duplicate ifdefs.
> 
> Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
> 
> ----------------------------------------------------------------
> Akira Yokosawa (2):
>       kernel-doc: Add unary operator * to $type_param_ref
>       mm/shmem.c: Use new form of *@param in kernel-doc
> 
> Chandan Babu R (18):
>       Merge tag 'repair-inode-mode-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'repair-quotacheck-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'scrub-nlinks-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'corruption-health-reports-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'indirect-health-reporting-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'repair-fscounters-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'btree-geometry-in-ops-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'btree-remove-btnum-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'btree-check-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'btree-readahead-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'buftarg-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'in-memory-btrees-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'repair-rmap-btree-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'repair-refcount-scalability-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'bmap-intent-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'realtime-bmap-intents-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'expand-bmap-intent-usage_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
>       Merge tag 'symlink-cleanups-6.9_2024-02-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.9-mergeC
> 
> Christoph Hellwig (70):
>       xfs: use kvfree for buf in xfs_ioc_getbmap
>       mm: move mapping_set_update out of <linux/swap.h>
>       shmem: move shmem_mapping out of line
>       shmem: set a_ops earlier in shmem_symlink
>       shmem: move the shmem_mapping assert into shmem_get_folio_gfp
>       shmem: export shmem_get_folio
>       shmem: export shmem_kernel_file_setup
>       shmem: document how to "persist" data when using shmem_*file_setup
>       xfs: use VM_NORESERVE in xfile_create
>       xfs: shmem_file_setup can't return NULL
>       xfs: use shmem_kernel_file_setup in xfile_create
>       xfs: don't modify file and inode flags for shmem files
>       xfs: remove xfile_stat
>       xfs: remove the xfile_pread/pwrite APIs
>       xfs: don't try to handle non-update pages in xfile_obj_load
>       xfs: don't allow highmem pages in xfile mappings
>       xfs: use shmem_get_folio in xfile_obj_store
>       xfs: use shmem_get_folio in in xfile_load
>       xfs: remove xfarray_sortinfo.page_kaddr
>       xfs: fix a comment in xfarray.c
>       xfs: remove bc_ino.flags
>       xfs: consolidate the xfs_alloc_lookup_* helpers
>       xfs: turn the allocbt cursor active field into a btree flag
>       xfs: move the btree stats offset into struct btree_ops
>       xfs: split out a btree type from the btree ops geometry flags
>       xfs: split the per-btree union in struct xfs_btree_cur
>       xfs: move comment about two 2 keys per pointer in the rmap btree
>       xfs: add a xfs_btree_init_ptr_from_cur
>       xfs: don't override bc_ops for staging btrees
>       xfs: fold xfs_allocbt_init_common into xfs_allocbt_init_cursor
>       xfs: remove xfs_allocbt_stage_cursor
>       xfs: fold xfs_inobt_init_common into xfs_inobt_init_cursor
>       xfs: remove xfs_inobt_stage_cursor
>       xfs: fold xfs_refcountbt_init_common into xfs_refcountbt_init_cursor
>       xfs: remove xfs_refcountbt_stage_cursor
>       xfs: fold xfs_rmapbt_init_common into xfs_rmapbt_init_cursor
>       xfs: remove xfs_rmapbt_stage_cursor
>       xfs: make full use of xfs_btree_stage_ifakeroot in xfs_bmbt_stage_cursor
>       xfs: fold xfs_bmbt_init_common into xfs_bmbt_init_cursor
>       xfs: remove xfs_bmbt_stage_cursor
>       xfs: split the agf_roots and agf_levels arrays
>       xfs: add a name field to struct xfs_btree_ops
>       xfs: add a sick_mask to struct xfs_btree_ops
>       xfs: refactor the btree cursor allocation logic in xchk_ag_btcur_init
>       xfs: split xfs_allocbt_init_cursor
>       xfs: remove xfs_inobt_cur
>       xfs: remove the btnum argument to xfs_inobt_count_blocks
>       xfs: remove the which variable in xchk_iallocbt
>       xfs: split xfs_inobt_insert_sprec
>       xfs: split xfs_inobt_init_cursor
>       xfs: pass a 'bool is_finobt' to xfs_inobt_insert
>       xfs: remove xfs_btnum_t
>       xfs: simplify xfs_btree_check_sblock_siblings
>       xfs: simplify xfs_btree_check_lblock_siblings
>       xfs: open code xfs_btree_check_lptr in xfs_bmap_btree_to_extents
>       xfs: consolidate btree ptr checking
>       xfs: misc cleanups for __xfs_btree_check_sblock
>       xfs: remove the crc variable in __xfs_btree_check_lblock
>       xfs: tighten up validation of root block in inode forks
>       xfs: consolidate btree block verification
>       xfs: rename btree helpers that depends on the block number representation
>       xfs: factor out a __xfs_btree_check_lblock_hdr helper
>       xfs: remove xfs_btree_reada_bufl
>       xfs: remove xfs_btree_reada_bufs
>       xfs: move and rename xfs_btree_read_bufl
>       xfs: split xfs_buf_rele for cached vs uncached buffers
>       xfs: remove the xfs_buftarg_t typedef
>       xfs: remove xfs_setsize_buftarg_early
>       xfs: move setting bt_logical_sectorsize out of xfs_setsize_buftarg
>       xfs: add a xfs_btree_ptrs_equal helper
> 
> Darrick J. Wong (88):
>       xfs: disable sparse inode chunk alignment check when there is no alignment
>       xfs: add file_{get,put}_folio
>       xfs: convert xfarray_pagesort to deal with large folios
>       xfs: remove xfile_{get,put}_page
>       xfs: speed up xfs_iwalk_adjust_start a little bit
>       xfs: implement live inode scan for scrub
>       xfs: allow scrub to hook metadata updates in other writers
>       xfs: stagger the starting AG of scrub iscans to reduce contention
>       xfs: cache a bunch of inodes for repair scans
>       xfs: iscan batching should handle unallocated inodes too
>       xfs: create a static name for the dot entry too
>       xfs: create a predicate to determine if two xfs_names are the same
>       xfs: create a macro for decoding ftypes in tracepoints
>       xfs: report the health of quota counts
>       xfs: repair file modes by scanning for a dirent pointing to us
>       xfs: create a xchk_trans_alloc_empty helper for scrub
>       xfs: create a helper to count per-device inode block usage
>       xfs: create a sparse load xfarray function
>       xfs: implement live quotacheck inode scan
>       xfs: track quota updates during live quotacheck
>       xfs: repair cannot update the summary counters when logging quota flags
>       xfs: repair dquots based on live quotacheck results
>       xfs: report health of inode link counts
>       xfs: teach scrub to check file nlinks
>       xfs: track directory entry updates during live nlinks fsck
>       xfs: teach repair to fix file nlinks
>       xfs: separate the marking of sick and checked metadata
>       xfs: report fs corruption errors to the health tracking system
>       xfs: report ag header corruption errors to the health tracking system
>       xfs: report block map corruption errors to the health tracking system
>       xfs: report btree block corruption errors to the health system
>       xfs: report dir/attr block corruption errors to the health system
>       xfs: report symlink block corruption errors to the health system
>       xfs: report inode corruption errors to the health system
>       xfs: report quota block corruption errors to the health system
>       xfs: report realtime metadata corruption errors to the health system
>       xfs: report XFS_IS_CORRUPT errors to the health system
>       xfs: add secondary and indirect classes to the health tracking system
>       xfs: remember sick inodes that get inactivated
>       xfs: update health status if we get a clean bill of health
>       xfs: repair summary counters
>       xfs: consolidate btree block freeing tracepoints
>       xfs: consolidate btree block allocation tracepoints
>       xfs: set the btree cursor bc_ops in xfs_btree_alloc_cursor
>       xfs: drop XFS_BTREE_CRC_BLOCKS
>       xfs: fix imprecise logic in xchk_btree_check_block_owner
>       xfs: encode the btree geometry flags in the btree ops structure
>       xfs: extern some btree ops structures
>       xfs: initialize btree blocks using btree_ops structure
>       xfs: rename btree block/buffer init functions
>       xfs: btree convert xfs_btree_init_block to xfs_btree_init_buf calls
>       xfs: remove the unnecessary daddr paramter to _init_block
>       xfs: set btree block buffer ops in _init_buf
>       xfs: move lru refs to the btree ops structure
>       xfs: factor out a xfs_btree_owner helper
>       xfs: factor out a btree block owner check
>       xfs: store the btree pointer length in struct xfs_btree_ops
>       xfs: create predicate to determine if cursor is at inode root level
>       xfs: make staging file forks explicit
>       xfs: teach buftargs to maintain their own buffer hashtable
>       xfs: support in-memory buffer cache targets
>       xfs: support in-memory btrees
>       xfs: create a helper to decide if a file mapping targets the rt volume
>       xfs: launder in-memory btree buffers before transaction commit
>       xfs: create agblock bitmap helper to count the number of set regions
>       xfs: repair the rmapbt
>       xfs: create a shadow rmap btree during rmap repair
>       xfs: define an in-memory btree for storing refcount bag info during repairs
>       xfs: hook live rmap operations during a repair operation
>       xfs: create refcount bag structure for btree repairs
>       xfs: port refcount repair to the new refcount bag structure
>       xfs: split tracepoint classes for deferred items
>       xfs: clean up bmap log intent item tracepoint callsites
>       xfs: remove xfs_trans_set_bmap_flags
>       xfs: add a bi_entry helper
>       xfs: reuse xfs_bmap_update_cancel_item
>       xfs: move xfs_bmap_defer_add to xfs_bmap_item.c
>       xfs: fix xfs_bunmapi to allow unmapping of partial rt extents
>       xfs: add a xattr_entry helper
>       xfs: add a realtime flag to the bmap update log redo items
>       xfs: support recovering bmap intent items targetting realtime extents
>       xfs: support deferred bmap updates on the attr fork
>       xfs: xfs_bmap_finish_one should map unwritten extents properly
>       xfs: move xfs_symlink_remote.c declarations to xfs_symlink_remote.h
>       xfs: move remote symlink target read function to libxfs
>       xfs: move symlink target write function to libxfs
>       xfs: fix log recovery erroring out on refcount recovery failure
>       xfs: fix scrub stats file permissions
> 
> Dave Chinner (18):
>       xfs: convert kmem_zalloc() to kzalloc()
>       xfs: convert kmem_alloc() to kmalloc()
>       xfs: move kmem_to_page()
>       xfs: convert kmem_free() for kvmalloc users to kvfree()
>       xfs: convert remaining kmem_free() to kfree()
>       xfs: use an empty transaction for fstrim
>       xfs: use __GFP_NOLOCKDEP instead of GFP_NOFS
>       xfs: use GFP_KERNEL in pure transaction contexts
>       xfs: place intent recovery under NOFS allocation context
>       xfs: place the CIL under nofs allocation context
>       xfs: clean up remaining GFP_NOFS users
>       xfs: use xfs_defer_alloc a bit more
>       xfs: use kvfree() in xfs_ioc_attr_list()
>       xfs: use kvfree in xfs_ioc_getfsmap()
>       xfs: fix SEEK_HOLE/DATA for regions with active COW extents
>       xfs: xfs_btree_bload_prep_block() should use __GFP_NOFAIL
>       xfs: use kvfree() in xlog_cil_free_logvec()
>       xfs: shrink failure needs to hold AGI buffer
> 
> Long Li (1):
>       xfs: ensure submit buffers on LSN boundaries in error handlers
> 
> Matthew Wilcox (Oracle) (3):
>       locking: Add rwsem_assert_held() and rwsem_assert_held_write()
>       xfs: Replace xfs_isilocked with xfs_assert_ilocked
>       xfs: Remove mrlock wrapper
> 
> Shrikanth Hegde (1):
>       xfs: remove duplicate ifdefs
> 
>  .../filesystems/xfs/xfs-online-fsck-design.rst     |   30 +-
>  fs/xfs/Kconfig                                     |   13 +
>  fs/xfs/Makefile                                    |   15 +-
>  fs/xfs/kmem.c                                      |   30 -
>  fs/xfs/kmem.h                                      |   83 -
>  fs/xfs/libxfs/xfs_ag.c                             |   79 +-
>  fs/xfs/libxfs/xfs_ag.h                             |   18 +-
>  fs/xfs/libxfs/xfs_alloc.c                          |  258 +--
>  fs/xfs/libxfs/xfs_alloc_btree.c                    |  191 ++-
>  fs/xfs/libxfs/xfs_alloc_btree.h                    |   10 +-
>  fs/xfs/libxfs/xfs_attr.c                           |    5 +-
>  fs/xfs/libxfs/xfs_attr_leaf.c                      |   22 +-
>  fs/xfs/libxfs/xfs_attr_remote.c                    |   37 +-
>  fs/xfs/libxfs/xfs_bmap.c                           |  365 +++--
>  fs/xfs/libxfs/xfs_bmap.h                           |   19 +-
>  fs/xfs/libxfs/xfs_bmap_btree.c                     |  152 +-
>  fs/xfs/libxfs/xfs_bmap_btree.h                     |    5 +-
>  fs/xfs/libxfs/xfs_btree.c                          | 1098 ++++++++-----
>  fs/xfs/libxfs/xfs_btree.h                          |  274 ++--
>  fs/xfs/libxfs/xfs_btree_mem.c                      |  347 ++++
>  fs/xfs/libxfs/xfs_btree_mem.h                      |   75 +
>  fs/xfs/libxfs/xfs_btree_staging.c                  |  133 +-
>  fs/xfs/libxfs/xfs_btree_staging.h                  |   10 +-
>  fs/xfs/libxfs/xfs_da_btree.c                       |   59 +-
>  fs/xfs/libxfs/xfs_da_format.h                      |   11 +
>  fs/xfs/libxfs/xfs_defer.c                          |   25 +-
>  fs/xfs/libxfs/xfs_dir2.c                           |   59 +-
>  fs/xfs/libxfs/xfs_dir2.h                           |   13 +
>  fs/xfs/libxfs/xfs_dir2_block.c                     |    8 +-
>  fs/xfs/libxfs/xfs_dir2_data.c                      |    3 +
>  fs/xfs/libxfs/xfs_dir2_leaf.c                      |    3 +
>  fs/xfs/libxfs/xfs_dir2_node.c                      |    7 +
>  fs/xfs/libxfs/xfs_dir2_sf.c                        |   16 +-
>  fs/xfs/libxfs/xfs_format.h                         |   21 +-
>  fs/xfs/libxfs/xfs_fs.h                             |    8 +-
>  fs/xfs/libxfs/xfs_health.h                         |   95 +-
>  fs/xfs/libxfs/xfs_ialloc.c                         |  240 ++-
>  fs/xfs/libxfs/xfs_ialloc_btree.c                   |  159 +-
>  fs/xfs/libxfs/xfs_ialloc_btree.h                   |   11 +-
>  fs/xfs/libxfs/xfs_iext_tree.c                      |   26 +-
>  fs/xfs/libxfs/xfs_inode_buf.c                      |   12 +-
>  fs/xfs/libxfs/xfs_inode_fork.c                     |   49 +-
>  fs/xfs/libxfs/xfs_inode_fork.h                     |    1 +
>  fs/xfs/libxfs/xfs_log_format.h                     |    4 +-
>  fs/xfs/libxfs/xfs_refcount.c                       |   69 +-
>  fs/xfs/libxfs/xfs_refcount_btree.c                 |   80 +-
>  fs/xfs/libxfs/xfs_refcount_btree.h                 |    2 -
>  fs/xfs/libxfs/xfs_rmap.c                           |  284 +++-
>  fs/xfs/libxfs/xfs_rmap.h                           |   31 +-
>  fs/xfs/libxfs/xfs_rmap_btree.c                     |  239 ++-
>  fs/xfs/libxfs/xfs_rmap_btree.h                     |    8 +-
>  fs/xfs/libxfs/xfs_rtbitmap.c                       |   11 +-
>  fs/xfs/libxfs/xfs_sb.c                             |    2 +
>  fs/xfs/libxfs/xfs_shared.h                         |   67 +-
>  fs/xfs/libxfs/xfs_symlink_remote.c                 |  155 +-
>  fs/xfs/libxfs/xfs_symlink_remote.h                 |   26 +
>  fs/xfs/libxfs/xfs_trans_inode.c                    |    6 +-
>  fs/xfs/libxfs/xfs_types.h                          |   26 +-
>  fs/xfs/mrlock.h                                    |   78 -
>  fs/xfs/scrub/agb_bitmap.h                          |    5 +
>  fs/xfs/scrub/agheader.c                            |   12 +-
>  fs/xfs/scrub/agheader_repair.c                     |   47 +-
>  fs/xfs/scrub/alloc_repair.c                        |   27 +-
>  fs/xfs/scrub/bitmap.c                              |   14 +
>  fs/xfs/scrub/bitmap.h                              |    2 +
>  fs/xfs/scrub/bmap.c                                |    2 +-
>  fs/xfs/scrub/bmap_repair.c                         |    8 +-
>  fs/xfs/scrub/btree.c                               |   58 +-
>  fs/xfs/scrub/common.c                              |  133 +-
>  fs/xfs/scrub/common.h                              |   13 +
>  fs/xfs/scrub/cow_repair.c                          |    2 +-
>  fs/xfs/scrub/dir.c                                 |    4 +-
>  fs/xfs/scrub/fscounters.c                          |   29 +-
>  fs/xfs/scrub/fscounters.h                          |   20 +
>  fs/xfs/scrub/fscounters_repair.c                   |   72 +
>  fs/xfs/scrub/health.c                              |  140 +-
>  fs/xfs/scrub/health.h                              |    5 +-
>  fs/xfs/scrub/ialloc.c                              |   20 +-
>  fs/xfs/scrub/ialloc_repair.c                       |   10 +-
>  fs/xfs/scrub/inode_repair.c                        |  237 ++-
>  fs/xfs/scrub/iscan.c                               |  767 +++++++++
>  fs/xfs/scrub/iscan.h                               |   84 +
>  fs/xfs/scrub/newbt.c                               |   14 +-
>  fs/xfs/scrub/newbt.h                               |    7 +
>  fs/xfs/scrub/nlinks.c                              |  930 +++++++++++
>  fs/xfs/scrub/nlinks.h                              |  102 ++
>  fs/xfs/scrub/nlinks_repair.c                       |  223 +++
>  fs/xfs/scrub/quotacheck.c                          |  867 ++++++++++
>  fs/xfs/scrub/quotacheck.h                          |   76 +
>  fs/xfs/scrub/quotacheck_repair.c                   |  261 +++
>  fs/xfs/scrub/rcbag.c                               |  307 ++++
>  fs/xfs/scrub/rcbag.h                               |   28 +
>  fs/xfs/scrub/rcbag_btree.c                         |  370 +++++
>  fs/xfs/scrub/rcbag_btree.h                         |   81 +
>  fs/xfs/scrub/readdir.c                             |    4 +-
>  fs/xfs/scrub/reap.c                                |    2 +-
>  fs/xfs/scrub/refcount.c                            |   12 +
>  fs/xfs/scrub/refcount_repair.c                     |  177 +-
>  fs/xfs/scrub/repair.c                              |  120 +-
>  fs/xfs/scrub/repair.h                              |   23 +-
>  fs/xfs/scrub/rmap.c                                |   26 +-
>  fs/xfs/scrub/rmap_repair.c                         | 1697 ++++++++++++++++++++
>  fs/xfs/scrub/rtsummary.c                           |    6 +-
>  fs/xfs/scrub/scrub.c                               |   37 +-
>  fs/xfs/scrub/scrub.h                               |   18 +-
>  fs/xfs/scrub/stats.c                               |    6 +-
>  fs/xfs/scrub/symlink.c                             |    3 +-
>  fs/xfs/scrub/trace.c                               |    8 +-
>  fs/xfs/scrub/trace.h                               |  637 +++++++-
>  fs/xfs/scrub/xfarray.c                             |  234 ++-
>  fs/xfs/scrub/xfarray.h                             |   30 +-
>  fs/xfs/scrub/xfile.c                               |  345 ++--
>  fs/xfs/scrub/xfile.h                               |   62 +-
>  fs/xfs/xfs_acl.c                                   |    4 +-
>  fs/xfs/xfs_attr_inactive.c                         |    4 +
>  fs/xfs/xfs_attr_item.c                             |   25 +-
>  fs/xfs/xfs_attr_list.c                             |   26 +-
>  fs/xfs/xfs_bmap_item.c                             |  119 +-
>  fs/xfs/xfs_bmap_item.h                             |    4 +
>  fs/xfs/xfs_bmap_util.c                             |   20 +-
>  fs/xfs/xfs_buf.c                                   |  320 ++--
>  fs/xfs/xfs_buf.h                                   |   21 +-
>  fs/xfs/xfs_buf_item.c                              |    8 +-
>  fs/xfs/xfs_buf_item_recover.c                      |    8 +-
>  fs/xfs/xfs_buf_mem.c                               |  270 ++++
>  fs/xfs/xfs_buf_mem.h                               |   34 +
>  fs/xfs/xfs_dir2_readdir.c                          |    8 +-
>  fs/xfs/xfs_discard.c                               |   19 +-
>  fs/xfs/xfs_dquot.c                                 |   36 +-
>  fs/xfs/xfs_error.c                                 |    8 +-
>  fs/xfs/xfs_extent_busy.c                           |    5 +-
>  fs/xfs/xfs_extfree_item.c                          |    8 +-
>  fs/xfs/xfs_file.c                                  |    4 +-
>  fs/xfs/xfs_filestream.c                            |    6 +-
>  fs/xfs/xfs_fsmap.c                                 |    4 +-
>  fs/xfs/xfs_health.c                                |  202 ++-
>  fs/xfs/xfs_hooks.c                                 |   52 +
>  fs/xfs/xfs_hooks.h                                 |   65 +
>  fs/xfs/xfs_icache.c                                |   14 +-
>  fs/xfs/xfs_icreate_item.c                          |    2 +-
>  fs/xfs/xfs_inode.c                                 |  274 +++-
>  fs/xfs/xfs_inode.h                                 |   37 +-
>  fs/xfs/xfs_inode_item.c                            |    6 +-
>  fs/xfs/xfs_inode_item_recover.c                    |    5 +-
>  fs/xfs/xfs_ioctl.c                                 |    8 +-
>  fs/xfs/xfs_iomap.c                                 |   19 +-
>  fs/xfs/xfs_iops.c                                  |    9 +-
>  fs/xfs/xfs_itable.c                                |   12 +-
>  fs/xfs/xfs_iwalk.c                                 |   41 +-
>  fs/xfs/xfs_linux.h                                 |   17 +-
>  fs/xfs/xfs_log.c                                   |   34 +-
>  fs/xfs/xfs_log_cil.c                               |   31 +-
>  fs/xfs/xfs_log_recover.c                           |  102 +-
>  fs/xfs/xfs_mount.c                                 |    2 +-
>  fs/xfs/xfs_mount.h                                 |   12 +-
>  fs/xfs/xfs_mru_cache.c                             |   17 +-
>  fs/xfs/xfs_qm.c                                    |   59 +-
>  fs/xfs/xfs_qm.h                                    |   16 +
>  fs/xfs/xfs_qm_bhv.c                                |    1 +
>  fs/xfs/xfs_quota.h                                 |   46 +
>  fs/xfs/xfs_refcount_item.c                         |   12 +-
>  fs/xfs/xfs_reflink.c                               |   16 +-
>  fs/xfs/xfs_rmap_item.c                             |   11 +-
>  fs/xfs/xfs_rtalloc.c                               |   18 +-
>  fs/xfs/xfs_stats.c                                 |    4 +-
>  fs/xfs/xfs_stats.h                                 |    2 +
>  fs/xfs/xfs_super.c                                 |   20 +-
>  fs/xfs/xfs_symlink.c                               |  158 +-
>  fs/xfs/xfs_symlink.h                               |    1 -
>  fs/xfs/xfs_sysfs.c                                 |    4 -
>  fs/xfs/xfs_trace.c                                 |    3 +
>  fs/xfs/xfs_trace.h                                 |  607 +++++--
>  fs/xfs/xfs_trans.c                                 |    2 +-
>  fs/xfs/xfs_trans.h                                 |    1 +
>  fs/xfs/xfs_trans_ail.c                             |    7 +-
>  fs/xfs/xfs_trans_buf.c                             |   42 +
>  fs/xfs/xfs_trans_dquot.c                           |  171 +-
>  include/linux/rwbase_rt.h                          |    9 +-
>  include/linux/rwsem.h                              |   46 +-
>  include/linux/shmem_fs.h                           |    6 +-
>  include/linux/swap.h                               |   10 -
>  mm/filemap.c                                       |    9 +
>  mm/internal.h                                      |    4 +
>  mm/shmem.c                                         |   42 +-
>  mm/workingset.c                                    |    1 +
>  scripts/kernel-doc                                 |    2 +-
>  186 files changed, 13274 insertions(+), 3585 deletions(-)
>  delete mode 100644 fs/xfs/kmem.c
>  delete mode 100644 fs/xfs/kmem.h
>  create mode 100644 fs/xfs/libxfs/xfs_btree_mem.c
>  create mode 100644 fs/xfs/libxfs/xfs_btree_mem.h
>  create mode 100644 fs/xfs/libxfs/xfs_symlink_remote.h
>  delete mode 100644 fs/xfs/mrlock.h
>  create mode 100644 fs/xfs/scrub/fscounters.h
>  create mode 100644 fs/xfs/scrub/fscounters_repair.c
>  create mode 100644 fs/xfs/scrub/iscan.c
>  create mode 100644 fs/xfs/scrub/iscan.h
>  create mode 100644 fs/xfs/scrub/nlinks.c
>  create mode 100644 fs/xfs/scrub/nlinks.h
>  create mode 100644 fs/xfs/scrub/nlinks_repair.c
>  create mode 100644 fs/xfs/scrub/quotacheck.c
>  create mode 100644 fs/xfs/scrub/quotacheck.h
>  create mode 100644 fs/xfs/scrub/quotacheck_repair.c
>  create mode 100644 fs/xfs/scrub/rcbag.c
>  create mode 100644 fs/xfs/scrub/rcbag.h
>  create mode 100644 fs/xfs/scrub/rcbag_btree.c
>  create mode 100644 fs/xfs/scrub/rcbag_btree.h
>  create mode 100644 fs/xfs/scrub/rmap_repair.c
>  create mode 100644 fs/xfs/xfs_buf_mem.c
>  create mode 100644 fs/xfs/xfs_buf_mem.h
>  create mode 100644 fs/xfs/xfs_hooks.c
>  create mode 100644 fs/xfs/xfs_hooks.h

