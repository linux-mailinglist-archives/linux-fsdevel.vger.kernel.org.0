Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD500326DD9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 17:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhB0Q3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 11:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhB0Q3s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 11:29:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 174B264DED;
        Sat, 27 Feb 2021 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614443345;
        bh=IF5KrOhlU8cBLHUhpwdTgbI39xpEkuocUjU5GL0divI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L+YYPufDIECLo7BD4dbaKqJYQkxpBVzdDJ4lT1/A8LquaG7YKxdZhogrYNvyNQI4k
         xfsxlLbgkpKA2ruLp9VREy4qLp6W/Na4PRH81Abuu3us2EYHCbAfKQ9GNn/O/3TmOC
         UB17GQQFGjBImDOZcLxUyPtIU51MkF7J3YqYyy+6FoONvksyKJ7vUlfJCsfsFrRMw6
         oSX54JDNzkHZWsE6FQAYizr8WRjZT/Pq/x2ne9fa/QZQGbZxTxA7YUHigWmcUNndCo
         sj3IrlCMT7TtgYxWXhgXqeHhQkfP2LZRXDDvABFa/LPTKfwQjP3fAuJtUEo30/YiO8
         z4h0wP4ZSRDBg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 04B3460A23;
        Sat, 27 Feb 2021 16:29:05 +0000 (UTC)
Subject: Re: [git pull] vfs.git misc stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDnf/cY4c0uOIcVd@zeniv-ca.linux.org.uk>
References: <YDnf/cY4c0uOIcVd@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDnf/cY4c0uOIcVd@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 6f24784f00f2b5862b367caeecc5cca22a77faa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ceabb6078b80a8544ba86d6ee523ad755ae6d5e
Message-Id: <161444334496.24634.2390663305624345985.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Feb 2021 16:29:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 27 Feb 2021 06:00:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ceabb6078b80a8544ba86d6ee523ad755ae6d5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
