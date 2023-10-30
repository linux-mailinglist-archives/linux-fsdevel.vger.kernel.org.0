Return-Path: <linux-fsdevel+bounces-1523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2327DB2EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 06:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB491F21A32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 05:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA89D1379;
	Mon, 30 Oct 2023 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkq8yJUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C261366
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 05:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F175AC433C7;
	Mon, 30 Oct 2023 05:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698644923;
	bh=mZcbWdyCAl0Q4TKuX6N13d1SYTzKqVvO0OX4SUagAOM=;
	h=From:To:Cc:Subject:Date:From;
	b=fkq8yJUcZAeOKxV/o3XCUvz/IL7LJ/0pQsqZvANby9ZTH3w/FOkco7av0tUtJ4/ub
	 1w5JDeYyWUV0AzRrlRDIjwLddHxKU0tFMqpKRkLhpU2/Xmc7ccTnUSEtBowonqL0NA
	 d5OmytxcNaDYzs7dQ0SgflpuXBTmVb4Kgvf2SvSsU11W/qOFpDlc2ouGTfkRcgkbFt
	 8xuFedbG2OFotR7xsCDPCNb2Sb/ncWRfpOUIyPQCzUiQtrDnm8XRzevbZIEvmw4HqU
	 W5U1arafBW9JWnePc3jjwvRWpvqPDJ9PE96kynLWrLBt8V6GY8zDxdwyyhqLw4VaoC
	 H1slbR2zBEQPA==
User-agent: mu4e 1.8.10; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: catherine.hoang@oracle.com,cheng.lin130@zte.com.cn,dan.j.williams@intel.com,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,osandov@fb.com,ruansy.fnst@fujitsu.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 22c2699cb068
Date: Mon, 30 Oct 2023 11:16:37 +0530
Message-ID: <87fs1s3bk6.fsf@debian-BULLSEYE-live-builder-AMD64>
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

22c2699cb068 mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind

47 new commits:

Catherine Hoang (1):
      [14a537983b22] xfs: allow read IO and FICLONE to run concurrently

Chandan Babu R (6):
      [d0e85e79d680] Merge tag 'realtime-fixes-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      [3ef52c010973] Merge tag 'clean-up-realtime-units-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      [9d4ca5afa604] Merge tag 'refactor-rt-unit-conversions-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      [035e32f7524d] Merge tag 'refactor-rtbitmap-macros-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      [830b4abfe2de] Merge tag 'refactor-rtbitmap-accessors-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA
      [9fa8753aa1f1] Merge tag 'rtalloc-speedups-6.7_2023-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.7-mergeA

Cheng Lin (1):
      [2b99e410b28f] xfs: introduce protection for drop nlink

Christoph Hellwig (1):
      [35dc55b9e80c] xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space

Darrick J. Wong (30):
      [948806280594] xfs: bump max fsgeom struct version
      [6c664484337b] xfs: hoist freeing of rt data fork extent mappings
      [b73494fa9a30] xfs: prevent rt growfs when quota is enabled
      [c2988eb5cff7] xfs: rt stubs should return negative errnos when rt disabled
      [ddd98076d5c0] xfs: fix units conversion error in xfs_bmap_del_extent_delay
      [f6a2dae2a1f5] xfs: make sure maxlen is still congruent with prod when rounding down
      [13928113fc5b] xfs: move the xfs_rtbitmap.c declarations to xfs_rtbitmap.h
      [a684c538bc14] xfs: convert xfs_extlen_t to xfs_rtxlen_t in the rt allocator
      [fa5a38723086] xfs: create a helper to convert rtextents to rtblocks
      [03f4de332e2e] xfs: convert rt bitmap/summary block numbers to xfs_fileoff_t
      [68db60bf01c1] xfs: create a helper to compute leftovers of realtime extents
      [f29c3e745dc2] xfs: convert rt bitmap extent lengths to xfs_rtbxlen_t
      [2c2b981b737a] xfs: create a helper to convert extlen to rtextlen
      [3d2b6d034f0f] xfs: rename xfs_verify_rtext to xfs_verify_rtbext
      [5dc3a80d46a4] xfs: create helpers to convert rt block numbers to rt extent numbers
      [2d5f216b77e3] xfs: convert rt extent numbers to xfs_rtxnum_t
      [055641248f64] xfs: convert do_div calls to xfs_rtb_to_rtx helper calls
      [5f57f7309d9a] xfs: create rt extent rounding helpers for realtime extent blocks
      [90d98a6ada1d] xfs: convert the rtbitmap block and bit macros to static inline functions
      [ef5a83b7e597] xfs: use shifting and masking when converting rt extents, if possible
      [add3cddaea50] xfs: remove XFS_BLOCKWSIZE and XFS_BLOCKWMASK macros
      [a9948626849c] xfs: convert open-coded xfs_rtword_t pointer accesses to helper
      [097b4b7b64ef] xfs: convert rt summary macros to helpers
      [312d61021b89] xfs: create a helper to handle logging parts of rt bitmap/summary blocks
      [d0448fe76ac1] xfs: create helpers for rtbitmap block/wordcount computations
      [97e993830a1c] xfs: use accessor functions for bitmap words
      [bd85af280de6] xfs: create helpers for rtsummary block/wordcount computations
      [663b8db7b025] xfs: use accessor functions for summary info words
      [5b1d0ae9753f] xfs: simplify xfs_rtbuf_get calling conventions
      [e2cf427c9149] xfs: simplify rt bitmap/summary block accessor functions

