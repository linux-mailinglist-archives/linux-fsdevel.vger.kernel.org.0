Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE562BD005
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfIXRCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 13:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfIXRCt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:02:49 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFE620673;
        Tue, 24 Sep 2019 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569344568;
        bh=hKUJRk7QMuhzcgsjkjUUakju3zdnETRA3LHzs2tBu7E=;
        h=Date:From:To:Cc:Subject:From;
        b=F0fcM2yk9NZNZbOS6LAuxm9OivSaXSahX2/DCEbqrSxZOzv4wE9pTUpYs5Q8GDnXT
         S2NL4KHleHKltdp4qgFeb+e0c0qehI2XxwReFJtHAOQ7bwowJA4Bcq5SNHf38cpF19
         18iDiiZLLHOj+3HYzBYBZAwrGdPKH3aSDEP/19+E=
Date:   Tue, 24 Sep 2019 10:02:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Subject: [GIT PULL] iomap: (far less) new code for 5.4
Message-ID: <20190924170248.GZ2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this series containing all the new iomap code for 5.4.
After last week's failed pull request attempt, I scuttled everything in
the branch except for the directio endio api changes, which were
trivial.  Everything else will simply have to wait for the next cycle.

The branch merges cleanly against this morning's HEAD and survived a
week's worth of xfstests.  The merge was completely straightforward, so
please let me know if you run into anything weird.

--D

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.4-merge-6

for you to fetch changes up to 838c4f3d7515efe9d0e32c846fb5d102b6d8a29d:

  iomap: move the iomap_dio_rw ->end_io callback into a structure (2019-09-19 15:32:45 -0700)

----------------------------------------------------------------
New code for 5.4:
- Report both io errors and short io results to the directio endio
  handler.
- Allow directio callers to pass an ops structure to iomap_dio_rw.

----------------------------------------------------------------
Christoph Hellwig (1):
      iomap: move the iomap_dio_rw ->end_io callback into a structure

Matthew Bobrowski (1):
      iomap: split size and error for iomap_dio_rw ->end_io

 fs/iomap/direct-io.c  | 24 ++++++++++--------------
 fs/xfs/xfs_file.c     | 14 ++++++++++----
 include/linux/iomap.h | 10 +++++++---
 3 files changed, 27 insertions(+), 21 deletions(-)
