Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B082F58A505
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 05:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbiHED07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 23:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbiHED00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:26:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60EF1C900;
        Thu,  4 Aug 2022 20:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 647C8B827B4;
        Fri,  5 Aug 2022 03:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27BBFC433C1;
        Fri,  5 Aug 2022 03:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659669979;
        bh=+WjaRbYckhxW7SOKo6CWTm+QsCzvgd3b+mqFxpyIoAg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U2ayBOY4qBFoaUtlSDhRMTv8jxhno0DFC2cA+ZREz/3T7LqzsRYHoVbExAymVYl0q
         He20m7bbM/doBLzUYiYmfBQRWMpJKoID/HiZIrJd0lGQkOZhq4tcpaT+gQ5P4SrpXu
         4+1nNRTI1KOFXzcaSJ4vIHID5pRNaM+xi+qGklPgeq2PzbQfKepEQJbemB9Jz0cM7f
         V8gJAmGtSsz9HHVmCDdTjSVezR6OtBYSIc/LLBrVLHRumBG6Kq3tet4gtkkDh8A067
         K7/C4lWFza1UDnKotvka6VyPQKgRcodJHdijbVsWEP05BIa7aJkyxrjDeQyF9csBMW
         XQseUoEZbQeyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18249C43142;
        Fri,  5 Aug 2022 03:26:19 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.0, part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuviV8ONBl1Sw5K0@magnolia>
References: <YuviV8ONBl1Sw5K0@magnolia>
X-PR-Tracked-List-Id: <fstests.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuviV8ONBl1Sw5K0@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.20-merge-6
X-PR-Tracked-Commit-Id: 5e9466a5d0604e20082d828008047b3165592caf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2a88c212e652e94f1e4b635910972ac57ba4e97
Message-Id: <165966997909.9883.3223768645784479578.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 03:26:19 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, fstests <fstests@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 4 Aug 2022 08:14:31 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.20-merge-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2a88c212e652e94f1e4b635910972ac57ba4e97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
