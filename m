Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8809495417
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 19:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346893AbiATSUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 13:20:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52248 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347496AbiATSUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:20:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAC86B81D84;
        Thu, 20 Jan 2022 18:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F3FC340E0;
        Thu, 20 Jan 2022 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642702839;
        bh=8fdxfst3ycYwM4HdtXKC1Zd0zG9g+8M9vAbEwluGCDE=;
        h=Date:From:To:Cc:Subject:From;
        b=D4qDLNWB+TJ7l7WzJbI+X72BjTRhu8ELUauQKLsKda2aFYhrtCJLA/wOBc5zfUvjk
         Yoo7INXvhnCYso3M8yUn9vGLn13dN80ZIIOxiRgKjatoRhBUrGMF1fBtY9g7cUuKMs
         13pq5zueUoojdYTk5YDNlBEEhme0QQHLuQJRkrBoRD+gy0MfRP5GwwKpFVAdYNNH8X
         dIS5tVnpnxwepz6NtIHID/FyyOzJTnIR+5SfQ9nlyJu2AF8vwcR/SXGB1ENGcQwvwF
         ugfIZtR+HChxPMzfcAomaxSaAAgZVyTV3VH/U8fyyXa0Zbjho3WXvSn7bGGBSbhETn
         wPp1nexGTN1vA==
Date:   Thu, 20 Jan 2022 10:20:39 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: DMAPI ioctl housecleaning for 5.17-rc1
Message-ID: <20220120182039.GN13540@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

This is the first of a series of small pull requests that perform some
long overdue housecleaning of XFS ioctls.  This first pull request
removes the FSSETDM ioctl, which was used to set DMAPI event attributes
on XFS files.  The DMAPI support has never been merged upstream and the
implementation of FSSETDM itself was removed two years ago, so let's
withdraw it completely.

As usual, I did a test-merge with upstream master as of a few minutes
ago and didn't see any merge conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 4a9bca86806fa6fc4fbccf050c1bd36a4778948a:

  xfs: fix online fsck handling of v5 feature bits on secondary supers (2022-01-12 09:45:21 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-4

for you to fetch changes up to 9dec0368b9640c09ef5af48214e097245e57a204:

  xfs: remove the XFS_IOC_FSSETDM definitions (2022-01-17 09:16:40 -0800)

----------------------------------------------------------------
Withdraw the ioctl definition for the FSSETDM ioctl.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: remove the XFS_IOC_FSSETDM definitions

 fs/xfs/libxfs/xfs_fs.h | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)
