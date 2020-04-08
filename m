Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381441A24BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgDHPMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 11:12:32 -0400
Received: from nautica.notk.org ([91.121.71.147]:56749 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgDHPMb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:12:31 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D04B4C009; Wed,  8 Apr 2020 17:12:29 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:12:14 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] 9p update for 5.7
Message-ID: <20200408151214.GA30977@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406110702.GA13469@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

v2 of monday's pull request. The commit date is just now, but that is
just the documentation patch I applied, there is no code change since
the last version.

Thanks,
Dominique

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-5.7-2

for you to fetch changes up to c6f141412d24c8d8a9d98ef45303c0235829044b:

  9p: document short read behaviour with O_NONBLOCK (2020-04-08 17:05:28 +0200)

----------------------------------------------------------------
9p pull request for inclusion in 5.7 (take 2)

- Change read with O_NONBLOCK to allow incomplete read and return immediately
(and document it)
- Rest is just cleanup (indent, unused field in struct, extra semicolon)

----------------------------------------------------------------
Dominique Martinet (2):
      net/9p: remove unused p9_req_t aux field
      9p: document short read behaviour with O_NONBLOCK

Krzysztof Kozlowski (1):
      9p: Fix Kconfig indentation

Sergey Alirzaev (2):
      9pnet: allow making incomplete read requests
      9p: read only once on O_NONBLOCK

zhengbin (1):
      9p: Remove unneeded semicolon

 Documentation/filesystems/9p.txt |  10 +++++++++
 fs/9p/Kconfig                    |  18 ++++++++--------
 fs/9p/vfs_file.c                 |   5 ++++-
 fs/9p/vfs_inode.c                |   2 +-
 include/net/9p/client.h          |   4 ++--
 net/9p/client.c                  | 144  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------
 6 files changed, 104 insertions(+), 79 deletions(-)
