Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC9586E70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiHAQSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiHAQSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:18:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B73E74D;
        Mon,  1 Aug 2022 09:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47AD6B812A2;
        Mon,  1 Aug 2022 16:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 010B5C433D7;
        Mon,  1 Aug 2022 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659370683;
        bh=LykFEOHq/aeDFRNdmo0JTTnYeIahKFi85gTgILHpzkw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GjauYRNOQKICXLEUegFd618KZyqS7hYTS4Hx8CqYYOlM7FUoQcPhddtx039xJzZAy
         Op1OvimQNNBzY8NxbHASyiw+5YwTLkjD/Oaqlhk4SE3NOxGFtC+IRjjW6hdl02Wg6V
         1K+pR+CehP6Y+/HJNxyGastLmliuvOnVt8GArvJkJSUmBJn47BXbzAljYP9CNgQuEg
         ZM0nK0bRKnweiCcF5/sgfeFOftlRatyCYXjUYM6hqdajDiXtkVQ2FxpMgCqlJlqCnl
         rT8R04Kw97o1fxQ/IlDQzUohu8wwd0fyE5ebHYl4Vf6+t6DxQDgVOrbW69yu8vUl5f
         Wf0AkKMTFPtaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E07E0C43140;
        Mon,  1 Aug 2022 16:18:02 +0000 (UTC)
Subject: Re: [GIT PULL] file locking changes for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6dfd152d3643c568b928a96d334b50754cd752d4.camel@kernel.org>
References: <6dfd152d3643c568b928a96d334b50754cd752d4.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6dfd152d3643c568b928a96d334b50754cd752d4.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v6.0
X-PR-Tracked-Commit-Id: db4abb4a32ec979ea5deea4d0095fa22ec99a623
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6a7cf70a3ca9dc83419dd3d8ef09a800da3d7c1
Message-Id: <165937068291.17475.9653797655780712882.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 16:18:02 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 01 Aug 2022 07:07:57 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6a7cf70a3ca9dc83419dd3d8ef09a800da3d7c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
