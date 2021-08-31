Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE33FCE07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 22:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbhHaTxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 15:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232241AbhHaTxk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:53:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D5AAE61059;
        Tue, 31 Aug 2021 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630439564;
        bh=NXeM58bBdRNZl6g/+Nhv9FCzBl5YSDlYvb5psbhBkrc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bX5cq7TpO2XfZjHQ350AstOc6I7fYwnMcDr8bTlv4ypOQkef0Xxj4jM13QKY+gNTV
         3tSVMAY8BPFCLGHK0tmThK8kGJ++7pPQSu6qTPb/CCm4qa8fM7wZf+GC98Ivtl29DD
         RRnDMwNpJGtBIG2DqQB6qI71gStji2W7paiEDATx5dllGMBsC/l85QRPV21Wyo6TBU
         gQ0Jozu10H5E25XJml7YYwTo7c6Dm8jUpSHMwhuamhW2Ou4zD7W8r3vRWacy3tVpT+
         hGriZ43O+Yj8uUFpZaLFq21Hv/kYb46DwK9T85WganinyLfDte0BrzS8nBCJLG+9Dv
         muxsb4ThSFoaw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D12336097A;
        Tue, 31 Aug 2021 19:52:44 +0000 (UTC)
Subject: Re: [GIT PULL] close_range updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210831100239.2297934-1-christian.brauner@ubuntu.com>
References: <20210831100239.2297934-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210831100239.2297934-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.close_range.v5.15
X-PR-Tracked-Commit-Id: 03ba0fe4d09f2eb0a91888caaa057ed67462ae2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 927bc120a248b658acc2f5206ec4e81a794d8a57
Message-Id: <163043956485.8865.15505757350277339044.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 19:52:44 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 12:02:39 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.close_range.v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/927bc120a248b658acc2f5206ec4e81a794d8a57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
