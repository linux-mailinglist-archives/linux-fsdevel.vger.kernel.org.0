Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93E37431E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 02:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF3AsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 20:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjF3AsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DDB210E;
        Thu, 29 Jun 2023 17:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23E6D61684;
        Fri, 30 Jun 2023 00:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 809EDC433C8;
        Fri, 30 Jun 2023 00:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688086082;
        bh=QW/ZG27r/j6e1SMW009tpdPRu5r+I9EmKaZX3lH+NX4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hSfc1SCLNlx85OVo5mFBs86NMQH8Te05uNf8t2Zen2V5oBX/V7dxhv+IaRMKfU5/L
         YtzNsZFp2Rj5jTz5K6vFzyngykIZLJosMwsZ+50+S1jMhlt2WxQDGy1z65CabDuEW1
         tiALfGYdP4wkxdwB6nhl43i3+qoFEKFcLWfWoPfzzrzzmyFWN+CfyBdnvpVz/EOvKB
         bP/+XUi8w3JocF5C3ayiYmR+Lcy6YIZB0NUIMlplrWuzemYalZ1ydYMaZsaKcLMuWX
         loeBd+blipKmLda9P7qe35KhhzFvBCHt7PxXdDWNNlcQA728OScyq8ClQccq5K7ZHS
         E24zMSPEQFgiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C562C39563;
        Fri, 30 Jun 2023 00:48:02 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJ4EkpN71LEsakct@bombadil.infradead.org>
References: <ZJ4EkpN71LEsakct@bombadil.infradead.org>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZJ4EkpN71LEsakct@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.5-rc1-fixes
X-PR-Tracked-Commit-Id: 554588e8e932e7a0fac7d3ae2132f2b727d9acfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82a2a51055895f419a3aaba15ffad419063191f0
Message-Id: <168808608243.32109.6957582709458880295.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 00:48:02 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de,
        matthieu.baerts@tessares.net, rdunlap@infradead.org,
        ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 29 Jun 2023 15:24:18 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.5-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82a2a51055895f419a3aaba15ffad419063191f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
