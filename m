Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA494E696D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 20:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353287AbiCXTp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 15:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353278AbiCXTpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:45:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99337BD9;
        Thu, 24 Mar 2022 12:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 378F2B825E9;
        Thu, 24 Mar 2022 19:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02A70C340EE;
        Thu, 24 Mar 2022 19:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151061;
        bh=xh9ztIJzCN/ZGS4noxx/LeNRv9RikHLUIOKFx//QXEI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q3oG93uafg/fakmieS9pW0mQHEM0b6NAw3RQyeVOvijyDi4BxKx7+eOIWWq9bMtZ4
         sd7Gv+7EY/CuENqklF1uwf7cPLMgNwoBZ6+aUIxmleaLqglYWRKuALmqNl9gteu9r5
         MDqwnF2x8Dpw0i6xATVRTe9obzZzEN1IamjGjQVqM8F/aA9uMb2Sx6+tlVxm8sQ9t0
         mT5/4g0/3chHE4jjWkhfb42Gjpg3xmOGWLhhx4Uzt+VikNQCkgIJpCshj91HF9o85M
         O5mVwFQ/E9W9qhvX5dvj+mJ7sWnuItK0f1JPX8w3cX18eqE0+J2Ew/Y2PYZXHZaI7P
         TnPqsmaqaEfdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4418E6D44B;
        Thu, 24 Mar 2022 19:44:20 +0000 (UTC)
Subject: Re: [GIT PULL] fs preempt_rt fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220323110248.858156-1-brauner@kernel.org>
References: <20220323110248.858156-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220323110248.858156-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.rt.v5.18
X-PR-Tracked-Commit-Id: 0f8821da48458982cf379eb4432f23958f2e3a6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e2d4650b34ffe0a39f70acc9429a58d94e39236
Message-Id: <164815106093.31218.17172939733647630845.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 19:44:20 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 12:02:49 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.rt.v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e2d4650b34ffe0a39f70acc9429a58d94e39236

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
