Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0283736EF66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 20:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhD2STL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 14:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241007AbhD2STL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3078E61459;
        Thu, 29 Apr 2021 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619720304;
        bh=6j/av4d0M3/hNqObn6+7yh+aKCPS6QNpSxslBHm6byo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bi++nVtD2LERw1/Pdd00PIw7JxVrg5mc25Pbhgn595hz6GpbZKDGizskLJeDJBTmA
         D2SKGAy8/ifibwY74I3+oZ1qmYK0kQMLbSDkz8/B5xxBgeHJsw9QvhzgHqciDgk5RB
         wARhi+trROUcFcOESDPPuTsTOlm6NohzgSxMbPTSh5pDaiQskSbje/NFvTv7s1W90c
         yKIrX8g9Ss9LHxDS5tPXnnf60HDUnidCZOK+d0mbPSZdVFebt5Ohm5hzNxf2xy8eMc
         YFwptHc9DU3ZhcNtNOoGVkPgI7ofDcph12/THq34r6OXLf1DLfbXYqBj/h4P/hwPWP
         Bd7KM7RcaSzxA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2AF9460A23;
        Thu, 29 Apr 2021 18:18:24 +0000 (UTC)
Subject: Re: [GIT PULL] Quota, ext2, reiserfs cleanups & improvents for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428122432.GC25222@quack2.suse.cz>
References: <20210428122432.GC25222@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428122432.GC25222@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.13-rc1
X-PR-Tracked-Commit-Id: a3cc754ad9b80491e2db5ae6a5a956490654abb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 767fcbc80f63d7f08ff6c0858fe33583e6fdd327
Message-Id: <161972030416.24326.5597744192884778063.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Apr 2021 18:18:24 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 14:24:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/767fcbc80f63d7f08ff6c0858fe33583e6fdd327

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
