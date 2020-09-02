Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14BB25AF60
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgIBPiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgIBPhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:37:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87971C061244;
        Wed,  2 Sep 2020 08:37:49 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDUpX-009Lvr-6d; Wed, 02 Sep 2020 15:37:47 +0000
Date:   Wed, 2 Sep 2020 16:37:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [git pull] epoll fixup
Message-ID: <20200902153747.GL1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Fixup for epoll regression; there's a better solution longer term,
but this is the least intrusive fix.

The following changes since commit 52c479697c9b73f628140dcdfcd39ea302d05482:

  do_epoll_ctl(): clean the failure exits up a bit (2020-08-22 18:25:52 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll

for you to fetch changes up to 77f4689de17c0887775bb77896f4cc11a39bf848:

  fix regression in "epoll: Keep a reference on files added to the check list" (2020-09-02 11:30:48 -0400)

----------------------------------------------------------------
Al Viro (1):
      fix regression in "epoll: Keep a reference on files added to the check list"

 fs/eventpoll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
