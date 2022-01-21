Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CBF495A31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 07:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378831AbiAUG4H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 01:56:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44568 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245091AbiAUG4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:56:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EC9BB81F4F;
        Fri, 21 Jan 2022 06:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF8D9C340E9;
        Fri, 21 Jan 2022 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642748162;
        bh=lUPkbLjoi7pfPVc4Mn9udZWeK9gfT9EFkIAgpBeop3o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uF8AVDA9sVr0T+IBuQWrZ7FUKD4yZbhoLkB0s2zbuthVt8hF34Wb0T1VU0LoBZXYl
         VT/IwPdCVfismlTAmhS8hz0mz6LRHuBg5EVZJV/LTr4s9hXB/Hf6njhoxvhUkN0C3i
         ebx29MS0vo9Y2s/7OymEUKnmGXjxjkjkGmXapJOAar0jFqSK3mgDr1aBi3XMIYGBeO
         dJCRqzRWOeafu6CppEDKsC2QNaFZ9DuGFLYmytT23TMYMG85EZoljvaAziYX+l+tIN
         SqE7Fwxo0UVjvO9aNFmqJPepw9nAgAdW60Vj5o0Aw5gGr46GvC7zHm45gG2BVGkfOK
         lQJlmfwKOBPHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD9E5F6079C;
        Fri, 21 Jan 2022 06:56:02 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: legacy Irix ioctl housecleaning for 5.17-rc1, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220120185920.GP13540@magnolia>
References: <20220120185920.GP13540@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220120185920.GP13540@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-6
X-PR-Tracked-Commit-Id: b3bb9413e717b44e4aea833d07f14e90fb91cf97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31d949782e1daf4b329337dd36b2d6d60764fe29
Message-Id: <164274816283.27527.4445590209473650660.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 06:56:02 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 20 Jan 2022 10:59:20 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31d949782e1daf4b329337dd36b2d6d60764fe29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
