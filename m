Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA433BDE01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 21:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhGFT0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 15:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhGFT0q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:26:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D50F261CA3;
        Tue,  6 Jul 2021 19:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625599447;
        bh=mMUdqONH5V7a9a134VRFolFVHzwyQENg7PcBm/g0N2E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X47xQNGo7Rpmtm8UEpI0KVzk5buhNh5SPG5g/ShYvJSTFYmSk0vfdgvoilq1zMG49
         4Nk5yfnfAIXFQYOwOmd1nCQIlMUAcNU9uOszZx2VlOR7AtpUDtzxrBP9RzH2VtY9NI
         gsoE6Gs1GKOE5hjaYmZnnx1MPpB8/ghQgQjm32BcsxjRwudZMV2kIKkTXXO+8xfbjs
         FFNEHwwlhBav2/Alybp78x0bnu3+H9Pzz8l4ww3RwqHFJwzo4Pcln2H6bpUKbj04dg
         gqjfjwZOz2GY6VKIRDSJdqIg1GTzQFt5y1jop34oOFKkcGX+bmnjTPjts0uITtNCtt
         OJlTm7zRNUQ5Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CED7B60A27;
        Tue,  6 Jul 2021 19:24:07 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs: an adjustment and a fix...
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSQwkp=dHCkE4crvPrMkSxu8ZCO=vamnBuhmzT3GRARnSg@mail.gmail.com>
References: <CAOg9mSQwkp=dHCkE4crvPrMkSxu8ZCO=vamnBuhmzT3GRARnSg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSQwkp=dHCkE4crvPrMkSxu8ZCO=vamnBuhmzT3GRARnSg@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.14-ofs1
X-PR-Tracked-Commit-Id: 0fdec1b3c9fbb5e856a40db5993c9eaf91c74a83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 729437e334a9d9e079e2be9a42629316bee8a17e
Message-Id: <162559944784.10101.13549230751071552762.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Jul 2021 19:24:07 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 6 Jul 2021 09:36:40 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.14-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/729437e334a9d9e079e2be9a42629316bee8a17e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
