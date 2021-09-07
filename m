Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994FB402F74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 22:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbhIGUPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 16:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345290AbhIGUPi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:15:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 30F76610E9;
        Tue,  7 Sep 2021 20:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631045671;
        bh=1dujuKFK8w4P9EEKkDUQFmkdzg+7U5OwR+zr3bspJOY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YcC4k15gvru9rvImXltRb50JScvBidkcngD9TwbUQM/DnYyZIPGcnzH8J7EVrtva5
         bD7OSzY/bxunqX4Pr1UWzJhZCzoSHIdAsSCrzO3NL6+H7QN0oc7ZEmWz+FF7P9g6KT
         oWCJrJmDCAWftBKcvgYHdfGuPCpBUPD7xPA5rQ1vLSDhS9mCdbsNX0IDVr0oCilc7b
         sJVqXzfxavAdDXVvj0dwy19nif/00QWFeSmgu32/FyERSzrOobf9rRLwOHfKe8hzuP
         oRdVUJt1V343wEJYkc69dmVpoMGgQX2mQIoECsY6+kQn04PozcxbqVxkyiRLDQxbGP
         wk3EyEPCLkCiw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2B10A609F5;
        Tue,  7 Sep 2021 20:14:31 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTcUNWiS2+m705i7@miu.piliscsaba.redhat.com>
References: <YTcUNWiS2+m705i7@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTcUNWiS2+m705i7@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.15
X-PR-Tracked-Commit-Id: a9667ac88e2b20f6426e09945e9dbf555fb86ff0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75b96f0ec5faf730128c32187e3e28441c27a094
Message-Id: <163104567116.21240.326539270436901238.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Sep 2021 20:14:31 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 7 Sep 2021 09:26:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75b96f0ec5faf730128c32187e3e28441c27a094

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
