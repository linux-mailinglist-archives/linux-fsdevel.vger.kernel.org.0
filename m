Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB92BC180
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 19:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgKUSjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 13:39:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgKUSjD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:39:03 -0500
Subject: Re: [GIT PULL] xfs: fixes for 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605983943;
        bh=qChbQrSAvJIWDL8x5WgpxWaSK6Sgj8zjIa25WO4PD9k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NKKYtREv9xZd6bbAw04xi18N2RIg45cVLEVO48INvVwOBj/Qp0fE/B5vycRospvj9
         mDbk6gm9Vtj/SVteJqiXlPtGo65L+rJEXD2YVyZ0tUJM2UNBUYmaliaO2c6lyJxwqt
         H93jRDkrtblSp7w4fu3gGihXthsDzb75zkiQh0/A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201121171710.GA7179@magnolia>
References: <20201121171710.GA7179@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201121171710.GA7179@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-fixes-7
X-PR-Tracked-Commit-Id: eb8409071a1d47e3593cfe077107ac46853182ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a349e4c659609fd20e4beea89e5c4a4038e33a95
Message-Id: <160598394343.7589.11599465646793448804.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Nov 2020 18:39:03 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 21 Nov 2020 09:17:10 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-fixes-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a349e4c659609fd20e4beea89e5c4a4038e33a95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
