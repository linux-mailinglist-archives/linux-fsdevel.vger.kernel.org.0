Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F0BBC33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 21:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfIWTVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 15:21:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36248 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfIWTVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:21:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCTu7-0000C1-H5; Mon, 23 Sep 2019 19:21:47 +0000
Date:   Mon, 23 Sep 2019 20:21:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] several more mount API conversions
Message-ID: <20190923192147.GC26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted conversions of options parsing to new API.
gfs2 is probably the most serious one here; the rest is
trivial stuff.  Other things in what used to be #work.mount
are going to wait for the next cycle (and preferably go via
git trees of the filesystems involved).

The following changes since commit 74983ac20aeafc88d9ceed64a8bf2a9024c488d5:

  vfs: Make fs_parse() handle fs_param_is_fd-type params better (2019-09-12 21:06:14 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount3

for you to fetch changes up to 1f52aa08d12f8d359e71b4bfd73ca9d5d668e4da:

  gfs2: Convert gfs2 to fs_context (2019-09-18 22:47:05 -0400)

----------------------------------------------------------------
Andrew Price (1):
      gfs2: Convert gfs2 to fs_context

David Howells (5):
      vfs: Convert bpf to use the new mount API
      vfs: Convert functionfs to use the new mount API
      hypfs: Fix error number left in struct pointer member
      vfs: Convert hypfs to use the new mount API
      vfs: Convert spufs to use the new mount API

 arch/powerpc/platforms/cell/spufs/inode.c | 207 +++++++------
 arch/s390/hypfs/inode.c                   | 137 +++++----
 drivers/usb/gadget/function/f_fs.c        | 233 +++++++-------
 fs/gfs2/incore.h                          |   8 +-
 fs/gfs2/ops_fstype.c                      | 495 ++++++++++++++++++++++--------
 fs/gfs2/super.c                           | 333 +-------------------
 fs/gfs2/super.h                           |   3 +-
 kernel/bpf/inode.c                        |  92 ++++--
 8 files changed, 749 insertions(+), 759 deletions(-)
