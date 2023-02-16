Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CFA699AEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 18:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBPRNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 12:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjBPRNV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:13:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08E14E5DC;
        Thu, 16 Feb 2023 09:13:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67F09B82923;
        Thu, 16 Feb 2023 17:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A51FC4339B;
        Thu, 16 Feb 2023 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676567595;
        bh=NVZw3UTbjOLW2Wu28+i+XCwzaauVckiYDTqQmOEyPbY=;
        h=Date:From:To:Cc:Subject:From;
        b=FFmZ1eiRcNM8jSEP0U7/pfCOuaLot9QDFmj4GvlcvEPMVO42FYLp8ySLWTPfxVM/x
         6xYTYaFYTJXpj5g2epDBlUYLeCIRkxKcT2+zJg7Qv2FQORo2r+WVwy/hRlRCrwh1ZM
         ZVDjWqcXYhmEw1GC5EK8H/2N85na2DaNJxMYimpwTpClqjTjdfXsU4d5nhVpLjDCjW
         gSokdQLf0aMCcqRwNkuS1M+GrXQWGBq6HNWGiZ7g1Z5KORH0ENbxd3qX+9QJOi1gHc
         qSg0k1LF+yH6njElnJt2356kiF7+jsS+2c4SOYR1CMpTf0CjehkAqgRbAP4eOjhIqw
         RaKiwshB7FLmw==
Date:   Thu, 16 Feb 2023 09:13:14 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     allison.henderson@oracle.com, dchinner@redhat.com,
        ddouwsma@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux@weissschuh.net,
        syzbot+090ae72d552e6bd93cfe@syzkaller.appspotmail.com,
        syzbot+898115bc6d7140437215@syzkaller.appspotmail.com,
        xu.panda@zte.com.cn, yang.yang29@zte.com.cn
Subject: [ANNOUNCE] xfs-linux: for-next updated to 60b730a40c43
Message-ID: <167656749094.3281519.13774669983884547147.stg-ugh@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
the next update.  The new commits in this update will be sent during the
second week of the merge window.

The new head of the for-next branch is commit:

60b730a40c43 xfs: fix uninitialized variable access

57 new commits:

Darrick J. Wong (11):
[ddccb81b26ec] xfs: pass the xfs_bmbt_irec directly through the log intent code
[f3ebac4c94c1] xfs: fix confusing variable names in xfs_bmap_item.c
[72ba455599ad] xfs: pass xfs_extent_free_item directly through the log intent code
[578c714b215d] xfs: fix confusing xfs_extent_item variable names
[1534328bb427] xfs: pass rmap space mapping directly through the log intent code
[ffaa196f6221] xfs: fix confusing variable names in xfs_rmap_item.c
[0b11553ec54a] xfs: pass refcount intent directly through the log intent code
[01a3af226b7d] xfs: fix confusing variable names in xfs_refcount_item.c
[dd07bb8b6baf] xfs: revert commit 8954c44ff477
[571dc9ae4eef] Merge tag 'xfs-alloc-perag-conversion' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.3-merge-A
[60b730a40c43] xfs: fix uninitialized variable access

Dave Chinner (43):
[c85007e2e394] xfs: don't use BMBT btree split workers for IO completion
[1dd0510f6d4b] xfs: fix low space alloc deadlock
[f08f984c63e9] xfs: prefer free inodes at ENOSPC over chunk allocation
[d5753847b216] xfs: block reservation too large for minleft allocation
[36b6ad2d9cb8] xfs: drop firstblock constraints from allocation setup
[692b6cddeb65] xfs: t_firstblock is tracking AGs not blocks
[55d5c3a386d7] xfs: don't assert fail on transaction cancel with deferred ops
[c4d5660afbdc] xfs: active perag reference counting
[368e2d09b41c] xfs: rework the perag trace points to be perag centric
[498f0adbcdb6] xfs: convert xfs_imap() to take a perag
[dedab3e4379d] xfs: use active perag references for inode allocation
[bab8b795185b] xfs: inobt can use perags in many more places than it does
[20a5eab49d35] xfs: convert xfs_ialloc_next_ag() to an atomic
[7ac2ff8bb371] xfs: perags need atomic operational state
[76257a15873c] xfs: introduce xfs_for_each_perag_wrap()
[ecd788a92460] xfs: rework xfs_alloc_vextent()
[2edf06a50f5b] xfs: factor xfs_alloc_vextent_this_ag() for  _iterate_ags()
[4811c933ea1a] xfs: combine __xfs_alloc_vextent_this_ag and  xfs_alloc_ag_vextent
[74c36a8689d3] xfs: use xfs_alloc_vextent_this_ag() where appropriate
[85843327094f] xfs: factor xfs_bmap_btalloc()
[319c9e874ac8] xfs: use xfs_alloc_vextent_first_ag() where appropriate
[2a7f6d41d8b7] xfs: use xfs_alloc_vextent_start_bno() where appropriate
[db4710fd1224] xfs: introduce xfs_alloc_vextent_near_bno()
[5f36b2ce79f2] xfs: introduce xfs_alloc_vextent_exact_bno()
[74b9aa63193b] xfs: introduce xfs_alloc_vextent_prepare()
[e4d174260779] xfs: move allocation accounting to xfs_alloc_vextent_set_fsbno()
[230e8fe8462f] xfs: fold xfs_alloc_ag_vextent() into callers
[8b81356825ff] xfs: move the minimum agno checks into xfs_alloc_vextent_check_args
[3432ef611199] xfs: convert xfs_alloc_vextent_iterate_ags() to use perag walker
[35bf2b1abc9a] xfs: convert trim to use for_each_perag_range
[89563e7dc099] xfs: factor out filestreams from xfs_bmap_btalloc_nullfb
[6b637ad0c7be] xfs: get rid of notinit from xfs_bmap_longest_free_extent
[05cf492a8d01] xfs: use xfs_bmap_longest_free_extent() in filestreams
[8f7747ad8c52] xfs: move xfs_bmap_btalloc_filestreams() to xfs_filestreams.c
[a52dc2ad3630] xfs: merge filestream AG lookup into xfs_filestream_select_ag()
[ba34de8defe0] xfs: merge new filestream AG selection into xfs_filestream_select_ag()
[3e43877a9dac] xfs: remove xfs_filestream_select_ag() longest extent check
[f38b46bbfa76] xfs: factor out MRU hit case in xfs_filestream_select_ag
[3054face139f] xfs: track an active perag reference in filestreams
[eb70aa2d8ed9] xfs: use for_each_perag_wrap in xfs_filestream_pick_ag
[571e259282a4] xfs: pass perag to filestreams tracing
[f8f1ed1ab3ba] xfs: return a referenced perag from filestreams allocator
[bd4f5d09cc93] xfs: refactor the filestreams allocator pick functions

