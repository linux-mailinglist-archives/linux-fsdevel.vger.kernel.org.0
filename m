Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C515673E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 20:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgBHTDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 14:03:31 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34146 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgBHTDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 14:03:31 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0VO5-009VKO-Ed; Sat, 08 Feb 2020 19:03:29 +0000
Date:   Sat, 8 Feb 2020 19:03:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc
Message-ID: <20200208190329.GG23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	bmap series from cmaiolino + getting rid of convolutions in
copy_mount_options() (a couple of copy_from_user() instead of
an the __get_user() crap)

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 12efec5602744c5a185049eb4fcfd9aebe01bd6f:

  saner copy_mount_options() (2020-02-03 21:23:33 -0500)

----------------------------------------------------------------
Al Viro (1):
      saner copy_mount_options()

Carlos Maiolino (5):
      fs: Enable bmap() function to properly return errors
      cachefiles: drop direct usage of ->bmap method.
      ecryptfs: drop direct calls to ->bmap
      fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
      fibmap: Reject negative block numbers

 drivers/md/md-bitmap.c | 16 ++++++++++------
 fs/cachefiles/rdwr.c   | 27 ++++++++++++++-------------
 fs/ecryptfs/mmap.c     | 16 ++++++----------
 fs/f2fs/data.c         | 16 +++++++++++-----
 fs/inode.c             | 32 +++++++++++++++++++-------------
 fs/ioctl.c             | 33 +++++++++++++++++++++++----------
 fs/jbd2/journal.c      | 22 +++++++++++++++-------
 fs/namespace.c         | 49 +++++++------------------------------------------
 include/linux/fs.h     |  9 ++++++++-
 mm/page_io.c           | 11 +++++++----
 10 files changed, 120 insertions(+), 111 deletions(-)
