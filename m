Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7F405DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 22:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbhIIUFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 16:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345172AbhIIUFJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 16:05:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D91EF61186;
        Thu,  9 Sep 2021 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631217839;
        bh=Xd55OPTZhkST2mdN57lFJ5d8Mtrl5pxL6RhoD5Za9EU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tHvzXJcCfN32CERLsckXhJ4/8aPIAjCjOdsOf877IyrKHFW4nwUPQMv0pIzjhbGCZ
         JyyNNayILIFCSIL+YGBAaUWvb2z+TBUTQwtCkBbn6EE0zUZ6uPNdyLU0Cf5fQSNGpZ
         eAgi+MeOoeqTtnBxSNOivN+V5BgjDRQV3hdknmWLKQoyDI6w2kn4M/Ho9An6jcTVlu
         rRouoiuPbIO94seTKthjyTlPxCLTuOwNYBlBQgYhCG2EGFjrA+KKHqvysuMesjjBD5
         +rztcup4PPWMOKy600+DWj84u/C4OA1RBZC1XtcTdx5qXUIPXlwn5HqRei+dv69b2x
         XStl6mnr9rE9Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D37B5608FC;
        Thu,  9 Sep 2021 20:03:59 +0000 (UTC)
Subject: Re: [git pull] root filesystem type handling series
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTmMyUnlqjvIB/rr@zeniv-ca.linux.org.uk>
References: <YTmMyUnlqjvIB/rr@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTmMyUnlqjvIB/rr@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.init
X-PR-Tracked-Commit-Id: 6e7c1770a212239e88ec01ddc7a741505bfd10e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2e694b9e6f3ec7deeb233b6b0fe20b6a47b304b
Message-Id: <163121783986.16320.9782196744984147818.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Sep 2021 20:03:59 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 9 Sep 2021 04:25:45 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.init

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2e694b9e6f3ec7deeb233b6b0fe20b6a47b304b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
