Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C643FBB1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhH3RlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 13:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238194AbhH3RlO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:41:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2571160F3A;
        Mon, 30 Aug 2021 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630345220;
        bh=dsraajEjNXwREK502uy+6/ooqvkm+ddi4enWumGSyIA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=epaajeCAujAHm48cJ7m++JSwl/SNn14eAcWWqviCSng/YxVVIZx4psyGGS3K9cJTX
         XgKP6ugIACGoH4uO52acLKqEa+fUCTlCKlBRYBagfNZfoqMq3/GwVNUMmIfllUE9vd
         Q5/udXiuRFXfo7N5TPm2C/A6jpAp0qLk7xKnuU462b2bnVm/bklb04d5Es3LEoG9o8
         FjDnI2XbvXX7cDGGttfBpYecB83Uxzz7z8gfwPzRUI3AkJC4k7pARsTAiccBWH+T4q
         XhvxHle8OnOlu8FVU17N9nveG0lIrdYexiZleZPsIFMjZFiPX8n+bBHAGF+3z99PYT
         FQkfJgZx/B+jg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 168A560A4F;
        Mon, 30 Aug 2021 17:40:20 +0000 (UTC)
Subject: Re: [GIT PULL] Hole punch vs page cache filling races fixes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210825145118.GI14620@quack2.suse.cz>
References: <20210825145118.GI14620@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20210825145118.GI14620@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_for_v5.15-rc1
X-PR-Tracked-Commit-Id: 7882c55ef64a8179160f24d86e82e525ffcce020
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa99f3c2b9c797d8fee28c674a2cbb5adb2ce2ef
Message-Id: <163034522003.32613.11096537622163982634.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 17:40:20 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 25 Aug 2021 16:51:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_for_v5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa99f3c2b9c797d8fee28c674a2cbb5adb2ce2ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
