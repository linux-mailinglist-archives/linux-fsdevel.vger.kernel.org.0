Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362C86A496F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 19:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjB0SSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 13:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjB0SSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:18:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6BE06E;
        Mon, 27 Feb 2023 10:18:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF6060EEA;
        Mon, 27 Feb 2023 18:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8315C433D2;
        Mon, 27 Feb 2023 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677521889;
        bh=ooVWcWHIEeGj8G37FUu4v9GfLrGz5Dde9blpD2uLqVM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rIT0oU/lhJyINdiya16xLwdeabKDXx/qp/dXadcO/tUTCsXcSvnmNlVn3UBA7GMnX
         CBq2p67OeNHO7ZBpgclBbcCHF4KI6rraA+vBEZ8udFdPwGYEpTjA300ke3pCOhxjF8
         erQIbounOuwTY5jP4yhaNACzc79KU1qjWaAzrPWkk9EjdyAT+V/JoK3DbktShv1xNZ
         iJLwi5+z8fB6RGllQhiL++nY5+K/Cus9W5Ma+1wkZQeCQ6Q4nHrYOpH7A2hIOrcJ7O
         rOhXshThcB4JmG7Qt3idviH9AV0HF39Ltlak3vAV0OCtkQniTuY/oQ6+8T7byStWu0
         sw0vuQQVFMF/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C77D7E68D2D;
        Mon, 27 Feb 2023 18:18:09 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/zYyN7NeLKusmSj@miu.piliscsaba.redhat.com>
References: <Y/zYyN7NeLKusmSj@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/zYyN7NeLKusmSj@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.3
X-PR-Tracked-Commit-Id: 1cc4606d19e3710bfab3f6704b87ff9580493c69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d40b2f4c94f221bd5aab205f945e6f88d3df0929
Message-Id: <167752188980.27343.711244069441124562.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Feb 2023 18:18:09 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 27 Feb 2023 17:23:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d40b2f4c94f221bd5aab205f945e6f88d3df0929

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
