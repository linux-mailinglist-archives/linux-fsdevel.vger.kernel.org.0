Return-Path: <linux-fsdevel+bounces-17855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E472E8B2FB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 07:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8287EB2262A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 05:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF7F13A26E;
	Fri, 26 Apr 2024 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ5SzrEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241617CD;
	Fri, 26 Apr 2024 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714108667; cv=none; b=opIrUztzkrBNh+gP86zCOiSV9e7xhXQ225NkVLVQYvdlMMJiu8x0k5liAiPQ+QJPIo2GuL2/GTg/cSb6vrFXtv74MznHJaqu9KC0ckNvdhkinLJarfBLTv+m3CCHJvorkxcRZHi6vrghFHYn23j74IBoJmZVYS7s8k3qTCcRQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714108667; c=relaxed/simple;
	bh=xUxiLmVXu95NiGCGkNvbiheq9/ydrit+Cc/inAMz5Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CyzFGGazeAv1q5GOAiPIAiX3jbMvH1Y0ztb9+QbEgM5i6RqdqIa3k2RFcVi5T7fJKKSlTGUihljNKTblQyp8xZyTqadd7xf41xDoJfrJmL7CyvXvyNR3LArx7sTT2ZwmZWVe3jare7+lbryNgISNHN/pPd1eTZW1bGVdRcOd/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ5SzrEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998A1C113CD;
	Fri, 26 Apr 2024 05:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714108667;
	bh=xUxiLmVXu95NiGCGkNvbiheq9/ydrit+Cc/inAMz5Jc=;
	h=From:To:Cc:Subject:Date:From;
	b=KQ5SzrEg1cXrBquSU+7PX0PJ4MRJpudeHXB1clnJFus0QyF5GTFWBBRk8YZzzTny/
	 +4G10PIyIJ3t6hl02ZORKCZhKaowQ7yCDBm1aPyE847ZuAhokxLATqjiMiGnZzNNCV
	 q67/r25+yMZrxxbJIVyAzQ/thtNgvNyz6w4XRqLN1bciYHdxqtt8oCvqD/H0hy6LCg
	 dwCXCeckN/q/rescM0Ao3iuSQyRAm03ncdF4tFdOtUbDBHTZPF6WrE2hZMT0gZ4PcK
	 /xn7al6LYx9Pab9St5qH4E4hhEwUgG44rsCXID+sN3PhYPWJQ16wnMZL/4vPQkl2zq
	 Wd2gbbJd08RDA==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: abaci@linux.alibaba.com,allison.henderson@oracle.com,darrick.wong@oracle.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,jiapeng.chong@linux.alibaba.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,mark.tinguely@oracle.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 08e012a62de8
Date: Fri, 26 Apr 2024 10:46:53 +0530
Message-ID: <877cgkog7c.fsf@debian-BULLSEYE-live-builder-AMD64>
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

08e012a62de8 xfs: Remove unused function xrep_dir_self_parent

95 new commits:

Allison Henderson (15):
      [98493ff87885] xfs: add parent pointer support to attribute code
      [8337d58ab286] xfs: define parent pointer ondisk extended attribute format
      [297da63379c6] xfs: Expose init_xattrs in xfs_create_tmpfile
      [a08d67296374] xfs: add parent pointer validator functions
      [7dba4a5fe1c5] xfs: extend transaction reservations for parent attributes
      [b7c62d90c12c] xfs: parent pointer attribute creation
      [f1097be220fa] xfs: add parent attributes to link
      [5d31a85dcc1f] xfs: add parent attributes to symlink
      [d2d18330f63c] xfs: remove parent pointers in unlink
      [5a8338c88284] xfs: Add parent pointers to rename
      [1c12949e50e1] xfs: Add parent pointers to xfs_cross_rename
      [daf9f884906b] xfs: don't return XFS_ATTR_PARENT attributes via listxattr
      [8f4b980ee67f] xfs: pass the attr value to put_listent when possible
      [7dafb449b792] xfs: don't remove the attr fork when parent pointers are enabled
      [5f98ec1cb5c2] xfs: add a incompat feature bit for parent pointers

