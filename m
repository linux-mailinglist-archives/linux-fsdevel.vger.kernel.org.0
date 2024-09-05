Return-Path: <linux-fsdevel+bounces-28738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F358896DA87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802A91F23C38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CD19D885;
	Thu,  5 Sep 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCq1mk1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85319925B;
	Thu,  5 Sep 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543643; cv=none; b=dXgV2xKcFwK2CuRUs/sRi+1kKF146fKY2nLMHZZqosvs4t56P+wNCKRpHJzZOUAkWT4q1SmX809/3uBlJ6+92Ay4drUajRA+bUCGx1A/ps3fRG1Qf1oRm8IKjoLoKMCbuyyGFenwSskxbJvZU90p2OycDxuLD1Ok3JJ/ZhaUrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543643; c=relaxed/simple;
	bh=jqT9gfQKg62Ke/yo1S3pOE/9To2elnqZSpgTqhq0gDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S0lk9SS4A4nLp8c2wLLXEWQuAloji59xstMx2MH7dZBBbrpRL3SjEvHLOi5E39H8NkFrUd5/jn71QCCKbevPkfEFORUIgogkIzaog0TEqQYrmUVOPVB9rw+n6GLgsfzQk9qpZ1fKGRMMa2HrObNUx73JxEo0LzZfbQq3HppNsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCq1mk1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF221C4CEC7;
	Thu,  5 Sep 2024 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725543643;
	bh=jqT9gfQKg62Ke/yo1S3pOE/9To2elnqZSpgTqhq0gDc=;
	h=From:To:Cc:Subject:Date:From;
	b=lCq1mk1jgUWjyB2/dmCJ+DgaYez1p1guO1G24bS8FetPmJxLACUrEiyBwvDvuEjYK
	 FwaBw2aW3//WsaQHYqexRTiTaZ4/T8O2hlZH/swbZHbyRcH2UV3vyEWCTu9FRFb+ic
	 tBm8V2jAsXUDgpAkDleuIdX6yzxS8YEhOt1Qhc2s6HEsq3nQKDlLCeHwPDljnUIjdi
	 jketICGecH+kzLdYuPLLeyu8nWAdEDUiTZQzBw5a4nXD65GVGOGSoMFJt4D5sIpQWu
	 G7EoaYHrVlzQ/HmNsN/fLjqxgvVXux4apEZs2wkg3BAPDNJVvG74dD2caGXK8V3gG3
	 GJ1VbLtcLwjkQ==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: abaci@linux.alibaba.com,dan.carpenter@linaro.org,dchinner@redhat.com,djwong@kernel.org,hch@lst.de,jiapeng.chong@linux.alibaba.com,jlayton@kernel.org,john.g.garry@oracle.com,kch@nvidia.com,kernel@mattwhitlock.name,lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,sam@gentoo.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 90fa22da6d6b
Date: Thu, 05 Sep 2024 19:08:46 +0530
Message-ID: <87ikva6wx3.fsf@debian-BULLSEYE-live-builder-AMD64>
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

90fa22da6d6b xfs: ensure st_blocks never goes to zero during COW writes

69 new commits:

Chandan Babu R (8):
      [41c38bf024ab] Merge tag 'atomic-file-commits-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      [37126ddd48ae] Merge tag 'metadir-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      [0879dee5cefb] Merge tag 'rtbitmap-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      [b2138a591c14] Merge tag 'rtalloc-fixes-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      [07b2bbcf77b2] Merge tag 'rtalloc-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      [8f78a440444f] Merge tag 'quota-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      [5384639bf7b8] Merge tag 'xfs-fixes-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      [169d89f33bb5] Merge tag 'btree-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA

