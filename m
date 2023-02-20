Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E288169D590
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 22:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjBTVL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 16:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjBTVL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:11:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B001CAE3;
        Mon, 20 Feb 2023 13:11:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2776AB80DD3;
        Mon, 20 Feb 2023 21:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D040CC4339B;
        Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676927502;
        bh=6g4NDisHRG4qmLpa8BDv5tH4TBrlHaYvx8l5KIe7WXw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sdoTBEeNBYdtVmrVdNW//ChctssgK3NklmOKxnCz0WQyVtRiMbNshiNUHLRikVrtK
         0LldUTSs15SzOMN8Ysxw3oPzk+RurcCGYQI9GlMEcrutCkEL0Zi6f7RFvShUcCElAd
         lyrHaN73u9XSfWSTvXtWcRPeyRnfSXwGzOvvaFcciZh3W4gO4cUvCihHDYCsvJzrgH
         c54e21B4a8tM4g+HPZGk3O3mTuM1EAwzOiD2yCMqhY9H3A5EPImcnwL5Q4+3ohORZE
         TxstAJ+wnZDN2OMeBVZqTtwcmOjSPFMDxA61gfnawhf5gNfYL0FEtjboqdMBCVbaWS
         ASCNuC0W/itdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B98B8E68D20;
        Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/KLHT3zaA0QFhVJ@sol.localdomain>
References: <Y/KLHT3zaA0QFhVJ@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/KLHT3zaA0QFhVJ@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 51e4e3153ebc32d3280d5d17418ae6f1a44f1ec1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6639c3ce7fd217c22b26aa9f2a3cb69dc19221f8
Message-Id: <167692750275.16986.16446454723187739663.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 21:11:42 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 19 Feb 2023 12:48:29 -0800:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6639c3ce7fd217c22b26aa9f2a3cb69dc19221f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
