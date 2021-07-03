Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660263BAA28
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 21:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhGCTn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 15:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhGCTnY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 15:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D67461627;
        Sat,  3 Jul 2021 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625341250;
        bh=MgRFRtvW8LTlbs41xRZ76fCe1AUak7IL1YVd4FlxH9w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CqhVAyLOsgwClz0Er7igc9f5kTjqOkhk857BtrPgflz87CqDo4saEgzWPOlWszvdG
         4JfK83kLTjWmH1pCebeQS+bOpuyWL2SIlZaF37fGfnc6Z6rDPF2DWA//0mJ5EEFDRA
         76Wpg+Mtz0QXwiBkruYt/0wyveicQHwO6dQ4FhvsNGKiqyp2QU5o+EB8Zzrt4sB+N8
         g4A41lIwC79hQz0+xu7MRcSVnfZt0Ogxsz49awAwXBXpUmdfJNwBk/L1/JMw714eo9
         5KiR9QL6Nk6we6sd1/O73kO7r6WQBVtXvPrHUl+zBENkVhVRdFQ3xP/BnCOceXpbDs
         Le6cq2PYj8ebA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 28BE160A37;
        Sat,  3 Jul 2021 19:40:50 +0000 (UTC)
Subject: Re: [git pull] vfs.git iov_iter stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YN/SPsDU3qdweQX0@zeniv-ca.linux.org.uk>
References: <YN/SPsDU3qdweQX0@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YN/SPsDU3qdweQX0@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter
X-PR-Tracked-Commit-Id: 6852df1266995c35b8621a95dcb7f91ca11ea409
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3acb15a3a1b841dc709c3853ec900170b2478e5
Message-Id: <162534125016.29280.18271769421083969613.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Jul 2021 19:40:50 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 3 Jul 2021 02:58:06 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3acb15a3a1b841dc709c3853ec900170b2478e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
