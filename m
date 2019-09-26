Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59ABF65C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfIZQCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 12:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZQCJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:02:09 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5744021D6C;
        Thu, 26 Sep 2019 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569513728;
        bh=pLb8aNBNJnYhkQZMJEcK+pAhyHWfRv4gC8XSAJ97+2U=;
        h=Date:From:To:Cc:Subject:From;
        b=rZ2tDLAcwPwvxLZP0G+NGGlClvuf9/yRWzE+MkIBER3OQKlflqMO/F9YA/gHX2UPD
         98Wj8IeGgbS5d9tHCVf2RAY99kp2OuhCB/Vjik/Nk/FrXPQodL+bYrn1n4HeOm11ee
         +aXsvOifRkU8BdembYzhIk+aOoA+JzrYp5nGojc8=
Date:   Thu, 26 Sep 2019 09:02:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.4-rc1
Message-ID: <20190926160206.GB9916@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second set of changes for 5.4-rc1.  There are a couple
of bug fixes and some small code cleanups that came in recently.

It has survived a couple of days of xfstests runs and merges cleanly
with this morning's master.  Please let me know if anything strange
happens.

--D

The following changes since commit 14e15f1bcd738dc13dd7c1e78e4800e8bc577980:

  xfs: push the grant head when the log head moves forward (2019-09-05 21:36:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.4-merge-8

for you to fetch changes up to 88d32d3983e72f2a7de72a49b701e2529c48e9c1:

  xfs: avoid unused to_mp() function warning (2019-09-24 09:40:19 -0700)

----------------------------------------------------------------
Changes since last update:
- Minor code cleanups.
- Fix a superblock logging error.
- Ensure that collapse range converts the data fork to extents format
  when necessary.
- Revert the ALLOC_USERDATA cleanup because it caused subtle
  behavior regressions.

----------------------------------------------------------------
Aliasgar Surti (1):
      xfs: removed unneeded variable

Austin Kim (1):
      xfs: avoid unused to_mp() function warning

Brian Foster (1):
      xfs: convert inode to extent format after extent merge due to shift

Darrick J. Wong (1):
      xfs: revert 1baa2800e62d ("xfs: remove the unused XFS_ALLOC_USERDATA flag")

Eric Sandeen (1):
      xfs: log proper length of superblock

 fs/xfs/libxfs/xfs_alloc.h |  7 ++++---
 fs/xfs/libxfs/xfs_bmap.c  | 13 +++++++++++--
 fs/xfs/libxfs/xfs_sb.c    |  2 +-
 fs/xfs/scrub/alloc.c      |  3 +--
 fs/xfs/xfs_sysfs.c        | 13 -------------
 5 files changed, 17 insertions(+), 21 deletions(-)
