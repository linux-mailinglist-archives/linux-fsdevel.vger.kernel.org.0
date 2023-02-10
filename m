Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA1F692434
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 18:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjBJRNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 12:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjBJRNK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:13:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47CF7A7E1;
        Fri, 10 Feb 2023 09:12:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDA9BB825AB;
        Fri, 10 Feb 2023 17:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CA4C433EF;
        Fri, 10 Feb 2023 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676049148;
        bh=dSrYgfvAVtR0ZuT/0xfZYM/PLUJUYwO3aMXAgAkHBtg=;
        h=Date:From:To:Cc:Subject:From;
        b=uY+Ry98xhdMGnIUrnxErFsxBVYY6/6AMQw6IjWUtfmwlnh578+20eNilQs74fqd75
         HVQim0R1enSJN5KYSGTIHe6G91ArtsMAqAzFppmS5/dy7na94H/IDdbC2Fl/8zqIqk
         rE3R68d++mTw/rF1byjkSQyKnxkql0Db8KHnwivlr0n+tIV2cT9l6eUSBPzeYOCG2m
         A36OlZr2LmKRBKChwLQ1o6rBXUaxztqc2qq8r9F/E+enEfZ7awPitJ+3w6WZsiBGQ0
         pckhrOjje/NqqmqbHi2mblb3bV17npkGXwVW8gIn5lia4YTAOgcSIoVM2JOJ7Fjfbw
         9HNBAbzTu1hPQ==
Date:   Fri, 10 Feb 2023 09:12:28 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, ddouwsma@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux@weissschuh.net,
        syzbot+898115bc6d7140437215@syzkaller.appspotmail.com,
        xu.panda@zte.com.cn, yang.yang29@zte.com.cn
Subject: [ANNOUNCE] xfs-linux: for-next updated to dd07bb8b6baf
Message-ID: <167604902064.3012541.14843121291940068102.stg-ugh@magnolia>
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
the next update.  This push adds a couple of patches that have trickled
in, and reverts the broken strscpy thing.  I'll think about Dave's
lengthy allocator rework next week after fstestscloud finishes with it.

The new head of the for-next branch is commit:

dd07bb8b6baf xfs: revert commit 8954c44ff477

13 new commits:

Darrick J. Wong (9):
[ddccb81b26ec] xfs: pass the xfs_bmbt_irec directly through the log intent code
[f3ebac4c94c1] xfs: fix confusing variable names in xfs_bmap_item.c
[72ba455599ad] xfs: pass xfs_extent_free_item directly through the log intent code
[578c714b215d] xfs: fix confusing xfs_extent_item variable names
[1534328bb427] xfs: pass rmap space mapping directly through the log intent code
[ffaa196f6221] xfs: fix confusing variable names in xfs_rmap_item.c
[0b11553ec54a] xfs: pass refcount intent directly through the log intent code
[01a3af226b7d] xfs: fix confusing variable names in xfs_refcount_item.c
[dd07bb8b6baf] xfs: revert commit 8954c44ff477

Dave Chinner (1):
[c85007e2e394] xfs: don't use BMBT btree split workers for IO completion

Donald Douwsma (1):
[167ce4cbfa37] xfs: allow setting full range of panic tags

Thomas Weiﬂschuh (1):
[2ee833352985] xfs: make kobj_type structures constant

Xu Panda (1):
[8954c44ff477] xfs: use strscpy() to instead of strncpy()

Code Diffstat:

Documentation/admin-guide/xfs.rst |   2 +-
fs/xfs/libxfs/xfs_alloc.c         |  32 ++++-----
fs/xfs/libxfs/xfs_bmap.c          |  32 ++++-----
fs/xfs/libxfs/xfs_bmap.h          |   5 +-
fs/xfs/libxfs/xfs_btree.c         |  18 ++++-
fs/xfs/libxfs/xfs_refcount.c      |  96 ++++++++++++--------------
fs/xfs/libxfs/xfs_refcount.h      |   4 +-
fs/xfs/libxfs/xfs_rmap.c          |  52 +++++++-------
fs/xfs/libxfs/xfs_rmap.h          |   6 +-
fs/xfs/xfs_bmap_item.c            | 137 ++++++++++++++++--------------------
fs/xfs/xfs_error.c                |   2 +-
fs/xfs/xfs_error.h                |  12 +++-
fs/xfs/xfs_extfree_item.c         |  99 +++++++++++++-------------
fs/xfs/xfs_globals.c              |   3 +-
fs/xfs/xfs_refcount_item.c        | 110 ++++++++++++++---------------
fs/xfs/xfs_rmap_item.c            | 142 ++++++++++++++++++--------------------
fs/xfs/xfs_sysfs.c                |  12 ++--
fs/xfs/xfs_sysfs.h                |  10 +--
fs/xfs/xfs_trace.h                |  15 ++--
19 files changed, 377 insertions(+), 412 deletions(-)
