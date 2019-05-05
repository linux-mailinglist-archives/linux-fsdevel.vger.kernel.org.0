Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA2213CC9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 04:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfEECTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 May 2019 22:19:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35900 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfEECTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 May 2019 22:19:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hN6jm-0008VW-Hp; Sun, 05 May 2019 02:18:50 +0000
Date:   Sun, 5 May 2019 03:18:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20190505021841.GZ23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	A couple of ->i_link use-after-free fixes, regression fix for
wrong errno on absent device name in mount(2) (this cycle stuff) +
ancient UFS braino in large GID handling on Solaris UFS images (bogus
cut'n'paste from large UID handling; wrong field checked to decide
whether we should look at old (16bit) or new (32bit) field).

The following changes since commit 6af1c849dfb1f1d326fbdd157c9bc882b921f450:

  aio: use kmem_cache_free() instead of kfree() (2019-04-04 20:13:59 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 4e9036042fedaffcd868d7f7aa948756c48c637d:

  ufs: fix braino in ufs_get_inode_gid() for solaris UFS flavour (2019-05-02 02:24:50 -0400)

----------------------------------------------------------------
Al Viro (4):
      securityfs: fix use-after-free on symlink traversal
      apparmorfs: fix use-after-free on symlink traversal
      [fix] get rid of checking for absent device name in vfs_get_tree()
      ufs: fix braino in ufs_get_inode_gid() for solaris UFS flavour

Alexander Lochmann (1):
      Abort file_remove_privs() for non-reg. files

 fs/inode.c                     |  9 +++++++--
 fs/super.c                     |  5 -----
 fs/ufs/util.h                  |  2 +-
 security/apparmor/apparmorfs.c | 13 +++++++++----
 security/inode.c               | 13 +++++++++----
 5 files changed, 26 insertions(+), 16 deletions(-)
