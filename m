Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548C478E38F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 01:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbjH3X62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 19:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjH3X61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:58:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD38CC9;
        Wed, 30 Aug 2023 16:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A671B82045;
        Wed, 30 Aug 2023 19:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4739C433CC;
        Wed, 30 Aug 2023 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693425030;
        bh=ua56A0gpMDY7nUOn/hZWJmDVkhzIvanGIXgnLz2lpG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RMRzq5TonUoEIrCKEjLS0HEfFMMNDRczIZOelWygjLKT38KFXay7gTdQKXsLhGm2C
         cB3N5921PwFyN0zRpzMjzi0y/8UfUdjxGMFYLsUuns4Q/yF20o4ROPYKwzlB8RXtd0
         v4wG72jtXfZi/6jWZcb8sj9oTr+6LYbDCet3zK8oWgfAqlCywJr+UEyIhJTfnnJo5g
         5hWUQLxuv4jRBS5LR/t/nWZ/rDo6/V6qCweI51133aQ2D5c0X7CqrEyWQnMd3h8ty8
         /S5/ilJ0V8iyXNdB+VgXeWQwKJWpoFrMy/2lKDOm6xrJOGmivF9kF45A9KYoTBHLnN
         9opBikIWSF8qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D20DEC64457;
        Wed, 30 Aug 2023 19:50:30 +0000 (UTC)
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230830102434.xnlh66omhs6ninet@quack3>
References: <20230830102434.xnlh66omhs6ninet@quack3>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230830102434.xnlh66omhs6ninet@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1
X-PR-Tracked-Commit-Id: df1ae36a4a0e92340daea12e88d43eeb2eb013b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1500e7e0726e963f64b9785a0cb0a820b2587bad
Message-Id: <169342503085.11446.7665673746621606400.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 19:50:30 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 12:24:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1500e7e0726e963f64b9785a0cb0a820b2587bad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
