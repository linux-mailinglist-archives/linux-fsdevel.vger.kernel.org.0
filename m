Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4171E320CC6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 19:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhBUSlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 13:41:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbhBUSk6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0319164F02;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932783;
        bh=BdtrW9KKDysj8aSQB1bawTcYxDbJkOXemTzKewhvJ78=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZSHiINmaMM87c6IgWKHfqFHPqVNZ8AGEAnz8XoQw3V8h/DTZmurFjzS0I549CnFaz
         8ziigEHpUWC+Yx9K7cdHa618zXwvESb0mozqThsQdQO/9xnHer85BmFhFdTA/JFiZs
         cNB43Jj+y3t7xnVI0cR5xx6mAFG4sjqCZghL4/DVuh3JX9uNizhTFvhx2ZB66wbsrJ
         LZj9fjJNgQMv22UBLbwR2egxotAX/F3MNrURbYFD3bZooaX0RmCsVhx/SMrIsTVXA2
         1ICII5fGJ1f6wrLVS32rTogG4ZOZY8lrmP2Uid/vmFVYNgt7qLubvDpjSlM0BNNyUy
         TLYbik49dgJ+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F20B260967;
        Sun, 21 Feb 2021 18:39:42 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YCwBY/FsxEsnI0M/@sol.localdomain>
References: <YCwBY/FsxEsnI0M/@sol.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YCwBY/FsxEsnI0M/@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 07c99001312cbf90a357d4877a358f796eede65b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7b36dc5cb37615b568b7161ddc53d604973ec8b
Message-Id: <161393278298.20435.13432772684850802253.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:42 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 09:31:15 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7b36dc5cb37615b568b7161ddc53d604973ec8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
