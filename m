Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A77496914
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jan 2022 02:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiAVBIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 20:08:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41544 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiAVBII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:08:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313CC61A51;
        Sat, 22 Jan 2022 01:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894A2C340E1;
        Sat, 22 Jan 2022 01:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642813687;
        bh=f9nzyluFJ8M82ikvyQwK1d+zkmtgOnVsNbb6WktqI+I=;
        h=Date:From:To:Cc:Subject:From;
        b=r57AwOIEYM7jTOQoJo3qdJjJpnlPplkLZmY6lhw0smep+o63Zwppz6bX0HlsoySNR
         7xWW4FpbKBGdc6muDVERe3qvDQ/NFOkOKKL3bYmX38sT/SXZZpqJ7Z+8m+D8KM69Xw
         ecaLMqLZKEBpvZGKJgwtSf6muf75PIZ25RZylvRu9P6bftkJ6MJZD5uO3GzqcSLL4/
         ja0OF3i+97Z+FxgjbSp8qTsmm7MJbI2ZHVKXwVsUTOpp/PcP3zOnjFlNA1ziTOMOhB
         rlda+uuw5F7z4FXceN1mA1Tc+VNpN/5m9PNk+G/9YrfSxF0M2iS+ifzqXCOwVtpz81
         6YlRFGIJnuKRQ==
Date:   Fri, 21 Jan 2022 17:08:07 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.17-rc1
Message-ID: <20220122010807.GT13540@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch of minor corrections for 5.17-rc1.  One of the
patches removes some dead code from xfs_ioctl32.h and the other fixes
broken workqueue flushing in the inode garbage collector.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit b3bb9413e717b44e4aea833d07f14e90fb91cf97:

  xfs: remove the XFS_IOC_{ALLOC,FREE}SP* definitions (2022-01-17 09:17:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-7

for you to fetch changes up to 6191cf3ad59fda5901160633fef8e41b064a5246:

  xfs: flush inodegc workqueue tasks before cancel (2022-01-19 14:58:26 -0800)

----------------------------------------------------------------
New code for 5.17:
- Minor cleanup of ioctl32 cruft
- Clean up open coded inodegc workqueue function calls

----------------------------------------------------------------
Brian Foster (1):
      xfs: flush inodegc workqueue tasks before cancel

Darrick J. Wong (1):
      xfs: remove unused xfs_ioctl32.h declarations

 fs/xfs/xfs_icache.c  | 22 ++++------------------
 fs/xfs/xfs_ioctl32.h | 18 ------------------
 2 files changed, 4 insertions(+), 36 deletions(-)
