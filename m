Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACF5196B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 04:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfEJCde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 22:33:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33114 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfEJCde (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 22:33:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hOvLp-0007zS-8k; Fri, 10 May 2019 02:33:33 +0000
Date:   Fri, 10 May 2019 03:33:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git braino fix
Message-ID: <20190510023333.GS23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Fix for umount -l/mount --move race caught by syzbot yesterday...

The following changes since commit 80f232121b69cc69a31ccb2b38c1665d770b0710:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next (2019-05-07 22:03:58 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 05883eee857eab4693e7d13ebab06716475c5754:

  do_move_mount(): fix an unsafe use of is_anon_ns() (2019-05-09 02:32:50 -0400)

----------------------------------------------------------------
Al Viro (1):
      do_move_mount(): fix an unsafe use of is_anon_ns()

 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
