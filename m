Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C5A3B9669
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhGATWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 15:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhGATWl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 15:22:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 791C9613FE;
        Thu,  1 Jul 2021 19:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625167210;
        bh=gvKeRV4p419r1F6ZMC6M8PflKnQpEcijYKzkM6SbHw8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MIht6FrJ+02ELcSTGQGamPovKrKKthVg35NVZj5Ez6wVuYDLcWc3ZCLx82mb7HDdy
         LQwTVgAMmwWnqAs3Q3aO+UMwe6RZMORsfGp1y6Xt81eIBX2Uh5QBddTKJ2cPkUiFNi
         31wlAzyF6+2WgCh0LlYZ6N+aTGdy6SQKkG3jyVLftxBsGkbJMTuHCrPXQ8o5bV+j76
         giHWMv34YbLS0QEInZ5E07OyO4030Vvo5VNWeeC8c7e+xZeLZvwKuLZ7zV7ocH3XF3
         6NyTlXXZbQmpZ7mcSQ9Sp5+kNQ2oEruL27Yep3B8pnW28F9Kqo1Q4b4BZWPy6y8IfV
         dfynR051zZCfA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 71D9D609B2;
        Thu,  1 Jul 2021 19:20:10 +0000 (UTC)
Subject: Re: [GIT PULL] Quota, udf, isofs, reiserfs, writeback changes for
 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210630161948.GA13951@quack2.suse.cz>
References: <20210630161948.GA13951@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210630161948.GA13951@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.14-rc1
X-PR-Tracked-Commit-Id: 8b0ed8443ae6458786580d36b7d5f8125535c5d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 911a2997a5b7c16b27dfe83d8e2f614e44d90f74
Message-Id: <162516721045.9429.17270473087388304951.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Jul 2021 19:20:10 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 30 Jun 2021 18:19:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/911a2997a5b7c16b27dfe83d8e2f614e44d90f74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
