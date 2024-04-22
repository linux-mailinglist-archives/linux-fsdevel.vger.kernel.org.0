Return-Path: <linux-fsdevel+bounces-17365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4018AC3EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 07:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36231C21548
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 05:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CAD18E25;
	Mon, 22 Apr 2024 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cugLSQd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01ED18AED;
	Mon, 22 Apr 2024 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765101; cv=none; b=C1f7i9xkKX+Q2rAgxlOko9BQGlASaXoTsxliGCF5U0f0pGz7N/d96DLD7pfdLDaXoRB6WSPgHctIa1ejdVq3wjVVcU96IP2fl6m80p8jVLhXww3aMEY4bUBJRza11eEZzF5x2unNci3esQDDtgFIbku4nIewY/HMiMA5pyQUBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765101; c=relaxed/simple;
	bh=ojdGkl6Y9JERiPwqkp8YzNWyq7FfqD7YfAkd5jPDJUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cw1wSzV1oc4Depb8xHLQKZYDXPqFJlawoi6Uw0Qt1A4BEuhpU2WZJxngxuvhlM2YTBxjv8IleT4m63mpDe5pXHMpeUPHMtOM9JxZFa7Ajkq/poi/9GgBr8N/ykVE63MfR2mJ1hIHYXnLNTD4grEnaGVmdlRx0AyzVFDTH87JNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cugLSQd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5677C113CC;
	Mon, 22 Apr 2024 05:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713765100;
	bh=ojdGkl6Y9JERiPwqkp8YzNWyq7FfqD7YfAkd5jPDJUU=;
	h=From:To:Cc:Subject:Date:From;
	b=cugLSQd1bUea119k2kVE22JGynix4AHxiRKOBOGnFgWGmziKvrCDQEqT+w/xhTZpO
	 qCCFB5XtsvwBrFUJQpe+M07HRsU3pvDT5PSSVPEBRKeLea2ghRrrMdqhdktL+0rySs
	 Xl+Z/dvhln7T2BYtEEv0rInheOFmK0Z9E7+M68YqxC4/LTKW5fwzzHRemw3/3QNuJU
	 6y88Y7v514gh+vyoejle3h3V7kOf18R3DFfqV1mU/p4kymPd+FLx1ehjTObzLnob0I
	 usqsP2mveVSdF/ex98wnvZ2fxM5+ntNrr++arFm/c7B2e/0DCOAt5dyp3S9unf0+nx
	 ETGi/CFCjgdjg==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: Dave Chinner
 <dchinner@redhat.com>,abaci@linux.alibaba.com,allison.henderson@oracle.com,catherine.hoang@oracle.com,dan.carpenter@linaro.org,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,jiapeng.chong@linux.alibaba.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,thorsten.blum@toblux.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to c414a87ff750
Date: Mon, 22 Apr 2024 11:16:13 +0530
Message-ID: <87jzkqlzbr.fsf@debian-BULLSEYE-live-builder-AMD64>
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

c414a87ff750 xfs: Remove unused function is_rt_data_fork

Christoph, Can you please rebase and re-post the following patchsets on top of
xfs-linux's updated for-next branch,
1. xfs: compile out v4 support if disabled
2. spring cleaning for xfs_extent_busy_clear
3. bring back RT delalloc support

106 new commits:

Allison Henderson (5):
      [7560c937b4b5] xfs: Increase XFS_DEFER_OPS_NR_INODES to 5
      [f103df763563] xfs: Increase XFS_QM_TRANS_MAXDQS to 5
      [267979b4ce75] xfs: Hold inode locks in xfs_ialloc
      [bd5562111d58] xfs: Hold inode locks in xfs_trans_alloc_dir
      [69291726caf1] xfs: Hold inode locks in xfs_rename

Chandan Babu R (16):
      [ebe0f798e1ac] Merge tag 'log-incompat-permissions-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [4ec2e3c16746] Merge tag 'file-exchange-refactorings-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [22d5a8e52de6] Merge tag 'atomic-file-updates-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [783c51708b5b] Merge tag 'repair-tempfiles-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [8b309acd10c0] Merge tag 'repair-rtsummary-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [fb1f7c662c5b] Merge tag 'dirattr-validate-owners-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [5f3e9511862c] Merge tag 'repair-xattrs-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [902603bfa12a] Merge tag 'repair-unlinked-inode-state-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [9e6b93b7272c] Merge tag 'repair-dirs-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [067d3f710026] Merge tag 'repair-orphanage-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [0313dd8fac1e] Merge tag 'repair-symlink-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [1eef01250de4] Merge tag 'repair-iunlink-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [9ba8e658d867] Merge tag 'inode-repair-improvements-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [6ad1b9147060] Merge tag 'discard-relax-locks-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [f910defd3898] Merge tag 'online-fsck-design-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA
      [9cb5f15d88d4] Merge tag 'retain-ilock-during-dir-ops-6.10_2024-04-15' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.10-mergeA

