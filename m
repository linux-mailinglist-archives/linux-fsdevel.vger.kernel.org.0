Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923313CCA48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jul 2021 20:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhGRSvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 14:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhGRSvY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 14:51:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5046361184;
        Sun, 18 Jul 2021 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626634106;
        bh=rJyAuMm1vmjPgHJgTP5GKsEyI5x5h60bVRrsKbrveTk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V6n9hJlPo2q8abU1oU1Iq1aZCTLFTFSUZn71vCNDHJmBhMPrYjr1N8XfNGEouFBG7
         TPbqoLucf6W2hkyy8n7/JlCdB7/J6yADymScM32f6zjPmLkTcQcBRtH0gMOnv/MFMb
         NFvJnA/1/AB55jMuAQJRW0XsaezFRHlT5ohEDfusxKZf+2vB5lCxs7vQam0pe+3RcK
         o36mC9NSy/TO5eRvk5hqrOGyLXsBmzVdTxqjyq0lYZmJWffsYjHh+EI9JVOkZmJ4Gm
         1wk6OonEQvcXaExFZ5GF/Dq40Ix0LY18nUA+kBxEB9oH7GGPzV9BWtFVv+2p0S0r/p
         nIADrUPaaVWDA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4754160A2A;
        Sun, 18 Jul 2021 18:48:26 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: fixes for 5.14-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210718163232.GA22402@magnolia>
References: <20210718163232.GA22402@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210718163232.GA22402@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.14-fixes-1
X-PR-Tracked-Commit-Id: 229adf3c64dbeae4e2f45fb561907ada9fcc0d0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbf1bddc4e171e26ac55a9637c7db13e75acf4fa
Message-Id: <162663410628.7372.7970370951401810839.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Jul 2021 18:48:26 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 18 Jul 2021 09:32:32 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.14-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbf1bddc4e171e26ac55a9637c7db13e75acf4fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
