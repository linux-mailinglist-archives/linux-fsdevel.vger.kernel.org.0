Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345BF2DB9C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 04:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgLPDox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 22:44:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLPDov (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:44:51 -0500
Subject: Re: [git pull] epoll rework
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090251;
        bh=F3Bo6vRcUuVqsTzpFOxJeiNYuj8d+g0rG5mW4NsJE8Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f0SRUXPBUswzBUOjcs9WkYTNhGruPWhBGWbKbPb1BqTkyRSuWf3owdTiRy/rkQCYr
         d/zy1RbovcahOErLSn92TUULYp25HGgZ/KkddIR3g3nSxsFTIYPL3T8BbdOokD0Egj
         Vb62mCrmw1BZBrJU+m8SwfLrw36jehqOpCBW0LiZgjD0mqQWeugr9Li+Zu5N47f+B1
         mSB6UfNXZA1wmYwA4by0vXAvcSjXWZmkgRnfDqxm+YkBTLE9VDPG+1I4hmVwyRF9NS
         TGPSK2vcsZMqbjdx5RBOfkWp/rbVHdS39IDj1KlCE0GgoM3YuwqRxhRqSzUHpDeQvP
         jCrblc/bS6UbQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214223417.GC3579531@ZenIV.linux.org.uk>
References: <20201214223417.GC3579531@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214223417.GC3579531@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll
X-PR-Tracked-Commit-Id: 319c15174757aaedacc89a6e55c965416f130e64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a825a6a0e7eb55c83c06f3c74631c2eeeb7d27f
Message-Id: <160809025093.9893.10861203833087594595.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:10 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 22:34:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a825a6a0e7eb55c83c06f3c74631c2eeeb7d27f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
