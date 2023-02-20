Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67769D4EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjBTUXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 15:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjBTUXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:23:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAFF222EA;
        Mon, 20 Feb 2023 12:23:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2263560F4B;
        Mon, 20 Feb 2023 20:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E80BBC4332C;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676924405;
        bh=ezQsVzm8VDpnu1/qB7VGdNBtXh0oszuJHPaS18oI8s4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hYNdC5Res6rSJt1oZQ/MO2IoLVqdWaLQC1unmFeBNwhzAXrgnxF95fzrGL4EYH9Xu
         0BAAsfSa7PWlSZLbu+MUQW9X6CKPtW+xn2xCrLiGAb7NEjFhLUK1071uJlEEqUYOI9
         n5zARrzTzmT2wDbqaLQXTPywnJfhWjTWPi0G8+NLLKgV2mjlYh+MZjSCWozzTt67Kc
         KgA+efxnEO5v83DwQHEg/xcg+FkmJGOha6hF8gRSPYGDJwq3LNPjNjStVes/gjiUTo
         ZmFzogthuwOPZqFSC6yB6HIL1FeboVRstcY2e6FJR/63G/8XUfzACDfAOQElbJtCit
         hkaOJCfs3HLfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD85DC43161;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] acl updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230217081004.1629199-1-brauner@kernel.org>
References: <20230217081004.1629199-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230217081004.1629199-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.v6.3
X-PR-Tracked-Commit-Id: 4e1da8fe031303599e78f88e0dad9f44272e4f99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91bc559d8d3aed488b4b50e9eba1d7ebb1da7bbf
Message-Id: <167692440583.19824.3626176644808932590.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 20:20:05 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 09:10:04 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.acl.v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91bc559d8d3aed488b4b50e9eba1d7ebb1da7bbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
