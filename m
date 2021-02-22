Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D09322183
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 22:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhBVVgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 16:36:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhBVVf4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:35:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C3E6664E5B;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029715;
        bh=FNLnMzUtwbJilYz9XqPcFpfrYljutKWT1xCB5KIOQqM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EphkNYIUgvIueR7mDgq/823fyCB+9bKA0stFRP3puVll655uf17uwKaiCU9ucOz8F
         hEFq/o/KAJDtjdn+YxnMZza5Emuk1r7L7QKaDg34vXT+HFWQwiOB6CJ8dcVfX/qNvP
         LvGVJTPCEqmnV3HVXEG/AmfvtHsz7jJFZ8/bm/oH15NT5nvze7klHHI+qzU1jyOAGe
         5dzLyARXYfjiv62zYesbEk+mMXCYqM8g6U/n9XJpQxDAp8jfjak/ASs6QCkmzKuO1y
         Yn2aWZi9a5+LIq9eJd1oqRXu1zKKNeNQUrlxlT06LsIocBlsI3NiqptErSRx6a2Xe9
         TyTkwkCuDhjoA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C0307609CC;
        Mon, 22 Feb 2021 21:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210221224626.392359-1-damien.lemoal@wdc.com>
References: <20210221224626.392359-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210221224626.392359-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.12-rc1
X-PR-Tracked-Commit-Id: 059c01039c0185dbee7ed080f1f2bd22cb1e4dab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f3d950ddd62f470d659849b5e3bbe27545aea6a
Message-Id: <161402971578.2768.16694835607392921950.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:15 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 07:46:26 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f3d950ddd62f470d659849b5e3bbe27545aea6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
