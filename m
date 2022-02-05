Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A324AAA8D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380716AbiBER33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:29:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35392 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380708AbiBER33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:29:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB065B80CA4;
        Sat,  5 Feb 2022 17:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E2F2C340E8;
        Sat,  5 Feb 2022 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644082166;
        bh=KwXWC0cRbxqx9RVPgAI5EgVNDjXauF/TZZ3h50Z9Sz4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q1a4zDrfkZlD1JDSL/Yuvi3cVApkriFFhfjtKiLsmM3d23zYJ2hcbAcKEmBJJ4IGj
         PvJ07OJC+n7tAnqDM6tCiWlp81kcMZrytjF7SKeJZAICmw1+jNTxqV8ae3BgFw1mwL
         r5kMg/Ygh+4KKlb+AHWkNVCn7P9jrTr+JeafyZtdeRDJZP1mm7KxhEp4gOwNr3zNui
         ifI3QEf489x8ATPggWg6V9WEPP5hTbfNwPbCXT3pOKK0S2IhJOq1/ASviGd68JMAL+
         muGkoMs2P0WY7nU6rmcJ8Rs+QKIszw5/t56+k5jyJKBslMgRved7oaLZ0l5bXp9WIY
         Gz2itMHhl0OhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D128E5869F;
        Sat,  5 Feb 2022 17:29:26 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: fixes for 5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220205024613.GV8313@magnolia>
References: <20220205024613.GV8313@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220205024613.GV8313@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.17-fixes-1
X-PR-Tracked-Commit-Id: ebb7fb1557b1d03b906b668aa2164b51e6b7d19a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 524446e2179855534b425647dfc250757905aad8
Message-Id: <164408216650.7836.5124902560305896166.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Feb 2022 17:29:26 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 18:46:13 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.17-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/524446e2179855534b425647dfc250757905aad8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
