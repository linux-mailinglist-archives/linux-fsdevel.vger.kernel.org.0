Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB43D948A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhG1RsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 13:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhG1RsL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:48:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 502C760BD3;
        Wed, 28 Jul 2021 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627494489;
        bh=ZvEUGHST7E8KYZRmlF/dhfdsrMhFYCLFXhraGfvuhR4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k4+SLkJDoNsX5pkEl2ZJ/sR7+JKcXSBtVrfkxGGmHhAf4CTNTT2hgbxFPuFXR3p1v
         nujJwbmy/kQP9VrJfomtktxN19p227hx/hzNCTKYzdz1/0cZQguc0IDfLwdWuQXOTB
         5F+RPMucjQfQ7gMECJPm1OkcguwlCAyUNXc5GXAFb0cQQWiOsr7sPoVjfm/2LyGi+F
         f5OGvd3WI5sD0+G38t7Ip0jnbN5TQ9UplvHEuIPu4C+mR8c44GoSiChKmX0m0xmk12
         u/se2rPHFrwSjb3IuTNFt95L7w43/QfYXu4HUv/LoGmfRI5nRxwFaFHkjPsVfumlNd
         Qa0hQ1sbzQ2JQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4B3DF609F7;
        Wed, 28 Jul 2021 17:48:09 +0000 (UTC)
Subject: Re: [GIT PULL] ext2 and reiserfs fixes for 5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210728132655.GI29619@quack2.suse.cz>
References: <20210728132655.GI29619@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210728132655.GI29619@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.14-rc4
X-PR-Tracked-Commit-Id: 13d257503c0930010ef9eed78b689cec417ab741
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4010a528219e01dd02e768b22168f7f0e78365ce
Message-Id: <162749448930.17712.9667733859748007305.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jul 2021 17:48:09 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 28 Jul 2021 15:26:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4010a528219e01dd02e768b22168f7f0e78365ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
