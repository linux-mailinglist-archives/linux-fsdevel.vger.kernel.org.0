Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183AB48BBA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 01:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347349AbiALANt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 19:13:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36338 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347320AbiALANo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C13486160B;
        Wed, 12 Jan 2022 00:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CE71C36AF2;
        Wed, 12 Jan 2022 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946423;
        bh=YUO6YCkuw12a6CsFZC7Vw1m0Xkbao88XcwEnkw2rMY8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E7opCw7oG6N0s6CMvOE2Cfn5OmiAYSE0ZjnTt7VxtQktJMxK25XO6WDb6NQdjggFu
         seScZoLHxCu9ASWbCBAwkOw9PdF55vuAegg13DA8ndOeqkUfwkTzbfgopWkwItSmRR
         T3uFcOOcqEkcNF7S5XRb/zOjW1fCGCNC33PWEpuMuBLfmFLLpDr2tWXk+Fk4bpk0Ay
         feLmzXVjPQmOJ1DquPE2JSkwEswt5yi4U2jssr8OCIt6sefJLrYHqo2FwSwBMkTYvY
         064JursnlJpaI/B9jyhJkLhuCDooPSIHecfGSt2sDG1BI+TGTapzUV5JvWn3qrALir
         p2yUEB0dsqMtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B5BFF60793;
        Wed, 12 Jan 2022 00:13:43 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110220615.GA656707@magnolia>
References: <20220110220615.GA656707@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110220615.GA656707@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-2
X-PR-Tracked-Commit-Id: 7e937bb3cbe1f6b9840a43f879aa6e3f1a5e6537
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11fc88c2e49ba8e3ca827dc9bdd7b7216be30a36
Message-Id: <164194642310.21161.8563846497332350289.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:43 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 14:06:15 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11fc88c2e49ba8e3ca827dc9bdd7b7216be30a36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
