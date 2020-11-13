Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521D62B2911
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 00:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKMXRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 18:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgKMXRj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:17:39 -0500
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F3D22256;
        Fri, 13 Nov 2020 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605309459;
        bh=2XOh4pb6uuRXC6Zuyb7xU9XGCXN5/4bSE/uVEYrDgUI=;
        h=Date:From:To:Cc:Subject:From;
        b=A7lC11FVJb9ocX7GbGW4dccTZQqkrnfII3I/4H6oE6WZZB5O/FmTinTaUxPYOLSla
         d12mLfHyAx9C41CCORHOJWl+ion79kA6C/JQtFUcc22t0rc3Nds6WLMXtglQqR3JME
         qIykUcmCtX7/a1Kad+9iTWyi2Sz3IE3KzTGAt5VI=
Date:   Fri, 13 Nov 2020 15:17:38 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.10-rc4
Message-ID: <20201113231738.GX9695@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing a few more bug fixes for 5.10.  I'm
going to have a couple more fixes for you some time next week.

The branch merges cleanly with upstream as of a few minutes ago, so
please let me know if anything strange happens.

--D

The following changes since commit 46afb0628b86347933b16ac966655f74eab65c8c:

  xfs: only flush the unshared range in xfs_reflink_unshare (2020-11-04 17:41:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-fixes-5

for you to fetch changes up to 2bd3fa793aaa7e98b74e3653fdcc72fa753913b5:

  xfs: fix a missing unlock on error in xfs_fs_map_blocks (2020-11-11 08:07:37 -0800)

----------------------------------------------------------------
Fixes for 5.10-rc4:
- Fix a fairly serious problem where the reverse mapping btree key
comparison functions were silently ignoring parts of the keyspace when
doing comparisons.
- Fix a thinko in the online refcount scrubber.
- Fix a missing unlock in the pnfs code.

----------------------------------------------------------------
Christoph Hellwig (1):
      xfs: fix a missing unlock on error in xfs_fs_map_blocks

Darrick J. Wong (4):
      xfs: fix flags argument to rmap lookup when converting shared file rmaps
      xfs: set the unwritten bit in rmap lookup flags in xchk_bmap_get_rmapextents
      xfs: fix rmap key and record comparison functions
      xfs: fix brainos in the refcount scrubber's rmap fragment processor

 fs/xfs/libxfs/xfs_rmap.c       |  2 +-
 fs/xfs/libxfs/xfs_rmap_btree.c | 16 ++++++++--------
 fs/xfs/scrub/bmap.c            |  2 ++
 fs/xfs/scrub/refcount.c        |  8 +++-----
 fs/xfs/xfs_pnfs.c              |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)
