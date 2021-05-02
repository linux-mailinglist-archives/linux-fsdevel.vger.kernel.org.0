Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA037098E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 03:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhEBBbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 May 2021 21:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhEBBbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 May 2021 21:31:34 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B957AC06174A;
        Sat,  1 May 2021 18:30:43 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ld0wU-00A5uF-DD; Sun, 02 May 2021 01:30:42 +0000
Date:   Sun, 2 May 2021 01:30:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] work.misc
Message-ID: <YI4AwgZaFSGsTDR9@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted stuff all over the place.  Will cause trivial conflicts in
f2fs and csky (if you've already pulled those).

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 80e5d1ff5d5f1ed5167a69b7c2fe86071b615f6b:

  useful constants: struct qstr for ".." (2021-04-15 22:36:45 -0400)

----------------------------------------------------------------
Al Viro (7):
      constify dentry argument of dentry_path()/dentry_path_raw()
      get rid of autofs_getpath()
      apparmor:match_mn() - constify devpath argument
      autofs: should_expire() argument is guaranteed to be positive
      whack-a-mole: kill strlen_user() (again)
      hostfs_open(): don't open-code file_dentry()
      useful constants: struct qstr for ".."

Mikulas Patocka (1):
      buffer: a small optimization in grow_buffers

 arch/csky/include/asm/uaccess.h  |  2 --
 arch/csky/lib/usercopy.c         |  2 +-
 arch/nds32/include/asm/uaccess.h |  1 -
 arch/nios2/include/asm/uaccess.h |  1 -
 arch/riscv/include/asm/uaccess.h |  1 -
 fs/autofs/autofs_i.h             |  1 +
 fs/autofs/expire.c               |  2 +-
 fs/autofs/waitq.c                | 72 +++++++++-------------------------------
 fs/buffer.c                      |  6 +---
 fs/d_path.c                      | 10 +++---
 fs/dcache.c                      |  2 ++
 fs/ext2/namei.c                  |  3 +-
 fs/ext4/namei.c                  |  3 +-
 fs/f2fs/dir.c                    |  4 +--
 fs/f2fs/namei.c                  |  3 +-
 fs/fuse/inode.c                  |  3 +-
 fs/hostfs/hostfs_kern.c          |  2 +-
 fs/nilfs2/namei.c                |  3 +-
 fs/udf/namei.c                   |  3 +-
 fs/ufs/super.c                   |  3 +-
 include/linux/dcache.h           |  5 +--
 security/apparmor/mount.c        |  4 +--
 22 files changed, 41 insertions(+), 95 deletions(-)
