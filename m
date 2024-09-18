Return-Path: <linux-fsdevel+bounces-29639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B9697BC4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F097B24B0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C044409;
	Wed, 18 Sep 2024 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTsZRbeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEF2628C;
	Wed, 18 Sep 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662946; cv=none; b=tSVYoKDLQ0BJuJ1TDTCgPh33dV2HLCW/HycKQI3KvH4SqR34TvV1aTuEaMjrSv2XOUf9AsWZNNVe9dYic9y739TjQNJPSJ5nRsRe9dk8VBOAuqFRrwHXfL8HIVgR7RNMXk9zpSKpaA58Nb1zB7X9t2vZFmlT8x50o0t5QJWbNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662946; c=relaxed/simple;
	bh=BMyyjObhnBwopFESIP5QS0Ad5ptwGbYIvoucOYWwcKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzZAVQkTVMtzcwQJxNJDjPqrmfxZ8e3dYjsLTEwQDOOcrAPdkZd2vnruBArKmdaDOtojfDz3oN9XGs9z6pddgK5DmAkf2r161nO+SfBVPUywbK2dsj1wCdf6kBc4bZtThU7h6lZ8B/LvuhPzJURjHEOyQZ7Ct24IuadCUzN5eb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTsZRbeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8C0C4CEC3;
	Wed, 18 Sep 2024 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726662945;
	bh=BMyyjObhnBwopFESIP5QS0Ad5ptwGbYIvoucOYWwcKs=;
	h=From:To:Cc:Subject:Date:From;
	b=hTsZRbeo8QH8p6ES3NVqC7Y55Mh37+QK+BlnUTE65pKLiQx7IIvuvtfFhJsUix1Ii
	 8TdqDgTaZooiMYwPjOfKYPrUQwMnUlhDsJhXHCf+bRekNZI2wlB8hvUWW1rdtfhZkc
	 Yhm5vtzb11/eVxr4f2wNhjJVu4JacHdWfu2uGgE/rEKb5nC3RB1wIF+HORFZ2vSOuu
	 1YpjdzZ/cDT8/oNEMud02JN0ohRVU1Ox8YyYugavE1kWVTqPXD2dakG7z0ug4Wy2mG
	 fCI5qzrFjljZ8v3uoKJhSn/eH6hrNZh+L6u3o4jt4Xnt4fNYZm2vAp/RaAEveSlhh+
	 ReITv56w5f6Gw==
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,
 sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Subject: [GIT PULL] xfs: new code for 6.12
Date: Wed, 18 Sep 2024 17:47:54 +0530
Message-ID: <87jzf9w34x.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch with changes for XFS for 6.12-rc1.

The pull request introduces new ioctls for exchanging contents of two files.
The remaining changes are limited to fixes and cleanups.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts. Please let me know if you encounter any problems.

Please note that in case you end up pulling contents of for-next branches of either
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
or
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

... You might end up with compilation errors. The trivial patch at
https://lore.kernel.org/linux-next/20240916093012.3a4dbb3f@canb.auug.org.au/#r
will resolve the issue.

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.12-merge-1

for you to fetch changes up to 90fa22da6d6b41dc17435aff7b800f9ca3c00401:

  xfs: ensure st_blocks never goes to zero during COW writes (2024-09-03 10:07:47 +0530)

----------------------------------------------------------------
New code for 6.12:

  * Introduce new ioctls to exchange contents of two files.
    The first ioctl does the preparation work to exchange the contents of two
    files while the second ioctl performs the actual exchange if the target
    file has not been changed since a given sampling point.

  * Fixes
    - Fix bugs associated with calculating the maximum range of realtime
      extents to scan for free space.
    - Copy keys instead of records when resizing the incore BMBT root block.
    - Do not report FITRIMming more bytes than possibly exist in the
      filesystem.
    - Modify xfs_fs.h to prevent C++ compilation errors.
    - Do not over eagerly free post-EOF speculative preallocation.
    - Ensure st_blocks never goes to zero during COW writes

  * Cleanups/refactors
    - Use Xarray to hold per-AG data instead of a Radix tree.
    - Cleanup the following functionality,
      - Realtime bitmap.
      - Inode allocator.
      - Quota.
      - Inode rooted btree code.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Chandan Babu R (8):
      Merge tag 'atomic-file-commits-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      Merge tag 'metadir-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      Merge tag 'rtbitmap-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      Merge tag 'rtalloc-fixes-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      Merge tag 'rtalloc-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      Merge tag 'quota-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      Merge tag 'xfs-fixes-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA
      Merge tag 'btree-cleanups-6.12_2024-09-02' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.12-mergeA

