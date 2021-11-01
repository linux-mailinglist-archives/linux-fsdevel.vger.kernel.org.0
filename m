Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D64441F40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 18:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhKARb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 13:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhKARbY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7A02460E8C;
        Mon,  1 Nov 2021 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787730;
        bh=qeNiMFBy1cSNUj0ddz0b+hNEBvdrSshNeRvCqeEietM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lDvVBMHk/LoAeJ/VxdTmEFl3k7hYfSrWy1NeWnpU2WRnyj3XuYDNH47HFhscY4F/0
         YfIyp3jLzHqLUY5bfM6eHeOGWe3n2AcRiqwimAeSSer3PBx0+nhDyZJup/9856z1Qm
         CJ9nKXY7SaG1vBm6MJdJqrZjLePNHh2WgCVJczP/ISDZTMR0U7naFNbkSNEfxrifEG
         F1LQHDcnhVGXIHz9nS/n8xtJVeQpuQA4h1nFN3Ws7e9zGRSAFLB9TKoAg8r3sm7StJ
         ScpHaENARZvg/OYg3h9Fps+ADhn8LGF85BDajF4xWFOFbnKKFM+ztbwjcwChhwtJsp
         nz6UmOwIStBJA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 73CA360A0F;
        Mon,  1 Nov 2021 17:28:50 +0000 (UTC)
Subject: Re: [GIT PULL] file locking changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <44baecaf3d322ef0674b7b9b88026cf18d371d14.camel@kernel.org>
References: <44baecaf3d322ef0674b7b9b88026cf18d371d14.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <44baecaf3d322ef0674b7b9b88026cf18d371d14.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.16
X-PR-Tracked-Commit-Id: 482e00075d660a16de822686a4be4f7c0e11e5e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ac211426fb6747c92d570647e2ce889e33cbffd
Message-Id: <163578773046.18307.9004662856873438464.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:50 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 29 Oct 2021 08:55:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ac211426fb6747c92d570647e2ce889e33cbffd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
