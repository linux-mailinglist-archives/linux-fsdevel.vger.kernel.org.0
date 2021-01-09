Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBE82EFD06
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 03:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbhAICHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 21:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbhAICHH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 21:07:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9D99023AC6;
        Sat,  9 Jan 2021 02:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610157966;
        bh=XgNBcMcH2z2Okn0EaX7+WrGAUoX1VY2CbTGv1/zD4fc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZCnab758G70YJcmZYvmnMe5c4IDS6eNdEkMw2cczaslqaAEOYW0haGjGlsC4phc91
         FsDVyJ51vr+MClauPyzeA7Bc8VwXh7eKysPbDEEa3vV6Z1HpdhePkKDuUbS/GCskvV
         BMOHA9lw1AppN2pDglV5nxLlh0/BB4ZvqhcwOvL0u1xvRU7Uyph9p/sg0dEHp+q4DS
         Uc520LcK+oXg7JFvMxIICYQbFM3c9yGNl703shJgmwab+D7tThLFf0/J2lZcOUpuwt
         gpxb6DLBQIty5y8yTqinHLVUJ4VKbJyVMDRsRW9LOMdEouCM9cvK+vhH1oWqmXzJ7B
         6BAyMIHvU8H7g==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 8E5F260077;
        Sat,  9 Jan 2021 02:06:06 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210109002841.941893-1-damien.lemoal@wdc.com>
References: <20210109002841.941893-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210109002841.941893-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.11-rc3
X-PR-Tracked-Commit-Id: 4f8b848788f77c7f5c3bd98febce66b7aa14785f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 996e435fd401de35df62ac943ab9402cfe85c430
Message-Id: <161015796651.28077.12964165452282999200.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Jan 2021 02:06:06 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat,  9 Jan 2021 09:28:41 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/996e435fd401de35df62ac943ab9402cfe85c430

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