Chandan Babu R (9):
      [1321890a1b51] Merge tag 'shrink-dirattr-args-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      [d7d02f750ae9] Merge tag 'improve-attr-validation-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      [47d83c194606] Merge tag 'pptrs-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      [0d2dd382a7c0] Merge tag 'scrub-pptrs-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      [1da824b0bfcf] Merge tag 'repair-pptrs-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      [f7cea94646b4] Merge tag 'scrub-directory-tree-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      [496baa2cb94f] Merge tag 'vectorized-scrub-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      [b878dbbe2acd] Merge tag 'reduce-scrub-iget-overhead-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC
      [4b0bf86c1797] Merge tag 'repair-fixes-6.10_2024-04-23' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeC

Christoph Hellwig (1):
      [f49af061f49c] xfs: check the flags earlier in xfs_attr_match

Darrick J. Wong (69):
      [f566d5b9fb71] xfs: remove XFS_DA_OP_REMOVE
      [779a4b606c76] xfs: remove XFS_DA_OP_NOTIME
      [54275d8496f3] xfs: remove xfs_da_args.attr_flags
      [ef80de940a63] xfs: attr fork iext must be loaded before calling xfs_attr_is_leaf
      [8ef1d96a985e] xfs: require XFS_SB_FEAT_INCOMPAT_LOG_XATTRS for attr log intent item recovery
      [c27411d4c640] xfs: make attr removal an explicit operation
      [f759784cb61c] xfs: use an XFS_OPSTATE_ flag for detecting if logged xattrs are available
      [cda60317ac57] xfs: rearrange xfs_da_args a bit to use less space
      [ad206ae50eca] xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2
      [f660ec8eaeb5] xfs: fix missing check for invalid attr flags
      [309dc9cbbb43] xfs: check shortform attr entry flags specifically
      [992c3b5c3fe6] xfs: restructure xfs_attr_complete_op a bit
      [2a2c05d013d0] xfs: use helpers to extract xattr op from opflags
      [1c7f09d210ab] xfs: validate recovered name buffers when recovering xattr items
      [0aeeeb796980] xfs: always set args->value in xfs_attri_item_recover
      [c07f018bc094] xfs: use local variables for name and value length in _attri_commit_pass2
      [50855427c254] xfs: refactor name/length checks in xfs_attri_validate
      [ffdcc3b8eb4d] xfs: refactor name/value iovec validation in xlog_recover_attri_commit_pass2
      [ea0b3e814741] xfs: enforce one namespace per attribute
      [63211876ced3] xfs: rearrange xfs_attr_match parameters
      [9713dc88773d] xfs: move xfs_attr_defer_add to xfs_attr_item.c
      [a64e0134754b] xfs: create a separate hashname function for extended attributes
      [f041455eb577] xfs: allow xattr matching on name and value for parent pointers
      [a918f5f2cd2c] xfs: refactor xfs_is_using_logged_xattrs checks in attr item recovery
      [5773f7f82be5] xfs: create attr log item opcodes and formats for parent pointers
      [ae673f534a30] xfs: record inode generation in xattr update log intent items
      [fb102fe7fe02] xfs: create a hashname function for parent pointers
      [af69d852dfe6] xfs: move handle ioctl code to xfs_handle.c
      [b8c9d4253da4] xfs: split out handle management helpers a bit
      [233f4e12bbb2] xfs: add parent pointer ioctls
      [7ea816ca4043] xfs: fix unit conversion error in xfs_log_calc_max_attrsetm_res
      [6ed858c7c678] xfs: drop compatibility minimum log size computations for reflink
      [2a009397eb5a] xfs: revert commit 44af6c7e59b12
      [67ac7091e35b] xfs: enable parent pointers
      [61b3f0df5c23] xfs: check dirents have parent pointers
      [b961c8bf1fc3] xfs: deferred scrub of dirents
      [0d29a20fbdba] xfs: scrub parent pointers
      [8ad345306d1e] xfs: deferred scrub of parent pointers
      [e7420e75ef04] xfs: remove some boilerplate from xfs_attr_set
      [bf61c36a45d4] xfs: make the reserved block permission flag explicit in xfs_attr_set
      [77ede5f44b0d] xfs: walk directory parent pointers to determine backref count
      [086e934fe9c7] xfs: salvage parent pointers when rebuilding xattr structures
      [59a2af9086f0] xfs: check parent pointer xattrs when scrubbing
      [5769aa41ee34] xfs: add raw parent pointer apis to support repair
      [76fc23b695f4] xfs: repair directories by scanning directory parent pointers
      [8559b21a64d9] xfs: implement live updates for directory repairs
      [e5d7ce0364d8] xfs: replay unlocked parent pointer updates that accrue during xattr repair
      [b334f7fab57a] xfs: repair directory parent pointers by scanning for dirents
      [65a1fb7a1129] xfs: implement live updates for parent pointer repairs
      [13db70078926] xfs: remove pointless unlocked assertion
      [55edcd1f8647] xfs: split xfs_bmap_add_attrfork into two pieces
      [6efbbdeb1406] xfs: add a per-leaf block callback to xchk_xattr_walk
      [a26dc21309af] xfs: actually rebuild the parent pointer xattrs
      [7be3d20bbeda] xfs: adapt the orphanage code to handle parent pointers
      [928b721a1178] xfs: teach online scrub to find directory tree structure problems
      [3f50ddbf4b47] xfs: repair link count of nondirectories after rebuilding parent pointers
      [d54c5ac80f8f] xfs: invalidate dirloop scrub path data when concurrent updates happen
      [327ed702d840] xfs: inode repair should ensure there's an attr fork to store parent pointers
      [271557de7cbf] xfs: reduce the rate of cond_resched calls inside scrub
      [37056912d572] xfs: report directory tree corruption in the health information
      [be7cf174e908] xfs: move xfs_ioc_scrub_metadata to scrub.c
      [3f31406aef49] xfs: fix corruptions in the directory tree
      [b27ce0da60a5] xfs: use dontcache for grabbing inodes during scrub
      [669175375223] xfs: drop the scrub file's iolock when transaction allocation fails
      [c77b37584c2d] xfs: introduce vectored scrub mode
      [4ad350ac5862] xfs: only iget the file once when doing vectored scrub-by-handle
      [b44bfc06958f] xfs: fix iunlock calls in xrep_adoption_trans_alloc
      [6d335233fe69] xfs: exchange-range for repairs is no longer dynamic
      [5e1c7d0b29f7] xfs: invalidate dentries for a file before moving it to the orphanage

