Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10342116062
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 05:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLHEqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 23:46:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57580 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfLHEqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 23:46:21 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idoSC-0001Jw-Ai; Sun, 08 Dec 2019 04:46:03 +0000
Date:   Sun, 8 Dec 2019 04:45:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] several misc cleanups
Message-ID: <20191208044556.GR4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	No common topic; FWIW, timestamp-related one got combined with
Deepa's patches and moved out into #work.timestamp; probably the next cycle
fodder.  A couple of dcache_readdir()-related ones (likely to get some
massage) - moved into next.misc for now, #work.dcache_readdir once it
gets into shape for public tree; they belong there anyway.  Which has
left just these three...

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 5c8b0dfc6f4a5e6c707827d0172fc1572e689094:

  make __d_alloc() static (2019-10-25 14:08:24 -0400)

----------------------------------------------------------------
Al Viro (1):
      make __d_alloc() static

Ben Dooks (2):
      fs/fnctl: fix missing __user in fcntl_rw_hint()
      fs/namespace: add __user to open_tree and move_mount syscalls

 fs/dcache.c    | 2 +-
 fs/fcntl.c     | 2 +-
 fs/internal.h  | 1 -
 fs/namespace.c | 6 +++---
 4 files changed, 5 insertions(+), 6 deletions(-)
