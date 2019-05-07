Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDB1669E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 17:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfEGPYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 11:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfEGPYc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 11:24:32 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CC820578;
        Tue,  7 May 2019 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557242671;
        bh=ToU2kpbHG/+to4t9z5CCHvUa2rGkhrtoLNWhIuujHvc=;
        h=Date:From:To:Cc:Subject:From;
        b=1Mf7MCIqg/t7D00A8YxZvqyEX8dx7zQBve9p64kOHhbjGQT3TSgy3BJz4Fjin9Z57
         1B30hGaWj7MxqnYe/mcMnJYiLTfB+bLCHjRqbTuHo70ezcx6pzufAZOtCZf8RKDXDI
         jlchPPn977yqX1EDeWrKohTEcmJGGUVPD4zfZt5M=
Date:   Tue, 7 May 2019 08:24:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Subject: [GIT PULL] iomap: cleanups and enhancements for 5.2
Message-ID: <20190507152430.GB1473023@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here are some patches for the iomap code for 5.2.  Nothing particularly
exciting here, just adding some callouts for gfs2 and cleaning a few
things.  It merges cleanly against this morning's HEAD and survived an
overnight run of xfstests.  Let me know if you run into anything weird.

--D

The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.2-merge-2

for you to fetch changes up to cbbf4c0be8a725f08153949f45a85b2adafbbbd3:

  iomap: move iomap_read_inline_data around (2019-05-01 20:16:40 -0700)

----------------------------------------------------------------
Changes for Linux 5.2:
- Add some extra hooks to the iomap buffered write path to enable gfs2
  journalled writes.
- SPDX conversion
- Various refactoring.

----------------------------------------------------------------
Andreas Gruenbacher (3):
      fs: Turn __generic_write_end into a void function
      iomap: Fix use-after-free error in page_done callback
      iomap: Add a page_prepare callback

Christoph Hellwig (3):
      iomap: convert to SPDX identifier
      iomap: Clean up __generic_write_end calling
      iomap: move iomap_read_inline_data around

 fs/buffer.c           |   8 ++--
 fs/gfs2/bmap.c        |  15 +++++---
 fs/internal.h         |   2 +-
 fs/iomap.c            | 105 +++++++++++++++++++++++++++-----------------------
 include/linux/iomap.h |  22 ++++++++---
 5 files changed, 88 insertions(+), 64 deletions(-)
