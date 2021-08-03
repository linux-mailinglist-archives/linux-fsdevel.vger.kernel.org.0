Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613263DF369
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhHCRBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 13:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237643AbhHCRA1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:00:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15DC661029;
        Tue,  3 Aug 2021 17:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628010011;
        bh=rDiK4WjxXKf9xLf6dccyHcyChbj8zc/HNGGLZBDVCtc=;
        h=Date:From:To:Cc:Subject:From;
        b=MWu5TwArWUo9SwUK1Jse2e0Z3Nrap+uB8JT1yUPmkvTER0Zi9t/dU9557locZe+d/
         oc/j/O98URnKtSN6bnhJTOpBhgAfspVSsRFn1oK/W5hT1vrcrj+QydkeDobpV4tDID
         Xy04ugvOidN3WEj11LVyuDLynPigb3poUfiQIXLv+Aig3wWa/E500yzGVGnLtWaNep
         1XdpQZT9Q7JaFAw0H2S0GH+a7ts6qiPy6HlFhKaBZPBxQ78nBcz62MK39I/nLUB7Al
         wtyeVXtCSa9kFf5rAKOeiLQ/HKiwEvIcCInwizZ4hBpK/yDZG3aA2685FxrtozPukz
         mMlVJuQHzFoJA==
Date:   Tue, 3 Aug 2021 10:00:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-5.15-merge updated to f1f264b4c134
Message-ID: <20210803170010.GE3601405@magnolia>
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
the next update.

The new head of the iomap-5.15-merge branch is commit:

f1f264b4c134 iomap: Fix some typos and bad grammar

New Commits:

Andreas Gruenbacher (1):
      [f1f264b4c134] iomap: Fix some typos and bad grammar

Christoph Hellwig (2):
      [d0364f9490d7] iomap: simplify iomap_readpage_actor
      [c1b79f11f4ec] iomap: simplify iomap_add_to_ioend

Gao Xiang (1):
      [69f4a26c1e0c] iomap: support reading inline data from non-zero pos

Matthew Wilcox (Oracle) (1):
      [b405435b419c] iomap: Support inline data with block size < page size


Code Diffstat:

 fs/iomap/buffered-io.c | 157 +++++++++++++++++++++++++------------------------
 fs/iomap/direct-io.c   |  10 ++--
 include/linux/iomap.h  |  18 ++++++
 3 files changed, 103 insertions(+), 82 deletions(-)
