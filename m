Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCCE320CB6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 19:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhBUSk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 13:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhBUSkW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0CC5964ED6;
        Sun, 21 Feb 2021 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932782;
        bh=hD0W6TeHmRY+7wntoH0hAa4Kz9t0QlbvFUvtY7qPtC8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XAb1vUTOd5p2MT7KdSwTAAZHYK2jMyTUp6yrELN2ySSoqjxq6eSnJOT2+1vXba6ee
         PF6T4DbIjps5CxdKyXbBm+h8O7T0jSE11iywdizJJMo28J7ZgU6SHHRKb7FF0N3/gx
         +KLgUsBnupddu7r9cK1BEZi5xcYWJs18HjgYN93w/aIkCaSKvfXUwLgm3qVl8ZtYoD
         Ou0G9/B27Fb/Dnc4USsyC132cMNtKvxAy+B8eT0UN52GXUsOaicmwACOIUukxSRtQz
         UdZ3FhLBet5PE9yF7rONQn1Z72NrVAZxPjCj5MeAuY2L4epb3ESMGlfySkD3EJdG57
         YncYPOCqwxAIw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 066E760967;
        Sun, 21 Feb 2021 18:39:42 +0000 (UTC)
Subject: Re: [GIT PULL] fcntl fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b811d76937408f4fded7314da18f770b88c83fe2.camel@kernel.org>
References: <b811d76937408f4fded7314da18f770b88c83fe2.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b811d76937408f4fded7314da18f770b88c83fe2.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.12
X-PR-Tracked-Commit-Id: cc4a3f885e8f2bc3c86a265972e94fef32d68f67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 961a9b512d314d133d5158d3a1d11e5cc49ab1a6
Message-Id: <161393278202.20435.13985739279879273918.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:42 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 06:50:24 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/961a9b512d314d133d5158d3a1d11e5cc49ab1a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
