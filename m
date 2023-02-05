Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAEA68B111
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 18:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBERLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 12:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBERLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 12:11:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FAD18AB5;
        Sun,  5 Feb 2023 09:11:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7073160B97;
        Sun,  5 Feb 2023 17:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F94C433EF;
        Sun,  5 Feb 2023 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675617092;
        bh=H9sWkZXnwmhlHUyqD3faF/Ugb/YsbBE3hdJqCnU0mvA=;
        h=Date:From:To:Cc:Subject:From;
        b=LObR9Gl/ffQUI3Wy3/RX9p4NbeFHWEnZLMT9YLDlUwQIIv0FbYYG6uCSuP/R70ydk
         VS0nede13Y2kDPbenJS+xad9MlG+u/pGY74/BpKjELFptiKdBq/HAsbHybGeUYY4Dv
         anhaSvPc2axJfXPFPfKoocM+uONF6Saeb3qwdjwYVW+MlBzBiyGkUoFkvDN4t19+ak
         kK0LiqHaATLuW9X6cQjzvA94AbK+Fp+FK0S4CVWM5JxMkec9hf1tjHqZDTxu4+qPom
         xX47PhAB26mdy6cBQFRegFmV2tX3YANe1ND67kppwhg6Tk4Tvz1gUFdmK/XNHHil/4
         USoHO8/npptsQ==
Date:   Sun, 5 Feb 2023 09:11:32 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, xu.panda@zte.com.cn,
        yang.yang29@zte.com.cn
Subject: [ANNOUNCE] xfs-linux: for-next updated to c85007e2e394
Message-ID: <167561660451.2288973.14377090401939067406.stg-ugh@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
the next update.  There's one bug fix and a number of cleanups here.  I
merged the first patchset in the online fsck series because all it does
is rename variables and push pointer arguments down to reduce argument
boxing and unboxing, and I wanted to make forward progress despite staff
time being severely limited in January due to new years, sickness, etc.

Dave's very large allocator rework is still pending.  It mostly looked
good, though I had a few minor questions and comprehension checks.
Seeing as we're about to pass -rc7 I hope that gets done soon.

The new head of the for-next branch is commit:

c85007e2e394 xfs: don't use BMBT btree split workers for IO completion

10 new commits:

Darrick J. Wong (8):
[ddccb81b26ec] xfs: pass the xfs_bmbt_irec directly through the log intent code
[f3ebac4c94c1] xfs: fix confusing variable names in xfs_bmap_item.c
[72ba455599ad] xfs: pass xfs_extent_free_item directly through the log intent code
[578c714b215d] xfs: fix confusing xfs_extent_item variable names
[1534328bb427] xfs: pass rmap space mapping directly through the log intent code
[ffaa196f6221] xfs: fix confusing variable names in xfs_rmap_item.c
[0b11553ec54a] xfs: pass refcount intent directly through the log intent code
[01a3af226b7d] xfs: fix confusing variable names in xfs_refcount_item.c

Dave Chinner (1):
[c85007e2e394] xfs: don't use BMBT btree split workers for IO completion

Xu Panda (1):
[8954c44ff477] xfs: use strscpy() to instead of strncpy()

Code Diffstat:

fs/xfs/libxfs/xfs_alloc.c    |  32 +++++-----
fs/xfs/libxfs/xfs_bmap.c     |  32 +++++-----
fs/xfs/libxfs/xfs_bmap.h     |   5 +-
fs/xfs/libxfs/xfs_btree.c    |  18 +++++-
fs/xfs/libxfs/xfs_refcount.c |  96 +++++++++++++----------------
fs/xfs/libxfs/xfs_refcount.h |   4 +-
fs/xfs/libxfs/xfs_rmap.c     |  52 ++++++++--------
fs/xfs/libxfs/xfs_rmap.h     |   6 +-
fs/xfs/xfs_bmap_item.c       | 137 ++++++++++++++++++-----------------------
fs/xfs/xfs_extfree_item.c    |  99 ++++++++++++++++--------------
fs/xfs/xfs_refcount_item.c   | 110 +++++++++++++++------------------
fs/xfs/xfs_rmap_item.c       | 142 +++++++++++++++++++++----------------------
fs/xfs/xfs_trace.h           |  15 ++---
fs/xfs/xfs_xattr.c           |   4 +-
14 files changed, 352 insertions(+), 400 deletions(-)