Dan Carpenter (1):
      [a4c51f7e45cf] xfs: small cleanup in xrep_update_qflags()

Darrick J. Wong (78):
      [549d3c9a2992] xfs: pass xfs_buf lookup flags to xfs_*read_agi
      [2afd5276d314] xfs: fix an AGI lock acquisition ordering problem in xrep_dinode_findmode
      [21ad2d03641a] xfs: fix potential AGI <-> ILOCK ABBA deadlock in xrep_dinode_findmode_walk_directory
      [98a778b42514] xfs: fix error bailout in xrep_abt_build_new_trees
      [5302a5c8beb2] xfs: only clear log incompat flags at clean unmount
      [a4db266a705c] xfs: move inode lease breaking functions to xfs_inode.c
      [3fc4844585c7] xfs: move xfs_iops.c declarations out of xfs_inode.h
      [00acb28d9674] xfs: declare xfs_file.c symbols in xfs_file.h
      [ee20808d848c] xfs: create a new helper to return a file's allocation unit
      [6b700a5be9b3] xfs: hoist multi-fsb allocation unit detection to a helper
      [ac5cebeed613] xfs: refactor non-power-of-two alignment checks
      [15f78aa3eb07] xfs: constify xfs_bmap_is_written_extent
      [5b9932f6001c] vfs: export remap and write check helpers
      [9a64d9b3109d] xfs: introduce new file range exchange ioctl
      [1518646eef26] xfs: create a incompat flag for atomic file mapping exchanges
      [6c08f434bd33] xfs: introduce a file mapping exchange log intent item
      [966ceafc7a43] xfs: create deferred log items for file mapping exchanges
      [42672471f938] xfs: bind together the front and back ends of the file range exchange code
      [5fd022ec7d42] xfs: add error injection to test file mapping exchange recovery
      [497d7a2608f8] xfs: condense extended attributes after a mapping exchange operation
      [da165fbde23b] xfs: condense directories after a mapping exchange operation
      [33a9be2b7016] xfs: condense symbolic links after a mapping exchange operation
      [e62941103faa] xfs: make file range exchange support realtime files
      [b3e60f84838d] xfs: support non-power-of-two rtextsize with exchange-range
      [14f19991020b] xfs: capture inode generation numbers in the ondisk exchmaps log item
      [f783529bee39] docs: update swapext -> exchmaps language
      [0730e8d8ba1d] xfs: enable logged file mapping exchange feature
      [cab23a4233c6] xfs: hide private inodes from bulkstat and handle functions
      [84c14ee39dd3] xfs: create temporary files and directories for online repair
      [20a3c1ecc35d] xfs: refactor live buffer invalidation for repairs
      [e81ce4241318] xfs: support preallocating and copying content into temporary files
      [56596d8bffd2] xfs: teach the tempfile to set up atomic file content exchanges
      [5befb047b9f4] xfs: add the ability to reap entire inode forks
      [abf039e2e4af] xfs: online repair of realtime summaries
      [9eef772f3a19] xfs: add an explicit owner field to xfs_da_args
      [17a85dc64ae0] xfs: use the xfs_da_args owner field to set new dir/attr block owner
      [33c028ffe36a] xfs: reduce indenting in xfs_attr_node_list
      [f4887fbc41dc] xfs: validate attr leaf buffer owners
      [8c25dc728bd1] xfs: validate attr remote value buffer owners
      [d44bea9b41ca] xfs: validate dabtree node buffer owners
      [402eef10a1ba] xfs: validate directory leaf buffer owners
      [cc6740ddb423] xfs: validate explicit directory data buffer owners
      [29b41ce919b7] xfs: validate explicit directory block buffer owners
      [fe6c9f8e48e0] xfs: validate explicit directory free block owners
      [98339edf0750] xfs: enable discarding of folios backing an xfile
      [d2bd7eef4f21] xfs: create a blob array data structure
      [629fdaf5f5b1] xfs: use atomic extent swapping to fix user file fork data
      [e47dcf113ae3] xfs: repair extended attributes
      [0ee230dec262] xfs: scrub should set preen if attr leaf has holes
      [40190f9f918a] xfs: flag empty xattr leaf blocks for optimization
      [e921533ef1a6] xfs: ensure unlinked list state is consistent with nlink during scrub
      [6c631e79e73c] xfs: create an xattr iteration function for scrub
      [8d81082a8c95] xfs: inactivate directory data blocks
      [b1991ee3e7cf] xfs: online repair of directories
      [669dfe883c8e] xfs: update the unlinked list when repairing link counts
      [a07b45576264] xfs: scan the filesystem to repair a directory dotdot entry
      [cc22edab9ea7] xfs: online repair of parent pointers
      [1e58a8ccf259] xfs: move orphan files to the orphanage
      [34c9382c1282] xfs: ask the dentry cache if it knows the parent of a directory
      [ef744be416b5] xfs: expose xfs_bmap_local_to_extents for online repair
      [e6c9e75fbe79] xfs: move files to orphanage instead of letting nlinks drop to zero
      [ea8214c3195c] xfs: pass the owner to xfs_symlink_write_target
      [73597e3e42b4] xfs: ensure dentry consistency when the orphanage adopts a file
      [10d587ecb77f] xfs: check AGI unlinked inode buckets
      [5b57257025f9] xfs: hoist AGI repair context to a heap object
      [2651923d8d8d] xfs: online repair of symbolic links
      [ab97f4b1c030] xfs: repair AGI unlinked inode bucket lists
      [40cb8613d612] xfs: check unused nlink fields in the ondisk inode
      [2935213a6831] xfs: try to avoid allocating from sick inode clusters
      [5f204051d998] xfs: pin inodes that would otherwise overflow link count
      [d85fe250f2eb] docs: update the parent pointers documentation to the final version
      [5220727ce8ee] docs: update online directory and parent pointer repair sections
      [1a5f6e08d4e3] xfs: create subordinate scrub contexts for xchk_metadata_inode_subtype
      [b0ffe661fab4] xfs: fix performance problems when fstrimming a subset of a fragmented AG
      [c91fe20e5ae7] docs: update offline parent pointer repair strategy
      [67bdcd499909] docs: describe xfs directory tree online fsck
      [34ef5e17d5fd] xfs: don't pick up IOLOCK during rmapbt repair scan
      [df7604714774] xfs: unlock new repair tempfiles after creation

