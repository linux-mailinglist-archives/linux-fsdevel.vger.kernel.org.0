Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CDC3BDDFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 21:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhGFT0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 15:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhGFT0o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:26:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4AEC361CAB;
        Tue,  6 Jul 2021 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625599445;
        bh=G9qbL6rD8y73F8EUjU8XvheyXJPIxDnhGB5Z8+byppE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j5ULxS07fgLqDqasMotOo1YDheoJBI1VIBrpjdI6Bn8P4zeYIjmNb/5DQMIm2sajn
         0bhpoPzGHjQ5onBbLWTx2Jie3NS0yf8PDRwUXzenMiopzktE/2FhTMySMXn4/UyRqo
         Qo1eT7tCuMGOCVS16mxxmO8wPsg0Zz2PLnOojlDSpxPeIJhJvcAQl4b5h+BHTtMlZC
         grxgywopNGdZ4nwZNh8CBM2RmZUnFmTMdy6kPnWBVtNKlOSWw3T+R0nuzcFfIx8XQo
         ILqASAhP5kE6/EigZS0Z7XWyP6u7WJG8n56hTn1btbpS5RrlccMNedUrFqg300gxB+
         Xhgh//4VsVPKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4533D60A27;
        Tue,  6 Jul 2021 19:24:05 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YORxA9+DVLqNlH99@miu.piliscsaba.redhat.com>
References: <YORxA9+DVLqNlH99@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YORxA9+DVLqNlH99@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.14
X-PR-Tracked-Commit-Id: c4e0cd4e0c16544ff0afecf07a5fe17de6077233
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e4f3e15175ffab5d2126dc8e7c8cfcc1654a5aa
Message-Id: <162559944527.10101.9554763098452921169.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Jul 2021 19:24:05 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 6 Jul 2021 17:04:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e4f3e15175ffab5d2126dc8e7c8cfcc1654a5aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
