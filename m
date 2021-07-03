Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5E3BA6BC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 04:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhGCC6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 22:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhGCC6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 22:58:41 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956CC061762;
        Fri,  2 Jul 2021 19:56:08 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzVp7-00EfNU-2e; Sat, 03 Jul 2021 02:56:05 +0000
Date:   Sat, 3 Jul 2021 02:56:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git d_path series
Message-ID: <YN/RxStDmizrFH/m@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	d_path.c refactoring

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.d_path

for you to fetch changes up to e4b275531887fef7f7d8a7284bfc32f0fbbd4208:

  getcwd(2): clean up error handling (2021-05-18 20:15:58 -0400)

----------------------------------------------------------------
Al Viro (14):
      d_path: "\0" is {0,0}, not {0}
      d_path: saner calling conventions for __dentry_path()
      d_path: regularize handling of root dentry in __dentry_path()
      d_path: get rid of path_with_deleted()
      getcwd(2): saner logics around prepend_path() call
      d_path: don't bother with return value of prepend()
      d_path: lift -ENAMETOOLONG handling into callers of prepend_path()
      d_path: make prepend_name() boolean
      d_path: introduce struct prepend_buffer
      d_path: prepend_path(): get rid of vfsmnt
      d_path: prepend_path(): lift resetting b in case when we'd return 3 out of loop
      d_path: prepend_path(): lift the inner loop into a new helper
      d_path: prepend_path() is unlikely to return non-zero
      getcwd(2): clean up error handling

 fs/d_path.c | 324 +++++++++++++++++++++++++-----------------------------------
 1 file changed, 133 insertions(+), 191 deletions(-)
