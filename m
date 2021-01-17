Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE102F9518
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 21:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbhAQUUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 15:20:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbhAQUUr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 15:20:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 291F4206F6;
        Sun, 17 Jan 2021 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610914806;
        bh=T5D+im4onKTFpain7lHAmx32O/a8JhqFsNsIAl2PpPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lVy7hw/Q+6bdjLConOCc4EZXEgosiRyUNvR53MieDh7hpCUoQQZHbZEzOwF7EpxDE
         4arCUKtJrmRTF8ZLd0rtzJp3m3YCD8013w/bpX3si7I4Ly46sCV+9lkclbTUmb5+8F
         QJQ+CCacSbH/FwrB6Xqh/yZRGxpP8R6YPuXs99qUv5xDdUDWDjsXpfNzNgJdfW5ii9
         OCuu9eJNvDdzZxIgT3DClTI5If7QHqZNf2NQHP2sc2tXQP2+LnAzgtBlqmIn8Ab7+b
         O2pVsvsmPmRAEtl+pBIQDYItMx/JEHNjWbzk/9nYxhotI19WLYQFwkb3GHJZYT0e/F
         d+fCY1JmXSARg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 1699660077;
        Sun, 17 Jan 2021 20:20:06 +0000 (UTC)
Subject: Re: [git pull] vfs.git fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210117032115.GG3579531@ZenIV.linux.org.uk>
References: <20210117032115.GG3579531@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210117032115.GG3579531@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: d36a1dd9f77ae1e72da48f4123ed35627848507d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a527a2b32d20a2bd8070f49e98cb1a89b0c98bb3
Message-Id: <161091480602.19660.12485024734325890961.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Jan 2021 20:20:06 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 17 Jan 2021 03:21:15 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a527a2b32d20a2bd8070f49e98cb1a89b0c98bb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
