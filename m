Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21119F437
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgDFLOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 07:14:02 -0400
Received: from nautica.notk.org ([91.121.71.147]:36170 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgDFLOB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:14:01 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 07:14:00 EDT
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9C620C009; Mon,  6 Apr 2020 13:07:17 +0200 (CEST)
Date:   Mon, 6 Apr 2020 13:07:02 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: [GIT PULL] 9p update for 5.7
Message-ID: <20200406110702.GA13469@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Not much new, but a few patches for this cycle.

Thanks,
Dominique


The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-5.7

for you to fetch changes up to 43657496e46672fe63bccc1fcfb5b68de6e1e2f4:

  net/9p: remove unused p9_req_t aux field (2020-03-27 09:29:57 +0000)

----------------------------------------------------------------
9p pull request for inclusion in 5.7

- Fix read with O_NONBLOCK to allow incomplete read and return
immediately
- Rest is just cleanup (indent, unused field in struct, extra semicolon)

----------------------------------------------------------------
Dominique Martinet (1):
      net/9p: remove unused p9_req_t aux field

Krzysztof Kozlowski (1):
      9p: Fix Kconfig indentation

Sergey Alirzaev (2):
      9pnet: allow making incomplete read requests
      9p: read only once on O_NONBLOCK

zhengbin (1):
      9p: Remove unneeded semicolon

 fs/9p/Kconfig           |  18 +++++++++---------
 fs/9p/vfs_file.c        |   5 ++++-
 fs/9p/vfs_inode.c       |   2 +-
 include/net/9p/client.h |   4 ++--
 net/9p/client.c         | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------
 5 files changed, 94 insertions(+), 79 deletions(-)
