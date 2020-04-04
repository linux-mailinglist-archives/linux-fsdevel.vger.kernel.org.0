Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649E319E716
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 20:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgDDSfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 14:35:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55004 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgDDSfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 14:35:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKndg-00AZnu-8a; Sat, 04 Apr 2020 18:35:28 +0000
Date:   Sat, 4 Apr 2020 19:35:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] exfat
Message-ID: <20200404183528.GO23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	fs/exfat replacement for drivers/staging/exfat.  Two conflicts -
drivers/staging/exfat/Kconfig modified in this branch and gone in mainline
and insertion into MAINTAINERS next to (now gone in mainline) entry for
drivers/staging variant.  Obvious resolution in both cases...

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.exfat

for you to fetch changes up to 9acd0d53800c55c6e2186e29b6433daf24617451:

  exfat: update file system parameter handling (2020-03-05 21:00:40 -0500)

----------------------------------------------------------------
Namjae Jeon (13):
      exfat: add in-memory and on-disk structures and headers
      exfat: add super block operations
      exfat: add inode operations
      exfat: add directory operations
      exfat: add file operations
      exfat: add fat entry operations
      exfat: add bitmap operations
      exfat: add exfat cache
      exfat: add misc operations
      exfat: add nls operations
      exfat: add Kconfig and Makefile
      MAINTAINERS: add exfat filesystem
      staging: exfat: make staging/exfat and fs/exfat mutually exclusive

Valdis Kletnieks (1):
      exfat: update file system parameter handling

 MAINTAINERS                   |    7 +
 drivers/staging/exfat/Kconfig |    2 +-
 fs/Kconfig                    |    3 +-
 fs/Makefile                   |    1 +
 fs/exfat/Kconfig              |   21 +
 fs/exfat/Makefile             |    8 +
 fs/exfat/balloc.c             |  280 ++++++++
 fs/exfat/cache.c              |  325 +++++++++
 fs/exfat/dir.c                | 1238 +++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h           |  519 +++++++++++++++
 fs/exfat/exfat_raw.h          |  184 ++++++
 fs/exfat/fatent.c             |  463 +++++++++++++
 fs/exfat/file.c               |  360 ++++++++++
 fs/exfat/inode.c              |  671 +++++++++++++++++++
 fs/exfat/misc.c               |  163 +++++
 fs/exfat/namei.c              | 1448 +++++++++++++++++++++++++++++++++++++++++
 fs/exfat/nls.c                |  831 +++++++++++++++++++++++
 fs/exfat/super.c              |  722 ++++++++++++++++++++
 18 files changed, 7244 insertions(+), 2 deletions(-)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile
 create mode 100644 fs/exfat/balloc.c
 create mode 100644 fs/exfat/cache.c
 create mode 100644 fs/exfat/dir.c
 create mode 100644 fs/exfat/exfat_fs.h
 create mode 100644 fs/exfat/exfat_raw.h
 create mode 100644 fs/exfat/fatent.c
 create mode 100644 fs/exfat/file.c
 create mode 100644 fs/exfat/inode.c
 create mode 100644 fs/exfat/misc.c
 create mode 100644 fs/exfat/namei.c
 create mode 100644 fs/exfat/nls.c
 create mode 100644 fs/exfat/super.c
