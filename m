Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E94495A2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 07:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378811AbiAUG4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 01:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245091AbiAUG4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:56:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA3DC061574;
        Thu, 20 Jan 2022 22:56:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E20D6171F;
        Fri, 21 Jan 2022 06:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7698C340E2;
        Fri, 21 Jan 2022 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642748162;
        bh=UrjpnrILwzQkw5gHLWqbr3gC6Hslo+Ca3K3VZFiR7P4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o6grQIuNLRfUvn4V2ri7KS0azXS2/GVbBgUJM1HwlGLixIk+KphrHndkcDWFH1nmf
         7biZ18vwtPJ/kEM4OqEHeZ/toKHQrDwOib9zrORSG7A7YyfVOkZC7xLrdqm4Tuwbld
         fejRKtM1SatS2GM/gS1NbXLzuZB45gQW7m2pVAsImrm8vqDsEeTDZHq7//yIVnuKvv
         I9eYdrQ2U1QyJVX1RrnDycAZiO4rNI6KjAp1AXWJIwe7mtERIQZ423iFuoirjQDUfd
         GnOn4Gj7N8qx6i4ZhHtCfS8RdrOLqRhrO0eYYA2D815jjJa0OH+PoES319N+gok/I3
         U8Y+XAZFdzlOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6F25F6079A;
        Fri, 21 Jan 2022 06:56:02 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: legacy Irix ioctl housecleaning for 5.17-rc1, part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220120184553.GO13540@magnolia>
References: <20220120184553.GO13540@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220120184553.GO13540@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-5
X-PR-Tracked-Commit-Id: 4d1b97f9ce7c0d2af2bb85b12d48e6902172a28e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3bb9413e717b44e4aea833d07f14e90fb91cf97
Message-Id: <164274816267.27527.14866415947964585469.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 06:56:02 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 20 Jan 2022 10:45:53 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3bb9413e717b44e4aea833d07f14e90fb91cf97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
