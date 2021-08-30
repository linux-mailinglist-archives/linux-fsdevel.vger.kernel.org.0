Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1DD3FBAC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 19:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhH3RVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 13:21:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238020AbhH3RVH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B962D60F42;
        Mon, 30 Aug 2021 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630344013;
        bh=u1SSIZ564CVdqcBd1nsCn90aKqrwbhc31YnLAlP39n8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EzMp35/M/cIvPervmMlcOYe18rT1IlD0SqrWEE1Z4jp8b6rvtDMwQP73u7tkRSQ8O
         XKq2cH09thqKxyThPfdZYqM/Bk93eEAsGiHUBmiQzbZeci/dnK8gFRIOJlu0fQq2Xt
         qAy8iiudhdvuBKFRYxmQ5C8fbKDRged0uQ17kiY90o5FXjCV3K1lXHyRT8Fhbs6SAf
         4yPPW7DoHJe1gteTI4uZMdNu3m7uZLE8VTtYFnyfbn13QRHoRR8L4aRcFG89KlEHqd
         kOzegUlJWDFbMKxd69c1Z/U1gV/U0tuQWJ6p9SuExHijZBCRJU/Fm/dTyLr8YWW1Mn
         P4Ad3hfLzShOg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AA07C60A4F;
        Mon, 30 Aug 2021 17:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210825124515.GE14620@quack2.suse.cz>
References: <20210825124515.GE14620@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210825124515.GE14620@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.15-rc1
X-PR-Tracked-Commit-Id: e43de7f0862b8598cd1ef440e3b4701cd107ea40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3513431926f9bfe3f4fcb06a39d9ec59b0470311
Message-Id: <163034401363.22842.2547320925579316758.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 17:20:13 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 25 Aug 2021 14:45:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3513431926f9bfe3f4fcb06a39d9ec59b0470311

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
