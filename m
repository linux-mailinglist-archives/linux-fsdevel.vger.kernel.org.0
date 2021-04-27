Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3279B36CC23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhD0UIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235719AbhD0UI1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:08:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 02F4360D07;
        Tue, 27 Apr 2021 20:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619554064;
        bh=FAB5oEa++Q6sbSqU4S0XmvToBY/6LIVz7MmNHC3lycI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hoPmi1M/FAmwn8uyAfuOdq7X5AxY58uLYIHSGRDgFOHBq4lJX2iI1bS190LOIQRHf
         HSh1fN7Ox6o2J34NmUnJtsa6mRs1ujQoAaqIAO7mq7PMqN34bFdi62+ekJ/Ia+BAqe
         wi7h4qxLnEwVM9mvKD6eEIg+4gv8p17kFL3YZCbt9naiOvbC3Y0/lJ4oAYjCaHrl9d
         Y5H/AClnXGMQQJNR/LZPkPsgXtgQ1Q9FyUj+vt4GOl52VxkUCev8+jsPudgqVyNl19
         YsNPpiBsqDvNCI6psS3w2Z1La7sONppP7SC+8rpM4URd24PALtg0JAdW0+/Ur2qDnN
         pHmDjCG6Lw90Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F241C609CC;
        Tue, 27 Apr 2021 20:07:43 +0000 (UTC)
Subject: Re: [GIT PULL] fs helper kernel-doc update
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210427113845.1712549-1-christian.brauner@ubuntu.com>
References: <20210427113845.1712549-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210427113845.1712549-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.docs.v5.13
X-PR-Tracked-Commit-Id: 92cb01c74ef13ca01e1af836236b140634967b82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc15422c1f14a84f539df7637b09d534e71b73a7
Message-Id: <161955406398.17333.15390846023719345766.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 20:07:43 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 13:38:46 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.docs.v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc15422c1f14a84f539df7637b09d534e71b73a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