Christoph Hellwig (37):
      xfs: remove xfs_validate_rtextents
      xfs: factor out a xfs_validate_rt_geometry helper
      xfs: make the RT rsum_cache mandatory
      xfs: use the recalculated transaction reservation in xfs_growfs_rt_bmblock
      xfs: clean up the ISVALID macro in xfs_bmap_adjacent
      xfs: remove the limit argument to xfs_rtfind_back
      xfs: ensure rtx mask/shift are correct after growfs
      xfs: factor out a xfs_rtallocate helper
      xfs: assert a valid limit in xfs_rtfind_forw
      xfs: rework the rtalloc fallback handling
      xfs: add bounds checking to xfs_rt{bitmap,summary}_read_buf
      xfs: factor out a xfs_rtallocate_align helper
      xfs: cleanup the calling convention for xfs_rtpick_extent
      xfs: make the rtalloc start hint a xfs_rtblock_t
      xfs: push the calls to xfs_rtallocate_range out to xfs_bmap_rtalloc
      xfs: factor out a xfs_growfs_rt_bmblock helper
      xfs: remove xfs_{rtbitmap,rtsummary}_wordcount
      xfs: factor out a xfs_last_rt_bmblock helper
      xfs: replace m_rsumsize with m_rsumblocks
      xfs: match on the global RT inode numbers in xfs_is_metadata_inode
      xfs: factor out rtbitmap/summary initialization helpers
      xfs: remove xfs_rtb_to_rtxrem
      xfs: push transaction join out of xfs_rtbitmap_lock and xfs_rtgroup_lock
      xfs: simplify xfs_rtalloc_query_range
      xfs: remove the i_mode check in xfs_release
      xfs: refactor f_op->release handling
      xfs: don't bother returning errors from xfs_file_release
      xfs: skip all of xfs_file_release when shut down
      xfs: check XFS_EOFBLOCKS_RELEASED earlier in xfs_release_eofblocks
      xfs: simplify extent lookup in xfs_can_free_eofblocks
      xfs: reclaim speculative preallocations for append only files
      xfs: use kfree_rcu_mightsleep to free the perag structures
      xfs: move the tagged perag lookup helpers to xfs_icache.c
      xfs: simplify tagged perag iteration
      xfs: convert perag lookup to xarray
      xfs: use xas_for_each_marked in xfs_reclaim_inodes_count
      xfs: ensure st_blocks never goes to zero during COW writes

Dan Carpenter (1):
      xfs: remove unnecessary check

Darrick J. Wong (19):
      xfs: don't return too-short extents from xfs_rtallocate_extent_block
      xfs: don't scan off the end of the rt volume in xfs_rtallocate_extent_block
      xfs: refactor aligning bestlen to prod
      xfs: clean up xfs_rtallocate_extent_exact a bit
      xfs: add xchk_setup_nothing and xchk_nothing helpers
      xfs: reduce excessive clamping of maxlen in xfs_rtallocate_extent_near
      xfs: validate inumber in xfs_iget
      xfs: fix broken variable-sized allocation detection in xfs_rtallocate_extent_block
      xfs: rearrange xfs_fsmap.c a little bit
      xfs: introduce new file range commit ioctls
      xfs: pass the icreate args object to xfs_dialloc
      xfs: move xfs_ioc_getfsmap out of xfs_ioctl.c
      xfs: fix C++ compilation errors in xfs_fs.h
      xfs: fix FITRIM reporting again
      xfs: replace shouty XFS_BM{BT,DR} macros
      xfs: refactor loading quota inodes in the regular case
      xfs: fix a sloppy memory handling bug in xfs_iroot_realloc
      xfs: standardize the btree maxrecs function parameters
      xfs: only free posteof blocks on first close

Dave Chinner (1):
      xfs: don't free post-EOF blocks on read close

Hongbo Li (1):
      xfs: use LIST_HEAD() to simplify code

Jiapeng Chong (1):
      xfs: Remove duplicate xfs_trans_priv.h header

