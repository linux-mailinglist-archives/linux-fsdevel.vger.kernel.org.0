Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF153641E46
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Dec 2022 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiLDRph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Dec 2022 12:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLDRpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Dec 2022 12:45:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68D12A85;
        Sun,  4 Dec 2022 09:45:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F6EAB80B72;
        Sun,  4 Dec 2022 17:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A3AC433C1;
        Sun,  4 Dec 2022 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670175931;
        bh=Af4THgWNCSbBdS00Y/eUDg3Of6Vyyi7iLZqMhIrVirM=;
        h=Date:From:To:Cc:Subject:From;
        b=Y5U4WRnPXLlC7vfve4F35v+tFDCVmvnj9WZOpOb4H9LCYPQNZ6JIry0AQcoFaUCpN
         Wts43K4dhzOYfLvSbD/gYNcV+cr763YXiKtQKYKJyvGpdpWaYlYOnEVXymGRhKovw2
         y6InYfixSKhy5Vd8f6n9TKErYInnWfhvco93mOumHafqUlJz0A4KJp5Eqo5QGQal5l
         V4llxiiRXC8ZqEW63LD/nLGjErjxbRg/XeuRJiP9X04GV9NvNBTbdTWV4SIsnmcz1Q
         UggJJiAocdb/e+QgLy9QdKUM5JK+V97PPL8VTb3s+bEEFnFo7NDnpawkQO4uJ3/Glp
         tmmuSRLanMhOw==
Date:   Sun, 4 Dec 2022 09:45:31 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     aalbersh@redhat.com, abaci@linux.alibaba.com, dchinner@redhat.com,
        guoxuenan@huawei.com, hch@lst.de, hsiangkao@linux.alibaba.com,
        leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, lukas@herbolt.com, sandeen@redhat.com,
        yang.lee@linux.alibaba.com, yangx.jy@fujitsu.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 1f5619ed8810
Message-ID: <167017588282.1802405.1759707049507526763.stg-ugh@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The for-next branch of the xfs-linux repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  Bug fixes only now.

The new head of the for-next branch is commit:

1f5619ed8810 xfs: Remove duplicated include in xfs_iomap.c

60 new commits:

Darrick J. Wong (44):
[9a48b4a6fd51] xfs: fully initialize xfs_da_args in xchk_directory_blocks
[be1317fdb8d4] xfs: don't track the AGFL buffer in the scrub AG context
[3e59c0103e66] xfs: log the AGI/AGF buffers when rolling transactions during an AG repair
[48ff40458f87] xfs: standardize GFP flags usage in online scrub
[b255fab0f80c] xfs: make AGFL repair function avoid crosslinked blocks
[a7a0f9a5503f] xfs: return EINTR when a fatal signal terminates scrub
[0a713bd41ea2] xfs: fix return code when fatal signal encountered during dquot scrub
[fcd2a43488d5] xfs: initialize the check_owner object fully
[6bf2f8791597] xfs: don't retry repairs harder when EAGAIN is returned
[306195f355bb] xfs: pivot online scrub away from kmem.[ch]
[9e13975bb062] xfs: load rtbitmap and rtsummary extent mapping btrees at mount time
[11f97e684583] xfs: skip fscounters comparisons when the scan is incomplete
[93b0c58ed04b] xfs: don't return -EFSCORRUPTED from repair when resources cannot be grabbed
[5f369dc5b4eb] xfs: make rtbitmap ILOCKing consistent when scanning the rt bitmap file
[e74331d6fa2c] xfs: online checking of the free rt extent count
[033985b6fe87] xfs: fix perag loop in xchk_bmap_check_rmaps
[6a5777865eeb] xfs: teach scrub to check for adjacent bmaps when rmap larger than bmap
[830ffa09fb13] xfs: block map scrub should handle incore delalloc reservations
[f23c40443d1c] xfs: check quota files for unwritten extents
[31785537010a] xfs: check that CoW fork extents are not shared
[5eef46358fae] xfs: teach scrub to flag non-extents format cow forks
[bd5ab5f98741] xfs: don't warn about files that are exactly s_maxbytes long
[f36b954a1f1b] xfs: check inode core when scrubbing metadata files
[823ca26a8f07] Merge tag 'scrub-fix-ag-header-handling-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
[af1077fa87c3] Merge tag 'scrub-cleanup-malloc-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
[3d8426b13bac] Merge tag 'scrub-fix-return-value-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
[b76f593b33aa] Merge tag 'scrub-fix-rtmeta-ilocking-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
[7aab8a05e7c7] Merge tag 'scrub-fscounters-enhancements-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
[cc5f38fa12fc] Merge tag 'scrub-bmap-enhancements-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
[7b082b5e8afa] Merge tag 'scrub-check-metadata-inode-records-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
[2653d53345bd] xfs: fix incorrect error-out in xfs_remove
[7dd73802f97d] Merge tag 'xfs-iomap-stale-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.2-mergeB
[c2beff99eb03] xfs: add debug knob to slow down writeback for fun
[254e3459285c] xfs: add debug knob to slow down write for fun
[032e160305f6] xfs: invalidate block device page cache during unmount
[fd5beaff250d] xfs: use memcpy, not strncpy, to format the attr prefix during listxattr
[e5827a007aa4] xfs: shut up -Wuninitialized in xfsaild_push
[4c6dbfd2756b] xfs: attach dquots to inode before reading data/cow fork mappings
[cd14f15b0e64] Merge tag 'iomap-write-race-testing-6.2_2022-11-30' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeC
[4b4d11bbeca4] Merge tag 'random-fixes-6.2_2022-11-30' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeC
[9d720a5a658f] xfs: hoist refcount record merge predicates
[b25d1984aa88] xfs: estimate post-merge refcounts correctly
[948961964b24] Merge tag 'maxrefcount-fixes-6.2_2022-12-01' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeD
[ddfdd530e43f] xfs: invalidate xfs_bufs when allocating cow extents

