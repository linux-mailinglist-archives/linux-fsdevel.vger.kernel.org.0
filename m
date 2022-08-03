Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7078558928A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiHCTAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiHCTA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D77B1DC;
        Wed,  3 Aug 2022 12:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B35AE611F3;
        Wed,  3 Aug 2022 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8519DC433B5;
        Wed,  3 Aug 2022 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659553225;
        bh=H817xxHdBsp/eOnZvzwP5+M0+rpPlYnl5fBAtnIyz34=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DMU4L3KbrgykjQQ0modyKZdyiVEDP1sdB0AJcegKbh8fdgF8s+6vYVk3B179XwV9f
         nzzxvH3bqfW4C02Y9wLyndgktfPPDbFxvd5R37S3e4GMxB5M+ZDyxSf1sbHEQPTk4h
         KLORXrxSvf1OHGBeSijQ/vGk+ChShxwB6Wr7j4vPi2fDFJ17YE3TvS/mbKHCfr3w8V
         QgiKxlj2k8cD7tyLn7gH2BWP56N6W/Fd25wvyjYCr6nZIFYtZ9sWgOpZExn516mPTi
         rtfonmvAwh4DiaIcuz9bTXQmbyB7RzGuEE0SmEP+Z4IWpD7E+BH5uUWpVic696qRgR
         V8y8PEzd+xGYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71DF0C43142;
        Wed,  3 Aug 2022 19:00:25 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 2 - lseek stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yug4Is18ZrZ3fEAy@ZenIV>
References: <Yug4Is18ZrZ3fEAy@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yug4Is18ZrZ3fEAy@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.lseek
X-PR-Tracked-Commit-Id: 868941b14441282ba08761b770fc6cad69d5bdb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a782e866497217f22c5d9014cbb7be8549151376
Message-Id: <165955322546.6947.304593791706042511.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 19:00:25 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 21:31:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.lseek

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a782e866497217f22c5d9014cbb7be8549151376

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
