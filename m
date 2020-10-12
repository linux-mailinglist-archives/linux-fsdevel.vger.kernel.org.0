Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F9128AC69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 05:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgJLDTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 23:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgJLDTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:19:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00FEC0613CE;
        Sun, 11 Oct 2020 20:19:54 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRoNN-00Fke8-A6; Mon, 12 Oct 2020 03:19:53 +0000
Date:   Mon, 12 Oct 2020 04:19:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [git pull] vfs.git quota compat series
Message-ID: <20201012031953.GG3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	More Christoph's compat cleanups: quotactl(2).

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.quota-compat

for you to fetch changes up to 80bdad3d7e3ec03f812471d9309f5f682e10f52b:

  quota: simplify the quotactl compat handling (2020-09-17 13:00:46 -0400)

----------------------------------------------------------------
Christoph Hellwig (3):
      compat: lift compat_s64 and compat_u64 to <asm-generic/compat.h>
      compat: add a compat_need_64bit_alignment_fixup() helper
      quota: simplify the quotactl compat handling

 arch/arm64/include/asm/compat.h        |   2 -
 arch/mips/include/asm/compat.h         |   2 -
 arch/parisc/include/asm/compat.h       |   2 -
 arch/powerpc/include/asm/compat.h      |   2 -
 arch/s390/include/asm/compat.h         |   2 -
 arch/sparc/include/asm/compat.h        |   3 +-
 arch/x86/entry/syscalls/syscall_32.tbl |   2 +-
 arch/x86/include/asm/compat.h          |   3 +-
 fs/quota/Kconfig                       |   5 --
 fs/quota/Makefile                      |   1 -
 fs/quota/compat.c                      | 120 ---------------------------------
 fs/quota/compat.h                      |  34 ++++++++++
 fs/quota/quota.c                       |  73 ++++++++++++++++----
 include/asm-generic/compat.h           |   8 +++
 include/linux/compat.h                 |   9 +++
 include/linux/quotaops.h               |   3 -
 kernel/sys_ni.c                        |   1 -
 17 files changed, 113 insertions(+), 159 deletions(-)
 delete mode 100644 fs/quota/compat.c
 create mode 100644 fs/quota/compat.h