John Garry (1):
      xfs: Use xfs set and clear mp state helpers

 fs/xfs/libxfs/xfs_ag.c             |  94 +---
 fs/xfs/libxfs/xfs_ag.h             |  14 -
 fs/xfs/libxfs/xfs_alloc_btree.c    |   6 +-
 fs/xfs/libxfs/xfs_alloc_btree.h    |   3 +-
 fs/xfs/libxfs/xfs_attr_leaf.c      |   8 +-
 fs/xfs/libxfs/xfs_bmap.c           | 101 +++--
 fs/xfs/libxfs/xfs_bmap_btree.c     |  24 +-
 fs/xfs/libxfs/xfs_bmap_btree.h     | 207 ++++++---
 fs/xfs/libxfs/xfs_defer.c          |   1 -
 fs/xfs/libxfs/xfs_fs.h             |  31 +-
 fs/xfs/libxfs/xfs_ialloc.c         |   9 +-
 fs/xfs/libxfs/xfs_ialloc.h         |   4 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c   |   6 +-
 fs/xfs/libxfs/xfs_ialloc_btree.h   |   3 +-
 fs/xfs/libxfs/xfs_inode_fork.c     |  40 +-
 fs/xfs/libxfs/xfs_inode_util.c     |   2 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |   5 +-
 fs/xfs/libxfs/xfs_refcount_btree.h |   3 +-
 fs/xfs/libxfs/xfs_rmap_btree.c     |   7 +-
 fs/xfs/libxfs/xfs_rmap_btree.h     |   3 +-
 fs/xfs/libxfs/xfs_rtbitmap.c       | 274 ++++++++----
 fs/xfs/libxfs/xfs_rtbitmap.h       |  61 +--
 fs/xfs/libxfs/xfs_sb.c             |  92 ++--
 fs/xfs/libxfs/xfs_sb.h             |   3 +
 fs/xfs/libxfs/xfs_trans_resv.c     |   4 +-
 fs/xfs/libxfs/xfs_types.h          |  12 -
 fs/xfs/scrub/bmap_repair.c         |   2 +-
 fs/xfs/scrub/common.h              |  29 +-
 fs/xfs/scrub/inode_repair.c        |  12 +-
 fs/xfs/scrub/rtsummary.c           |  11 +-
 fs/xfs/scrub/rtsummary.h           |   2 +-
 fs/xfs/scrub/rtsummary_repair.c    |  12 +-
 fs/xfs/scrub/scrub.h               |  29 +-
 fs/xfs/scrub/tempfile.c            |   2 +-
 fs/xfs/xfs_bmap_item.c             |  17 +
 fs/xfs/xfs_bmap_util.c             |  38 +-
 fs/xfs/xfs_discard.c               |  17 +-
 fs/xfs/xfs_exchrange.c             | 143 +++++-
 fs/xfs/xfs_exchrange.h             |  16 +-
 fs/xfs/xfs_file.c                  |  72 ++-
 fs/xfs/xfs_fsmap.c                 | 403 +++++++++++------
 fs/xfs/xfs_fsmap.h                 |   6 +-
 fs/xfs/xfs_fsops.c                 |   2 +-
 fs/xfs/xfs_icache.c                |  89 ++--
 fs/xfs/xfs_inode.c                 |  86 +---
 fs/xfs/xfs_inode.h                 |  12 +-
 fs/xfs/xfs_ioctl.c                 | 134 +-----
 fs/xfs/xfs_log.c                   |   2 +-
 fs/xfs/xfs_log_recover.c           |   2 +-
 fs/xfs/xfs_mount.c                 |   2 +-
 fs/xfs/xfs_mount.h                 |   5 +-
 fs/xfs/xfs_mru_cache.c             |   3 +-
 fs/xfs/xfs_qm.c                    |  48 +-
 fs/xfs/xfs_qm.h                    |   3 +
 fs/xfs/xfs_qm_syscalls.c           |  13 +-
 fs/xfs/xfs_quotaops.c              |  53 ++-
 fs/xfs/xfs_rtalloc.c               | 868 +++++++++++++++++--------------------
 fs/xfs/xfs_super.c                 |  13 +-
 fs/xfs/xfs_symlink.c               |   2 +-
 fs/xfs/xfs_trace.h                 |  61 ++-
 60 files changed, 1772 insertions(+), 1454 deletions(-)

