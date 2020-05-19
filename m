Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752B61DA5B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgESXkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 19:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESXkC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 19:40:02 -0400
Subject: Re: [git pull] vfs.git fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589931602;
        bh=5opkHb0R86fUJcTzkP/kljBnGNUL+6FNaV4sQhh6Gi8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d3dy7WBxAmccnpXPUzmYCUeOZNQd3hYcz5LYKKROSMvP8GfvaHTjCdhKimUGtDbDD
         e8tdu2S74YGqGXV4vGgWJt9EW5YU9TprtjgkrUgPePxDDEP/k7ITayZaI9hxmmBvsr
         EMfJEu4Mh0y9lW6nyfAiM6SBUny1jfkXd8H9Nzms=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200519224830.GV23230@ZenIV.linux.org.uk>
References: <20200519224830.GV23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200519224830.GV23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 4e89b7210403fa4a8acafe7c602b6212b7af6c3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 115a54162a6c0d0ef2aef25ebd0b61fc5e179ebe
Message-Id: <158993160225.31257.10906065004391606523.pr-tracker-bot@kernel.org>
Date:   Tue, 19 May 2020 23:40:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 19 May 2020 23:48:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/115a54162a6c0d0ef2aef25ebd0b61fc5e179ebe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
