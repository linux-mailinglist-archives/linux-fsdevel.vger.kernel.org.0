Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A6E6D4E60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjDCQvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjDCQvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1302186;
        Mon,  3 Apr 2023 09:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B8E61E92;
        Mon,  3 Apr 2023 16:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA629C433D2;
        Mon,  3 Apr 2023 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680540678;
        bh=7e8Tl7hvfn6U4ZWD4kurl8I6KmecwzxwRF5MbcFRC2k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SMFj/7hmMB0OeTHdixOGJpqG7GKFC09pGLZsPJIcuKT/rFAieaJ2gIWaqhcYWpoR5
         W8MHEpdIrtHITCnpN1QM3nx7/6iOZBVSxmjpyMfMg67gtIlZ2Gbaccc7APwvz0gkdy
         BDcHqHNOVYR+TT3HjSPis3nlE6SfzXWlcEHOadeV+G3i8pFVNUqh0al3gWAjc7/96Z
         O7QQe8McSDoAGW9wdLJ+QaCQWTQTKcpoQrhVi6gT8+4LKW+ElNjsH2yKAlDc6pDLje
         liaCGGsCUWlgK0o1sjn/IS6iiRAsOnSEIsRbTDlhhAEfMZGcWr4Oges8wNThd/adut
         4/NFHfJgwpPIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E117C41670;
        Mon,  3 Apr 2023 16:51:18 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230403-hardener-elevate-44493c0e466b@brauner>
References: <20230403-hardener-elevate-44493c0e466b@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230403-hardener-elevate-44493c0e466b@brauner>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/vfs.misc.fixes.v6.3-rc6
X-PR-Tracked-Commit-Id: cb2239c198ad9fbd5aced22cf93e45562da781eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 148341f0a2f53b5e8808d093333d85170586a15d
Message-Id: <168054067863.29791.2106328294277907380.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Apr 2023 16:51:18 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon,  3 Apr 2023 13:04:58 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/vfs.misc.fixes.v6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/148341f0a2f53b5e8808d093333d85170586a15d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
