Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84A4370F60
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 23:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhEBViu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 17:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232405AbhEBVir (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 17:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7F72661029;
        Sun,  2 May 2021 21:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619991475;
        bh=KG6y1nakyAFqM21muse0MKUJvkIrJKjM4WgCaifK4eI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MPLbVzs/RaRcNa0s7gucNyGLM2WaYT9F6medd008m2wH8j5ST0qcC6pcfWyDp4ACl
         sQUCkyGsgCINW18I/rFjj+WhvJc1/dlhkjdyBBkz7LikF6O9+CcOFNd90DvcpmUjQT
         YEPdCc3/O8SgwaQ8kzZ4GtAzAjddMdluYKqFfIbshLCIvTa+H5CpOyI+rQtAQ+dXtb
         vB+nstNu4FuimWR2H/VqPlQ03ahPZ+m6RYfoRxu8ck7ZkuOTHg5lvq714qLh2apYzI
         akQBUjCUiU9EozhUUSzOQ1FMFB7caHFqOXMj1Ayuy0dP2RikPUBEnedmQSgxoHXLsm
         zAh3UtoB0O56A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6CAC8609CF;
        Sun,  2 May 2021 21:37:55 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs pull request for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSQ-p8vJ6LbSeTeNUCfu-PsT2=iS2+Kab-LYCu9h6MUu2A@mail.gmail.com>
References: <CAOg9mSQ-p8vJ6LbSeTeNUCfu-PsT2=iS2+Kab-LYCu9h6MUu2A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSQ-p8vJ6LbSeTeNUCfu-PsT2=iS2+Kab-LYCu9h6MUu2A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.13-ofs-1
X-PR-Tracked-Commit-Id: 211f9f2e0503efa4023a46920e7ad07377b4ec58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ccce092fc64d19504fa54de4fd659e279cc92e7
Message-Id: <161999147538.30267.2765538701697779439.pr-tracker-bot@kernel.org>
Date:   Sun, 02 May 2021 21:37:55 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Mike Marshall <hubcapsc@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 2 May 2021 16:45:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.13-ofs-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ccce092fc64d19504fa54de4fd659e279cc92e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
