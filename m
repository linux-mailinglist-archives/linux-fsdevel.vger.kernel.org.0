Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2F34297D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 01:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhCTAf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 20:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhCTAfR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:35:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4282061979;
        Sat, 20 Mar 2021 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616200517;
        bh=Bo0LQ01jz/FxphSgbU+khnJAKkXsNXu0FLxv7JzbtYg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T4SeIrPuo0CNcnwQjRlXkBPh1rABmrllf+V3GLhmd/qyh8DkVAQfb8jLYtFxHbDEo
         VVIpdcWcTLndkZsgp+oqbDD6yEt6hOt3xvBhvJfTKRGFfSQ3ccQ5GkteFj1lrVThme
         1dpLXr+G+TOqwTvJe55mG3IzSxSVmcFxqxoLdDwza7P5Vfjjdzp7qnNEF9zJ8X2343
         524GejgP9aZeyOLbO+praA1URSrQUgOkveGlIuQI5J75CpA4cfmYcsJH1BDow0dKPF
         rRrbF4pAKV8fX6K3/nQ3dTMrC9Giy0FxPsnGmbO6Wz902123jzntpHVnmZI+zgp/H+
         thi9D/kfQaf/Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2BBED609DB;
        Sat, 20 Mar 2021 00:35:17 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210320002714.436286-1-damien.lemoal@wdc.com>
References: <20210320002714.436286-1-damien.lemoal@wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210320002714.436286-1-damien.lemoal@wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.12-rc4
X-PR-Tracked-Commit-Id: 6980d29ce4da223ad7f0751c7f1d61d3c6b54ab3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c273e10bc0cc7efb933e0ca10e260cdfc9f0b8c
Message-Id: <161620051712.3919.12661751559129951034.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Mar 2021 00:35:17 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 20 Mar 2021 09:27:14 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c273e10bc0cc7efb933e0ca10e260cdfc9f0b8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