Christoph Hellwig (37):
      [021d9c107e29] xfs: remove xfs_validate_rtextents
      [6529eef810e2] xfs: factor out a xfs_validate_rt_geometry helper
      [3cb30d516229] xfs: make the RT rsum_cache mandatory
      [a18a69bbec08] xfs: use the recalculated transaction reservation in xfs_growfs_rt_bmblock
      [1e21d1897f93] xfs: clean up the ISVALID macro in xfs_bmap_adjacent
      [119c65e56bc1] xfs: remove the limit argument to xfs_rtfind_back
      [86a0264ef26e] xfs: ensure rtx mask/shift are correct after growfs
      [a9f646af4307] xfs: factor out a xfs_rtallocate helper
      [6d2db12d56a3] xfs: assert a valid limit in xfs_rtfind_forw
      [fd048a1bb391] xfs: rework the rtalloc fallback handling
      [b4781eea6872] xfs: add bounds checking to xfs_rt{bitmap,summary}_read_buf
      [b2dd85f41476] xfs: factor out a xfs_rtallocate_align helper
      [237130564ef3] xfs: cleanup the calling convention for xfs_rtpick_extent
      [ec12f97f1b8a] xfs: make the rtalloc start hint a xfs_rtblock_t
      [c8e5a0bfe008] xfs: push the calls to xfs_rtallocate_range out to xfs_bmap_rtalloc
      [7996f10ce6cc] xfs: factor out a xfs_growfs_rt_bmblock helper
      [1fc51cf11dd8] xfs: remove xfs_{rtbitmap,rtsummary}_wordcount
      [266e78aec4b9] xfs: factor out a xfs_last_rt_bmblock helper
      [33912286cb19] xfs: replace m_rsumsize with m_rsumblocks
      [feb09b727b03] xfs: match on the global RT inode numbers in xfs_is_metadata_inode
      [2a95ffc44b61] xfs: factor out rtbitmap/summary initialization helpers
      [fa0fc38b255c] xfs: remove xfs_rtb_to_rtxrem
      [0a59e4f3e167] xfs: push transaction join out of xfs_rtbitmap_lock and xfs_rtgroup_lock
      [df8b181f1551] xfs: simplify xfs_rtalloc_query_range
      [6e13dbebd518] xfs: remove the i_mode check in xfs_release
      [5d3ca6261121] xfs: refactor f_op->release handling
      [98e44e2bc0fb] xfs: don't bother returning errors from xfs_file_release
      [c741d79c1a97] xfs: skip all of xfs_file_release when shut down
      [b717089efe47] xfs: check XFS_EOFBLOCKS_RELEASED earlier in xfs_release_eofblocks
      [11f4c3a53add] xfs: simplify extent lookup in xfs_can_free_eofblocks
      [9372dce08b34] xfs: reclaim speculative preallocations for append only files
      [4ef7c6d39dc7] xfs: use kfree_rcu_mightsleep to free the perag structures
      [f48f0a8e00b6] xfs: move the tagged perag lookup helpers to xfs_icache.c
      [f9ffd095c89a] xfs: simplify tagged perag iteration
      [32fa4059fe67] xfs: convert perag lookup to xarray
      [866cf1dd3d5c] xfs: use xas_for_each_marked in xfs_reclaim_inodes_count
      [90fa22da6d6b] xfs: ensure st_blocks never goes to zero during COW writes

Dan Carpenter (1):
      [fb8b941c75bd] xfs: remove unnecessary check

Darrick J. Wong (19):
      [cb59233e8237] xfs: don't return too-short extents from xfs_rtallocate_extent_block
      [e99aa0401eb4] xfs: don't scan off the end of the rt volume in xfs_rtallocate_extent_block
      [e6a74dcf9bc3] xfs: refactor aligning bestlen to prod
      [62c3d2496808] xfs: clean up xfs_rtallocate_extent_exact a bit
      [0902819fe649] xfs: add xchk_setup_nothing and xchk_nothing helpers
      [74c234bbe51a] xfs: reduce excessive clamping of maxlen in xfs_rtallocate_extent_near
      [05aba1953f4a] xfs: validate inumber in xfs_iget
      [9e9be9840fad] xfs: fix broken variable-sized allocation detection in xfs_rtallocate_extent_block
      [516f91035c27] xfs: rearrange xfs_fsmap.c a little bit
      [398597c3ef7f] xfs: introduce new file range commit ioctls
      [390b4775d678] xfs: pass the icreate args object to xfs_dialloc
      [2ca7b9d7b808] xfs: move xfs_ioc_getfsmap out of xfs_ioctl.c
      [64dfa18d6e32] xfs: fix C++ compilation errors in xfs_fs.h
      [c460f0f1a2bc] xfs: fix FITRIM reporting again
      [79124b374006] xfs: replace shouty XFS_BM{BT,DR} macros
      [2c4162be6c10] xfs: refactor loading quota inodes in the regular case
      [de55149b6639] xfs: fix a sloppy memory handling bug in xfs_iroot_realloc
      [411a71256de6] xfs: standardize the btree maxrecs function parameters
      [f1204d96450f] xfs: only free posteof blocks on first close

Dave Chinner (1):
      [816e3599ca9b] xfs: don't free post-EOF blocks on read close

Hongbo Li (1):
      [70045dafdf8d] xfs: use LIST_HEAD() to simplify code

Jiapeng Chong (1):
      [9db384feea85] xfs: Remove duplicate xfs_trans_priv.h header

