Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB6B274B25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 23:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIVV3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 17:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIVV3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:29:11 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D37C061755;
        Tue, 22 Sep 2020 14:29:11 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKpqX-0045vx-0B; Tue, 22 Sep 2020 21:29:09 +0000
Date:   Tue, 22 Sep 2020 22:29:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs fixes
Message-ID: <20200922212908.GB3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	No common topic, just several assorted fixes.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 933a3752babcf6513117d5773d2b70782d6ad149:

  fuse: fix the ->direct_IO() treatment of iov_iter (2020-09-17 17:26:56 -0400)

----------------------------------------------------------------
Al Viro (1):
      fuse: fix the ->direct_IO() treatment of iov_iter

Alexey Dobriyan (1):
      fs: fix cast in fsparam_u32hex() macro

Hans de Goede (1):
      vboxsf: Fix the check for the old binary mount-arguments struct

 fs/fuse/file.c            | 25 ++++++++++++-------------
 fs/vboxsf/super.c         |  2 +-
 include/linux/fs_parser.h |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)
