Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0364AE67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 04:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiLMDtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 22:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiLMDtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:49:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD051E3CC;
        Mon, 12 Dec 2022 19:49:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D13361315;
        Tue, 13 Dec 2022 03:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F728C433D2;
        Tue, 13 Dec 2022 03:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670903374;
        bh=/X5Op94URkLjRBXWSRWf7FwdC48XNY1FNK27gfhCPro=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IvRrUX93W5GzYccNgckhLQPu8BXyHu7MzyhqG7QPQaLtWmRfNyiLYoco2zVFWNmb2
         6qEs9zXakXiR8niHqjmOhFDj9vwFIex8gsz2uFD8aa0OeEekHqgiYuzLc31t1rFmL/
         4jBntGDIXGF6DKbBjhewW0eO3zMq2wDs2ZGplumiDoV1Mfm09BQX9E904zTHliJwRW
         ahOywBNwDoD7Z2KSMwXdV6iwrWSH98//asbhKYUty2s92d4BRxZ37sfovIFaNIkyWr
         TDCfaS6rfmEfH1zyNEPk75E7dnVMbOKhR3Zy6C2kmfrdEWnb35YoQO1/HPE6UibKvI
         9Acr5vvLUC2hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E669C395EE;
        Tue, 13 Dec 2022 03:49:34 +0000 (UTC)
Subject: Re: [GIT PULL] fs idmapped updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212131915.176194-1-brauner@kernel.org>
References: <20221212131915.176194-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212131915.176194-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.mnt_idmap.v6.2
X-PR-Tracked-Commit-Id: 5a6f52d20ce3cd6d30103a27f18edff337da191b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b93f5069fd95cea7915aab321fd74d2548ba75c
Message-Id: <167090337438.3662.8989011849660282384.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 03:49:34 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 14:19:15 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.mnt_idmap.v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b93f5069fd95cea7915aab321fd74d2548ba75c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
