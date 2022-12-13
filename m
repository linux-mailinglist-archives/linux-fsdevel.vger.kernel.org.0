Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30364BC9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 20:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiLMTD2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 14:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiLMTDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:03:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F5F06;
        Tue, 13 Dec 2022 11:02:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44B0FB815AE;
        Tue, 13 Dec 2022 19:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7096C433EF;
        Tue, 13 Dec 2022 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670958159;
        bh=ju451JAlj8WzDOsSR1fkLmrfXQjiy5GX2YSN0Nj9B6g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o9N1alUEepsrxtRLT6uwqy2Kw/naliGws5twlo1k1lZ2yVL/anzAQMJEuGDYXy6mI
         tVp7fWOkB4kDydF5cPFJM+VAOdBbP/9cccZij2EgnmYgyZ7jNGniWAfnQXXClJnnPp
         Jy4Hln4JNTXeYPmHHHYCSXHGnYjh7sZMsI9K+ZuC7lNDxeYlzpCl8R7xtQmenjTj2e
         CHvsA02VAGOsW7GUfdGafatMssHKptwhj0GcC7ozA+rwv0VMM9iUfX4vBCu8MwHMJK
         ydHaix8d5VnZg24xZzlhubOZOe7IN/iEN65lTWWCidNgq+x0hbGMC2hb1sRXaWMxjw
         B58jYngirAzeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D332FC41612;
        Tue, 13 Dec 2022 19:02:39 +0000 (UTC)
Subject: Re: [GIT PULL] vfs: new code for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167095549511.1666109.751880057026708836.stg-ugh@magnolia>
References: <167095549511.1666109.751880057026708836.stg-ugh@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <167095549511.1666109.751880057026708836.stg-ugh@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-6.2-merge-1
X-PR-Tracked-Commit-Id: a79168a0c00d710420c1758f6c38df89e12f0763
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a45a7db9bc7b9e36f213330dcb13356b86a5633a
Message-Id: <167095815986.20557.16011182672581201239.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 19:02:39 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, bfoster@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 10:19:17 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-6.2-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a45a7db9bc7b9e36f213330dcb13356b86a5633a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
