Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA41E4952E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 00:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfFQWdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 18:33:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34366 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFQWc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:32:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hd0BN-00017T-FN; Mon, 17 Jun 2019 22:32:57 +0000
Date:   Mon, 17 Jun 2019 23:32:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] a couple of fixes for mount stuff
Message-ID: <20190617223257.GX17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	MS_MOVE regression fix + breakage in fsmount(2) (also introduced in
this cycle, along with fsmount(2) itself).  I'm still digging through the
piles of mail, so there might be more fixes to follow, but these two are
obvious and self-contained, so there's no point delaying those...

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to d728cf79164bb38e9628d15276e636539f857ef1:

  fs/namespace: fix unprivileged mount propagation (2019-06-17 17:36:09 -0400)

----------------------------------------------------------------
Christian Brauner (1):
      fs/namespace: fix unprivileged mount propagation

Eric Biggers (1):
      vfs: fsmount: add missing mntget()

 fs/namespace.c | 2 ++
 fs/pnode.c     | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)
