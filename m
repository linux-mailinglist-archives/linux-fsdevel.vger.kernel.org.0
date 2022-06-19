Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75701550B4B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiFSPBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiFSPB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:01:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147664FB;
        Sun, 19 Jun 2022 08:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DF9B61187;
        Sun, 19 Jun 2022 15:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E75AFC34114;
        Sun, 19 Jun 2022 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655650886;
        bh=L2VsiMgSYDAv716lsrtHSGc8ApkW8zWk+QTXCnI/UZY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OnHmrwxak/1T6aPK+m3VJgOt9TgYBmO+dusR01UfZGZi6veXqPeFdz61Vw8WhzM07
         gRIlDraftLY4WwD/a8vNcWakWtCf/Cs37b5p2BzWeD/tJlHnjH2yr1aLRyyMaVNwbB
         LD0iPps4HZ6ameu1PKa83wGCW4Nu0or20/6xwhWJxPWjr9Dc3Z8W2JNHq4g9gSVPUr
         QJ/cvos4A572Wt+C+M0BhhaK3cxFx+mwIKCBTdEBDk0wMIP/b5FXnG8VCnmtwaZpGW
         wfUAd4EljCuDuXS84a0liqkFVJ1Q8M7haGdCWw6v+s2bNAbQneODVd9zMfGCZEG4ko
         U47gQI2WgHEhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D188AE737F0;
        Sun, 19 Jun 2022 15:01:25 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yq6inbC6Y6YT0uGJ@magnolia>
References: <Yq6inbC6Y6YT0uGJ@magnolia>
X-PR-Tracked-List-Id: <fstests.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yq6inbC6Y6YT0uGJ@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-fixes-1
X-PR-Tracked-Commit-Id: e89ab76d7e2564c65986add3d634cc5cf5bacf14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 063232b6c46ef81a952362647541d897e806ec5d
Message-Id: <165565088584.16911.7114333742757230195.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jun 2022 15:01:25 +0000
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

The pull request you sent on Sat, 18 Jun 2022 21:14:21 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/063232b6c46ef81a952362647541d897e806ec5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