John Garry (1):
      [ca57120dfe27] xfs: Use xfs set and clear mp state helpers

Code Diffstat:

 fs/xfs/libxfs/xfs_ag.c             |  94 +---------
 fs/xfs/libxfs/xfs_ag.h             |  14 --
 fs/xfs/libxfs/xfs_alloc_btree.c    |   6 +-
 fs/xfs/libxfs/xfs_alloc_btree.h    |   3 +-
 fs/xfs/libxfs/xfs_attr_leaf.c      |   8 +-
 fs/xfs/libxfs/xfs_bmap.c           | 101 ++++++-----
 fs/xfs/libxfs/xfs_bmap_btree.c     |  24 +--
 fs/xfs/libxfs/xfs_bmap_btree.h     | 207 +++++++++++++++-------
 fs/xfs/libxfs/xfs_defer.c          |   1 -
 fs/xfs/libxfs/xfs_fs.h             |  31 +++-
 fs/xfs/libxfs/xfs_ialloc.c         |   9 +-
 fs/xfs/libxfs/xfs_ialloc.h         |   4 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c   |   6 +-
 fs/xfs/libxfs/xfs_ialloc_btree.h   |   3 +-
 fs/xfs/libxfs/xfs_inode_fork.c     |  40 ++---
 fs/xfs/libxfs/xfs_inode_util.c     |   2 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |   5 +-
 fs/xfs/libxfs/xfs_refcount_btree.h |   3 +-
 fs/xfs/libxfs/xfs_rmap_btree.c     |   7 +-
 fs/xfs/libxfs/xfs_rmap_btree.h     |   3 +-
 fs/xfs/libxfs/xfs_rtbitmap.c       | 274 +++++++++++++++++++++--------
 fs/xfs/libxfs/xfs_rtbitmap.h       |  61 ++-----
 fs/xfs/libxfs/xfs_sb.c             |  92 ++++++----
 fs/xfs/libxfs/xfs_sb.h             |   3 +
 fs/xfs/libxfs/xfs_trans_resv.c     |   4 +-
 fs/xfs/libxfs/xfs_types.h          |  12 --
 fs/xfs/scrub/bmap_repair.c         |   2 +-
 fs/xfs/scrub/common.h              |  29 +--
 fs/xfs/scrub/inode_repair.c        |  12 +-
 fs/xfs/scrub/rtsummary.c           |  11 +-
 fs/xfs/scrub/rtsummary.h           |   2 +-
 fs/xfs/scrub/rtsummary_repair.c    |  12 +-
 fs/xfs/scrub/scrub.h               |  29 +--
 fs/xfs/scrub/tempfile.c            |   2 +-
 fs/xfs/xfs_bmap_item.c             |  17 ++
 fs/xfs/xfs_bmap_util.c             |  38 ++--
 fs/xfs/xfs_discard.c               |  17 +-
 fs/xfs/xfs_exchrange.c             | 143 ++++++++++++++-
 fs/xfs/xfs_exchrange.h             |  16 +-
 fs/xfs/xfs_file.c                  |  72 +++++++-
 fs/xfs/xfs_fsmap.c                 | 403 +++++++++++++++++++++++++++---------------
 fs/xfs/xfs_fsmap.h                 |   6 +-
 fs/xfs/xfs_fsops.c                 |   2 +-
 fs/xfs/xfs_icache.c                |  89 +++++++---
 fs/xfs/xfs_inode.c                 |  86 +--------
 fs/xfs/xfs_inode.h                 |  12 +-
 fs/xfs/xfs_ioctl.c                 | 134 +-------------
 fs/xfs/xfs_log.c                   |   2 +-
 fs/xfs/xfs_log_recover.c           |   2 +-
 fs/xfs/xfs_mount.c                 |   2 +-
 fs/xfs/xfs_mount.h                 |   5 +-
 fs/xfs/xfs_mru_cache.c             |   3 +-
 fs/xfs/xfs_qm.c                    |  48 ++++-
 fs/xfs/xfs_qm.h                    |   3 +
 fs/xfs/xfs_qm_syscalls.c           |  13 +-
 fs/xfs/xfs_quotaops.c              |  53 +++---
 fs/xfs/xfs_rtalloc.c               | 868 ++++++++++++++++++++++++++++++++++++++++++------------------------------------------------
 fs/xfs/xfs_super.c                 |  13 +-
 fs/xfs/xfs_symlink.c               |   2 +-
 fs/xfs/xfs_trace.h                 |  61 ++++++-
 60 files changed, 1772 insertions(+), 1454 deletions(-)

