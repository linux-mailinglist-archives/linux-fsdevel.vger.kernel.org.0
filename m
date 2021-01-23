Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07459301808
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 20:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbhAWT3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jan 2021 14:29:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbhAWT3Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jan 2021 14:29:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DF9F2255F;
        Sat, 23 Jan 2021 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611430115;
        bh=ulxCc6m2jpL11hzDVgckgKNjpHVeM3WgcSjSQCzV6wk=;
        h=Date:From:To:Cc:Subject:From;
        b=C81R8tfDG/fN4y8zhO/QNk8zqOT1clwO/UwcLzQbndycYjB8G8JVc5c+Z1sYCdZ6l
         icjAJjHQotku8OEhpAhxpBvaxeiMm9b2a+4+lNJgOIFTZjk8+2/f8Y+uvhFqQyQsV8
         tjaOAB/Re0kVtyvcqPJOiooJAHTq8YiOmlxRMUs/J/USfXqb8Hkty4MpXDS7jNCAIf
         wdhIlp/dgm3LwWnAg5fBOHdLSQMuwFkzI2I8LfifXEq5+e+B/oWfA+C4ZAuuSMziBc
         VgEMTCBlTw9V+IhKzZDEDyQN0/qTRIR7MQR+AxJlU5Pt9sJbvP+J/9w+hCzuy2yAUA
         Z/aUuTRAYhbeQ==
Date:   Sat, 23 Jan 2021 11:28:35 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 213f627104da
Message-ID: <20210123192835.GA7692@magnolia>
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
the next update.  This branch contains only the three iomap patches
needed to support unaligned directio overwites without locking.

The new head of the iomap-for-next branch is commit:

213f627104da iomap: add a IOMAP_DIO_OVERWRITE_ONLY flag

New Commits:

Christoph Hellwig (3):
      [5724be5de88f] iomap: rename the flags variable in __iomap_dio_rw
      [2f63296578ca] iomap: pass a flags argument to iomap_dio_rw
      [213f627104da] iomap: add a IOMAP_DIO_OVERWRITE_ONLY flag


Code Diffstat:

 fs/btrfs/file.c       |  7 +++----
 fs/ext4/file.c        |  5 ++---
 fs/gfs2/file.c        |  7 ++-----
 fs/iomap/direct-io.c  | 26 ++++++++++++++++----------
 fs/xfs/xfs_file.c     |  5 ++---
 fs/zonefs/super.c     |  4 ++--
 include/linux/iomap.h | 18 ++++++++++++++++--
 7 files changed, 43 insertions(+), 29 deletions(-)
