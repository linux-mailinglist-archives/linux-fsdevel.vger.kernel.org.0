Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA0372E02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEDQ1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 12:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhEDQ1X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 12:27:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 881C261073;
        Tue,  4 May 2021 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620145588;
        bh=PVpCUjYTydL+RTJmDVTB5eDtZU1UGHDfwl9/8A5O8xA=;
        h=Date:From:To:Cc:Subject:From;
        b=M6JIzKR+b0fDMzJiA01klcK/MZPsHsjxtMs2ERHTkI86KVDmTQGGwzWRyjH+vAGYP
         aJzsDqsCjHI+AqN2ydxVo4eR3kHOA0OlNRpDMLSm/f2rbVwBZoMS6S3uhapBuMgmys
         TVq53hFHNePdRYVqNmtUGdVAHWKNfBEXN0/wI97MBcHO8N7pnThGHD0L9/TC9T5kYS
         VVrWMAvQdk0EHMHaYbvmAWt1m9z/vEO3AKGr9Eurs9ayiEQF9oAcNIbsRPC6PsMBfQ
         teNH0+AvU8pVyfl4oqkaeyxgf3PZApEvSwfn+AaeCYNLXOdNBx4THhTHHsRcHmGbC2
         RezLWo0bv0rhg==
Date:   Tue, 4 May 2021 09:26:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 6e552494fb90
Message-ID: <20210504162627.GA8582@magnolia>
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
the next update.  This is just removing io_private now that we're into
the second week of the merge window and nobody suddenly wanted to use
it.

The new head of the iomap-for-next branch is commit:

6e552494fb90 iomap: remove unused private field from ioend

New Commits:

Brian Foster (1):
      [6e552494fb90] iomap: remove unused private field from ioend


Code Diffstat:

 fs/iomap/buffered-io.c | 7 +------
 fs/xfs/xfs_aops.c      | 2 +-
 include/linux/iomap.h  | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)
