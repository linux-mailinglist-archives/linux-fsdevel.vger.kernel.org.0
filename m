Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B712E2944
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Dec 2020 00:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgLXXfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Dec 2020 18:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgLXXfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Dec 2020 18:35:54 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E7C061573;
        Thu, 24 Dec 2020 15:35:14 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksa8R-003vJg-Cu; Thu, 24 Dec 2020 23:35:07 +0000
Date:   Thu, 24 Dec 2020 23:35:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc stuff
Message-ID: <20201224233507.GZ3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted patches from previous cycle(s)...

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 2e2cbaf920d14de9a96180ddefd6861bcc46f07d:

  fix hostfs_open() use of ->f_path.dentry (2020-12-21 21:42:29 -0500)

----------------------------------------------------------------
Al Viro (2):
      Make sure that make_create_in_sticky() never sees uninitialized value of dir_mode
      fix hostfs_open() use of ->f_path.dentry

Eric Biggers (1):
      fs/namespace.c: WARN if mnt_count has become negative

Hao Li (2):
      fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()
      fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set

 fs/dcache.c             | 9 ++++++++-
 fs/hostfs/hostfs_kern.c | 2 +-
 fs/inode.c              | 4 +++-
 fs/namei.c              | 4 +++-
 fs/namespace.c          | 9 ++++++---
 fs/pnode.h              | 2 +-
 include/linux/fs.h      | 3 +--
 7 files changed, 23 insertions(+), 10 deletions(-)
