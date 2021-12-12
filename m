Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E21E47176A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Dec 2021 01:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhLLAev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 19:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhLLAet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 19:34:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D4C061714;
        Sat, 11 Dec 2021 16:34:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEA3FB80B81;
        Sun, 12 Dec 2021 00:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B0CFC004DD;
        Sun, 12 Dec 2021 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639269285;
        bh=WWyIsTZJSHNdano2d10Xl2eOTOGo/zid2rQWi4FFiZQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y8yqPDGExPDwRwawD9I+hPtV1q1ddHj7OtnC08zotb/rnmNFm2BBQ6sMAF/4BctbM
         av+29zkZ+wAqZIMO68oQ9MsIks0RLZ0eleTIMYE7cFuUgzvCuCU9RimSS6oJdrmxxX
         TSUsvIY72Boystgiyu1mcHxZXNO8xcr7rspxT/wRX6/Bl2uf6+Wpx2l6NAbPYYc3LG
         8aSfOq1bwTick7w5OUa7GRHkGN58FdgeaEVItIMjNNiCqUfGDz/2cQwSgXq5SY1XdS
         1D4IqIWvyu6URnofG2RHzfmbVBZN1Zt94+DawpvjzLKUEwDReGrKE2lcYs74cUupIQ
         E4uWWmXDkjl8A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7424960A4D;
        Sun, 12 Dec 2021 00:34:45 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211211172242.GH1218082@magnolia>
References: <20211211172242.GH1218082@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211211172242.GH1218082@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-fixes-3
X-PR-Tracked-Commit-Id: 089558bc7ba785c03815a49c89e28ad9b8de51f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e034d9cbf9f17613c954541f65390be5c35807fc
Message-Id: <163926928546.10000.18339109912268195117.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Dec 2021 00:34:45 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 11 Dec 2021 09:22:42 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e034d9cbf9f17613c954541f65390be5c35807fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
