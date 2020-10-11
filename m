Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060DC28A924
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 20:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgJKSGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJKSGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:06:12 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295E3C0613CE;
        Sun, 11 Oct 2020 11:06:12 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRfjV-00FWeV-JD; Sun, 11 Oct 2020 18:06:09 +0000
Date:   Sun, 11 Oct 2020 19:06:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20201011180609.GC3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Sat in -next for a while, fixes an obvious bug
(leak introduced in 5.8, i.e. the mess from previous cycle).

The following changes since commit 933a3752babcf6513117d5773d2b70782d6ad149:

  fuse: fix the ->direct_IO() treatment of iov_iter (2020-09-17 17:26:56 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 8a018eb55e3ac033592afbcb476b0ffe64465b12:

  pipe: Fix memory leaks in create_pipe_files() (2020-10-01 09:40:35 -0400)

----------------------------------------------------------------
Qian Cai (1):
      pipe: Fix memory leaks in create_pipe_files()

 fs/pipe.c                   | 11 +++++------
 include/linux/watch_queue.h |  6 ++++++
 2 files changed, 11 insertions(+), 6 deletions(-)
