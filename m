Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFE93BA542
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 23:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGBVuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 17:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230221AbhGBVuQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:50:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5902E613FC;
        Fri,  2 Jul 2021 21:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625262463;
        bh=W23hoKsKNZwgUM2RU2Z6+BHRmeA8FgIKMQtBI4tgovE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zdhb26xPH/JdGVUELgCzQA8GyXaCX8oAOnlSxYod1ppEeNgcyLtqsCv8x+QqJuOKE
         WUJXaikP97wOxLNWJRUHWwj6d+IL9zzvWGLpGwdZi9Jlr54kR/EGviJTCFawcxkK/q
         d6ipYnjdpGazNl2lRlWOKXGhtGVHNXvZcWvo3lmxGrTWyscYnucjwhUn6tBvY3ZhkC
         uWeAjlMJ2UDITPyFoYHc0pizQ44uF0NOr7IpmNjxS/VSy4a0T8CkQWQ4tNGrGIDCTk
         +GBrpbvKlOMMyf6vnfh5U/SulG6sokA3JAxEdnDbiL9kk+ggML2uYQ8gX5AJLaTEVu
         2JFNEt06TcCyQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5167360283;
        Fri,  2 Jul 2021 21:47:43 +0000 (UTC)
Subject: Re: [GIT PULL] configfs updates for Linux 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YN86Qdthbzfa5wfY@infradead.org>
References: <YN86Qdthbzfa5wfY@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YN86Qdthbzfa5wfY@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-5.13
X-PR-Tracked-Commit-Id: c886fa3cf6ffbe13006053ceb27c93d41928de30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ced4cca754a6322463720768ce50c45c2865ba5b
Message-Id: <162526246332.28144.32159973218493810.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 21:47:43 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joel Becker <jlbec@evilplan.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 2 Jul 2021 18:09:37 +0200:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ced4cca754a6322463720768ce50c45c2865ba5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
