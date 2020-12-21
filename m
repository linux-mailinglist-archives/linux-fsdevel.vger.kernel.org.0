Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E212DF860
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 05:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgLUEqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Dec 2020 23:46:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgLUEqA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:46:00 -0500
Subject: Re: [GIT PULL] orangefs pull request for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608525920;
        bh=zyx8EUQyzG3aTasiqpcqDyzLl/go7DAUuT/mSnamjuY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BwDBQ5qqqI50kNhcwuCukfY+Te9qotwfKHeFBko+l1bF8I2BMeGxuYf4xdcxdc6hT
         pfNpz+KUkfkMfg1Y4Wj21RQLilFiv8B5yvECz9ntn0VOckY6MRyfV7TrGvBK5HiOvG
         U7alBnUqMaC3F35KAmuV36bxhEPEzJ2DW2/j3WdenTpKj52N6r7vGdwmswZY+WRuZD
         KEIXXKrndGFV7kqCARxsGiMrEv1F/Vku0/QkBYlOGAL2nAvL+j44QvK6fxbyzRCgat
         bfith7RQw9kpFT5RKeYAupqi92Yj9mUiNHrkOu95CmlDBZr7O+9ikIk5vYpI0KCyIX
         s5td0/n3l8UNA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSTwWmVWZVsWd6eUmqrzLpSDii0hyYLCRN_edH3uBhUmaA@mail.gmail.com>
References: <CAOg9mSTwWmVWZVsWd6eUmqrzLpSDii0hyYLCRN_edH3uBhUmaA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSTwWmVWZVsWd6eUmqrzLpSDii0hyYLCRN_edH3uBhUmaA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.11-ofs1
X-PR-Tracked-Commit-Id: c1048828c3dbd96c7e371fae658e5f40e6a45e99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e37b12e4bb21e7c81732370b0a2b34bd196f380b
Message-Id: <160852592000.19479.13148600718708002685.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Dec 2020 04:45:20 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Mike Marshall <hubcapsc@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 20 Dec 2020 15:06:25 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.11-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e37b12e4bb21e7c81732370b0a2b34bd196f380b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