Dave Chinner (4):
      [2c03d9560ece] xfs: fix CIL sparse lock context warnings
      [6279a2050c8b] xfs: fix sparse warning in xfs_extent_busy_clear
      [fb272da7fad1] xfs: silence sparse warning when checking version number
      [d274418f88d2] xfs: fix sparse warnings about unused interval tree functions

Jiapeng Chong (1):
      [c414a87ff750] xfs: Remove unused function is_rt_data_fork

Thorsten Blum (1):
      [d95913bf84ce] xfs: Fix typo in comment

Code Diffstat:

 .../filesystems/xfs/xfs-online-fsck-design.rst        |  632 ++++++---
 fs/read_write.c                                       |    1 +
 fs/remap_range.c                                      |    4 +-
 fs/xfs/Makefile                                       |   13 +
 fs/xfs/libxfs/xfs_ag.c                                |    8 +-
 fs/xfs/libxfs/xfs_attr.c                              |   16 +-
 fs/xfs/libxfs/xfs_attr.h                              |    2 +
 fs/xfs/libxfs/xfs_attr_leaf.c                         |   60 +-
 fs/xfs/libxfs/xfs_attr_leaf.h                         |    4 +-
 fs/xfs/libxfs/xfs_attr_remote.c                       |   13 +-
 fs/xfs/libxfs/xfs_bmap.c                              |   12 +-
 fs/xfs/libxfs/xfs_bmap.h                              |    8 +-
 fs/xfs/libxfs/xfs_da_btree.c                          |  169 ++-
 fs/xfs/libxfs/xfs_da_btree.h                          |    3 +
 fs/xfs/libxfs/xfs_da_format.h                         |    5 +
 fs/xfs/libxfs/xfs_defer.c                             |   12 +-
 fs/xfs/libxfs/xfs_defer.h                             |   10 +-
 fs/xfs/libxfs/xfs_dir2.c                              |    5 +
 fs/xfs/libxfs/xfs_dir2.h                              |    4 +
 fs/xfs/libxfs/xfs_dir2_block.c                        |   42 +-
 fs/xfs/libxfs/xfs_dir2_data.c                         |   18 +-
 fs/xfs/libxfs/xfs_dir2_leaf.c                         |  100 +-
 fs/xfs/libxfs/xfs_dir2_node.c                         |   44 +-
 fs/xfs/libxfs/xfs_dir2_priv.h                         |   15 +-
 fs/xfs/libxfs/xfs_errortag.h                          |    4 +-
 fs/xfs/libxfs/xfs_exchmaps.c                          | 1240 +++++++++++++++++
 fs/xfs/libxfs/xfs_exchmaps.h                          |  124 ++
 fs/xfs/libxfs/xfs_format.h                            |   32 +-
 fs/xfs/libxfs/xfs_fs.h                                |   42 +
 fs/xfs/libxfs/xfs_ialloc.c                            |   56 +-
 fs/xfs/libxfs/xfs_ialloc.h                            |    5 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c                      |    4 +-
 fs/xfs/libxfs/xfs_inode_buf.c                         |    8 +
 fs/xfs/libxfs/xfs_log_format.h                        |   66 +-
 fs/xfs/libxfs/xfs_log_recover.h                       |    4 +
 fs/xfs/libxfs/xfs_sb.c                                |    5 +
 fs/xfs/libxfs/xfs_symlink_remote.c                    |   54 +-
 fs/xfs/libxfs/xfs_symlink_remote.h                    |    8 +-
 fs/xfs/libxfs/xfs_trans_space.h                       |    4 +
 fs/xfs/scrub/agheader.c                               |   43 +-
 fs/xfs/scrub/agheader_repair.c                        |  879 +++++++++++-
 fs/xfs/scrub/agino_bitmap.h                           |   49 +
 fs/xfs/scrub/alloc_repair.c                           |    2 +-
 fs/xfs/scrub/attr.c                                   |  157 ++-
 fs/xfs/scrub/attr.h                                   |    7 +
 fs/xfs/scrub/attr_repair.c                            | 1207 ++++++++++++++++
 fs/xfs/scrub/attr_repair.h                            |   11 +
 fs/xfs/scrub/bitmap.c                                 |   22 +-
 fs/xfs/scrub/common.c                                 |   28 +-
 fs/xfs/scrub/dab_bitmap.h                             |   37 +
 fs/xfs/scrub/dabtree.c                                |   24 +
 fs/xfs/scrub/dabtree.h                                |    3 +
 fs/xfs/scrub/dir.c                                    |   32 +-
 fs/xfs/scrub/dir_repair.c                             | 1509 +++++++++++++++++++++
 fs/xfs/scrub/findparent.c                             |  448 ++++++
 fs/xfs/scrub/findparent.h                             |   50 +
 fs/xfs/scrub/fscounters.c                             |    2 +-
 fs/xfs/scrub/inode.c                                  |   19 +
 fs/xfs/scrub/inode_repair.c                           |  112 +-
 fs/xfs/scrub/iscan.c                                  |   54 +-
 fs/xfs/scrub/iscan.h                                  |   16 +
 fs/xfs/scrub/listxattr.c                              |  312 +++++
 fs/xfs/scrub/listxattr.h                              |   17 +
 fs/xfs/scrub/nlinks.c                                 |   47 +-
 fs/xfs/scrub/nlinks.h                                 |    7 +
 fs/xfs/scrub/nlinks_repair.c                          |  182 ++-
 fs/xfs/scrub/orphanage.c                              |  589 ++++++++
 fs/xfs/scrub/orphanage.h                              |   75 +
 fs/xfs/scrub/parent.c                                 |   14 +-
 fs/xfs/scrub/parent_repair.c                          |  330 +++++
 fs/xfs/scrub/readdir.c                                |   13 +-
 fs/xfs/scrub/reap.c                                   |  443 +++++-
 fs/xfs/scrub/reap.h                                   |   21 +
 fs/xfs/scrub/repair.c                                 |  122 +-
 fs/xfs/scrub/repair.h                                 |   27 +
 fs/xfs/scrub/rmap_repair.c                            |   24 +-
 fs/xfs/scrub/rtsummary.c                              |   33 +-
 fs/xfs/scrub/rtsummary.h                              |   37 +
 fs/xfs/scrub/rtsummary_repair.c                       |  177 +++
 fs/xfs/scrub/scrub.c                                  |   87 +-
 fs/xfs/scrub/scrub.h                                  |   26 +
 fs/xfs/scrub/symlink.c                                |   13 +-
 fs/xfs/scrub/symlink_repair.c                         |  506 +++++++
 fs/xfs/scrub/tempexch.h                               |   23 +
 fs/xfs/scrub/tempfile.c                               |  871 ++++++++++++
 fs/xfs/scrub/tempfile.h                               |   48 +
 fs/xfs/scrub/trace.c                                  |    1 +
 fs/xfs/scrub/trace.h                                  |  743 +++++++++-
 fs/xfs/scrub/xfarray.c                                |   17 +
 fs/xfs/scrub/xfarray.h                                |    2 +
 fs/xfs/scrub/xfblob.c                                 |  168 +++
 fs/xfs/scrub/xfblob.h                                 |   50 +
 fs/xfs/scrub/xfile.c                                  |   12 +
 fs/xfs/scrub/xfile.h                                  |    6 +
 fs/xfs/xfs_attr_item.c                                |    1 +
 fs/xfs/xfs_attr_list.c                                |   89 +-
 fs/xfs/xfs_bmap_util.c                                |    4 +-
 fs/xfs/xfs_buf.c                                      |    3 +
 fs/xfs/xfs_dir2_readdir.c                             |    6 +-
 fs/xfs/xfs_discard.c                                  |  153 ++-
 fs/xfs/xfs_dquot.c                                    |   41 +
 fs/xfs/xfs_dquot.h                                    |    1 +
 fs/xfs/xfs_error.c                                    |    3 +
 fs/xfs/xfs_exchmaps_item.c                            |  614 +++++++++
 fs/xfs/xfs_exchmaps_item.h                            |   64 +
 fs/xfs/xfs_exchrange.c                                |  804 +++++++++++
 fs/xfs/xfs_exchrange.h                                |   38 +
 fs/xfs/xfs_export.c                                   |    2 +-
 fs/xfs/xfs_extent_busy.c                              |   27 +-
 fs/xfs/xfs_file.c                                     |   88 +-
 fs/xfs/xfs_file.h                                     |   15 +
 fs/xfs/xfs_inode.c                                    |  281 +++-
 fs/xfs/xfs_inode.h                                    |   24 +-
 fs/xfs/xfs_ioctl.c                                    |    5 +
 fs/xfs/xfs_iops.c                                     |    4 +
 fs/xfs/xfs_iops.h                                     |    7 +-
 fs/xfs/xfs_itable.c                                   |    8 +
 fs/xfs/xfs_iwalk.c                                    |    4 +-
 fs/xfs/xfs_linux.h                                    |    5 +
 fs/xfs/xfs_log.c                                      |   28 +-
 fs/xfs/xfs_log.h                                      |    2 -
 fs/xfs/xfs_log_cil.c                                  |    2 +-
 fs/xfs/xfs_log_priv.h                                 |    8 +-
 fs/xfs/xfs_log_recover.c                              |   52 +-
 fs/xfs/xfs_mount.c                                    |    8 +-
 fs/xfs/xfs_mount.h                                    |    8 +-
 fs/xfs/xfs_qm.c                                       |    4 +-
 fs/xfs/xfs_qm.h                                       |    2 +-
 fs/xfs/xfs_super.c                                    |   23 +
 fs/xfs/xfs_symlink.c                                  |   63 +-
 fs/xfs/xfs_trace.c                                    |    2 +
 fs/xfs/xfs_trace.h                                    |  336 ++++-
 fs/xfs/xfs_trans.c                                    |    9 +-
 fs/xfs/xfs_trans_dquot.c                              |   15 +-
 fs/xfs/xfs_xattr.c                                    |   42 +-
 include/linux/fs.h                                    |    1 +
 136 files changed, 14410 insertions(+), 1096 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_exchmaps.c
 create mode 100644 fs/xfs/libxfs/xfs_exchmaps.h
 create mode 100644 fs/xfs/scrub/agino_bitmap.h
 create mode 100644 fs/xfs/scrub/attr_repair.c
 create mode 100644 fs/xfs/scrub/attr_repair.h
 create mode 100644 fs/xfs/scrub/dab_bitmap.h
 create mode 100644 fs/xfs/scrub/dir_repair.c
 create mode 100644 fs/xfs/scrub/findparent.c
 create mode 100644 fs/xfs/scrub/findparent.h
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

