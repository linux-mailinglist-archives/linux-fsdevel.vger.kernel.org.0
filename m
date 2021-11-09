Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31944B347
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 20:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbhKITer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 14:34:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243391AbhKITem (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:34:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EC7146134F;
        Tue,  9 Nov 2021 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636486316;
        bh=HfqS+RG5tYj5iGr44sACjYEXiOTzWDp4C+ie012WV9I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CbQMumXZw1mnqsxS32frg1zKSNLnN9YCF/yatkPhPd/HEDQZ/EmZGX3lAQe33cKVB
         16ccx2Wu+7fW3JncamOR0PZEylGTYQurqO0NxEWbzg3JVfqwTgBLwnXQFu3jcG2Gzd
         g8MyT75el9LvrlL0FIpuGUrNKCSWhksAWzQMdRxwG2KfC51rUenOdybT92G9Anjxyw
         vNhKCuosVUlwMJLeydgPiskvmXiPFDybuwBDcTgAvCXXg2yP84H95cLzhOGGU1B7Iy
         PYbJAdojRczIV4gRFPKKUbikvcZxsxZtezSn4G2lCFdMX7D/hFNEvzlP/sXn96zjVp
         a1WBZgDJ5OTyQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E5E4D60985;
        Tue,  9 Nov 2021 19:31:55 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs: three fixes from other folks...
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSSOwQcMfwaVtqRe-WAF_LEjQzqWB+G-_ks4j=2J6s1s9g@mail.gmail.com>
References: <CAOg9mSSOwQcMfwaVtqRe-WAF_LEjQzqWB+G-_ks4j=2J6s1s9g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSSOwQcMfwaVtqRe-WAF_LEjQzqWB+G-_ks4j=2J6s1s9g@mail.gmail.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/hubcap/linux tags/for-linus-5.16-ofs1
X-PR-Tracked-Commit-Id: ac2c63757f4f413980d6c676dbe1ae2941b94afa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0c7d4a07f2f0f7cddda690b53f2e50c50ded309
Message-Id: <163648631593.13393.5966838947503809877.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Nov 2021 19:31:55 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 8 Nov 2021 10:11:13 -0500:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/hubcap/linux tags/for-linus-5.16-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0c7d4a07f2f0f7cddda690b53f2e50c50ded309

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
