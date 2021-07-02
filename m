Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC13BA545
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 23:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhGBVuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 17:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhGBVuQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:50:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AAE06613FE;
        Fri,  2 Jul 2021 21:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625262463;
        bh=H9G+NI6LjzmUjD6zKMMTCHkkfrf4Hsp9Ki2ndNk0r/8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lUf9LvPbIxJiYS0z81Ct5/GlHQQwgLReI/y+HAa9X1LTN2WTz6cu2MsaD/YbLB7z7
         LucSQxv2RairKPQWQK4gn10bgrIzxRKRvMXwZHgNsH2VeV62KVghsg+rW/OlmqYo3q
         ctRjUuk6uYCG+DCqre+K2XqsJpta3HplRy6P2BifAkaaSpvAX8fLYBXDoNCMaMOf7T
         XaalNnlfGhAmYbYT6kwZ13xZ5NFvVt3Vr/rF2UJ+oBdBR+0R2mLDr2kUDts4XNBj1o
         71FfGEXh96MtegOd0GUt0H+omyWkgh1xKKJI8dZ5/rwva1KQfJr732N99GV5t505d7
         EVFdlcmC6MVlA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A3E5260283;
        Fri,  2 Jul 2021 21:47:43 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210702201643.GA13765@locust>
References: <20210702201643.GA13765@locust>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210702201643.GA13765@locust>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.14-merge-6
X-PR-Tracked-Commit-Id: 1effb72a8179a02c2dd8a268454ccf50bf68aa50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f7b640f001f9781e0803fb60e7b3e7f2f1a1757
Message-Id: <162526246366.28144.4236351495860897999.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 21:47:43 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 2 Jul 2021 13:16:43 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.14-merge-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f7b640f001f9781e0803fb60e7b3e7f2f1a1757

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
