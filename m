Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E7336BAE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 22:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhDZU6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 16:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233971AbhDZU6L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:58:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E867661107;
        Mon, 26 Apr 2021 20:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619470649;
        bh=wDOfCFkgJhSONK05d8lIA3HBqMPh05si1kwOhpGJ83E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y2nb2ZGz8oClzWVZcgQp1vCHqNK/d0/5+MIiRBbW5g4FgVVcJiKBID28LtTG4T842
         pJKjgaJQS3GG5SEK3uD1UMaN6LijZsDd5lMi9516Rfz0idiJyf81Voqclj+lLuZ9dl
         lPBzPFo+10+ZS06ezIU6ASWFmpLeoNxG8XvtrlnVJzz0kvgWFRfdjCX75Z4lLHd5/M
         j0tJ2qz5PXZxkB8QCYG+guGOHJMLKQz4bxAc7GyCGVEYe2lQLFdabNrRepXwgcFHbX
         97NmjZ9ebwR5lT8ADTlKFIYpU3cIHJA+v6yo0iUPIQBCoOI3u726jVwQlcrD4Z/LOG
         FR9W29J7IfaVA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E2933609B0;
        Mon, 26 Apr 2021 20:57:28 +0000 (UTC)
Subject: Re: [GIT PULL] file locking fixes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2623d52cefb71fab85fbfbd0315ac48ac89e00ee.camel@kernel.org>
References: <2623d52cefb71fab85fbfbd0315ac48ac89e00ee.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2623d52cefb71fab85fbfbd0315ac48ac89e00ee.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.13
X-PR-Tracked-Commit-Id: cbe6fc4e01421c890d74422cdd04c6b1c8f62dda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: befbfe07e646d9ffc5be1e2c943aefa5e23bf3b8
Message-Id: <161947064892.16410.15388113234248183084.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 20:57:28 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Luo Longjun <luolongjun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 07:18:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/befbfe07e646d9ffc5be1e2c943aefa5e23bf3b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
