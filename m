Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2C55083C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 06:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiFSEO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 00:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFSEOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 00:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D064EE;
        Sat, 18 Jun 2022 21:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 786EB60F54;
        Sun, 19 Jun 2022 04:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE5FC34114;
        Sun, 19 Jun 2022 04:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655612061;
        bh=8swXHtNtUIz24MU/iY0uao3YyLZF/bZ9wAlFbPV4RuM=;
        h=Date:From:To:Cc:Subject:From;
        b=m4+JP5b57zGUQMLnlvBtWuCVqRlR32plZm9J5zxFcEJizx2m/Lk7UyruibZ71bVqR
         hhez7SE55eiUt8vpqfnh92gw81Zfb31HjY9FiuuSeS21lyhNz6JRR1t10h1MwGUMJC
         cr3J+1IklelyDm3fxXj6r7vWPDul292Lq82JSumvi0G8VolF4Dl6l8f+kkaEKnpEK4
         S8L6/pHzdayligFG1NcfZXz9NxNqRCe+VTmnag3zXm8MlR6IaWYcNdG7SKRa/4ycap
         coBO6v/Ml1dDCzm3xHBeH3X84W2zanc+gqTXnbHPNzb2LBuV4ai3AcBOeILwJ5QMh0
         aOdSmnj6K9A9w==
Date:   Sat, 18 Jun 2022 21:14:21 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, fstests <fstests@vger.kernel.org>
Subject: [GIT PULL] xfs: bug fixes for 5.19-rc3
Message-ID: <Yq6inbC6Y6YT0uGJ@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing bug fixes for XFS for 5.19-rc3.
There's not a whole lot this time around (I'm still on vacation) but
here are some important fixes for new features merged in -rc1.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and it completed flawlessly.  Please let me know if you encounter
any problems.

--D

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-fixes-1

for you to fetch changes up to e89ab76d7e2564c65986add3d634cc5cf5bacf14:

  xfs: preserve DIFLAG2_NREXT64 when setting other inode attributes (2022-06-15 23:13:33 -0700)

----------------------------------------------------------------
Fixes for 5.19-rc3:
 - Fix a bug where inode flag changes would accidentally drop nrext64.
 - Fix a race condition when toggling LARP mode.

----------------------------------------------------------------
Darrick J. Wong (3):
      xfs: fix TOCTOU race involving the new logged xattrs control knob
      xfs: fix variable state usage
      xfs: preserve DIFLAG2_NREXT64 when setting other inode attributes

 fs/xfs/libxfs/xfs_attr.c      |  9 +++++----
 fs/xfs/libxfs/xfs_attr.h      | 12 +-----------
 fs/xfs/libxfs/xfs_attr_leaf.c |  2 +-
 fs/xfs/libxfs/xfs_da_btree.h  |  4 +++-
 fs/xfs/xfs_attr_item.c        | 15 +++++++++------
 fs/xfs/xfs_ioctl.c            |  3 ++-
 fs/xfs/xfs_xattr.c            | 17 ++++++++++++++++-
 7 files changed, 37 insertions(+), 25 deletions(-)
