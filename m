Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD52591CC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbiHMVsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiHMVsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 17:48:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9021EECB;
        Sat, 13 Aug 2022 14:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 199F9B80ACB;
        Sat, 13 Aug 2022 21:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3E7CC43470;
        Sat, 13 Aug 2022 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660427283;
        bh=jdISA6ctq2Q8rlniubegPhnzUXuYoVABHHRbvpeVBU8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oQ6Fp1GJkWSczdnMaXPhEijJCSfNPZauikSUZJJmukN4TeZG5dfZpNkFOO/zdOX6e
         hW83OPPhD0F408luKojoMeMG8bQZirZisR0FYM+tVZ9QbyFuHaAbp+iplvp37r6JRE
         o+M4Kzb6GAd78dzAIMRyuivhE8ygaX1899aWtxKqDIhQ6A2b5JnRIDx8EApUCHmqn0
         hyzNlu21N4HTzbgz9EMpe9EU3He4srDPi3zvg12kVdnUbMvK3E4z0MpoZToTSRHZzu
         pv9Xw1YIs7mYEO9/xLfeIS8HZwdLfsc0m6pvdcbdVIQxUje/iEw7XFwIE7OGKKB7vN
         Mv8PQ3jWnpfwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C198BC43141;
        Sat, 13 Aug 2022 21:48:03 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.0, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvfKWgGHTQVxBFBe@magnolia>
References: <YvfKWgGHTQVxBFBe@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvfKWgGHTQVxBFBe@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.20-merge-8
X-PR-Tracked-Commit-Id: 031d166f968efba6e4f091ff75d0bb5206bb3918
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9872e4a8734c68b78e8782e4f7f49e22cd6e9463
Message-Id: <166042728378.29926.2603186754173996401.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Aug 2022 21:48:03 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, fstests <fstests@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 13 Aug 2022 08:59:22 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.20-merge-8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9872e4a8734c68b78e8782e4f7f49e22cd6e9463

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
