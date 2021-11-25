Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2345E0A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 19:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbhKYStK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 13:49:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhKYSrJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:47:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0885860E8E;
        Thu, 25 Nov 2021 18:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637865838;
        bh=Ww36dVQvD7Y54YQ3VLNNtyqWcKw4HjCvbAsripqXkys=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UGgKjTBFnT3fl5i/LxNQXLM2dJ4uz1ppniKGYGMiSt5CT00hByfBAp3S6ScFL8QZE
         Q5K9wzFOoB7E53nhYasTckREi85/FVwfux9xf/MCbd1kS7hDKBB1UVzgNfIUqG1Kq2
         0IHcblV3du9ljkBGyprm8s6Ykx7mUqkxr8HE0Y3BFnifqAmGK+la5czkgiGBFwJnRK
         JcswHYDypGCF8Tzi5rvpfALbP2NgHNrgW3yft9CEQQm17Ox8e9pKpKWgQ9sOx8w79p
         664GLatiAbWzOhk5GBmu+U2iAVOqgv2jSoYdd6cEnoFLzUQiKLvNBX5FshDMnw+CjZ
         pC33CskSxagmg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E997A609D5;
        Thu, 25 Nov 2021 18:43:57 +0000 (UTC)
Subject: Re: [GIT PULL] Folio fixes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZ6enA9aRgJLL55w@casper.infradead.org>
References: <YZ6enA9aRgJLL55w@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <YZ6enA9aRgJLL55w@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.16b
X-PR-Tracked-Commit-Id: c035713998700e8843c7d087f55bce3c54c0e3ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79941493ff3e75219fd1d37a09b46a604e9e55ac
Message-Id: <163786583789.16379.16587477525658554494.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Nov 2021 18:43:57 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 24 Nov 2021 20:20:44 +0000:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.16b

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79941493ff3e75219fd1d37a09b46a604e9e55ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
