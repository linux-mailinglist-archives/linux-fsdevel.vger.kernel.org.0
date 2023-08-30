Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869F978E347
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 01:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbjH3XaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 19:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjH3XaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:30:06 -0400
X-Greylist: delayed 4166 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 16:30:04 PDT
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E106C2;
        Wed, 30 Aug 2023 16:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C35AACE1E8E;
        Wed, 30 Aug 2023 19:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFC0DC433C9;
        Wed, 30 Aug 2023 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693425004;
        bh=j4ylGEx3iQdhkDA8l19/QuCxpkKnkjcN7goiITVkGlE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iz4Bw3qghRHsaStjHKgawztRdWsuaLd8w5rweEglEoYay4M1yqBcsCYv1ricVSLzB
         U2+CtdC2cFXz1X7JHEmLXCgqRaGyRbljuuy+/xMFuXTlILhEHeo+QHbkbztWAPGYVw
         iyLcRHPJg1unZn4qma681gjW2lQSNdL3nWmdMe8UZe+BcUsgTv6BKsK3VutTOEJMKT
         ZaPrGqTIwbfwsLrmtH4rBKAKygC8DMDPIK6jcv+9jm1tkuHMz3qXhF0rSGjBzhlDdr
         /tdyaITi7UHWRqtEBcYwcjlaAq8lqXFfuDrzYwPjley2UJgMOSDn6CPSfEovCSaL28
         eeS+Dg20/iw5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF969C64457;
        Wed, 30 Aug 2023 19:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87cyz4smqi.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <87cyz4smqi.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <87cyz4smqi.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.6-merge-1
X-PR-Tracked-Commit-Id: c1950a111dd87604009496e06033ee248c676424
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53ea7f624fb91074c2f9458832ed74975ee5d64c
Message-Id: <169342500465.11446.3656604097317362296.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 19:50:04 +0000
To:     Chandan Babu R <chandan.babu@oracle.com>
Cc:     chandan.babu@oracle.com, torvalds@linux-foundation.org,
        cem@kernel.org, corbet@lwn.net, dchinner@redhat.com,
        djwong@kernel.org, kent.overstreet@linux.dev,
        pangzizhen001@208suo.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 18:34:59 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.6-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53ea7f624fb91074c2f9458832ed74975ee5d64c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