Dave Chinner (9):
[118e021b4b66] xfs: write page faults in iomap are not buffered writes
[198dd8aedee6] xfs: punching delalloc extents on write failure is racy
[b71f889c18ad] xfs: use byte ranges for write cleanup ranges
[9c7babf94a0d] xfs,iomap: move delalloc punching to iomap
[f43dc4dc3eff] iomap: buffered write failure should not truncate the page cache
[7348b322332d] xfs: xfs_bmap_punch_delalloc_range() should take a byte range
[d7b64041164c] iomap: write iomap validity checks
[304a68b9c63b] xfs: use iomap_valid method to detect stale cached iomaps
[6e8af15ccdc4] xfs: drop write error injection is unfixable, remove it

Guo Xuenan (3):
[1eb52a6a7198] xfs: wait iclog complete before tearing down AIL
[575689fc0ffa] xfs: fix super block buf log item UAF during force shutdown
[8c25febf2396] xfs: get rid of assert from xfs_btree_islastblock

Long Li (2):
[59f6ab40fd87] xfs: fix sb write verify for lazysbcount
[28b4b0596343] xfs: fix incorrect i_nlink caused by inode racing

Lukas Herbolt (1):
[64c80dfd04d1] xfs: Print XFS UUID on mount and umount events.

Yang Li (1):
[1f5619ed8810] xfs: Remove duplicated include in xfs_iomap.c

Code Diffstat:

fs/iomap/buffered-io.c         | 254 ++++++++++++++++++++++++++++++++++++++++-
fs/iomap/iter.c                |  19 ++-
fs/xfs/libxfs/xfs_bmap.c       |   8 +-
fs/xfs/libxfs/xfs_btree.h      |   1 -
fs/xfs/libxfs/xfs_errortag.h   |  18 +--
fs/xfs/libxfs/xfs_refcount.c   | 146 ++++++++++++++++++++---
fs/xfs/libxfs/xfs_sb.c         |   4 +-
fs/xfs/scrub/agheader.c        |  47 +++++---
fs/xfs/scrub/agheader_repair.c |  81 ++++++++++---
fs/xfs/scrub/attr.c            |  11 +-
fs/xfs/scrub/bitmap.c          |  11 +-
fs/xfs/scrub/bmap.c            | 147 +++++++++++++++++++-----
fs/xfs/scrub/btree.c           |  14 ++-
fs/xfs/scrub/common.c          |  48 +++++---
fs/xfs/scrub/common.h          |   2 +-
fs/xfs/scrub/dabtree.c         |   4 +-
fs/xfs/scrub/dir.c             |  10 +-
fs/xfs/scrub/fscounters.c      | 109 +++++++++++++++++-
fs/xfs/scrub/inode.c           |   2 +-
fs/xfs/scrub/quota.c           |   8 +-
fs/xfs/scrub/refcount.c        |  12 +-
fs/xfs/scrub/repair.c          |  51 ++++++---
fs/xfs/scrub/scrub.c           |   6 +-
fs/xfs/scrub/scrub.h           |  18 +--
fs/xfs/scrub/symlink.c         |   2 +-
fs/xfs/xfs_aops.c              |  32 +++---
fs/xfs/xfs_bmap_util.c         |  10 +-
fs/xfs/xfs_bmap_util.h         |   2 +-
fs/xfs/xfs_buf.c               |   1 +
fs/xfs/xfs_buf_item.c          |   2 +
fs/xfs/xfs_error.c             |  46 ++++++--
fs/xfs/xfs_error.h             |  13 +++
fs/xfs/xfs_file.c              |   2 +-
fs/xfs/xfs_fsmap.c             |   4 +-
fs/xfs/xfs_icache.c            |   6 +
fs/xfs/xfs_inode.c             |   2 +-
fs/xfs/xfs_iomap.c             | 185 ++++++++++++++++++------------
fs/xfs/xfs_iomap.h             |   6 +-
fs/xfs/xfs_log.c               |  46 +++++---
fs/xfs/xfs_mount.c             |  15 +++
fs/xfs/xfs_pnfs.c              |   6 +-
fs/xfs/xfs_rtalloc.c           |  60 +++++++++-
fs/xfs/xfs_super.c             |   2 +-
fs/xfs/xfs_trace.c             |   2 +
fs/xfs/xfs_trace.h             |  86 ++++++++++++++
fs/xfs/xfs_trans_ail.c         |   4 +-
fs/xfs/xfs_xattr.c             |   2 +-
include/linux/iomap.h          |  47 ++++++--
48 files changed, 1305 insertions(+), 309 deletions(-)
