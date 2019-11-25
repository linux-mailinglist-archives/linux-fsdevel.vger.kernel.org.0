Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E96E108800
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 05:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKYEpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 23:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfKYEpF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 23:45:05 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2C42071A;
        Mon, 25 Nov 2019 04:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574657105;
        bh=aSroA1tJkkhrawkEnz+x1J5uQ7dP73E3kkFNwgxCrjc=;
        h=Date:From:To:Cc:Subject:From;
        b=xd6oamJw8cdBpyxa6Dqk9inUzve8hNxbG1AIZD2wMpTNYQ1rW/HtPYBrWv94WluWI
         phH34pvHnUTvLA9VsvUg3VpCVG/FBlpadA5cPHbsWRlRkw1/f/CZzBrvMjxlsTJzBm
         nJhcjw7jyYFZqyAiwy5RVmbNPr8nELP2Cg2b24iY=
Date:   Sun, 24 Nov 2019 20:45:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fsverity updates for 5.5
Message-ID: <20191125044503.GB9817@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to 73f0ec02d670a61afcef49bc0a74d42e324276ea:

  docs: fs-verity: mention statx() support (2019-11-13 12:15:34 -0800)

----------------------------------------------------------------

Expose the fs-verity bit through statx().

----------------------------------------------------------------
Eric Biggers (5):
      docs: fs-verity: document first supported kernel version
      statx: define STATX_ATTR_VERITY
      ext4: support STATX_ATTR_VERITY
      f2fs: support STATX_ATTR_VERITY
      docs: fs-verity: mention statx() support

 Documentation/filesystems/fsverity.rst | 12 ++++++++++--
 fs/ext4/inode.c                        |  5 ++++-
 fs/f2fs/file.c                         |  5 ++++-
 include/linux/stat.h                   |  3 ++-
 include/uapi/linux/stat.h              |  2 +-
 5 files changed, 21 insertions(+), 6 deletions(-)
