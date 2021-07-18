Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A053CCA46
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jul 2021 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhGRSvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 14:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230402AbhGRSvY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 14:51:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6689861186;
        Sun, 18 Jul 2021 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626634106;
        bh=pvQ0Zxb2ILAuFyTetxXMOtpaF32INjgho6wS7jYMTBI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G+yW3f/HElZuO7vpPu42IhWReU7u6a44CCbeS2W6/O3VY8fHaXJ+mZ+Rpfy3bhqbp
         HEiFeGFdqlF4zZv1AUjnKGC3VzKsiXRiDUOW5ekt6ZswGk3a1k7WcjU61pn8bnmx+0
         RpaiqxaxUCUQB/gRu2a1eCA4jKUmnh87Huk3fixqED15fmv+DU4NYJXY2MiQ4mzYle
         dgiZ9CdZ6+L5Rx7Tue5ByiVp1ln0jznDxiNHlBshW0b18XfajBNen4EO/y3djfvprk
         5NSbMvm5GdOILVERJqQfdV/aMuEjTwnorDKNaLAWVQlTj2lkzGoltmIPznU5XTvn7g
         1Fk+HsBpr5/Zg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5C0C960A37;
        Sun, 18 Jul 2021 18:48:26 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210718163931.GB22402@magnolia>
References: <20210718163931.GB22402@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210718163931.GB22402@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.14-fixes-1
X-PR-Tracked-Commit-Id: b102a46ce16fd5550aed882c3c5b95f50da7992c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0eb870a84224c9bfde0dc547927e8df1be4267c
Message-Id: <162663410637.7372.13651239253430897917.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Jul 2021 18:48:26 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 18 Jul 2021 09:39:31 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.14-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0eb870a84224c9bfde0dc547927e8df1be4267c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
