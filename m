Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED1436B243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 13:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhDZLTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 07:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232185AbhDZLTb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:19:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E33761131;
        Mon, 26 Apr 2021 11:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619435930;
        bh=qs4Z74BgQgrjtyJP9H3ollB6/E8cZAm8W1oEEykMr98=;
        h=Subject:From:To:Cc:Date:From;
        b=WGTD/0MVt+VXgO2Bz0OiqQ5/YzzNOF+/TvbowX9/hwHIYtaJYwfXdx1B3L4w2DuWh
         9GzSdWOrZZrY8qwdSABGdKQeqDWQK8ujF2i0Vn3peFBKnrbKyB0MvI3P4bj0gO3sJF
         9YutoArQH5HFNmKV2xT30RmfWuaG8WbKnM17+WZKmRIfuNeNmWDwr0xGJj7cx+w4Pr
         O1EDRzrjNPgf7NsXRx1OOPyUkY/nvMkkAToQE3Fuf72KQuCFWSxPOUeK940vvzFQ79
         0nuGHhQ0Q6d3pB0it2ZEwjeTnlM/PXXERA5bDp807p01PqCulV53MuCtO8oeoqx4m1
         pb5bEpXtG7S1Q==
Message-ID: <2623d52cefb71fab85fbfbd0315ac48ac89e00ee.camel@kernel.org>
Subject: [GIT PULL] file locking fixes for v5.13
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Luo Longjun <luolongjun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Date:   Mon, 26 Apr 2021 07:18:48 -0400
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.13

for you to fetch changes up to cbe6fc4e01421c890d74422cdd04c6b1c8f62dda:

  fs/locks: remove useless assignment in fcntl_getlk (2021-04-13 07:26:38 -0400)

----------------------------------------------------------------
When we reworked the blocked locks into a tree structure instead of a
flat list a few releases ago, we lost the ability to see all of the file
locks in /proc/locks. Luo's patch fixes it to dump out all of the
blocked locks instead, which restores the full output.

This changes the format of /proc/locks as the blocked locks are shown at
multiple levels of indentation now, but lslocks (the only common program
I've ID'ed that scrapes this info) seems to be OK with that.

Tian also contributed a small patch to remove a useless assignment.
----------------------------------------------------------------
Luo Longjun (1):
      fs/locks: print full locks information

Tian Tao (1):
      fs/locks: remove useless assignment in fcntl_getlk

 fs/locks.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 10 deletions(-)

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

