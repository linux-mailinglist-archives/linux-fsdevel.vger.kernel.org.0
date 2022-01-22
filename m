Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C524496B81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jan 2022 10:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiAVJkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jan 2022 04:40:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58782 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiAVJkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:40:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 331BB60C60;
        Sat, 22 Jan 2022 09:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96A4BC340E5;
        Sat, 22 Jan 2022 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642844415;
        bh=9/IAH2DUf55E9gnYhri346LVumqj9GeddYu+TrOpJFA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BaEJdGIDuXfm3Sv2sdE5SqCYEY+4jw4/gP7THdld6FGQgbrs5cSKkO4NMOaXZO0fU
         XRzjU7LiEnY2E/t99GhdzG4F0x6yPJhvJsENcROyzVcvpUuanwkB1JLdSPtj7qs4Pe
         hl/izkr9orbDEYxxVioe3qpFeXPeBeHjto/U+kcedQSsx+VDWI3GNAWqQaWP5gjbjF
         SW0IfkQtV8z40uKeQ6k1ZgRT2ew2ZS+pJWQL+fgDsnWZu3z+CEPHOKjVYU136mmaHv
         BTgUzj15D8ExVVTMAKtbl9BIc7/5DQPxr7DG3N7WnmXAvfUs1n+SyQAJ04JkItj+LS
         9ltu3rtV17mqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 808F3F6079D;
        Sat, 22 Jan 2022 09:40:15 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220122010807.GT13540@magnolia>
References: <20220122010807.GT13540@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220122010807.GT13540@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-7
X-PR-Tracked-Commit-Id: 6191cf3ad59fda5901160633fef8e41b064a5246
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cb69c8044fd534a0e19154831234d75f7b8d447
Message-Id: <164284441552.7666.5195906929759259618.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 09:40:15 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 17:08:07 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cb69c8044fd534a0e19154831234d75f7b8d447

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
