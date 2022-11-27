Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4B639CFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Nov 2022 21:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiK0Ut5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Nov 2022 15:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiK0Ut4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:49:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB06DEED;
        Sun, 27 Nov 2022 12:49:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBF63B80B3E;
        Sun, 27 Nov 2022 20:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E264C433C1;
        Sun, 27 Nov 2022 20:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669582192;
        bh=E1OoS1xsLIbwxc3tVPjiODzCH5X2bbrK1jIgnY8LKQU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B7SfoAIcwoIyu9aWaxba0N4d143JuXZ06hSYhN3je07GR2o7Iapecp+HrQi2edr6g
         mI3REYFqsNzd7Yns4eh7elRvXvnk5ZegvHXOvN30/d4K3SLjNDFbjTP9FA4kqYInjn
         c/0sN+Ja4YbKD0GCMb7l0fhH5JezXdyeqbsgLLZf1sKMwRAqlz4O2EvizyXQ4Y1vyW
         vmjCukS3c75yDt1vk65jtR9PSCBeBcGG1lnJW7NvdLGA1XFm+z8aS4wlwOA+VJx4g4
         E779VrXj8lvzIAJ4nDM7eM/oyYa2YEHMc1jKprsEoXSfdtsYhhUEH9jiY8aslvOwsG
         eWb+arC4gYTPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B8D3E21EFD;
        Sun, 27 Nov 2022 20:49:52 +0000 (UTC)
Subject: Re: [git pull] more fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4Otysg7VQdEj1Jp@ZenIV>
References: <Y4Otysg7VQdEj1Jp@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4Otysg7VQdEj1Jp@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 10bc8e4af65946b727728d7479c028742321b60a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf562a45a0d57fb0333363c9d4ff82d061898355
Message-Id: <166958219243.7005.6850979600013704611.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Nov 2022 20:49:52 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 27 Nov 2022 18:34:50 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf562a45a0d57fb0333363c9d4ff82d061898355

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
