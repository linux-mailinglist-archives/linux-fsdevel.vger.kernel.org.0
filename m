Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277A078B951
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjH1UP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjH1UPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B64C5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 13:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D35596511A
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 20:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48388C433C8;
        Mon, 28 Aug 2023 20:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253715;
        bh=bMf1Stl/F4k5sUJiC980eODQL9YlJK9/1sII86IX+Fw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kgESPSiy3jNh/nyRPHafl5TEAazhF3gPM3nyvbcnyvsGX4+URB0qOUSXLFuQmmlPY
         fjq1uqGlcHe9hZwUYEikmr+aY9lh6ZiBzgjU+NOQS+DLqYQtpLcGVEgvrz6M5Ug+ga
         PHIYTlUG22iMAiJq8u601D37kIh4P7rQUSJkmCNIhdB2fu3YiF7j7zIrssSY2zsAL7
         3kd3jf35bcrtcfSg9Tl5opdK5Wc0WgEieZEYY6D+VNPyhDTb49WPV8c6GzegtCsZS/
         Pg9Qz/evWixllVGcww1lCdKhC5ugxOdQ303AqCsDuA4NpfvPxudKOjtZCVIiTSqp58
         N5Q1XRO2CX/wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3728AC3274C;
        Mon, 28 Aug 2023 20:15:15 +0000 (UTC)
Subject: Re: [GIT PULL] file locking updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <be49e494a64fc983e87fd96a441a4f13a62d4362.camel@kernel.org>
References: <be49e494a64fc983e87fd96a441a4f13a62d4362.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <be49e494a64fc983e87fd96a441a4f13a62d4362.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v6.6
X-PR-Tracked-Commit-Id: 74f6f5912693ce454384eaeec48705646a21c74f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f20ae9cf5b0743e70ed460ae52f976a8488a8c79
Message-Id: <169325371522.5740.18149738425468475569.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:15 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Will Shiu <Will.Shiu@mediatek.com>, jwilk@jwilk.net,
        Stas Sergeev <stsp2@yandex.ru>,
        Chuck Lever <chuck.lever@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 12:19:00 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f20ae9cf5b0743e70ed460ae52f976a8488a8c79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
