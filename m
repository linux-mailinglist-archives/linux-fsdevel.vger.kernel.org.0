Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65001744EA2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGBQgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBQgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 12:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA77E60;
        Sun,  2 Jul 2023 09:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9300F60C52;
        Sun,  2 Jul 2023 16:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2821C433C7;
        Sun,  2 Jul 2023 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688315761;
        bh=a5Ul8SjZIvkIzNbCOa5Q1mOct0Ddcq/z6DUZB/zk3rw=;
        h=Date:From:To:Cc:Subject:From;
        b=YSBe1MOZZukpoiEItsSQsT0PDXsHuvPiypHF8kMh5r2BKdVhQYNdRFNznsHFA4iaP
         AP3kGHQutg9wSdSHPj4+nUEzkW1K+Jc4qBh6pCNcqgFr/PUNxJLAKCU3Xm0f0meP0O
         qpBhm7NbDJnBe0SBMT/XeoArRBQ0awOpdUanuOxptNBec/hXqUZ5dR6PFR8AO8e1Wd
         ZpfYN/ligcxGqDZRLgAkm5+hUc9eOr+HqvpC40xWixVXnL/iy6fGswjrCp+sXjsoch
         ymDMQ1q/o7+/qJ9eAR2Fq80/BKwGiMcwqgeKRDrCiWicSYsJvUBUWDVfG7750tTKNQ
         L+SpciZZpPibw==
Date:   Sun, 2 Jul 2023 09:36:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     chandan.babu@oracle.com, chandanrlinux@gmail.com,
        colin.i.king@gmail.com, dchinner@redhat.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ruansy.fnst@fujitsu.com, wen.gang.wang@oracle.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 5cf32f63b0f4
Message-ID: <168831570915.552142.2712544895758062687.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
the next update.  There's at least one more bugfix out for review; if
you have more, please send them.

The new head of the for-next branch is commit:

5cf32f63b0f4 xfs: fix the calculation for "end" and "length"

17 new commits:

Colin Ian King (1):
[347eb95b27eb] xfs: remove redundant initializations of pointers drop_leaf and save_leaf

Darrick J. Wong (7):
[63ef7a35912d] xfs: fix interval filtering in multi-step fsmap queries
[7975aba19cba] xfs: fix integer overflows in the fsmap rtbitmap and logdev backends
[d898137d789c] xfs: fix getfsmap reporting past the last rt extent
[f045dd00328d] xfs: clean up the rtbitmap fsmap backend
[a949a1c2a198] xfs: fix logdev fsmap query result filtering
[3ee9351e7490] xfs: validate fsmap offsets specified in the query keys
[75dc03453122] xfs: fix xfs_btree_query_range callers to initialize btree rec fully

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

Code Diffstat:

fs/xfs/libxfs/xfs_ag.c             |   2 +-
fs/xfs/libxfs/xfs_alloc.c          | 271 +++++++++++++++++++++++--------------
fs/xfs/libxfs/xfs_alloc.h          |  21 +--
fs/xfs/libxfs/xfs_attr_leaf.c      |   2 -
fs/xfs/libxfs/xfs_bmap.c           |   8 +-
fs/xfs/libxfs/xfs_bmap_btree.c     |   3 +-
fs/xfs/libxfs/xfs_ialloc.c         |   8 +-
fs/xfs/libxfs/xfs_ialloc_btree.c   |   3 +-
fs/xfs/libxfs/xfs_refcount.c       |  22 +--
fs/xfs/libxfs/xfs_refcount_btree.c |   8 +-
fs/xfs/libxfs/xfs_rmap.c           |  10 +-
fs/xfs/libxfs/xfs_sb.c             |  56 +++++++-
fs/xfs/xfs_extent_busy.c           |  36 ++++-
fs/xfs/xfs_extent_busy.h           |   6 +-
fs/xfs/xfs_extfree_item.c          |  75 +++++++++-
fs/xfs/xfs_fsmap.c                 | 261 ++++++++++++++++++-----------------
fs/xfs/xfs_log.c                   |  47 ++-----
fs/xfs/xfs_notify_failure.c        |   9 +-
fs/xfs/xfs_reflink.c               |   3 +-
fs/xfs/xfs_trace.h                 |  25 ++++
fs/xfs/xfs_trans_ail.c             |   2 +-
21 files changed, 556 insertions(+), 322 deletions(-)
