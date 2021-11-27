Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC73D460197
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 22:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356303AbhK0VIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 16:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356249AbhK0VG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 16:06:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7CC061748;
        Sat, 27 Nov 2021 13:03:14 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76DDDB80953;
        Sat, 27 Nov 2021 21:03:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id DE95860041;
        Sat, 27 Nov 2021 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638046991;
        bh=M9iWelulHSAJZRzK6BiJyTANHMw0wEJokeGbDPmy2ss=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lj4MZkYenRB/j20hWTdgKSrF5xI49hyJ9ULq1mc3PbC0qDUMCGF6iSovAnpPsln8g
         8eJgfbRtuUrMARjrsjKcNyZK8ibcvSAGqIIVWWtt8fSMR8S/OST+gdj96Jy4p1zJnP
         wnwuj3bgimFdDumYScFUSfSOh7Dae2+qbNNp2ffIr4NRkzvx8HOXF7nDJZlIsDi2Yz
         JAmRyuzaXG+IIGsKQQWZ6I8fqHrUlR8Q7uxAbF6Ivw19ePswuar9DcVFp2Hfv3u29W
         MfsfSiaqx9JY+qMxC1LCGc0tRoPVsOTW7ip/Hd15XJLH61l9nnIC6soQ+6+mfM5Joh
         vvGFM0JcMGLGw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CA42360074;
        Sat, 27 Nov 2021 21:03:11 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: bug fixes and doc improvements for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211127200426.GA8467@magnolia>
References: <20211127200426.GA8467@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211127200426.GA8467@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.16-fixes-1
X-PR-Tracked-Commit-Id: 5ad448ce2976f829d95dcae5e6e91f6686b0e4de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adfb743ac0267de089c878d2f81be2facdcb4fe2
Message-Id: <163804699176.3764.7334731821624514456.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Nov 2021 21:03:11 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 27 Nov 2021 12:04:26 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.16-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adfb743ac0267de089c878d2f81be2facdcb4fe2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