Jiapeng Chong (1):
      [08e012a62de8] xfs: Remove unused function xrep_dir_self_parent

Code Diffstat:

 fs/xfs/Makefile                 |    7 +-
 fs/xfs/libxfs/xfs_attr.c        |  214 ++++---
 fs/xfs/libxfs/xfs_attr.h        |   44 +-
 fs/xfs/libxfs/xfs_attr_leaf.c   |   94 +++-
 fs/xfs/libxfs/xfs_attr_sf.h     |    1 +
 fs/xfs/libxfs/xfs_bmap.c        |   38 +-
 fs/xfs/libxfs/xfs_bmap.h        |    3 +-
 fs/xfs/libxfs/xfs_da_btree.h    |   33 +-
 fs/xfs/libxfs/xfs_da_format.h   |   30 +-
 fs/xfs/libxfs/xfs_dir2.c        |    2 +-
 fs/xfs/libxfs/xfs_dir2.h        |    2 +-
 fs/xfs/libxfs/xfs_format.h      |    4 +-
 fs/xfs/libxfs/xfs_fs.h          |  116 +++-
 fs/xfs/libxfs/xfs_health.h      |    4 +-
 fs/xfs/libxfs/xfs_log_format.h  |   25 +-
 fs/xfs/libxfs/xfs_log_rlimit.c  |   46 ++
 fs/xfs/libxfs/xfs_ondisk.h      |    6 +
 fs/xfs/libxfs/xfs_parent.c      |  379 +++++++++++++
 fs/xfs/libxfs/xfs_parent.h      |  110 ++++
 fs/xfs/libxfs/xfs_sb.c          |    4 +
 fs/xfs/libxfs/xfs_trans_resv.c  |  328 +++++++++--
 fs/xfs/libxfs/xfs_trans_space.c |  121 ++++
 fs/xfs/libxfs/xfs_trans_space.h |   25 +-
 fs/xfs/scrub/attr.c             |   79 ++-
 fs/xfs/scrub/attr_repair.c      |  492 +++++++++++++++-
 fs/xfs/scrub/attr_repair.h      |    4 +
 fs/xfs/scrub/common.c           |   12 +-
 fs/xfs/scrub/common.h           |   27 +-
 fs/xfs/scrub/dir.c              |  342 ++++++++++-
 fs/xfs/scrub/dir_repair.c       |  591 +++++++++++++++++--
 fs/xfs/scrub/dirtree.c          |  985 ++++++++++++++++++++++++++++++++
 fs/xfs/scrub/dirtree.h          |  178 ++++++
 fs/xfs/scrub/dirtree_repair.c   |  821 +++++++++++++++++++++++++++
 fs/xfs/scrub/findparent.c       |   12 +-
 fs/xfs/scrub/findparent.h       |   10 +-
 fs/xfs/scrub/health.c           |    1 +
 fs/xfs/scrub/ino_bitmap.h       |   37 ++
 fs/xfs/scrub/inode_repair.c     |   41 ++
 fs/xfs/scrub/iscan.c            |   13 +-
 fs/xfs/scrub/listxattr.c        |   10 +-
 fs/xfs/scrub/listxattr.h        |    4 +-
 fs/xfs/scrub/nlinks.c           |   86 ++-
 fs/xfs/scrub/nlinks_repair.c    |    6 +-
 fs/xfs/scrub/orphanage.c        |   98 +++-
 fs/xfs/scrub/orphanage.h        |   11 +
 fs/xfs/scrub/parent.c           |  686 ++++++++++++++++++++++
 fs/xfs/scrub/parent_repair.c    | 1314 ++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/scrub/readdir.c          |   78 +++
 fs/xfs/scrub/readdir.h          |    3 +
 fs/xfs/scrub/repair.h           |    4 +
 fs/xfs/scrub/rtsummary_repair.c |   10 +-
 fs/xfs/scrub/scrub.c            |  239 +++++++-
 fs/xfs/scrub/scrub.h            |   79 ++-
 fs/xfs/scrub/stats.c            |    1 +
 fs/xfs/scrub/symlink_repair.c   |    5 +-
 fs/xfs/scrub/tempexch.h         |    1 -
 fs/xfs/scrub/tempfile.c         |   26 +-
 fs/xfs/scrub/trace.c            |    5 +
 fs/xfs/scrub/trace.h            |  570 ++++++++++++++++++-
 fs/xfs/scrub/xfarray.c          |   10 +-
 fs/xfs/scrub/xfarray.h          |    4 +
 fs/xfs/scrub/xfile.c            |    2 +-
 fs/xfs/scrub/xfs_scrub.h        |    6 +-
 fs/xfs/xfs_acl.c                |   17 +-
 fs/xfs/xfs_attr_item.c          |  559 +++++++++++++++---
 fs/xfs/xfs_attr_item.h          |   10 +
 fs/xfs/xfs_attr_list.c          |   31 +-
 fs/xfs/xfs_export.c             |    2 +-
 fs/xfs/xfs_export.h             |    2 +
 fs/xfs/xfs_handle.c             |  952 +++++++++++++++++++++++++++++++
 fs/xfs/xfs_handle.h             |   33 ++
 fs/xfs/xfs_health.c             |    1 +
 fs/xfs/xfs_inode.c              |  220 ++++++--
 fs/xfs/xfs_inode.h              |    3 +-
 fs/xfs/xfs_ioctl.c              |  620 +-------------------
 fs/xfs/xfs_ioctl.h              |   28 -
 fs/xfs/xfs_ioctl32.c            |    1 +
 fs/xfs/xfs_iops.c               |   17 +-
 fs/xfs/xfs_mount.c              |   16 +
 fs/xfs/xfs_mount.h              |    6 +-
 fs/xfs/xfs_super.c              |   14 +
 fs/xfs/xfs_symlink.c            |   30 +-
 fs/xfs/xfs_trace.c              |    1 +
 fs/xfs/xfs_trace.h              |  102 +++-
 fs/xfs/xfs_xattr.c              |   54 +-
 fs/xfs/xfs_xattr.h              |    3 +-
 86 files changed, 10020 insertions(+), 1241 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_parent.c
 create mode 100644 fs/xfs/libxfs/xfs_parent.h
 create mode 100644 fs/xfs/libxfs/xfs_trans_space.c
 create mode 100644 fs/xfs/scrub/dirtree.c
 create mode 100644 fs/xfs/scrub/dirtree.h
 create mode 100644 fs/xfs/scrub/dirtree_repair.c
 create mode 100644 fs/xfs/scrub/ino_bitmap.h
 create mode 100644 fs/xfs/xfs_handle.c
 create mode 100644 fs/xfs/xfs_handle.h

