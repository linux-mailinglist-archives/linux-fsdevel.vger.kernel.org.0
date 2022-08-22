Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38E359C737
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 20:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiHVStl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 14:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbiHVSsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:48:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F84A80F
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 11:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E312BB8189E
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 18:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8770DC4314D;
        Mon, 22 Aug 2022 18:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661194084;
        bh=HnncE3lqraSsMLF/KR80vVlCoPumrkf0bZnsYaQUue8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mYPlXhvYLKr5uM6vmdBTwMcYLKAxvacalnOUGkRdwJx6djLHm0yb+y5+6Xju9Td6t
         8OJFwpJKFklnsagzj6GR1sK2QGbjd9UGzMchaLEfWpEX1Oi+f0J/zHwJehm9jnWcdP
         XJZa8UQ+brOqHmLwABfjKUqyPHqXea7Nhj9ujSPUPACKYBByMjrLaIRV1J16pd0bGx
         Sff8m2SeQ1moPXmikmo9EBiumEKE2icZHDqbcNE/7MGrA78DtnHzsmeu4FpAdbcDYY
         rLTF0cGSdSRsIDztVxfP12Ma1iqLx3c2HCd1w2Nkj0VAVu/EQqEBFbadvl8wPnqMsH
         8dHyHO5fHbmkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73F51C04E59;
        Mon, 22 Aug 2022 18:48:04 +0000 (UTC)
Subject: Re: [GIT PULL] fix file locking regression for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c700310868333ab8fc3f8a94f12f910590bc365c.camel@kernel.org>
References: <c700310868333ab8fc3f8a94f12f910590bc365c.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c700310868333ab8fc3f8a94f12f910590bc365c.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v6.0-2
X-PR-Tracked-Commit-Id: 932c29a10d5d0bba63b9f505a8ec1e3ce8c02542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b20ee4813f3fe79f5ee227c576a55c2df5d59078
Message-Id: <166119408446.19448.9121793274408457963.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Aug 2022 18:48:04 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Marc Dionne <marc.dionne@auristor.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 22 Aug 2022 06:51:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b20ee4813f3fe79f5ee227c576a55c2df5d59078

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
