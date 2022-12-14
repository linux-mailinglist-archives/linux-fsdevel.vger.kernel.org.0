Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5E264D001
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 20:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLNTUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 14:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbiLNTUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:20:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974F7264A0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 11:20:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46B0FB81A0A
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 19:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9529C433D2;
        Wed, 14 Dec 2022 19:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671045597;
        bh=azqAfFaiaAhUx+Aot3WVOKSKxEyAG0+vDFnrLRFwJN8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XvbzNukTsTuts2yxBOatXTfg2e5kfClbdg83dW1YbCcHZfA/ZG9Xznh79yFh4GFGw
         29yHUd5EnhU5ghD3tJEFi3pHoa2GJsJgQ8Ga7lU1rFU8ChTCQPIk7LeLCnXifIfxSZ
         UnGD62JfLIwvCs7AwvRSVDF55q6OWfcwm3HCVdyE5xGdsnA70qeJPyyaODo+iYtN2y
         3qz2qA56mZdCfc4J/CuukH55AqNm4LOLEbjLczYSlEdu1nrkCRCNl6OwOFUZwxfe7k
         TVUTW8rmGN74ep8afeZbdyEoUOGUng58c4KS89rFXhlGyn7MgbzGtfPdRj6pSN7T+J
         uoZNPXhNdnwCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4B80E29F4D;
        Wed, 14 Dec 2022 19:19:57 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs pull request for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSR0m_Tb_1uKHMXseJ2AEUpvN3siaJd9rC-Fykx4QEXMXA@mail.gmail.com>
References: <CAOg9mSR0m_Tb_1uKHMXseJ2AEUpvN3siaJd9rC-Fykx4QEXMXA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSR0m_Tb_1uKHMXseJ2AEUpvN3siaJd9rC-Fykx4QEXMXA@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git/ tags/for-linus-6.2-ofs1
X-PR-Tracked-Commit-Id: 31720a2b109b3080eb77e97b8f6f50a27b4ae599
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f1f5caed5bfadd1cc8bdb0563eb8874dc3573ca
Message-Id: <167104559786.24859.3913493896826653270.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 19:19:57 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 14 Dec 2022 14:15:42 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git/ tags/for-linus-6.2-ofs1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f1f5caed5bfadd1cc8bdb0563eb8874dc3573ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
