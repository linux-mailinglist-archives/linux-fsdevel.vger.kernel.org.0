Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C22D8232
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 23:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436627AbgLKWgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 17:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436623AbgLKWgB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:36:01 -0500
Subject: Re: [GIT PULL] zonefs fixes for 5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607726120;
        bh=ENsMxHTUmjJUcQgDfTdn3hTwjZpF8ecqISxxw451ItE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sLAwhz4zmuBaW1QXoYj4LgauWuJkkc5nR3IP8tyIXeg3hzFZX6Oy9oEztH1xMwOK6
         2g3evlNcz4JYD8CKoSrl02PowKiTKaWRg/mRtEPmV3y0xRhpOQB6w6w6Zb0/992AkP
         0KIayAIIdpImF7ZGV4KBblnEPPX/Jxn+2tPtONboL5u5SkN1+h8KkTmDTDIjCaGQ8O
         KJTFQBt7iQsyTDc85p0yPEEHPZSJ9VybBO05KSinqXgSOxyXzzHHGNOYiPX0yBcx/N
         nIrO8FKXS7RUkJ2ZM0EOaV8nYzUDBipA5aOciGpBAf+IEfKyogDoz6EHXeLiqE3Tal
         dd9mYkiBvqKQw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201211113449.460981-1-damien.lemoal@wdc.com>
References: <20201211113449.460981-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201211113449.460981-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.10-rc7
X-PR-Tracked-Commit-Id: 6bea0225a4bf14a58af71cb9677a756921469e46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 782598ecea73a4aecdd25cb0ceb0b19e8674cf30
Message-Id: <160772612075.9549.362390144993255480.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Dec 2020 22:35:20 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 11 Dec 2020 20:34:49 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/782598ecea73a4aecdd25cb0ceb0b19e8674cf30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
