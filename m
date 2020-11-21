Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011FF2BC182
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 19:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgKUSjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 13:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbgKUSjD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:39:03 -0500
Subject: Re: [GIT PULL] fanotify fix for 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605983943;
        bh=WBD20vjgWIRORJFiFVnvsZJYVF68nO/Dkqr2WfQZOcE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rCwffB/LRdsMuvBcpi1jRB2NAXjO27UPfKuhYdngG0ea2yuizoqhHPR7WJvyR49QQ
         4UIE3BCts/lrFO8ML0mnhfWrV9sjDjcepMToblmOraU1nZTiF7r+CsFWCdaiC4awA6
         NO9JmCXuiyn8pVwT0+tQNh9o1jGCoLK8r3sU5ic0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201120201854.GC27360@quack2.suse.cz>
References: <20201120201854.GC27360@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201120201854.GC27360@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.10-rc5
X-PR-Tracked-Commit-Id: 7372e79c9eb9d7034e498721eb2861ae4fdbc618
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba911108f4ec1643b7b1d1c1db88e4f8451f201b
Message-Id: <160598394319.7589.8119310265674166801.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Nov 2020 18:39:03 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 21:18:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba911108f4ec1643b7b1d1c1db88e4f8451f201b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
