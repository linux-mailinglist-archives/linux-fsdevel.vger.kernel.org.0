Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3419C1F5FA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 03:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFKBuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 21:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFKBuF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:50:05 -0400
Subject: Re: [git pull] a bit of epoll stuff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591840204;
        bh=5nXrBcLI1uEIstboXFPvrUqwWcgXgFT3YkhrgQJzrPw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oHG5CJY/0A/BguWGP9Hgj91/ftiCgBZ8gOYfI7EV/Ts/uzoHXnwQU+Rvn+CaCp6ZM
         YiGrNuA0mwMxJfQ+/jn7ZF8NcQFmXGJimBV1oASOVtwIS0tM0VwgunXeLtBXKPxE76
         XXLorNasdtXwOYYFlwKEHSs9iG2dJjiHSfBJWNaM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200610203328.GX23230@ZenIV.linux.org.uk>
References: <20200610203328.GX23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200610203328.GX23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll
X-PR-Tracked-Commit-Id: 12aceb89b0bce19eb89735f9de7a9983e4f0adae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b29482fde649c72441d5478a4ea2c52c56d97a5e
Message-Id: <159184020461.24802.10401553401917385136.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 01:50:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 21:33:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b29482fde649c72441d5478a4ea2c52c56d97a5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
