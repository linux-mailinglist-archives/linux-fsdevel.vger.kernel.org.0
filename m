Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C282C3397E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 21:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhCLUDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 15:03:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234342AbhCLUDb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:03:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F042664F85;
        Fri, 12 Mar 2021 20:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615579411;
        bh=pkkuLGg/NMGELiX2+2obV33I4UFPt8neJxZZYrn08JE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BsfRZiGeM5V1MUf83A8Bnnfc/M7tVleYLwWJpcUDO9k/wZhUS8+Fg+CNBWrbRtM/2
         y4fPtEDm3UxxZheX3QcuIVNCFD17qOvN5/UMg2NGczFH7PVY1u/jgbiAe01bRlpc5H
         Wkdi8SUj5VkVdEbnJtGDfRjt326ZIodVCrqDH1l9aNEZ2DWeYgWHSGOyld7FOUUW2X
         ylNJXEyMffrHhzsf60RPPT2PN7w4BU06yCrmfsOzu6YFjUNIcTIludz3AdqWUOIUlb
         2WGRTBiXppQ2QdAVvaqkWmRZFksN6B6RMNaCI11yKmobm0iqwgNHsEMEGRpzssSvMN
         j1MCqRPu5Ewiw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DD32F609E7;
        Fri, 12 Mar 2021 20:03:30 +0000 (UTC)
Subject: Re: [GIT PULL] configfs fix for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YEu0VSxxvvCZorin@infradead.org>
References: <YEu0VSxxvvCZorin@infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YEu0VSxxvvCZorin@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.12
X-PR-Tracked-Commit-Id: 14fbbc8297728e880070f7b077b3301a8c698ef9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d9d53de51eb52d077ffaf67da2320dafa6da1c6
Message-Id: <161557941084.10515.2982478393429355187.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 20:03:30 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 19:35:01 +0100:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d9d53de51eb52d077ffaf67da2320dafa6da1c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
