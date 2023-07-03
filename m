Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B466746106
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjGCQzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 12:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCQzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2FE6B;
        Mon,  3 Jul 2023 09:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65E6460FD0;
        Mon,  3 Jul 2023 16:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D69C433C8;
        Mon,  3 Jul 2023 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688403341;
        bh=+fJdK3HbJTp3127pSMentEHV8HU0TkL+IOput1SVlfs=;
        h=Date:From:To:Cc:Subject:From;
        b=doJcfgFvg65ZIY4zzasSYIw9tktRSgBfr92j5ubHgMTnlSCNAtYplA0ODmBNmFI4r
         Nd6sErebeD7BpRl0iqcTic2Ce03B1bpjcjFexWp5SlJzxXsOnZERJ+yy6jEeUXkks5
         p/jZFqy/gDE8Ah7g3/BJBvlHtSan4PP+Nmfk2kAAEQcj2svpu9impWu0ApfBGw9I6y
         4OJ3FUdZs1oODcBl+0NBXIfwBYLrDG2DsEkiIxK0kHw56LBDdIe0/OD2rz1r3SkFUZ
         cVw3WqqPW2m0fYi8HetqON0NEdB1mLYUlehSps47BjB9O8a3avmcroaV6lCascAXM2
         Evvc40MGDQbuQ==
Date:   Mon, 3 Jul 2023 09:55:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     abaci@linux.alibaba.com, chandan.babu@oracle.com,
        chandanrlinux@gmail.com, colin.i.king@gmail.com,
        dchinner@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, ruansy.fnst@fujitsu.com,
        wen.gang.wang@oracle.com, yang.lee@linux.alibaba.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 34acceaa8818
Message-ID: <168840330350.1303450.11213970633638533550.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
the next update.

The new head of the for-next branch is commit:

34acceaa8818 xfs: Remove unneeded semicolon

19 new commits:

Colin Ian King (1):
[347eb95b27eb] xfs: remove redundant initializations of pointers drop_leaf and save_leaf

Darrick J. Wong (8):
[63ef7a35912d] xfs: fix interval filtering in multi-step fsmap queries
[7975aba19cba] xfs: fix integer overflows in the fsmap rtbitmap and logdev backends
[d898137d789c] xfs: fix getfsmap reporting past the last rt extent
[f045dd00328d] xfs: clean up the rtbitmap fsmap backend
[a949a1c2a198] xfs: fix logdev fsmap query result filtering
[3ee9351e7490] xfs: validate fsmap offsets specified in the query keys
[75dc03453122] xfs: fix xfs_btree_query_range callers to initialize btree rec fully
[2d7d1e7ea321] xfs: AGI length should be bounds checked

Dave Chinner (8):
[939bd50dfbe7] xfs: don't reverse order of items in bulk AIL insertion
[b742d7b4f0e0] xfs: use deferred frees for btree block freeing
[6a2a9d776c4a] xfs: pass alloc flags through to xfs_extent_busy_flush()
[0853b5de42b4] xfs: allow extent free intents to be retried
[8ebbf262d468] xfs: don't block in busy flushing when freeing extents
[f1e1765aad7d] xfs: journal geometry is not properly bounds checked
[edd8276dd702] xfs: AGF length has never been bounds checked
[2bed0d82c2f7] xfs: fix bounds check in xfs_defer_agfl_block()

Shiyang Ruan (1):
[5cf32f63b0f4] xfs: fix the calculation for "end" and "length"

Yang Li (1):
[34acceaa8818] xfs: Remove unneeded semicolon

Code Diffstat:

fs/xfs/libxfs/xfs_ag.c             |   2 +-
fs/xfs/libxfs/xfs_alloc.c          | 291 ++++++++++++++++++++++++-------------
fs/xfs/libxfs/xfs_alloc.h          |  24 +--
fs/xfs/libxfs/xfs_attr_leaf.c      |   2 -
fs/xfs/libxfs/xfs_bmap.c           |   8 +-
fs/xfs/libxfs/xfs_bmap_btree.c     |   3 +-
fs/xfs/libxfs/xfs_ialloc.c         |  32 ++--
fs/xfs/libxfs/xfs_ialloc_btree.c   |   3 +-
fs/xfs/libxfs/xfs_refcount.c       |  22 +--
fs/xfs/libxfs/xfs_refcount_btree.c |   8 +-
fs/xfs/libxfs/xfs_rmap.c           |  10 +-
fs/xfs/libxfs/xfs_sb.c             |  56 ++++++-
fs/xfs/xfs_extent_busy.c           |  36 ++++-
fs/xfs/xfs_extent_busy.h           |   6 +-
fs/xfs/xfs_extfree_item.c          |  75 +++++++++-
fs/xfs/xfs_fsmap.c                 | 261 +++++++++++++++++----------------
fs/xfs/xfs_log.c                   |  47 ++----
fs/xfs/xfs_notify_failure.c        |   9 +-
fs/xfs/xfs_reflink.c               |   3 +-
fs/xfs/xfs_trace.h                 |  25 ++++
fs/xfs/xfs_trans_ail.c             |   2 +-
21 files changed, 590 insertions(+), 335 deletions(-)
