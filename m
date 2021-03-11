Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63418337B58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 18:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCKRrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 12:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhCKRra (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:47:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29D1864E77;
        Thu, 11 Mar 2021 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615484850;
        bh=CUpOtfHKdUUcy/1c7hi0EkO0Isi78+jkwbojfh+uXIs=;
        h=Date:From:To:Subject:From;
        b=QUXlWx5vvxEk74wiuUQkDaNYPD6hLHBP4uSAUmERR7ThANciUVjqEBw10PoiWKXfm
         CWnMIAbsDMXYW4dcALi6D7PBSH77vKwG5pJKZsri/iP4ThFAkMTgE3YtRPfvwX3JFl
         8qIsidcLKFSdw8tlSs8/Q2oIPnK6cvmX41UlMyUrukfD5ryvmodoUmi+j+FQrPNOQ9
         zbAV1oLJy8p25VUyGXDxuCqiuVFIWJeV+ZQ2tkRL9ySoywwLpevUR4MWoW7eUbKDEC
         VTiR7zlqqPtYfqjzHVoaX6SCj2avg2DEdPCntifRSK7XLYCImCxOhe5AGeOp/02sWx
         ZsnzQf91FE8bQ==
Date:   Thu, 11 Mar 2021 09:47:29 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 5808fecc5723
Message-ID: <20210311174729.GA8425@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-for-next branch is commit:

5808fecc5723 iomap: Fix negative assignment to unsigned sis->pages in iomap_swapfile_activate

New Commits:

Ritesh Harjani (1):
      [5808fecc5723] iomap: Fix negative assignment to unsigned sis->pages in iomap_swapfile_activate


Code Diffstat:

 fs/iomap/swapfile.c | 10 ++++++++++
 1 file changed, 10 insertions(+)
