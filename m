Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81C97BC984
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 20:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbjJGSMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjJGSMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:12:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C139AD;
        Sat,  7 Oct 2023 11:12:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAAD7C433C7;
        Sat,  7 Oct 2023 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696702355;
        bh=K0j65ydUUjg+GP4JNaC55CxsiDCSqPwnjhZAPCOQ/Gs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IXGBd0YJp+efiuCD4bpwCW7ta0ewrKUco3TenZVggmwX98k9oRKnOMDk1m3Zh5Yvz
         BpFUp1y8droBjzLLtxjUB4x3dyAruqw2avtMjcNclTfYYsA4QczWWO5aPRggLAZhe8
         zulvqM0wD4Rtoez80pjCFbqPqmWziEEXYlQqRuUk7grfKjZD3O5bcnAeEjkh8XCvO/
         rpAc4t7ca78a4TC0tZQjJmeSnjvKzjg86BLI4EG4uaDJUTi0ZOmy/Jk32+rEBGTLQe
         qxlP/v2X7NXY5hlWfDyXM8i4UuEhhH2jKoWhAS7aYUCAtl7vvzVIFxUp+TtUxAiM8t
         bKphn6qgOeWTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A730FE632D6;
        Sat,  7 Oct 2023 18:12:35 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877cnyiff9.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <877cnyiff9.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877cnyiff9.fsf@debian-BULLSEYE-live-builder-AMD64>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.6-fixes-3
X-PR-Tracked-Commit-Id: 4e69f490d211ce4e11db60c05c0fcd0ac2f8e61e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 102363a39b8d37b5839403e08cfaf900de0cddfa
Message-Id: <169670235567.17141.15810098941372692804.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Oct 2023 18:12:35 +0000
To:     Chandan Babu R <chandanbabu@kernel.org>
Cc:     torvalds@linux-foundation.org, dchinner@redhat.com,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 07 Oct 2023 21:32:15 +0530:

> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.6-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/102363a39b8d37b5839403e08cfaf900de0cddfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
