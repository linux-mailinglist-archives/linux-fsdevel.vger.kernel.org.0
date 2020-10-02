Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CBA281910
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 19:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbgJBRU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBRU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:20:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADEC0613D0;
        Fri,  2 Oct 2020 10:20:28 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOOjJ-00AWKN-D1; Fri, 02 Oct 2020 17:20:25 +0000
Date:   Fri, 2 Oct 2020 18:20:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] epoll fixes
Message-ID: <20201002172025.GJ3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Several race fixes in epoll.

The following changes since commit 77f4689de17c0887775bb77896f4cc11a39bf848:

  fix regression in "epoll: Keep a reference on files added to the check list" (2020-09-02 11:30:48 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll

for you to fetch changes up to 3701cb59d892b88d569427586f01491552f377b1:

  ep_create_wakeup_source(): dentry name can change under you... (2020-09-24 19:41:58 -0400)

----------------------------------------------------------------
Al Viro (4):
      epoll: do not insert into poll queues until all sanity checks are done
      epoll: replace ->visited/visited_list with generation count
      epoll: EPOLL_CTL_ADD: close the race in decision to take fast path
      ep_create_wakeup_source(): dentry name can change under you...

 fs/eventpoll.c | 72 +++++++++++++++++++++++++---------------------------------
 1 file changed, 31 insertions(+), 41 deletions(-)
