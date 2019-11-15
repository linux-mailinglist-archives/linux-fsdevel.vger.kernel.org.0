Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6EFD214
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 01:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOAuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 19:50:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49784 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKOAuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:50:14 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVPoS-0007lg-Tx; Fri, 15 Nov 2019 00:50:13 +0000
Date:   Fri, 15 Nov 2019 00:50:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20191115005012.GM26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted fixes all over the place; some of that is -stable
fodder, some - regressions from the last window.

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 762c69685ff7ad5ad7fee0656671e20a0c9c864d:

  ecryptfs_lookup_interpose(): lower_dentry->d_parent is not stable either (2019-11-10 11:57:45 -0500)

----------------------------------------------------------------
Al Viro (7):
      autofs: fix a leak in autofs_expire_indirect()
      cgroup: don't put ERR_PTR() into fc->root
      exportfs_decode_fh(): negative pinned may become positive without the parent locked
      audit_get_nd(): don't unlock parent too early
      ecryptfs: fix unlink and rmdir in face of underlying fs modifications
      ecryptfs_lookup_interpose(): lower_dentry->d_inode is not stable
      ecryptfs_lookup_interpose(): lower_dentry->d_parent is not stable either

Eric Biggers (1):
      fs/namespace.c: fix use-after-free of mount in mnt_warn_timestamp_expiry()

Guillem Jover (1):
      aio: Fix io_pgetevents() struct __compat_aio_sigset layout

 fs/aio.c               | 10 +++---
 fs/autofs/expire.c     |  5 +--
 fs/ecryptfs/inode.c    | 84 +++++++++++++++++++++++++++++++-------------------
 fs/exportfs/expfs.c    | 31 +++++++++++--------
 fs/namespace.c         | 15 +++++----
 kernel/audit_watch.c   |  2 +-
 kernel/cgroup/cgroup.c |  5 +--
 7 files changed, 91 insertions(+), 61 deletions(-)
