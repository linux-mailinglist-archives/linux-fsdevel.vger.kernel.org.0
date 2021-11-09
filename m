Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CD44B344
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 20:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbhKITen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 14:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243375AbhKITek (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:34:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B5C9F61381;
        Tue,  9 Nov 2021 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636486314;
        bh=2eJ7UD3EGkgSIfsmHxP2dOsvpKD24cTvb7/EgsaXCvE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jg471DVHAcSRRXekSXiMpnHPcK9I7l3VUdkOaBE3yVi1UKRcVXrSGo7W+GR/ZAVUT
         22l7JGVkNgp4cyyJzH5vRRRrB26NzCfrJAX8T7kUDpTx8CgD4AU/zx62B6oHt9Xtdc
         4JI27BznDsI2caVLojkydpd2l1H2Or8bIQRjrQYODkbG7b60r9JRJIxoze6ouuzBNn
         v/Es9f4Ky1kCwrIoB2ZyCiZO+2iv9nDpNm2BXab6ObfjSydNKE/u/UHV1v8ThEdjw7
         4W90sPFJiV2gTmxoV8zbHR5F7w1V+HFErADDCfNCD6Rw2MenCnr1bN4H12ai2aD99Q
         iptox6wK05i2g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AF99760A3C;
        Tue,  9 Nov 2021 19:31:54 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYo4pwtSVE12qsLN@miu.piliscsaba.redhat.com>
References: <YYo4pwtSVE12qsLN@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYo4pwtSVE12qsLN@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.16
X-PR-Tracked-Commit-Id: 712a951025c0667ff00b25afc360f74e639dfabe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdd39b0539c4271d4242bc780fb1f04e130c4377
Message-Id: <163648631471.13393.13973835146560856191.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Nov 2021 19:31:54 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 9 Nov 2021 10:00:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdd39b0539c4271d4242bc780fb1f04e130c4377

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
