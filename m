Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11CF7B3D19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 01:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjI2X7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 19:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjI2X7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 19:59:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C057F9;
        Fri, 29 Sep 2023 16:59:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C93EFC433C8;
        Fri, 29 Sep 2023 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696031950;
        bh=TYbXjTD4yLDMrr6JJPR3DJllrIYPE/nqoYqCeJb+CMM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QJmGFTFFZZ4d3a6jQLV86Q6CCRo7mqi4tobo6wDfJRC0Sm7VdLJi/1gno/kCD3Oow
         K8PSF6R9TuLnBSEZMx8XOGWXaQPWsOlnZF5+GPv7nBnd3L4ipP9YnDSdFgo8GcPF/s
         0V9whGQydQCXPGGYuYRzwcnNFTDCvd4MGRI3XDV3a7TLsaEh9RC6O19hraRvhsYxtC
         Pk2QWkE9q2g2MMlFARgikKD+ExJV2LTQavOCx9qnamiwXVkY+nVwa0YTRVoZ8mpZ4u
         dmF9pmGoqDB9MJTvODVa0oiENlxLOL7KQ24sUdBt99JsDzA9nZQjpxHZMgXJ5wZeL+
         v2xf/Rpv/z2oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A63A5C395C5;
        Fri, 29 Sep 2023 23:59:10 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87r0mhf4rs.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87r0mhf4rs.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r0mhf4rs.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.6-fixes-2
X-PR-Tracked-Commit-Id: 59c71548cf1090bf42e0b0d1bc375d83d6efed3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10c0b6ba25a71d14f80586f6a795dbc47f5c6731
Message-Id: <169603195066.31385.17895430149826350683.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 23:59:10 +0000
To:     Chandan Babu R <chandanbabu@kernel.org>
Cc:     torvalds@linux-foundation.org, dchinner@redhat.com,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 19:09:34 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.6-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10c0b6ba25a71d14f80586f6a795dbc47f5c6731

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
