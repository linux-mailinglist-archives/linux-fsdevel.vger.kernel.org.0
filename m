Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A8274BF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 00:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgIVWPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 18:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgIVWPZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:15:25 -0400
Subject: Re: [git pull] vfs fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600812924;
        bh=jmuAq5tea2wXdciq0ihXQtHSWAh1KGEWL9/YTE4qmjg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DHIuJxUIctqAyoedg/BGhoXQK24Z4O0p+Wq5yRvDgWMP+fjL8urIbPC0g4E5J1efR
         UOZ/+kcIPUFW5XyDtdaJzYSwndXPzQakPaM5827un30g34l+nJChL8eToDxN2T+f8b
         UqZHpodlQVVEufOgtH5+aKKZO3eBmIWWVJlPLptM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200922212908.GB3421308@ZenIV.linux.org.uk>
References: <20200922212908.GB3421308@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200922212908.GB3421308@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 933a3752babcf6513117d5773d2b70782d6ad149
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 805c6d3c19210c90c109107d189744e960eae025
Message-Id: <160081292493.1950.2619560059383841489.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Sep 2020 22:15:24 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 22 Sep 2020 22:29:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/805c6d3c19210c90c109107d189744e960eae025

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
