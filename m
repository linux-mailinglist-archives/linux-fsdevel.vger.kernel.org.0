Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62D3531D89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiEWVQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiEWVPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5568E52BD;
        Mon, 23 May 2022 14:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 411A9614E6;
        Mon, 23 May 2022 21:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A60FEC36AE3;
        Mon, 23 May 2022 21:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653340501;
        bh=9ChFLuhQoCLGrAE03qfgiK6TltWopbBvKkG/qtIFzao=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sgsZR+a3FOmZi+HkddWmCrSPa40PeGxH7NnTvAtg15eUFE77gWlmjgQQ5jA/dgP6F
         BUEnWYiROd949c3Eb/ZHLhePbhBhq1mV0quBXpYjN6nvfcfvwAuTBz6GAhu4cYSG0A
         bw95y2c0xpCYrctmO7UUyN0skrcj3wWk/tPIfi0GgX1jR38qiIC2HYAapfI1ngQejZ
         yxo1xR0pM5EmE+Dq6o8z3QER2wdCWnbgKiMPtoczT9M6++HR6u4l+NUnCb9qCCOnpI
         QinRNFFv6un1fcNthKQFM1X/4ILtHZfSvkDsKO+DEN/DGOqUM0gNXbwBlCyJehW5pt
         +qwIQkZQ/ujHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 952D5EAC081;
        Mon, 23 May 2022 21:15:01 +0000 (UTC)
Subject: Re: [GIT PULL] Writeback fix for 5.19-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f9ff32f1-3573-37bd-a9ab-1b9ed6cfadd9@kernel.dk>
References: <f9ff32f1-3573-37bd-a9ab-1b9ed6cfadd9@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f9ff32f1-3573-37bd-a9ab-1b9ed6cfadd9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.19/writeback-2022-05-22
X-PR-Tracked-Commit-Id: 68f4c6eba70df70a720188bce95c85570ddfcc87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df1c5d73d2856af0425bdf6f023202e957bd7435
Message-Id: <165334050160.6568.2635308662541692995.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 21:15:01 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 22 May 2022 15:36:06 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.19/writeback-2022-05-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df1c5d73d2856af0425bdf6f023202e957bd7435

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
