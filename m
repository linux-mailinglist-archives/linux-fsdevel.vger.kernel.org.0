Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3CC3480A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 19:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhCXSiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 14:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237181AbhCXSiC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7247461A12;
        Wed, 24 Mar 2021 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616611082;
        bh=55wf6kBFtwFtWJkC1Qb/tRewawmakxcwlWCRQyGpZXc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ljp1VGOIwmDNwx9NlBk6mK+1bVTnowPGa4Y4Ke4iCfAqqWu9H4P8K8/+laK2wr5VT
         gpwvqJbYDbeA+CQULzZpI5mZ8iS4mXLj0IEiUb3HgAD9XADQRgiuPxRnUI4HlfMneV
         rLzNzzxsF2R9bXlklQ/qiey1l41PmkCUEhm8zLTq4b57MNjebH1APt5aYZDbmceoGZ
         XDOxDO4FGzNjp8LgN1JEWivfG7D1Mme+6w/227ZjYXqAk43xTP0l5yQ8C6VgmhRyi6
         UqETs2ESQ8jgBHySAp4mrINHWJauRZ6wGZDzqMEmdpFRZysW/D9gNv8nQ9uPfuzkv6
         e2rOUQIGL1B8g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 62CB660A3E;
        Wed, 24 Mar 2021 18:38:02 +0000 (UTC)
Subject: Re: [GIT PULL] cachefiles, afs: mm wait fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2813194.1616574081@warthog.procyon.org.uk>
References: <2813194.1616574081@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2813194.1616574081@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-cachefiles-fixes-20210323
X-PR-Tracked-Commit-Id: 75b69799610c2b909a18e709c402923ea61aedc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a9d2e133e2fb6429d7503eb1d382ca4049219d7
Message-Id: <161661108234.26767.13532998179931130129.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Mar 2021 18:38:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 24 Mar 2021 08:21:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-cachefiles-fixes-20210323

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a9d2e133e2fb6429d7503eb1d382ca4049219d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