Donald Douwsma (1):
[167ce4cbfa37] xfs: allow setting full range of panic tags

Thomas Weiﬂschuh (1):
[2ee833352985] xfs: make kobj_type structures constant

Xu Panda (1):
[8954c44ff477] xfs: use strscpy() to instead of strncpy()

Code Diffstat:

Documentation/admin-guide/xfs.rst  |   2 +-
fs/xfs/libxfs/xfs_ag.c             |  93 ++++-
fs/xfs/libxfs/xfs_ag.h             | 111 +++++-
fs/xfs/libxfs/xfs_ag_resv.c        |   2 +-
fs/xfs/libxfs/xfs_alloc.c          | 717 +++++++++++++++++++++++--------------
fs/xfs/libxfs/xfs_alloc.h          |  61 ++--
fs/xfs/libxfs/xfs_alloc_btree.c    |   2 +-
fs/xfs/libxfs/xfs_bmap.c           | 704 +++++++++++++++++-------------------
fs/xfs/libxfs/xfs_bmap.h           |  12 +-
fs/xfs/libxfs/xfs_bmap_btree.c     |  64 ++--
fs/xfs/libxfs/xfs_btree.c          |  18 +-
fs/xfs/libxfs/xfs_ialloc.c         | 241 ++++++-------
fs/xfs/libxfs/xfs_ialloc.h         |   5 +-
fs/xfs/libxfs/xfs_ialloc_btree.c   |  47 ++-
fs/xfs/libxfs/xfs_ialloc_btree.h   |  20 +-
fs/xfs/libxfs/xfs_refcount.c       |  96 +++--
fs/xfs/libxfs/xfs_refcount.h       |   4 +-
fs/xfs/libxfs/xfs_refcount_btree.c |  10 +-
fs/xfs/libxfs/xfs_rmap.c           |  52 ++-
fs/xfs/libxfs/xfs_rmap.h           |   6 +-
fs/xfs/libxfs/xfs_rmap_btree.c     |   2 +-
fs/xfs/libxfs/xfs_sb.c             |   3 +-
fs/xfs/scrub/agheader_repair.c     |  35 +-
fs/xfs/scrub/bmap.c                |   2 +-
fs/xfs/scrub/common.c              |  21 +-
fs/xfs/scrub/fscounters.c          |  13 +-
fs/xfs/scrub/repair.c              |   7 +-
fs/xfs/xfs_bmap_item.c             | 137 +++----
fs/xfs/xfs_bmap_util.c             |   2 +-
fs/xfs/xfs_discard.c               |  50 ++-
fs/xfs/xfs_error.c                 |   2 +-
fs/xfs/xfs_error.h                 |  12 +-
fs/xfs/xfs_extfree_item.c          |  99 ++---
fs/xfs/xfs_filestream.c            | 455 +++++++++++------------
fs/xfs/xfs_filestream.h            |   6 +-
fs/xfs/xfs_fsmap.c                 |   5 +-
fs/xfs/xfs_globals.c               |   3 +-
fs/xfs/xfs_icache.c                |   8 +-
fs/xfs/xfs_inode.c                 |   2 +-
fs/xfs/xfs_iwalk.c                 |  10 +-
fs/xfs/xfs_mount.h                 |   3 +-
fs/xfs/xfs_refcount_item.c         | 110 +++---
fs/xfs/xfs_reflink.c               |   4 +-
fs/xfs/xfs_rmap_item.c             | 142 ++++----
fs/xfs/xfs_super.c                 |  47 ++-
fs/xfs/xfs_sysfs.c                 |  12 +-
fs/xfs/xfs_sysfs.h                 |  10 +-
fs/xfs/xfs_trace.h                 |  96 +++--
fs/xfs/xfs_trans.c                 |   8 +-
fs/xfs/xfs_trans.h                 |   2 +-
50 files changed, 1916 insertions(+), 1659 deletions(-)
