Return-Path: <linux-fsdevel+bounces-19820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA58C9F79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452C52815D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBDD136649;
	Mon, 20 May 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyvrtDu2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD34C66;
	Mon, 20 May 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218221; cv=none; b=I1qUslOQeh+JxTEV+Fgm0zBzrKurM+iFCvuvyVx5C3/Qudlk1Ky2iD0H1Gwx/Hcy8rAk4dUJBAsmxYgp3iY34W1QjRGJB9R2ztmp97oXwsTlOcFGBq4icw3vKdoFHNf4QVhrGvjc+c1XggDBkMs6Ud/QdNL3x8maCvH+njsBE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218221; c=relaxed/simple;
	bh=DZQRbJ+NiP4SfIiYwV9t69lmRvJBbJMQnDnZ5VbARxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AFk4HJZG3zy1BxcwxRAt3p75DVdoFw17oUEEc7RtZgkqxERN3eW/z0WccZC+j8HdzsWuVaC5t7X0c2HRCH75k4BMwd83IF70xdO92ULUZq9dHEW8j8R0qVD3p7kuLfBfSi4MwkNYJi0u2839HN04soUT0kuS0UsUpGvcRbNgyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyvrtDu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF94C2BD10;
	Mon, 20 May 2024 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716218220;
	bh=DZQRbJ+NiP4SfIiYwV9t69lmRvJBbJMQnDnZ5VbARxg=;
	h=From:To:Cc:Subject:Date:From;
	b=gyvrtDu24xWdMuF9MFHKsuCrdLwUfXsJmUInQs+tz9K5zCR1+4PQqxMFxIas+GGDe
	 9l7JQC8swK20P748dN9hIkoc915sORPFndoPbTZMYZaVUDStoNKx6RgFBva7t73Kbn
	 jSnCk2KBvqPBbLO6QvpfQJVkqtQCkV3Vd5E8+VJeN2yAsPMtma75z84h3Ry2Xt45dS
	 0iPqRhea/PROFJP8+5VC+s9+hVQfwdudz86Tx2dIrSVOFBjLPaQVgWW4cHsgk/UCHY
	 5Cw98+JzUP5lOuDg/LLjM3p98c1Ew4YV09OIPj7RK2xSxD2OMNKHwEzKnU8Y5nf+U8
	 GvAyrwDX0i09A==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: new code for 6.10
Date: Mon, 20 May 2024 20:43:54 +0530
Message-ID: <87h6esfr88.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch with changes for XFS for 6.10-rc1.

Online repair feature continues to be expanded. Please refer to the section
"New code for 6.10" for a brief description of changes added to Online
repair. Also, we now support delayed allocation for realtime devices which
have an extent size that is equal to filesystem's block size.

