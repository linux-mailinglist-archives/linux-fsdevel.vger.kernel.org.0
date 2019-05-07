Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B116CB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 22:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfEGUxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 16:53:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52278 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfEGUxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 16:53:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hO75T-0000aP-6S; Tue, 07 May 2019 20:53:19 +0000
Date:   Tue, 7 May 2019 21:53:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc pieces
Message-ID: <20190507205319.GN23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted stuff, with no common topic whatsoever...

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 6ee9706aa22e026f438caabb2982e5f78de2c82c:

  libfs: document simple_get_link() (2019-04-30 23:59:25 -0400)

----------------------------------------------------------------
Arnd Bergmann (1):
      fs: use timespec64 in relatime_need_update

Chengguang Xu (1):
      fs/block_dev.c: remove unused include

Eric Biggers (4):
      Documentation/filesystems/vfs.txt: remove bogus "Last updated" date
      Documentation/filesystems/vfs.txt: document how ->i_link works
      Documentation/filesystems/Locking: fix ->get_link() prototype
      libfs: document simple_get_link()

 Documentation/filesystems/Locking |  2 +-
 Documentation/filesystems/vfs.txt |  8 ++++++--
 fs/block_dev.c                    |  1 -
 fs/inode.c                        |  4 ++--
 fs/libfs.c                        | 14 ++++++++++++++
 5 files changed, 23 insertions(+), 6 deletions(-)
