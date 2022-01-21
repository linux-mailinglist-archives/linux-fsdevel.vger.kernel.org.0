Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB052495A2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 07:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378825AbiAUG4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 01:56:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44540 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378815AbiAUG4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:56:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC831B81F4C;
        Fri, 21 Jan 2022 06:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F2B1C340E1;
        Fri, 21 Jan 2022 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642748162;
        bh=a9pgeZqr0JmGYluOdtJwOV+zTIALLnOYMtDetBzllpI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N3pGXLupNpzK7lU32g3f43fUiDkqdr+anGpN7Ia90F+ZAfpjA1vm3Vgz7f/DLnmfN
         WxFGD0NVXwxTA4lHc7Cdvr1AL+AiG9JbhEJq+cD3TJcu2wVOCC2DGSqlgqq+E6SKXp
         nUzzmDnlIlHJMEtY8MH5kLvfGdN+7o4JPdWpgPAZe7uVkVlFp06pQo0KYa5pny4u8g
         l4gJLkm3681djg4Z5BBA5ETLEfagKPo+i2grqK5keh6xB5Eh7TIiiHnWmGr3JquGTW
         PeHwiwwbcXuaYx51mr3Sjq+fBNJT6jT+xKen/DFfxJ2aqFVqF0cuixeuyNctQyNXIy
         0rs0bc+2uY3OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DD7FF60795;
        Fri, 21 Jan 2022 06:56:02 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: DMAPI ioctl housecleaning for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220120182039.GN13540@magnolia>
References: <20220120182039.GN13540@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220120182039.GN13540@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-4
X-PR-Tracked-Commit-Id: 9dec0368b9640c09ef5af48214e097245e57a204
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d1b97f9ce7c0d2af2bb85b12d48e6902172a28e
Message-Id: <164274816250.27527.6119097451475838528.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 06:56:02 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 20 Jan 2022 10:20:39 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d1b97f9ce7c0d2af2bb85b12d48e6902172a28e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
