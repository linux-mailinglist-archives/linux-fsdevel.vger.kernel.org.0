Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0169D4EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 21:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBTUX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 15:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjBTUX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:23:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B386196;
        Mon, 20 Feb 2023 12:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BC4860F34;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 295B1C4331E;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676924405;
        bh=ky+UTpDhwWy8ZkS3siYy1JcN6NaJMyDDr///B0Z/V9Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KyxDBJUMBfk8JvR7n1Yarb4OqDLjg//8JJo7QZy5xu2upPAiDohJL9WFpR70sJOGY
         ME2VsTcWNPpb3FaCjUc5xUl3AIhgYU2+lCMfB2ZSQwoRaD8GrG5JaBQIXY6hC32eZf
         1CcPo1haC6RrOvP6DnkeA7lh6E1+KQ4Pb1cTUBaWEeP6H4s8q3krpTF1hPH0SeUsmF
         aODGm0ddQNNur91oFQuc06Ip/ED/llpPTc9TP3+YmlCghSJh3j2iGhgZie2xquJo6X
         bHvzqF/zts1OEJw/yXBiaLpEVA/EB65iKvUlTIXldaHFmRLj3mZtjDWSkkyoOdkfPp
         2YsGSudX6U4ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03D6EE68D20;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] file locking changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c56632e59e4c5b727619de7dd79db11d15bdca6f.camel@kernel.org>
References: <c56632e59e4c5b727619de7dd79db11d15bdca6f.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c56632e59e4c5b727619de7dd79db11d15bdca6f.camel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v6.3
X-PR-Tracked-Commit-Id: c65454a947263dfdf482076388aaed60af84ca2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 575a7e0f812a4968ad1e0c00026692ede040e13f
Message-Id: <167692440501.19824.11930982305287076294.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 20:20:05 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 06:07:34 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/575a7e0f812a4968ad1e0c00026692ede040e13f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
