Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA79320CCB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhBUSl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 13:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhBUSlF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:41:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BD08D64F09;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932783;
        bh=mU1YKO6hXB9b42Edt6eL0Iwdw4mTZppHe/Ap8s66jh4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sNuINbr0zOI0RADEK5qgv2nZANDz20p/z7s4IZhx7TtIbF8eTBZnXXelPEN3ytSaW
         P4Y59F53yeK9FFxHdWsZT7e630h/M3BpVUJf/1BItzMzLNo2NBuFjwHMmAMGP1ag/L
         O4p2C/ObAiuax0Dc7xiJWirXVbNpAWnSGH4fLeEij0MBqCeKmacSl6ds1Sh5JUchrP
         mvip8xc95OKfSaoQTKirKLo+VWBdqo9SD0GPbWu3cKNsXiEalncVQ9oiOlF2x2Vj+Q
         JVHHwhoMjRcwmkb7q+xgGy921x4EhN/Ej3rkHMdFutq48W1GDTjyYSqPV3uNrNWGXH
         aCCMrpLuzS4XQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B816260191;
        Sun, 21 Feb 2021 18:39:43 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210219041244.GZ7193@magnolia>
References: <20210219041244.GZ7193@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210219041244.GZ7193@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.12-merge-5
X-PR-Tracked-Commit-Id: 1cd738b13ae9b29e03d6149f0246c61f76e81fcf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b52bb135aad99deea9bfe5f050c3295b049adc87
Message-Id: <161393278374.20435.8997839961461434518.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:43 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 18 Feb 2021 20:12:44 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.12-merge-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b52bb135aad99deea9bfe5f050c3295b049adc87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
