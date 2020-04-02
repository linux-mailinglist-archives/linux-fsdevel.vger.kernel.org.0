Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C219C6BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbgDBQH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 12:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388972AbgDBQH5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:07:57 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 709A02063A;
        Thu,  2 Apr 2020 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585843676;
        bh=pZjm/1Qvu4RLX44Z2RQzPe+xLwWY2hDAJm1DbeLQaTI=;
        h=Date:From:To:Cc:Subject:From;
        b=2ZvDib7Xqc8MpjEQFSnN/noANaOgBb3M5FQHcUGhc1oVm9XJo1+9sL684Yx2GmGyn
         L9vhztP8mQZqVcdqm0+okJMU6RH6ohm1pVvS8quS62uglIu7NtV6V0tEEsnM4vFQQi
         W4zklR5YMZ3GMyl9AL+WyeFqgdPsxrHGRa5+8NK4=
Date:   Thu, 2 Apr 2020 09:07:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] iomap: new code for 5.7
Message-ID: <20200402160756.GA56932@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this set of new code for 5.7.  We're fixing tracepoints and
comments in this cycle, so there shouldn't be any surprises here.  I
performed a test merge just now and everything went smoothly.

I anticipate sending a second pull request next week with a single bug
fix for readahead, but it's still undergoing QA.

--D

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.7-merge-2

for you to fetch changes up to d9973ce2fe5bcdc5e01bb3f49833d152b8e166ca:

  iomap: fix comments in iomap_dio_rw (2020-03-18 08:04:36 -0700)

----------------------------------------------------------------
New iomap code for 5.7:
- Fix a broken tracepoint
- Fix a broken comment

----------------------------------------------------------------
Matthew Wilcox (Oracle) (1):
      iomap: Remove pgoff from tracepoints

yangerkun (1):
      iomap: fix comments in iomap_dio_rw

 fs/iomap/buffered-io.c |  7 ++++---
 fs/iomap/direct-io.c   |  4 ++--
 fs/iomap/trace.h       | 27 +++++++++++----------------
 3 files changed, 17 insertions(+), 21 deletions(-)
