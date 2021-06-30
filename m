Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2643B7C18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhF3DiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 23:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232630AbhF3DiP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0DFF661D07;
        Wed, 30 Jun 2021 03:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625024147;
        bh=uq2/KfDOugqNifKHy3zUd4XbCbiAYlH4hRKMRWcDU8U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DnWufIFQ0OYkzZMI1abWfY7NQeu1J+6s8FjUWox70rY7UqzczaYY4XYncNaxGYzii
         8DQJN3j0vHILy9rezfbzvloN31qUvMqLYFuCSxB1RtxKmjpvBvoqTldsit5bz/VTZN
         NWjgGAT+GZhoIq99LPKXJWPUmNkezn4rAkBDjrm/bF96x14de30ppqytIReOC+8nt4
         wRyxS0N8x2Sm+lNFpkQkT3fxbRtZHXFh7DAGw3X7swNAenD6vk9Uew6MjM4QQFgfJu
         2agB99uO2MBcz3FyRdQELzvRm+hKRSONnBYN1XyKSW8zWENfQa8aPK/R94U72z+NiO
         yMPb9lsCPmjnQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 087DE60A27;
        Wed, 30 Jun 2021 03:35:47 +0000 (UTC)
Subject: Re: [GIT PULL] mount_setattr updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210629123511.1191153-1-christian.brauner@ubuntu.com>
References: <20210629123511.1191153-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210629123511.1191153-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.mount_setattr.nosymfollow.v5.14
X-PR-Tracked-Commit-Id: 5990b5d770cbfe2b4254d870240e9863aca421e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30d1a556a9970e02794501068fd91d4417363f0a
Message-Id: <162502414702.31877.10617953807453883214.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 03:35:47 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 14:35:11 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.mount_setattr.nosymfollow.v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30d1a556a9970e02794501068fd91d4417363f0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
