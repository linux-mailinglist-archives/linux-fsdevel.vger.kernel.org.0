Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E848BBDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 01:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347210AbiALAbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 19:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347113AbiALAbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:31:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD561C06173F;
        Tue, 11 Jan 2022 16:31:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51406B81D6B;
        Wed, 12 Jan 2022 00:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1028EC36AE3;
        Wed, 12 Jan 2022 00:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641947460;
        bh=1W+J5ZF8So/ZYJAlHulAMkWgRAhRZIU/kA0xo95V/8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imijIEX2oW21715cS5Xv6YaftRcFAq3XNQAG/EykRJrilaxrBooE2Wod98SB72Rnz
         FZqncWON5nMqn6mKjslYaN+fLLHmLLDlLmQmSu/bVU2WXxyVMfXgfAjZfCHWuofRUH
         tK24FFoxxjaIdoxVuPtT2j0968HjcviUFEBnWl+mfTmQp43Fhy43t1rK+EFVvM04zc
         1u91afsfgNKQk4D4LeHTHsW5NanEMfwwAF28OATSJblMjNEFJ3VKmJhZMrFrs4ny06
         j9QoCxXZCdKNtp6wmxJUsZwhcxYut2AnDerrujExgEJ8OCeGaU1DHKF83u/w5uU3rB
         HRQd4awpME5Xg==
Date:   Tue, 11 Jan 2022 16:30:59 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [GIT PULL] iomap for 5.17
Message-ID: <20220112003059.GH398655@magnolia>
References: <YdyoN7RU/JMOk/lW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdyoN7RU/JMOk/lW@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 10, 2022 at 09:42:15PM +0000, Matthew Wilcox wrote:
> I know these requests usually come from Darrick, and we had intended
> that they would come that route.  Between the holidays and various
> things which Darrick needed to work on, he asked if I could send the
> pull request directly.  There weren't any other iomap patches pending
> for this release, which probably also played a role.

Just to confirm this explicitly -- yes, it really did transpire that
Matthew submitted the only iomap patches for 5.17, so I told him to go
ahead and send a pull request straight to Linus.

--D

> There is a conflict between this tree and the nvdimm tree.  We've done
> our best to make the resolution easy for you with the last patch in this
> series ("Inline __iomap_zero_iter into its caller").  If you'd rather just
> resolve the entire conflict yourself, feel free to drop that last patch.
> 
> The resolution Stephen has been carrying is here:
> https://lore.kernel.org/all/20211224172421.3f009baa@canb.auug.org.au/
> 
> The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:
> 
>   Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/willy/linux.git tags/iomap-5.17
> 
> for you to fetch changes up to 4d7bd0eb72e5831ddb1288786a96448b48440825:
> 
>   iomap: Inline __iomap_zero_iter into its caller (2021-12-21 13:51:08 -0500)
> 
> ----------------------------------------------------------------
> Convert xfs/iomap to use folios
> 
> This should be all that is needed for XFS to use large folios.
> There is no code in this pull request to create large folios, but
> no additional changes should be needed to XFS or iomap once they
> are created.
> 
> ----------------------------------------------------------------
> Matthew Wilcox (Oracle) (26):
>       block: Add bio_add_folio()
>       block: Add bio_for_each_folio_all()
>       fs/buffer: Convert __block_write_begin_int() to take a folio
>       iomap: Convert to_iomap_page to take a folio
>       iomap: Convert iomap_page_create to take a folio
>       iomap: Convert iomap_page_release to take a folio
>       iomap: Convert iomap_releasepage to use a folio
>       iomap: Add iomap_invalidate_folio
>       iomap: Pass the iomap_page into iomap_set_range_uptodate
>       iomap: Convert bio completions to use folios
>       iomap: Use folio offsets instead of page offsets
>       iomap: Convert iomap_read_inline_data to take a folio
>       iomap: Convert readahead and readpage to use a folio
>       iomap: Convert iomap_page_mkwrite to use a folio
>       iomap: Allow iomap_write_begin() to be called with the full length
>       iomap: Convert __iomap_zero_iter to use a folio
>       iomap: Convert iomap_write_begin() and iomap_write_end() to folios
>       iomap: Convert iomap_write_end_inline to take a folio
>       iomap,xfs: Convert ->discard_page to ->discard_folio
>       iomap: Simplify iomap_writepage_map()
>       iomap: Simplify iomap_do_writepage()
>       iomap: Convert iomap_add_to_ioend() to take a folio
>       iomap: Convert iomap_migrate_page() to use folios
>       iomap: Support large folios in invalidatepage
>       xfs: Support large folios
>       iomap: Inline __iomap_zero_iter into its caller
> 
>  Documentation/core-api/kernel-api.rst |   1 +
>  block/bio.c                           |  22 ++
>  fs/buffer.c                           |  23 +-
>  fs/internal.h                         |   2 +-
>  fs/iomap/buffered-io.c                | 551 +++++++++++++++++-----------------
>  fs/xfs/xfs_aops.c                     |  24 +-
>  fs/xfs/xfs_icache.c                   |   2 +
>  include/linux/bio.h                   |  56 +++-
>  include/linux/iomap.h                 |   3 +-
>  9 files changed, 389 insertions(+), 295 deletions(-)
> 
