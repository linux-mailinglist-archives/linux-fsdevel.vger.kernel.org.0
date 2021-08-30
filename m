Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDCA3FBAC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhH3RVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 13:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238038AbhH3RVH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:21:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CEC5360F56;
        Mon, 30 Aug 2021 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630344013;
        bh=fcThTzTD+24QNMo9eDapys4Zmc0PGYzg18EdTRd+PjA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j8xpFOuQslNqoPTnqQ5ELhZSXlpUm6M7cryRwfvrmLnFl3v1Dj7lA3VzzOPuQ9vRY
         DA1oA2GgvA1S4pxeyb2xVBJBbLy6gOvxoslhtjcIQWWlt6YS3J9Jm2OhzQiu4erhf0
         iiYxlIpYj9M4egkLEtgai+X2TUDsBk9TvDk8Uh1BA7Snn1LtDUiAu+MG6cj22+RpBV
         7ILflGXcxCbKimLHA2HQ3pMxoGu6fWm1Q/JFVLWyOf5/CK8KkL6+Bdo5weXCwmjk/t
         dwaRinahxERuxRxHg/fooLFgqTf+sHyZelCDAp/WY2G7IH+96hj4VJUbwwGux27KdK
         Wrc0wD/VcdiNg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C3C7A60A6C;
        Mon, 30 Aug 2021 17:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] UDF and isofs fixes and cleanups for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210825131941.GG14620@quack2.suse.cz>
References: <20210825131941.GG14620@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210825131941.GG14620@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.15-rc1
X-PR-Tracked-Commit-Id: 58bc6d1be2f3b0ceecb6027dfa17513ec6aa2abb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1ca8e7147d07cb8649c618bc9902a9a7e6444e1
Message-Id: <163034401379.22842.6015908716781207308.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 17:20:13 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 25 Aug 2021 15:19:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1ca8e7147d07cb8649c618bc9902a9a7e6444e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
