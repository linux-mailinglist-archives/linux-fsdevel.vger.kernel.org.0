Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4B4AAA91
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380744AbiBER3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380725AbiBER3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:29:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315BAC061348;
        Sat,  5 Feb 2022 09:29:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF332B80CAC;
        Sat,  5 Feb 2022 17:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6D03C340EF;
        Sat,  5 Feb 2022 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644082166;
        bh=DP4reiDeLBUgpPNcg6xTx8Soq05WJHD+O+qX/H7/TOM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FF6/Uwdgy1BZxB3a6YdXrz9K5jDBSdJzM5ksM45TNhITjzQ7NRSZPSEGT4eC+frzF
         VBns1SzUO+zeHkFfjfQCDdWsipEOWEp0vzpDJvebl9fnR/jWhtHJ4BRdSMiTr+VOCX
         76VlZ2IuLLwnqBH8BLEekdqHvEXGpG08Wp3pyd1mA5RFdHYrt3VoSEKj0jrAMMnqMv
         pHpjOIDkDeFNBe/BdHx/hMNQzMmgCdOVDnpzxOIvcJYal6CL7WB96erKMHW0RzGffc
         CRqQ1CSvJ8lk0+oQp7yly8diYLncj3HR0PE10A6+0wOtK9821A608hpc9kgh66UcjF
         euTYzfB6oMU9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A5DBE6BBD2;
        Sat,  5 Feb 2022 17:29:26 +0000 (UTC)
Subject: Re: [GIT PULL] vfs: fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220205025100.GW8313@magnolia>
References: <20220205025100.GW8313@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220205025100.GW8313@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.17-fixes-2
X-PR-Tracked-Commit-Id: 2d86293c70750e4331e9616aded33ab6b47c299d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea7b3e6d42d7afa141ff765099d6b4ea406001bc
Message-Id: <164408216656.7836.6110778217091833319.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Feb 2022 17:29:26 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 18:51:00 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.17-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea7b3e6d42d7afa141ff765099d6b4ea406001bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
