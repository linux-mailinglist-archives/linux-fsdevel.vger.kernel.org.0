Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD044C53C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 06:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiBZFE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 00:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBZFE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 00:04:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA191A363A;
        Fri, 25 Feb 2022 21:04:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F6A960ACB;
        Sat, 26 Feb 2022 05:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAA0C340E9;
        Sat, 26 Feb 2022 05:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645851862;
        bh=vxpA8Z0m1mTNaF9SKN3WRIDhB9TzV1mdR7CazXGdyok=;
        h=Date:From:To:Cc:Subject:From;
        b=upzyy+wW0JCdxVM9O+cJZ0apbAGK1fjaMWX5aa0cqSVPBERb7SVcmS60fDhEx25F+
         ioWMgCHscNhg5SHXhZSrMVmw1pOXWU1x6KxuT09TOS9EipXSDK+QnrfkIm78DvwC3C
         GymcvYpCXcXgkeSvOiHENkBPKoqTpMhCheRu7j6BbgY6i9X0AHFmm3K2DUKuUeEYyI
         3k3LJofU3Oi/k85JrOVFCQieoWM4hApOqMHG7l+LDAn+2TD47HNzZdJ3L4Y8iF0KKh
         +bW7akVICdt3wRGuLkdFolKDK/qbxtQeNzEYgWmK1pBKkCB+JE7sI9hEOA3DkNEn81
         orA2vtSAeN5lg==
Date:   Fri, 25 Feb 2022 21:04:21 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.17-rc6
Message-ID: <20220226050421.GZ8313@magnolia>
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

Hi Linus,

Please pull this branch containing bug fixes for XFS for 5.17-rc6.
There's nothing exciting, just more fixes for not returning
sync_filesystem error values (and eliding it when it's not necessary).

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit cea267c235e1b1ec3bfc415f6bd420289bcb3bc9:

  xfs: ensure log flush at the end of a synchronous fallocate call (2022-02-01 14:14:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-fixes-2

for you to fetch changes up to b97cca3ba9098522e5a1c3388764ead42640c1a5:

  xfs: only bother with sync_filesystem during readonly remount (2022-02-09 21:07:24 -0800)

----------------------------------------------------------------
Bug fixes for 5.17-rc4:
 - Only call sync_filesystem when we're remounting the filesystem
   readonly readonly, and actually check its return value.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: only bother with sync_filesystem during readonly remount

 fs/xfs/xfs_super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
