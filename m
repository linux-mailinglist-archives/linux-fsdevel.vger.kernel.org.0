Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93CE748FA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGEVU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGEVU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E3019AB;
        Wed,  5 Jul 2023 14:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB3376176C;
        Wed,  5 Jul 2023 21:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D248C433C8;
        Wed,  5 Jul 2023 21:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688592055;
        bh=bVy2hBcyzkpwSLQ8N9/KVqkINIw3MyB5d3jHPItqSJY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TURntV1o1ex/moIiK3RPww3zGiTfQBeA1izIREHnNk5qHAAY+xI+ylH8/XVJTqpHf
         tOv7b8YG/LkoLr2KZ2oc1yYDanoOkjY9aSoghSQbIow3y6BA5IbIqUyxld+KNfAool
         qZ9R3RRPbFieXcU0TRWctu1VUL+YHyUyy8z6UBhwc5JN6UZTFTRbSi7s9gMpN8r1+V
         uqEocUx5Z12cLWQJbgT/i9gtEm4v6mKB1881udNm/mlKdOzS+vIXGPFxsuque02Xax
         gjtvMUyb9K3OWXYs1flDKMitP1vhYYwVAoI3LlGfQwan3kfuPqVkAp/COSkP6Z+/Lm
         6/9AebdgamKtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47F17C0C40E;
        Wed,  5 Jul 2023 21:20:55 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: more new code for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168857207832.2801401.3108975452748877163.stg-ugh@frogsfrogsfrogs>
References: <168857207832.2801401.3108975452748877163.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168857207832.2801401.3108975452748877163.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.5-merge-5
X-PR-Tracked-Commit-Id: 34acceaa8818a0ff4943ec5f2f8831cfa9d3fe7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb8e7e9f0bc47d01bea310808ab8c27f6484d850
Message-Id: <168859205529.795.13901712588047732028.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jul 2023 21:20:55 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     djwong@kernel.org, torvalds@linux-foundation.org,
        abaci@linux.alibaba.com, chandan.babu@oracle.com,
        chandanrlinux@gmail.com, colin.i.king@gmail.com,
        dchinner@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, ruansy.fnst@fujitsu.com,
        wen.gang.wang@oracle.com, yang.lee@linux.alibaba.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 5 Jul 2023 08:51:17 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.5-merge-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb8e7e9f0bc47d01bea310808ab8c27f6484d850

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
