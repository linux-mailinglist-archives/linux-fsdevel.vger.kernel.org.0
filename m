Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4BC479807
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Dec 2021 02:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhLRBfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 20:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhLRBfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:35:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AADC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Dec 2021 17:35:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 563D661F48
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Dec 2021 01:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4279C36AE7;
        Sat, 18 Dec 2021 01:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639791318;
        bh=/i7ak4txA+I8JbdMd9zzrqu6xWKpHLJhZVm28fP+eaA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iQmcp0jpzwnRRHDK8guG9McrB2buLUJCglt2dxaNNC2SZuULV1CdQbhWxuAEi14fv
         bnuf+yGHpREzXpfX7ahbPAOssSpjSNKkA/qJgtF+kDx9jcJABEip+kxk6h826uHi1t
         ZV3vZauwsvbbEiE4PKpOLS+Ti8ELe5Ddt6YPYyKeb9esD/4DLNV7Wv7EUEg1d9vEcI
         k+DLLRunGOCNZFF+FHmYdR9XFtiZNQRENsi2rGt/n6EQBpAFDSlCI6huotwMNHMGFG
         WLlNav288NdA7anmak7rxAShwdhHW84qYQe59wHtse/MmU5U8+tkfp/Ki6PA7Zmef6
         6Il09/eSR7UvQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 971F860A39;
        Sat, 18 Dec 2021 01:35:18 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 5.16-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211217234907.303996-1-damien.lemoal@opensource.wdc.com>
References: <20211217234907.303996-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211217234907.303996-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.16-rc6
X-PR-Tracked-Commit-Id: bce472f90952cc8be03dded25c4aa109d27e5924
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1887bf5cc4954d93c06cb0d6a8242fe7f00b4584
Message-Id: <163979131861.2028.8362989102567515014.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Dec 2021 01:35:18 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 18 Dec 2021 08:49:07 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1887bf5cc4954d93c06cb0d6a8242fe7f00b4584

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
