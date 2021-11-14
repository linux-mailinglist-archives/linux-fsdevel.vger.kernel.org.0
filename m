Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E835844FB8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Nov 2021 21:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhKNU1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 15:27:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231436AbhKNU1V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 15:27:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1100060462;
        Sun, 14 Nov 2021 20:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636921467;
        bh=R/2ceRnbMhu2ZUu2GczjarustDgI4bmWSaWhmHf/n7M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qdupi9mbbrV/3XaDYCO3LIOZO7gAlKdAaHXTJ5HUiOQXnWdLdz4Z239ocGadwkyqQ
         j+nNoPx5+o3EiDShErF17zM7YREuqxX8ZdjDt0u9G72iykjyRLU5ktVOFXHU+aVeN5
         fGrC01jK3vdEPqtvs7YngZ2kAvkTUJUbO0fFhE1AVQoq27pNx38aWZ8xYvZ4bpPGNA
         Gil09OYjjMZaK4haMNkcrZyFE0himBEXXo/b0gEdWobqhGk7scOI0Zxcrv0kmh6nZI
         RUp9aaoEC/uzM+11OuojZhzxIf9Xa9aDK/a8r8F56Ux9dioqEC0ljqw60z8kp8bjEM
         ETroySmokMJhw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id EF17B609F7;
        Sun, 14 Nov 2021 20:24:26 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: cleanups and resyncs for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211114172309.GE24307@magnolia>
References: <20211114172309.GE24307@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211114172309.GE24307@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-merge-5
X-PR-Tracked-Commit-Id: 4a6b35b3b3f28df81fea931dc77c4c229cbdb5b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce49bfc8d0372212ccd7d1c1b45c60b077f77684
Message-Id: <163692146690.4278.335385691531056076.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Nov 2021 20:24:26 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 14 Nov 2021 09:23:09 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-merge-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce49bfc8d0372212ccd7d1c1b45c60b077f77684

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