Dave Chinner (1):
      [41f33d82cfd3] xfs: consolidate realtime allocation arguments

Omar Sandoval (6):
      [e94b53ff699c] xfs: cache last bitmap block in realtime allocator
      [e23aaf450de7] xfs: invert the realtime summary cache
      [1b5d63963f98] xfs: return maximum free size from xfs_rtany_summary()
      [ec5857bf0763] xfs: limit maxlen based on available space in xfs_rtallocate_extent_near()
      [85fa2c774397] xfs: don't try redundant allocations in xfs_rtallocate_extent_near()
      [e0f7422f54b0] xfs: don't look for end of extent further than necessary in xfs_rtallocate_extent_near()

Shiyang Ruan (1):
      [22c2699cb068] mm, pmem, xfs: Introduce MF_MEM_PRE_REMOVE for unbind

Code Diffstat:

 drivers/dax/super.c            |   3 +-
 fs/xfs/libxfs/xfs_bmap.c       |  45 +++----
 fs/xfs/libxfs/xfs_format.h     |  34 ++---
 fs/xfs/libxfs/xfs_rtbitmap.c   | 803 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------
 fs/xfs/libxfs/xfs_rtbitmap.h   | 383 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_sb.c         |   2 +
 fs/xfs/libxfs/xfs_sb.h         |   2 +-
 fs/xfs/libxfs/xfs_trans_resv.c |  10 +-
 fs/xfs/libxfs/xfs_types.c      |   4 +-
 fs/xfs/libxfs/xfs_types.h      |  10 +-
 fs/xfs/scrub/bmap.c            |   2 +-
 fs/xfs/scrub/fscounters.c      |   2 +-
 fs/xfs/scrub/inode.c           |   3 +-
 fs/xfs/scrub/rtbitmap.c        |  28 ++---
 fs/xfs/scrub/rtsummary.c       |  72 ++++++-----
 fs/xfs/scrub/trace.c           |   1 +
 fs/xfs/scrub/trace.h           |  15 +--
 fs/xfs/xfs_bmap_util.c         |  74 +++++------
 fs/xfs/xfs_file.c              |  63 ++++++++--
 fs/xfs/xfs_fsmap.c             |  15 +--
 fs/xfs/xfs_inode.c             |  24 ++++
 fs/xfs/xfs_inode.h             |   9 ++
 fs/xfs/xfs_inode_item.c        |   3 +-
 fs/xfs/xfs_ioctl.c             |   5 +-
 fs/xfs/xfs_linux.h             |  12 ++
 fs/xfs/xfs_mount.h             |   8 +-
 fs/xfs/xfs_notify_failure.c    | 108 +++++++++++++++-
 fs/xfs/xfs_ondisk.h            |   4 +
 fs/xfs/xfs_reflink.c           |   4 +
 fs/xfs/xfs_rtalloc.c           | 626 +++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------
 fs/xfs/xfs_rtalloc.h           |  94 ++------------
 fs/xfs/xfs_super.c             |   3 +-
 fs/xfs/xfs_trans.c             |   7 +-
 include/linux/mm.h             |   1 +
 mm/memory-failure.c            |  21 +++-
 35 files changed, 1547 insertions(+), 953 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_rtbitmap.h

