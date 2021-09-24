Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714344179E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbhIXRf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344554AbhIXRfY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:35:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6D2486103B;
        Fri, 24 Sep 2021 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632504831;
        bh=l80xHo3LSMbaGxsESA1waD33TNPr+o5h4iO7rcDNJT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sZ8YJai1GukF0TijwiL+fdd7BDThnF+L9mMTzL10kylpD13HKpR/1SMVa3n/pAYik
         SroIqvun7TQZdVFpz3y4nROFfik3H+k2AUeAuysA79viE+/lNlOg1rWu8vxQ9OKTOp
         IhIEzQonO5DFRnYI68X8M4iN9eJ8osFdIm94KAEIte6a7nuDsXG3bD1nWwqkAfO5mJ
         TCHuvH9mAxeJhZWkMU2tbtD1KuD/yF0GowExaQxkRZDuUZ/9Cg1gEEkecEHINO1B4Q
         /t3If4uzyCzLZz4vOdKqrr+GpZvkoT+bixYCjipPWM75+UEc0orHCyJEDXLam/0K+5
         Rc+YacNMDbbjA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 673F460A88;
        Fri, 24 Sep 2021 17:33:51 +0000 (UTC)
Subject: Re: [GIT PULL] Two fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210924102703.GA19744@quack2.suse.cz>
References: <20210924102703.GA19744@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210924102703.GA19744@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.15-rc3
X-PR-Tracked-Commit-Id: 372d1f3e1bfede719864d0d1fbf3146b1e638c88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e655c81ade7b877cb5ee31c85e88928ec3f77db6
Message-Id: <163250483141.13479.1938375695052407939.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Sep 2021 17:33:51 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 24 Sep 2021 12:27:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e655c81ade7b877cb5ee31c85e88928ec3f77db6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
