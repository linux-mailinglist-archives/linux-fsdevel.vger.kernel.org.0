Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8796B2F9053
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 04:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbhAQDWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jan 2021 22:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbhAQDWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jan 2021 22:22:02 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296AEC061573;
        Sat, 16 Jan 2021 19:21:22 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0yct-00Awrb-Qi; Sun, 17 Jan 2021 03:21:15 +0000
Date:   Sun, 17 Jan 2021 03:21:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20210117032115.GG3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Several assorted fixes.  I still think that audit ->d_name race
is better fixed that way for the benefit of backports, with any fancier
variants done on top of that.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to d36a1dd9f77ae1e72da48f4123ed35627848507d:

  dump_common_audit_data(): fix racy accesses to ->d_name (2021-01-16 15:11:35 -0500)

----------------------------------------------------------------
Al Viro (2):
      umount(2): move the flag validity checks first
      dump_common_audit_data(): fix racy accesses to ->d_name

Christoph Hellwig (1):
      iov_iter: fix the uaccess area in copy_compat_iovec_from_user

 fs/namespace.c       | 7 +++++--
 lib/iov_iter.c       | 2 +-
 security/lsm_audit.c | 7 +++++--
 3 files changed, 11 insertions(+), 5 deletions(-)