We did find a regression late in the development cycle
(https://lore.kernel.org/linux-xfs/87ttj8ircu.fsf@debian-BULLSEYE-live-builder-AMD64/).
The regression is limited to files residing on an XFS realtime volume which
has a Realtime extent size larger than filesystem's block size. I believe this
configuration is rare and hence we can go ahead with merging the new
code. Presently, A fix
(https://lore.kernel.org/linux-xfs/20240517111355.233085-1-yi.zhang@huaweicloud.com/T/#t)
is being discussed.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.10-merge-6

for you to fetch changes up to 25576c5420e61dea4c2b52942460f2221b8e46e8:

  xfs: simplify iext overflow checking and upgrade (2024-05-03 11:20:06 +0530)

----------------------------------------------------------------
New code for 6.10:

  * Introduce Parent Pointer extended attribute for inodes.

  * Online Repair
    - Implement atomic file content exchanges i.e. exchange ranges of bytes
      between two files atomically.
    - Create temporary files to repair file-based metadata. This uses atomic
      file content exchange facility to swap file fork mappings between the
      temporary file and the metadata inode.

    - Allow callers of directory/xattr code to set an explicit owner number to
      be written into the header fields of any new blocks that are created.
      This is required to avoid walking every block of the new structure and
      modify their ownership during online repair.
    - Repair
      - Extended attributes
      - Inode unlinked state
      - Directories
      - Symbolic links
      - AGI's unlinked inode list.
      - Parent pointers.
    - Move Orphan files to lost and found directory.
    - Fixes for Inode repair functionality.
    - Introduce a new sub-AG FITRIM implementation to reduce the duration for
      which the AGF lock is held.
    - Updates for the design documentation.
    - Use Parent Pointers to assist in checking directories, parent pointers,
      extended attributes, and link counts.

  * Bring back delalloc support for realtime devices which have an extent size
    that is equal to filesystem's block size.

  * Improve performance of log incompat feature handling.

  * Fixes
    - Prevent userspace from reading invalid file data due to incorrect.
      updation of file size when performing a non-atomic clone operation.
    - Minor fixes to online repair.
    - Fix confusing return values from xfs_bmapi_write().
    - Fix an out of bounds access due to incorrect h_size during log recovery.
    - Defer upgrading the extent counters in xfs_reflink_end_cow_extent() until
      we know we are going to modify the extent mapping.
    - Remove racy access to if_bytes check in xfs_reflink_end_cow_extent().
    - Fix sparse warnings.

  * Cleanups
    - Hold inode locks on all files involved in a rename until the completion
      of the operation. This is in preparation for the parent pointers patchset
      where parent pointers are applied in a separate chained update from the
      actual directory update.
    - Compile out v4 support when disabled.
    - Cleanup xfs_extent_busy_clear().
    - Remove unused flags and fields from struct xfs_da_args.
    - Remove definitions of unused functions.
    - Improve extended attribute validation.
    - Add higher level directory operations helpers to remove duplication of
      code.
    - Cleanup quota (un)reservation interfaces.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Allison Henderson (20):
      xfs: Increase XFS_DEFER_OPS_NR_INODES to 5
      xfs: Increase XFS_QM_TRANS_MAXDQS to 5
      xfs: Hold inode locks in xfs_ialloc
      xfs: Hold inode locks in xfs_trans_alloc_dir
      xfs: Hold inode locks in xfs_rename
      xfs: add parent pointer support to attribute code
      xfs: define parent pointer ondisk extended attribute format
      xfs: Expose init_xattrs in xfs_create_tmpfile
      xfs: add parent pointer validator functions
      xfs: extend transaction reservations for parent attributes
      xfs: parent pointer attribute creation
      xfs: add parent attributes to link
      xfs: add parent attributes to symlink
      xfs: remove parent pointers in unlink
      xfs: Add parent pointers to rename
      xfs: Add parent pointers to xfs_cross_rename
      xfs: don't return XFS_ATTR_PARENT attributes via listxattr
      xfs: pass the attr value to put_listent when possible
      xfs: don't remove the attr fork when parent pointers are enabled
      xfs: add a incompat feature bit for parent pointers

Chandan Babu R (26):
      Merge tag 'log-incompat-permissions-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'file-exchange-refactorings-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'atomic-file-updates-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'repair-tempfiles-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'repair-rtsummary-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'dirattr-validate-owners-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'repair-xattrs-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'repair-unlinked-inode-state-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'repair-dirs-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'repair-orphanage-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'repair-symlink-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'repair-iunlink-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'inode-repair-improvements-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'discard-relax-locks-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'online-fsck-design-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'retain-ilock-during-dir-ops-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      Merge tag 'shrink-dirattr-args-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      Merge tag 'improve-attr-validation-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      Merge tag 'pptrs-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      Merge tag 'scrub-pptrs-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      Merge tag 'repair-pptrs-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      Merge tag 'scrub-directory-tree-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      Merge tag 'vectorized-scrub-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      Merge tag 'reduce-scrub-iget-overhead-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      Merge tag 'repair-fixes-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      Merge tag 'xfs-cleanups-6.10_2024-05-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeF

Christoph Hellwig (38):
      xfs: move more logic into xfs_extent_busy_clear_one
      xfs: unwind xfs_extent_busy_clear
      xfs: remove the unused xfs_extent_busy_enomem trace event
      xfs: compile out v4 support if disabled
      xfs: make XFS_TRANS_LOWMODE match the other XFS_TRANS_ definitions
      xfs: refactor realtime inode locking
      xfs: free RT extents after updating the bmap btree
      xfs: move RT inode locking out of __xfs_bunmapi
      xfs: block deltas in xfs_trans_unreserve_and_mod_sb must be positive
      xfs: split xfs_mod_freecounter
      xfs: reinstate RT support in xfs_bmapi_reserve_delalloc
      xfs: cleanup fdblock/frextent accounting in xfs_bmap_del_extent_delay
      xfs: support RT inodes in xfs_mod_delalloc
      xfs: look at m_frextents in xfs_iomap_prealloc_size for RT allocations
      xfs: rework splitting of indirect block reservations
      xfs: stop the steal (of data blocks for RT indirect blocks)
      xfs: reinstate delalloc for RT inodes (if sb_rextsize == 1)
      xfs: check the flags earlier in xfs_attr_match
      xfs: factor out a xfs_dir_lookup_args helper
      xfs: factor out a xfs_dir_createname_args helper
      xfs: factor out a xfs_dir_removename_args helper
      xfs: factor out a xfs_dir_replace_args helper
      xfs: refactor dir format helpers
      xfs: fix error returns from xfs_bmapi_write
      xfs: remove the unusued tmp_logflags variable in xfs_bmapi_allocate
      xfs: lift a xfs_valid_startblock into xfs_bmapi_allocate
      xfs: don't open code XFS_FILBLKS_MIN in xfs_bmapi_write
      xfs: pass the actual offset and len to allocate to xfs_bmapi_allocate
      xfs: remove the xfs_iext_peek_prev_extent call in xfs_bmapi_allocate
      xfs: fix xfs_bmap_add_extent_delay_real for partial conversions
      xfs: do not allocate the entire delalloc extent in xfs_bmapi_write
      xfs: fix log recovery buffer allocation for the legacy h_size fixup
      xfs: clean up buffer allocation in xlog_do_recovery_pass
      xfs: consolidate the xfs_quota_reserve_blkres definitions
      xfs: xfs_quota_unreserve_blkres can't fail
      xfs: upgrade the extent counters in xfs_reflink_end_cow_extent later
      xfs: remove a racy if_bytes check in xfs_reflink_end_cow_extent
      xfs: simplify iext overflow checking and upgrade

Dan Carpenter (1):
      xfs: small cleanup in xrep_update_qflags()

Darrick J. Wong (152):
      xfs: pass xfs_buf lookup flags to xfs_*read_agi
      xfs: fix an AGI lock acquisition ordering problem in xrep_dinode_findmode
      xfs: fix potential AGI <-> ILOCK ABBA deadlock in xrep_dinode_findmode_walk_directory
      xfs: fix error bailout in xrep_abt_build_new_trees
      xfs: only clear log incompat flags at clean unmount
      xfs: move inode lease breaking functions to xfs_inode.c
      xfs: move xfs_iops.c declarations out of xfs_inode.h
      xfs: declare xfs_file.c symbols in xfs_file.h
      xfs: create a new helper to return a file's allocation unit
      xfs: hoist multi-fsb allocation unit detection to a helper
      xfs: refactor non-power-of-two alignment checks
      xfs: constify xfs_bmap_is_written_extent
      vfs: export remap and write check helpers
      xfs: introduce new file range exchange ioctl
      xfs: create a incompat flag for atomic file mapping exchanges
      xfs: introduce a file mapping exchange log intent item
      xfs: create deferred log items for file mapping exchanges
      xfs: bind together the front and back ends of the file range exchange code
      xfs: add error injection to test file mapping exchange recovery
      xfs: condense extended attributes after a mapping exchange operation
      xfs: condense directories after a mapping exchange operation
      xfs: condense symbolic links after a mapping exchange operation
      xfs: make file range exchange support realtime files
      xfs: support non-power-of-two rtextsize with exchange-range
      xfs: capture inode generation numbers in the ondisk exchmaps log item
      docs: update swapext -> exchmaps language
      xfs: enable logged file mapping exchange feature
      xfs: hide private inodes from bulkstat and handle functions
      xfs: create temporary files and directories for online repair
      xfs: refactor live buffer invalidation for repairs
      xfs: support preallocating and copying content into temporary files
      xfs: teach the tempfile to set up atomic file content exchanges
      xfs: add the ability to reap entire inode forks
      xfs: online repair of realtime summaries
      xfs: add an explicit owner field to xfs_da_args
      xfs: use the xfs_da_args owner field to set new dir/attr block owner
      xfs: reduce indenting in xfs_attr_node_list
      xfs: validate attr leaf buffer owners
      xfs: validate attr remote value buffer owners
      xfs: validate dabtree node buffer owners
      xfs: validate directory leaf buffer owners
      xfs: validate explicit directory data buffer owners
      xfs: validate explicit directory block buffer owners
      xfs: validate explicit directory free block owners
      xfs: enable discarding of folios backing an xfile
      xfs: create a blob array data structure
      xfs: use atomic extent swapping to fix user file fork data
      xfs: repair extended attributes
      xfs: scrub should set preen if attr leaf has holes
      xfs: flag empty xattr leaf blocks for optimization
      xfs: ensure unlinked list state is consistent with nlink during scrub
      xfs: create an xattr iteration function for scrub
      xfs: inactivate directory data blocks
      xfs: online repair of directories
      xfs: update the unlinked list when repairing link counts
      xfs: scan the filesystem to repair a directory dotdot entry
      xfs: online repair of parent pointers
      xfs: move orphan files to the orphanage
      xfs: ask the dentry cache if it knows the parent of a directory
      xfs: expose xfs_bmap_local_to_extents for online repair
      xfs: move files to orphanage instead of letting nlinks drop to zero
      xfs: pass the owner to xfs_symlink_write_target
      xfs: ensure dentry consistency when the orphanage adopts a file
      xfs: check AGI unlinked inode buckets
      xfs: hoist AGI repair context to a heap object
      xfs: online repair of symbolic links
      xfs: repair AGI unlinked inode bucket lists
      xfs: check unused nlink fields in the ondisk inode
      xfs: try to avoid allocating from sick inode clusters
      xfs: pin inodes that would otherwise overflow link count
      docs: update the parent pointers documentation to the final version
      docs: update online directory and parent pointer repair sections
      xfs: create subordinate scrub contexts for xchk_metadata_inode_subtype
      xfs: fix performance problems when fstrimming a subset of a fragmented AG
      docs: update offline parent pointer repair strategy
      docs: describe xfs directory tree online fsck
      xfs: don't pick up IOLOCK during rmapbt repair scan
      xfs: unlock new repair tempfiles after creation
      xfs: remove XFS_DA_OP_REMOVE
      xfs: remove XFS_DA_OP_NOTIME
      xfs: remove xfs_da_args.attr_flags
      xfs: attr fork iext must be loaded before calling xfs_attr_is_leaf
      xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item recovery
      xfs: make attr removal an explicit operation
      xfs: use an XFS_OPSTATE_ flag for detecting if logged xattrs are available
      xfs: rearrange xfs_da_args a bit to use less space
      xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2
      xfs: fix missing check for invalid attr flags
      xfs: check shortform attr entry flags specifically
      xfs: restructure xfs_attr_complete_op a bit
      xfs: use helpers to extract xattr op from opflags
      xfs: validate recovered name buffers when recovering xattr items
      xfs: always set args->value in xfs_attri_item_recover
      xfs: use local variables for name and value length in _attri_commit_pass2
      xfs: refactor name/length checks in xfs_attri_validate
      xfs: refactor name/value iovec validation in xlog_recover_attri_commit_pass2
      xfs: enforce one namespace per attribute
      xfs: rearrange xfs_attr_match parameters
      xfs: move xfs_attr_defer_add to xfs_attr_item.c
      xfs: create a separate hashname function for extended attributes
      xfs: allow xattr matching on name and value for parent pointers
      xfs: refactor xfs_is_using_logged_xattrs checks in attr item recovery
      xfs: create attr log item opcodes and formats for parent pointers
      xfs: record inode generation in xattr update log intent items
      xfs: create a hashname function for parent pointers
      xfs: move handle ioctl code to xfs_handle.c
      xfs: split out handle management helpers a bit
      xfs: add parent pointer ioctls
      xfs: fix unit conversion error in xfs_log_calc_max_attrsetm_res
      xfs: drop compatibility minimum log size computations for reflink
      xfs: revert commit 44af6c7e59b12
      xfs: enable parent pointers
      xfs: check dirents have parent pointers
      xfs: deferred scrub of dirents
      xfs: scrub parent pointers
      xfs: deferred scrub of parent pointers
      xfs: remove some boilerplate from xfs_attr_set
      xfs: make the reserved block permission flag explicit in xfs_attr_set
      xfs: walk directory parent pointers to determine backref count
      xfs: salvage parent pointers when rebuilding xattr structures
      xfs: check parent pointer xattrs when scrubbing
      xfs: add raw parent pointer apis to support repair
      xfs: repair directories by scanning directory parent pointers
      xfs: implement live updates for directory repairs
      xfs: replay unlocked parent pointer updates that accrue during xattr repair
      xfs: repair directory parent pointers by scanning for dirents
      xfs: implement live updates for parent pointer repairs
      xfs: remove pointless unlocked assertion
      xfs: split xfs_bmap_add_attrfork into two pieces
      xfs: add a per-leaf block callback to xchk_xattr_walk
      xfs: actually rebuild the parent pointer xattrs
      xfs: adapt the orphanage code to handle parent pointers
      xfs: teach online scrub to find directory tree structure problems
      xfs: repair link count of nondirectories after rebuilding parent pointers
      xfs: invalidate dirloop scrub path data when concurrent updates happen
      xfs: inode repair should ensure there's an attr fork to store parent pointers
      xfs: reduce the rate of cond_resched calls inside scrub
      xfs: report directory tree corruption in the health information
      xfs: move xfs_ioc_scrub_metadata to scrub.c
      xfs: fix corruptions in the directory tree
      xfs: use dontcache for grabbing inodes during scrub
      xfs: drop the scrub file's iolock when transaction allocation fails
      xfs: introduce vectored scrub mode
      xfs: only iget the file once when doing vectored scrub-by-handle
      xfs: fix iunlock calls in xrep_adoption_trans_alloc
      xfs: exchange-range for repairs is no longer dynamic
      xfs: invalidate dentries for a file before moving it to the orphanage
      xfs: use unsigned ints for non-negative quantities in xfs_attr_remote.c
      xfs: turn XFS_ATTR3_RMT_BUF_SPACE into a function
      xfs: create a helper to compute the blockcount of a max sized remote value
      xfs: minor cleanups of xfs_attr3_rmt_blocks
      xfs: widen flags argument to the xfs_iflags_* helpers

Dave Chinner (3):
      xfs: fix CIL sparse lock context warnings
      xfs: silence sparse warning when checking version number
      xfs: fix sparse warnings about unused interval tree functions

Jiapeng Chong (2):
      xfs: Remove unused function is_rt_data_fork
      xfs: Remove unused function xrep_dir_self_parent

Thorsten Blum (1):
      xfs: Fix typo in comment

Zhang Yi (4):
      xfs: match lock mode in xfs_buffered_write_iomap_begin()
      xfs: make the seq argument to xfs_bmapi_convert_delalloc() optional
      xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
      xfs: convert delayed extents to unwritten when zeroing post eof blocks

 .../filesystems/xfs/xfs-online-fsck-design.rst     |  632 ++++---
 fs/read_write.c                                    |    1 +
 fs/remap_range.c                                   |    4 +-
 fs/xfs/Makefile                                    |   18 +
 fs/xfs/libxfs/xfs_ag.c                             |   12 +-
 fs/xfs/libxfs/xfs_ag_resv.c                        |   24 +-
 fs/xfs/libxfs/xfs_ag_resv.h                        |    2 +-
 fs/xfs/libxfs/xfs_alloc.c                          |    4 +-
 fs/xfs/libxfs/xfs_attr.c                           |  233 ++-
 fs/xfs/libxfs/xfs_attr.h                           |   46 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                      |  154 +-
 fs/xfs/libxfs/xfs_attr_leaf.h                      |    4 +-
 fs/xfs/libxfs/xfs_attr_remote.c                    |  104 +-
 fs/xfs/libxfs/xfs_attr_remote.h                    |    8 +-
 fs/xfs/libxfs/xfs_attr_sf.h                        |    1 +
 fs/xfs/libxfs/xfs_bmap.c                           |  377 ++--
 fs/xfs/libxfs/xfs_bmap.h                           |   13 +-
 fs/xfs/libxfs/xfs_da_btree.c                       |  189 +-
 fs/xfs/libxfs/xfs_da_btree.h                       |   34 +-
 fs/xfs/libxfs/xfs_da_format.h                      |   37 +-
 fs/xfs/libxfs/xfs_defer.c                          |   12 +-
 fs/xfs/libxfs/xfs_defer.h                          |   10 +-
 fs/xfs/libxfs/xfs_dir2.c                           |  283 ++-
 fs/xfs/libxfs/xfs_dir2.h                           |   23 +-
 fs/xfs/libxfs/xfs_dir2_block.c                     |   42 +-
 fs/xfs/libxfs/xfs_dir2_data.c                      |   18 +-
 fs/xfs/libxfs/xfs_dir2_leaf.c                      |  100 +-
 fs/xfs/libxfs/xfs_dir2_node.c                      |   44 +-
 fs/xfs/libxfs/xfs_dir2_priv.h                      |   15 +-
 fs/xfs/libxfs/xfs_errortag.h                       |    4 +-
 fs/xfs/libxfs/xfs_exchmaps.c                       | 1235 ++++++++++++
 fs/xfs/libxfs/xfs_exchmaps.h                       |  124 ++
 fs/xfs/libxfs/xfs_format.h                         |   34 +-
 fs/xfs/libxfs/xfs_fs.h                             |  158 +-
 fs/xfs/libxfs/xfs_health.h                         |    4 +-
 fs/xfs/libxfs/xfs_ialloc.c                         |   56 +-
 fs/xfs/libxfs/xfs_ialloc.h                         |    5 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c                   |    4 +-
 fs/xfs/libxfs/xfs_inode_buf.c                      |    8 +
 fs/xfs/libxfs/xfs_inode_fork.c                     |   57 +-
 fs/xfs/libxfs/xfs_inode_fork.h                     |    6 +-
 fs/xfs/libxfs/xfs_log_format.h                     |   89 +-
 fs/xfs/libxfs/xfs_log_recover.h                    |    4 +
 fs/xfs/libxfs/xfs_log_rlimit.c                     |   46 +
 fs/xfs/libxfs/xfs_ondisk.h                         |    6 +
 fs/xfs/libxfs/xfs_parent.c                         |  379 ++++
 fs/xfs/libxfs/xfs_parent.h                         |  110 ++
 fs/xfs/libxfs/xfs_rtbitmap.c                       |   57 +
 fs/xfs/libxfs/xfs_rtbitmap.h                       |   17 +
 fs/xfs/libxfs/xfs_sb.c                             |    9 +
 fs/xfs/libxfs/xfs_shared.h                         |    6 +-
 fs/xfs/libxfs/xfs_symlink_remote.c                 |   54 +-
 fs/xfs/libxfs/xfs_symlink_remote.h                 |    8 +-
 fs/xfs/libxfs/xfs_trans_resv.c                     |  328 +++-
 fs/xfs/libxfs/xfs_trans_space.c                    |  121 ++
 fs/xfs/libxfs/xfs_trans_space.h                    |   29 +-
 fs/xfs/scrub/agheader.c                            |   43 +-
 fs/xfs/scrub/agheader_repair.c                     |  879 ++++++++-
 fs/xfs/scrub/agino_bitmap.h                        |   49 +
 fs/xfs/scrub/alloc_repair.c                        |    2 +-
 fs/xfs/scrub/attr.c                                |  218 ++-
 fs/xfs/scrub/attr.h                                |    7 +
 fs/xfs/scrub/attr_repair.c                         | 1663 +++++++++++++++++
 fs/xfs/scrub/attr_repair.h                         |   15 +
 fs/xfs/scrub/bitmap.c                              |   22 +-
 fs/xfs/scrub/common.c                              |   41 +-
 fs/xfs/scrub/common.h                              |   27 +-
 fs/xfs/scrub/dab_bitmap.h                          |   37 +
 fs/xfs/scrub/dabtree.c                             |   24 +
 fs/xfs/scrub/dabtree.h                             |    3 +
 fs/xfs/scrub/dir.c                                 |  377 +++-
 fs/xfs/scrub/dir_repair.c                          | 1958 ++++++++++++++++++++
 fs/xfs/scrub/dirtree.c                             |  985 ++++++++++
 fs/xfs/scrub/dirtree.h                             |  178 ++
 fs/xfs/scrub/dirtree_repair.c                      |  821 ++++++++
 fs/xfs/scrub/findparent.c                          |  454 +++++
 fs/xfs/scrub/findparent.h                          |   56 +
 fs/xfs/scrub/fscounters.c                          |   14 +-
 fs/xfs/scrub/fscounters.h                          |    1 +
 fs/xfs/scrub/fscounters_repair.c                   |   12 +-
 fs/xfs/scrub/health.c                              |    1 +
 fs/xfs/scrub/ino_bitmap.h                          |   37 +
 fs/xfs/scrub/inode.c                               |   19 +
 fs/xfs/scrub/inode_repair.c                        |  153 +-
 fs/xfs/scrub/iscan.c                               |   67 +-
 fs/xfs/scrub/iscan.h                               |   16 +
 fs/xfs/scrub/listxattr.c                           |  320 ++++
 fs/xfs/scrub/listxattr.h                           |   19 +
 fs/xfs/scrub/nlinks.c                              |  133 +-
 fs/xfs/scrub/nlinks.h                              |    7 +
 fs/xfs/scrub/nlinks_repair.c                       |  186 +-
 fs/xfs/scrub/orphanage.c                           |  627 +++++++
 fs/xfs/scrub/orphanage.h                           |   86 +
 fs/xfs/scrub/parent.c                              |  700 ++++++-
 fs/xfs/scrub/parent_repair.c                       | 1612 ++++++++++++++++
 fs/xfs/scrub/quota_repair.c                        |    6 -
 fs/xfs/scrub/readdir.c                             |  150 +-
 fs/xfs/scrub/readdir.h                             |    3 +
 fs/xfs/scrub/reap.c                                |  443 ++++-
 fs/xfs/scrub/reap.h                                |   21 +
 fs/xfs/scrub/repair.c                              |  127 +-
 fs/xfs/scrub/repair.h                              |   31 +
 fs/xfs/scrub/rmap_repair.c                         |   24 +-
 fs/xfs/scrub/rtbitmap_repair.c                     |    2 -
 fs/xfs/scrub/rtsummary.c                           |   33 +-
 fs/xfs/scrub/rtsummary.h                           |   37 +
 fs/xfs/scrub/rtsummary_repair.c                    |  175 ++
 fs/xfs/scrub/scrub.c                               |  310 +++-
 fs/xfs/scrub/scrub.h                               |   91 +
 fs/xfs/scrub/stats.c                               |    1 +
 fs/xfs/scrub/symlink.c                             |   13 +-
 fs/xfs/scrub/symlink_repair.c                      |  509 +++++
 fs/xfs/scrub/tempexch.h                            |   22 +
 fs/xfs/scrub/tempfile.c                            |  851 +++++++++
 fs/xfs/scrub/tempfile.h                            |   48 +
 fs/xfs/scrub/trace.c                               |    6 +
 fs/xfs/scrub/trace.h                               | 1307 ++++++++++++-
 fs/xfs/scrub/xfarray.c                             |   27 +-
 fs/xfs/scrub/xfarray.h                             |    6 +
 fs/xfs/scrub/xfblob.c                              |  168 ++
 fs/xfs/scrub/xfblob.h                              |   50 +
 fs/xfs/scrub/xfile.c                               |   14 +-
 fs/xfs/scrub/xfile.h                               |    6 +
 fs/xfs/scrub/xfs_scrub.h                           |    6 +-
 fs/xfs/xfs_acl.c                                   |   17 +-
 fs/xfs/xfs_aops.c                                  |   60 +-
 fs/xfs/xfs_attr_item.c                             |  560 +++++-
 fs/xfs/xfs_attr_item.h                             |   10 +
 fs/xfs/xfs_attr_list.c                             |  120 +-
 fs/xfs/xfs_bmap_item.c                             |    4 +-
 fs/xfs/xfs_bmap_util.c                             |   71 +-
 fs/xfs/xfs_bmap_util.h                             |    2 +-
 fs/xfs/xfs_buf.c                                   |    3 +
 fs/xfs/xfs_dir2_readdir.c                          |   25 +-
 fs/xfs/xfs_discard.c                               |  153 +-
 fs/xfs/xfs_dquot.c                                 |   47 +-
 fs/xfs/xfs_dquot.h                                 |    1 +
 fs/xfs/xfs_error.c                                 |    3 +
 fs/xfs/xfs_exchmaps_item.c                         |  614 ++++++
 fs/xfs/xfs_exchmaps_item.h                         |   64 +
 fs/xfs/xfs_exchrange.c                             |  804 ++++++++
 fs/xfs/xfs_exchrange.h                             |   38 +
 fs/xfs/xfs_export.c                                |    4 +-
 fs/xfs/xfs_export.h                                |    2 +
 fs/xfs/xfs_extent_busy.c                           |   80 +-
 fs/xfs/xfs_file.c                                  |   88 +-
 fs/xfs/xfs_file.h                                  |   15 +
 fs/xfs/xfs_fsmap.c                                 |    4 +-
 fs/xfs/xfs_fsops.c                                 |   29 +-
 fs/xfs/xfs_fsops.h                                 |    2 +-
 fs/xfs/xfs_handle.c                                |  952 ++++++++++
 fs/xfs/xfs_handle.h                                |   33 +
 fs/xfs/xfs_health.c                                |    1 +
 fs/xfs/xfs_icache.c                                |    4 +-
 fs/xfs/xfs_inode.c                                 |  496 ++++-
 fs/xfs/xfs_inode.h                                 |   41 +-
 fs/xfs/xfs_ioctl.c                                 |  625 +------
 fs/xfs/xfs_ioctl.h                                 |   28 -
 fs/xfs/xfs_ioctl32.c                               |    1 +
 fs/xfs/xfs_iomap.c                                 |  105 +-
 fs/xfs/xfs_iops.c                                  |   23 +-
 fs/xfs/xfs_iops.h                                  |    7 +-
 fs/xfs/xfs_itable.c                                |    8 +
 fs/xfs/xfs_iwalk.c                                 |    4 +-
 fs/xfs/xfs_linux.h                                 |    5 +
 fs/xfs/xfs_log.c                                   |   28 +-
 fs/xfs/xfs_log.h                                   |    2 -
 fs/xfs/xfs_log_cil.c                               |    2 +-
 fs/xfs/xfs_log_priv.h                              |    8 +-
 fs/xfs/xfs_log_recover.c                           |   85 +-
 fs/xfs/xfs_mount.c                                 |  111 +-
 fs/xfs/xfs_mount.h                                 |   88 +-
 fs/xfs/xfs_qm.c                                    |    4 +-
 fs/xfs/xfs_qm.h                                    |    2 +-
 fs/xfs/xfs_quota.h                                 |   23 +-
 fs/xfs/xfs_reflink.c                               |   48 +-
 fs/xfs/xfs_rtalloc.c                               |   29 +-
 fs/xfs/xfs_super.c                                 |   76 +-
 fs/xfs/xfs_symlink.c                               |   93 +-
 fs/xfs/xfs_trace.c                                 |    3 +
 fs/xfs/xfs_trace.h                                 |  440 ++++-
 fs/xfs/xfs_trans.c                                 |   72 +-
 fs/xfs/xfs_trans_dquot.c                           |   15 +-
 fs/xfs/xfs_xattr.c                                 |   92 +-
 fs/xfs/xfs_xattr.h                                 |    3 +-
 include/linux/fs.h                                 |    1 +
 186 files changed, 25098 insertions(+), 3038 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_exchmaps.c
 create mode 100644 fs/xfs/libxfs/xfs_exchmaps.h
 create mode 100644 fs/xfs/libxfs/xfs_parent.c
 create mode 100644 fs/xfs/libxfs/xfs_parent.h
 create mode 100644 fs/xfs/libxfs/xfs_trans_space.c
 create mode 100644 fs/xfs/scrub/agino_bitmap.h
 create mode 100644 fs/xfs/scrub/attr_repair.c
 create mode 100644 fs/xfs/scrub/attr_repair.h
 create mode 100644 fs/xfs/scrub/dab_bitmap.h
 create mode 100644 fs/xfs/scrub/dir_repair.c
 create mode 100644 fs/xfs/scrub/dirtree.c
 create mode 100644 fs/xfs/scrub/dirtree.h
 create mode 100644 fs/xfs/scrub/dirtree_repair.c
 create mode 100644 fs/xfs/scrub/findparent.c
 create mode 100644 fs/xfs/scrub/findparent.h
 create mode 100644 fs/xfs/scrub/ino_bitmap.h
 create mode 100644 fs/xfs/scrub/listxattr.c
 create mode 100644 fs/xfs/scrub/listxattr.h
 create mode 100644 fs/xfs/scrub/orphanage.c
 create mode 100644 fs/xfs/scrub/orphanage.h
 create mode 100644 fs/xfs/scrub/parent_repair.c
 create mode 100644 fs/xfs/scrub/rtsummary.h
 create mode 100644 fs/xfs/scrub/rtsummary_repair.c
 create mode 100644 fs/xfs/scrub/symlink_repair.c
 create mode 100644 fs/xfs/scrub/tempexch.h
 create mode 100644 fs/xfs/scrub/tempfile.c
 create mode 100644 fs/xfs/scrub/tempfile.h
 create mode 100644 fs/xfs/scrub/xfblob.c
 create mode 100644 fs/xfs/scrub/xfblob.h
 create mode 100644 fs/xfs/xfs_exchmaps_item.c
 create mode 100644 fs/xfs/xfs_exchmaps_item.h
 create mode 100644 fs/xfs/xfs_exchrange.c
 create mode 100644 fs/xfs/xfs_exchrange.h
 create mode 100644 fs/xfs/xfs_file.h
 create mode 100644 fs/xfs/xfs_handle.c
 create mode 100644 fs/xfs/xfs_handle.h

