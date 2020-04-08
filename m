Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920781A268D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgDHP6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 11:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbgDHP6O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:58:14 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3292087E;
        Wed,  8 Apr 2020 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586361493;
        bh=KLd75C5Be35rlPJtDuMM34jf2E+oL936lM7axCW8aG4=;
        h=Date:From:To:Cc:Subject:From;
        b=u1pXD3gaZtsYla1aIsMCdluupyDVFvmq41qy6ba62DkTYsYLog/6xazjvJ5sk5GNr
         SuLSLoDmSs/lSIq34RAq2nMqRNlHetXuY7UdMk1+JFZuPEzvkIM8Cje/vWqZ6paoPi
         DRotM+nBnZLQtxDo+/KWDcP9VHvjLAXEziP1yWd0=
Date:   Wed, 8 Apr 2020 08:58:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] iomap: bug fix for 5.7
Message-ID: <20200408155813.GB6741@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this single iomap bug fix for 5.7 to prevent a crash when
memory is tight and readahead is going on.  It merged cleanly with
upstream head as of a few minutes ago.

--D

The following changes since commit d9973ce2fe5bcdc5e01bb3f49833d152b8e166ca:

  iomap: fix comments in iomap_dio_rw (2020-03-18 08:04:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.7-merge-3

for you to fetch changes up to 457df33e035a2cffc6561992f3f25a6c61605c46:

  iomap: Handle memory allocation failure in readahead (2020-04-02 09:08:53 -0700)

----------------------------------------------------------------
Bug fixes for 5.7:
- Fix a problem in readahead where we can crash if we can't allocate a
full bio due to GFP_NORETRY.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (1):
      iomap: Handle memory allocation failure in readahead

 fs/iomap/buffered-io.c | 8 ++++++++
 1 file changed, 8 insertions(+)
