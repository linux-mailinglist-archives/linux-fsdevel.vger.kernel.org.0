Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F835F4800
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 19:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJDRCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJDRCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:02:09 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3952FD2;
        Tue,  4 Oct 2022 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=n0un+HEb2R+QtuIW+qziuqB+84HBmpl8+T7eieJ8PhE=; b=duxippqHtj07PlHGBev7r7FkIf
        Fhc+NZXvHJS836whE/0qc7GsrXha9uf1i6pBZr9kVxb+swHPgyFxwUsaG5T9F3hf2d3f9N9hXgEvr
        e//Fkd9e/ttm9loPYRh7nh5MqcRPu6UQFHSqvwTYZlqGxIf1jhoFAH5WxqTNn3aeuUSYKo33t6NF4
        gwfh6Zzx9aDw7fjAaW0+ZnuoZBsayU0OTW4aSExLmsL/orI7IlSlO3SwV0QcHcnaXDXEL+7dJWsSm
        8u2DpCKcNiVjpaCrYo+eUNanIlacA4Ia2PHYrHH6ev6mLDr2kHtF001ejnVJu3tWABKjqZcofUaNc
        RzrLouyA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oflJ0-0072UG-1s;
        Tue, 04 Oct 2022 17:02:06 +0000
Date:   Tue, 4 Oct 2022 18:02:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 6 (constification, mostly struct path)
Message-ID: <YzxnDoPjLjkuUlXp@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... with another constification patch stuck in the same branch
(->getprocattr() one)

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-path

for you to fetch changes up to 88569546e8a13a0c1ccf119dac72376784b0ea42:

  ecryptfs: constify path (2022-09-01 17:40:38 -0400)

----------------------------------------------------------------
whack-a-mole: constifying struct path *

----------------------------------------------------------------
Al Viro (11):
      ->getprocattr(): attribute name is const char *, TYVM...
      do_sys_name_to_handle(): constify path
      may_linkat(): constify path
      fs/notify: constify path
      overlayfs: constify path
      do_proc_readlink(): constify path
      __io_setxattr(): constify path
      audit_init_parent(): constify path
      nd_jump_link(): constify path
      spufs: constify path
      ecryptfs: constify path

 arch/powerpc/platforms/cell/spufs/inode.c |  6 +++---
 arch/powerpc/platforms/cell/spufs/spufs.h |  2 +-
 fs/ecryptfs/ecryptfs_kernel.h             |  2 +-
 fs/ecryptfs/file.c                        |  2 +-
 fs/ecryptfs/inode.c                       |  2 +-
 fs/ecryptfs/main.c                        |  2 +-
 fs/fhandle.c                              |  2 +-
 fs/internal.h                             |  2 +-
 fs/namei.c                                |  4 ++--
 fs/notify/fanotify/fanotify.c             |  2 +-
 fs/notify/fanotify/fanotify.h             |  2 +-
 fs/notify/fanotify/fanotify_user.c        |  6 +++---
 fs/overlayfs/copy_up.c                    | 12 ++++++------
 fs/overlayfs/file.c                       |  2 +-
 fs/overlayfs/inode.c                      |  6 +++---
 fs/overlayfs/namei.c                      |  4 ++--
 fs/overlayfs/overlayfs.h                  | 22 +++++++++++-----------
 fs/overlayfs/readdir.c                    | 16 ++++++++--------
 fs/overlayfs/super.c                      |  8 ++++----
 fs/overlayfs/util.c                       | 10 +++++-----
 fs/proc/base.c                            |  4 ++--
 include/linux/lsm_hook_defs.h             |  2 +-
 include/linux/namei.h                     |  2 +-
 include/linux/security.h                  |  4 ++--
 io_uring/xattr.c                          |  2 +-
 kernel/audit_watch.c                      |  2 +-
 security/apparmor/lsm.c                   |  2 +-
 security/security.c                       |  4 ++--
 security/selinux/hooks.c                  |  2 +-
 security/smack/smack_lsm.c                |  2 +-
 30 files changed, 70 insertions(+), 70 deletions(-)
