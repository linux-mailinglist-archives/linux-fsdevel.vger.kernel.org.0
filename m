Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621A3326BEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 07:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhB0GBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 01:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhB0GBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 01:01:16 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D4C06174A;
        Fri, 26 Feb 2021 22:00:36 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFseT-001Ggb-U6; Sat, 27 Feb 2021 06:00:30 +0000
Date:   Sat, 27 Feb 2021 06:00:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc stuff
Message-ID: <YDnf/cY4c0uOIcVd@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted stuff pile - no common topic here.
One trivial conflict in Documentation/filesystems/porting.rst  

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 6f24784f00f2b5862b367caeecc5cca22a77faa3:

  whack-a-mole: don't open-code iminor/imajor (2021-02-23 10:25:29 -0500)

----------------------------------------------------------------
Al Viro (3):
      audit_alloc_mark(): don't open-code ERR_CAST()
      9p: fix misuse of sscanf() in v9fs_stat2inode()
      whack-a-mole: don't open-code iminor/imajor

Eric Biggers (2):
      vfs: don't unnecessarily clone write access for writable fds
      fs/inode.c: make inode_init_always() initialize i_ino to 0

 Documentation/filesystems/porting.rst  |  7 +++++
 arch/sh/boards/mach-landisk/gio.c      |  6 ++--
 drivers/block/loop.c                   |  2 +-
 drivers/dax/super.c                    |  2 +-
 drivers/rtc/rtc-m41t80.c               |  4 +--
 drivers/s390/char/vmur.c               |  2 +-
 drivers/staging/vme/devices/vme_user.c | 12 ++++----
 fs/9p/vfs_inode.c                      | 21 ++++++--------
 fs/gfs2/inode.c                        |  4 +--
 fs/inode.c                             |  1 +
 fs/jfs/super.c                         |  1 -
 fs/namespace.c                         | 53 +++++++++++++---------------------
 include/linux/mount.h                  |  1 -
 kernel/audit_fsnotify.c                |  2 +-
 14 files changed, 53 insertions(+), 65 deletions(-)
