Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A342320CB3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 19:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBUSkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 13:40:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhBUSkW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C3CCA64EDE;
        Sun, 21 Feb 2021 18:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932781;
        bh=MinWkuGXiGR97wCgjIBw+Y3yZxiPDl6yPUUMmzHyIf0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fRhHvtVHO1Qx7uq/lKYHT4deizDI6j+YiZSlP9t2UJpMkde39FteFzUAoUKH+mtnT
         KPO5QwS8sSWs2/9lnMgLEeSw6fwnU7Qept5RIPvhPf4CFjZj8CIPLaWfSXO2pNmyrI
         oifmZgaSDmreFkAM9cgUGYbMCwWCvlq80lyplZIYcdyyrn5ol5/QJEqwvs5givSZO8
         xTGbYPS5QeQY6POJlSsrNMdKGCXHlPPjV+QEwX7w0/cwevTd0scCGyHB8jMk5R+3c4
         Ezs6/+eyX5Ojqbf00+tYd1e3oYTgUsHttJ3WLB/DiUnOoCU27X9LNa/AdX9Z9qkA+w
         Lwz+bMybcjuJw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BF13560191;
        Sun, 21 Feb 2021 18:39:41 +0000 (UTC)
Subject: Re: [git pull] sendfile fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YCk/f0efY5OhibCn@zeniv-ca.linux.org.uk>
References: <YCk/f0efY5OhibCn@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YCk/f0efY5OhibCn@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sendfile
X-PR-Tracked-Commit-Id: b964bf53e540262f2d12672b3cca10842c0172e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 054560e961a0ee4067fccfcfa943335e1aa48928
Message-Id: <161393278177.20435.3908049806998672463.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:41 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 14 Feb 2021 15:19:27 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sendfile

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/054560e961a0ee4067fccfcfa943335e1aa48928

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
