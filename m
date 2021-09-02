Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7803FF26B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346715AbhIBRiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 13:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346636AbhIBRiO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:38:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 29DC7610F7;
        Thu,  2 Sep 2021 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630604236;
        bh=QBYTml/x3K/PePcy/qE1VF3LU3rtoHrlLGNyqEMZ92s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UNkwfzAIAzBZQlZojuPKcz1iQUGdPUJ56ZnZbHxPIB4qOBTqBnKKfgn2KFlXyFTrr
         HwiYtpU3pGvxHJcEDsAUwcZx84Ql7pGyArhsu6WRUbEPumM4PW65hKzqx/aC+LyZmO
         RvCokvVoyd5LZ+PGNwMqopjPhXa2buEShtUiv6ZFZu732n7iLiiG0uOL6/aGlxUofV
         FcQWQij7soMcGV5B3ECHDx/JsyqPNw3JJpOSIZQQsVmLLKAJLbEiMssfjaPAPl8Kl0
         4N9ix8Av1PiN4mIrsvUrLqxFubleSVi2gh+Ph7FsYx45TwGTRmt0x6umjLiWWiQ7h1
         hjJgASIqS3kvA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 21B2D60A0C;
        Thu,  2 Sep 2021 17:37:16 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc1
X-PR-Tracked-Commit-Id: 1266b4a7ecb679587dc4d098abe56ea53313d569
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 412106c203b759fa7fbcc4f855a90ab18e681ccb
Message-Id: <163060423613.29568.6718988652036312622.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 17:37:16 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Yue Hu <huyue2@yulong.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 06:59:42 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/412106c203b759fa7fbcc4f855a90ab18e681ccb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
