Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633E43F1E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhHSRBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 13:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhHSRBR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:01:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64DEE601FD;
        Thu, 19 Aug 2021 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629392435;
        bh=M5BHfHJAkSSmZv02eYuhcGz0ph/ujZ0I7tv9sqoTvn0=;
        h=Date:From:To:Cc:Subject:From;
        b=dk6vzXfy4+/XH9+NGId3DZJtJz5vYpcnNAiRIsnZS0Ug4w0ImgKt+WhWJKqc02sWG
         mBZ4j5KEpNnlc79GHSKIlPZ7qRFD9vCG0rqJK+V95Nh8cnINhRSTLbv5B+7Q7sIoup
         xnBkCiIM1T/vA14ltE2vXN3weQfIPN4N293wlXLiZWYqDlTahZXdDWvQgfx89/gxR8
         LuAaFVHFFaNPRPjHpvEBmKcPzhx37NePBVnsQfCDCbWLW5H0HNd7SujcE+S6+p41mz
         Vk+FQce63xBmrSgtiW3f/M6XA2wggJ1K74oGKN0RFuPwLrknzclsr4KlGt5Jvo+XvC
         9p7P2BgwFbCKw==
Date:   Thu, 19 Aug 2021 10:00:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>, xuyu@linux.alibaba.com
Subject: [ANNOUNCE] xfs-linux: iomap-5.15-merge updated to 742dd4b8c5bb
Message-ID: <20210819170034.GS12640@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.15-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  I decided to merge the iomap_iter conversion because
it doesn't change any of the exported apis.  Bugfixes notwithstanding,
I think this is it for 5.15.

The new head of the iomap-5.15-merge branch is commit:

742dd4b8c5bb mm/swap: consider max pages in iomap_swapfile_add_extent

New Commits:

Andreas Gruenbacher (1):
      [f1f264b4c134] iomap: Fix some typos and bad grammar

Christoph Hellwig (30):
      [d0364f9490d7] iomap: simplify iomap_readpage_actor
      [c1b79f11f4ec] iomap: simplify iomap_add_to_ioend
      [d9d381f3ef5b] iomap: fix a trivial comment typo in trace.h
      [1d25d0aecfcd] iomap: remove the iomap arguments to ->page_{prepare,done}
      [66b8165ed4b5] iomap: mark the iomap argument to iomap_sector const
      [4495c33e4d30] iomap: mark the iomap argument to iomap_inline_data const
      [e3c4ffb0c221] iomap: mark the iomap argument to iomap_inline_data_valid const
      [6d49cc8545e9] fs: mark the iomap argument to __block_write_begin_int const
      [7e4f4b2d689d] fsdax: mark the iomap argument to dax_iomap_sector as const
      [78c64b00f842] iomap: mark the iomap argument to iomap_read_inline_data const
      [1acd9e9c015b] iomap: mark the iomap argument to iomap_read_page_sync const
      [740499c78408] iomap: fix the iomap_readpage_actor return value for inline data
      [f4b896c213f0] iomap: add the new iomap_iter model
      [f6d480006cea] iomap: switch readahead and readpage to use iomap_iter
      [ce83a0251c6e] iomap: switch iomap_file_buffered_write to use iomap_iter
      [8fc274d1f4b4] iomap: switch iomap_file_unshare to use iomap_iter
      [2aa3048e03d3] iomap: switch iomap_zero_range to use iomap_iter
      [253564bafff3] iomap: switch iomap_page_mkwrite to use iomap_iter
      [a6d3d49587d1] iomap: switch __iomap_dio_rw to use iomap_iter
      [7892386d3571] iomap: switch iomap_fiemap to use iomap_iter
      [6d8a1287a489] iomap: switch iomap_bmap to use iomap_iter
      [40670d18e878] iomap: switch iomap_seek_hole to use iomap_iter
      [c4740bf1edad] iomap: switch iomap_seek_data to use iomap_iter
      [3d99a1ce3854] iomap: switch iomap_swapfile_activate to use iomap_iter
      [ca289e0b95af] fsdax: switch dax_iomap_rw to use iomap_iter
      [57320a01fe1f] iomap: remove iomap_apply
      [1b5c1e36dc0e] iomap: pass an iomap_iter to various buffered I/O helpers
      [b74b1293e6ca] iomap: rework unshare flag
      [65dd814a6187] fsdax: switch the fault handlers to use iomap_iter
      [fad0a1ab34f7] iomap: constify iomap_iter_srcmap

Darrick J. Wong (2):
      [b69eea82d37d] iomap: pass writeback errors to the mapping
      [8d04fbe71fa0] iomap: move loop control code to iter.c

Gao Xiang (1):
      [69f4a26c1e0c] iomap: support reading inline data from non-zero pos

Matthew Wilcox (Oracle) (3):
      [b405435b419c] iomap: Support inline data with block size < page size
      [ab069d5fdcd1] iomap: Use kmap_local_page instead of kmap_atomic
      [ae44f9c286da] iomap: Add another assertion to inline data handling

Shiyang Ruan (2):
      [55f81639a715] fsdax: factor out helpers to simplify the dax fault code
      [c2436190e492] fsdax: factor out a dax_fault_actor() helper

Xu Yu (1):
      [742dd4b8c5bb] mm/swap: consider max pages in iomap_swapfile_add_extent


Code Diffstat:

 fs/btrfs/inode.c       |   5 +-
 fs/buffer.c            |   4 +-
 fs/dax.c               | 606 +++++++++++++++++++++++--------------------------
 fs/gfs2/bmap.c         |   5 +-
 fs/internal.h          |   4 +-
 fs/iomap/Makefile      |   2 +-
 fs/iomap/apply.c       |  99 --------
 fs/iomap/buffered-io.c | 508 ++++++++++++++++++++---------------------
 fs/iomap/direct-io.c   | 172 +++++++-------
 fs/iomap/fiemap.c      | 101 ++++-----
 fs/iomap/iter.c        |  80 +++++++
 fs/iomap/seek.c        |  98 ++++----
 fs/iomap/swapfile.c    |  44 ++--
 fs/iomap/trace.h       |  35 ++-
 include/linux/iomap.h  |  91 ++++++--
 15 files changed, 917 insertions(+), 937 deletions(-)
 delete mode 100644 fs/iomap/apply.c
 create mode 100644 fs/iomap/iter.c
