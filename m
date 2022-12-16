Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6587D64E5E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 03:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLPCQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 21:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLPCQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:16:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241021A047
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 18:16:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D460BB81C34
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 02:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B258C433F0;
        Fri, 16 Dec 2022 02:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671156979;
        bh=AhsXdli7/fRPX3nKLM2uXPDTqtnabRFe6DP7C3UYp8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HLzKecOOmHVtj0m5nQ3qhzljqswcNm5U3NusQkeNEN0Mkja1nOLub6RKxddI+fp4i
         Jhi0oua5Pw6EUUHSstMWFXd91WKJVNyRxzRT7KEI9xwJEtz5iRG2OLgce+EcciI0+V
         WC1LgywevktpoNu/iVEuPIk4CVooRw6kMcbY5tYeaHNIkS7ai89OS2VnFXO37bKWzi
         JKdsvEKd9Zzgw18DgSaghiwqMqYXrNJtpaxGUN85g4GrwrU/++1+pOBEKgb1W3GZQP
         6hjjdNSlwE0J4P6EtiH2zoQB9eoY7NHQpKTOTWjPpgI/B7e0SgPkBm3XdD09Pv1O94
         0foz4wo/5QLAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68DA5E451BC;
        Fri, 16 Dec 2022 02:16:19 +0000 (UTC)
Subject: Re: [GIT PULL] Writeback fixes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7d6731de-b583-9552-24e3-601fbdae6a1b@kernel.dk>
References: <7d6731de-b583-9552-24e3-601fbdae6a1b@kernel.dk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7d6731de-b583-9552-24e3-601fbdae6a1b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.2/writeback-2022-12-12
X-PR-Tracked-Commit-Id: 23e188a16423a6e65290abf39dd427ff047e6843
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23dc9c755a19dea099df6ccb6dd129e24b4d5ad8
Message-Id: <167115697942.9308.15906719641833724661.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 02:16:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 15 Dec 2022 16:30:46 -0700:

> git://git.kernel.dk/linux.git tags/for-6.2/writeback-2022-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23dc9c755a19dea099df6ccb6dd129e24b4d5ad8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
