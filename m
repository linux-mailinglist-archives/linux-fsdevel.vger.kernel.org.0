Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0821A4E696B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 20:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349517AbiCXTp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 15:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353277AbiCXTpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:45:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED8D37ABD;
        Thu, 24 Mar 2022 12:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0664EB825EA;
        Thu, 24 Mar 2022 19:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFEF0C340F8;
        Thu, 24 Mar 2022 19:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151060;
        bh=W+/vvP7lJNPUI13LZBDgrXOoyNWKielfaFD1GVkF5ps=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a7A3MvyIc1N63TcTd9UrQAcG2qczBng9WubB2LRTbuF3Uo+B4tKUYaXHv3aozu8XG
         ry+/gu4E/KMRtUCpR5IKRY6bkvdVKU9OOYLDb1tsxMCB92IEIcAW0MQ1tz4zlS1J6l
         c6mg81QY/ju/t98QbK9kexO0/oML80MGW6ssS0LN4hLMAPhvC72Hq2OJk3IwW8TWjy
         cUuYGEpHyD+JBsdw7HIvhqLNa+DDa+SQSD+hpCc+wgkANoTQ20HdF+Sm+2kmjq1Mju
         X1dfZeuv/eZKzJrFJ6AIl5lBboS/GwqEzC/pb9MvlwVDEYc8Y4xZfHzfJpFhAFCBFS
         uro64isLYFlJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A864CE6D44B;
        Thu, 24 Mar 2022 19:44:20 +0000 (UTC)
Subject: Re: [GIT PULL] fs/mount_setattr updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220323110209.858041-1-brauner@kernel.org>
References: <20220323110209.858041-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220323110209.858041-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.v5.18
X-PR-Tracked-Commit-Id: e257039f0fc7da36ac3a522ef9a5cb4ae7852e67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15f2e3d6c1f713050d2d51f822fc4253f67ae7ac
Message-Id: <164815106068.31218.423861105405824934.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 19:44:20 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 12:02:09 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15f2e3d6c1f713050d2d51f822fc4253f67ae7ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
