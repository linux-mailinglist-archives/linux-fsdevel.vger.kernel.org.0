Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA781DB8E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 23:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441398AbfJQVRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 17:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441370AbfJQVRk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:17:40 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A456821835;
        Thu, 17 Oct 2019 21:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571347059;
        bh=TRUimJkb9BIH+tvtj38jcgugc7QpvMg4Upv9UIIbvQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=TCHOCmAG6pfmMzIKN7YRoTc8oxZv0dWugvpCXH78CADUwSbWKWIof9hLnqsDO2JHh
         WC59PcVgDUh+1dnGqo60W3BjgHX0ROjf4vUU/6MUOPmU/q+t9kid7uBQdOlx8Z8D9u
         cDIpOLszUwqlqn7nG6VI/dx00R98OQNk3RhIv78g=
Date:   Thu, 17 Oct 2019 14:17:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.4-rc4
Message-ID: <20191017211739.GQ13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this set of changes for 5.4-rc4.  The only change converts
the seconds field in the recently added XFS bulkstat structure to a
signed 64-bit quantity.  The structure layout doesn't change and so far
there are no users of the ioctl to break because we only publish xfs
ioctl interfaces through the XFS userspace development libraries, and
we're still working on a 5.3 release.

The branch has survived a round of xfstests runs and merges cleanly with
this afternoon's master.  Please let me know if anything strange
happens.

--D

The following changes since commit aeea4b75f045294e1c026acc380466daa43afc65:

  xfs: move local to extent inode logging into bmap helper (2019-10-09 08:54:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.4-fixes-4

for you to fetch changes up to 5e0cd1ef64744e41e029dfca7d0ae285c486f386:

  xfs: change the seconds fields in xfs_bulkstat to signed (2019-10-15 08:46:07 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix a timestamp signedness problem in the new bulkstat ioctl.

----------------------------------------------------------------
Darrick J. Wong (1):
      xfs: change the seconds fields in xfs_bulkstat to signed

 fs/xfs/libxfs/xfs_fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
