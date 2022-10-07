Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C65F7269
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 03:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiJGBBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 21:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiJGBBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD296F192D;
        Thu,  6 Oct 2022 18:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D14617A1;
        Fri,  7 Oct 2022 01:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA22BC433C1;
        Fri,  7 Oct 2022 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665104480;
        bh=Pt0vBd4tOxkx5psXmw67Ufbw4yGK/kaO5mWq+0W+l40=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GNMTCqgbcUobFIL6jtd2BUjZdjwTBTXGz9XVDa2RB72IBJKoRVhiu/f5iD7WFLHfO
         yBg+Q4tdS4HADDUMXhQXKb6wPG8MtgfOYps1SudT7zIfEfA9GBDcxe+xAv4uqd/8PS
         yQF9Nynr8oQ+I6MD+Z/vS7QObFUUE96ijbZDPwuHXxNBX90HkShfJcWhDqs5IWbIIS
         XjVHs/VRZpPAVNYOddwGc7n4KPhwTtLgOAIxpr0mDAQXfQ/ZGD9IK2NOKxg02eo8R8
         bBpcAVpuTMNxQSdTVSGPZLdc4f8SKcUCGpdIaI9Ysj21E4QMpYvAC0fd3+6JAm06tS
         5ldzvnFvCyWUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADC65E2A05F;
        Fri,  7 Oct 2022 01:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: new code for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz26clbuE/nMjyNU@magnolia>
References: <Yz26clbuE/nMjyNU@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz26clbuE/nMjyNU@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.1-merge-1
X-PR-Tracked-Commit-Id: adc9c2e5a723052de4f5bd7e3d6add050ba400e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c86114194e644b6da9107d75910635c9e87179e
Message-Id: <166510448070.27686.17212143410730510687.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 01:01:20 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, djwong@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 5 Oct 2022 10:10:10 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.1-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c86114194e644b6da9107d75910635c9e87179e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
