Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D69D4A664C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 21:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiBAUqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 15:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbiBAUqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:46:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC2CC06173B;
        Tue,  1 Feb 2022 12:46:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED1EA61728;
        Tue,  1 Feb 2022 20:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F7C6C340EC;
        Tue,  1 Feb 2022 20:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643748372;
        bh=kda6kC7xEDHD1DBGXGaP3bY+Mvx1srbsEdRDQjzD850=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uhTx1oL+oMzFKNo+NN2w1hKuLnePvj+/AzasiPw0fGo5kJ1NdW0ZsEhYiQ6TcpvkL
         yMk34DyWC1ZaigYC5SLDFCUJ+lH2hVIofIwR+8BmWH8X2fp5XNRLV0ZXGffhSRRP5O
         hj0X1/TDnHdMN6eIUgmkBIEIEPNIHbaxTAkb33HkqIRpMmQy61voubysQHlV6NJuPx
         RKXdjrak2/cNdTvA9QUECzssnEZsyxen2xWFBvIA4XsWVL+nmo/CzsNOIxXZStDE7m
         OzFpqhQASaNuhL/41cr7M7PSnL4Y85VLtcQ/8df2VNdScDezhuUjd+tij9mnwB3I7C
         HSd3xjIYwGP1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F0A5E5D07D;
        Tue,  1 Feb 2022 20:46:12 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yfk/5lIpC2jC9P7F@miu.piliscsaba.redhat.com>
References: <Yfk/5lIpC2jC9P7F@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-unionfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yfk/5lIpC2jC9P7F@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.17-rc3
X-PR-Tracked-Commit-Id: 94fd19752b28aa66c98e7991734af91dfc529f8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24d7f48c72362bc7cdb8adf06cb303fe4a2c200d
Message-Id: <164374837231.6282.14818932060276777076.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Feb 2022 20:46:12 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 1 Feb 2022 15:12:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24d7f48c72362bc7cdb8adf06cb303fe4a2c200d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
