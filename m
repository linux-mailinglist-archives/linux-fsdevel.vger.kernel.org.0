Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF36672B91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 23:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjARWrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 17:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjARWrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:47:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D17A63E3D;
        Wed, 18 Jan 2023 14:47:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9F6EB81F83;
        Wed, 18 Jan 2023 22:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5DE3C433F1;
        Wed, 18 Jan 2023 22:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082027;
        bh=JWCl1ZWZAs1W8KPwAon/CLRVAoq0WcPAhupCon+bLEI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t13V5DI1c0IWTKKVgo600A5yDEIdnPSIR/UTzvthUCEfIn3jMsCEvpO3DNFMLWYQh
         Zs9r6/gNUwBBlfMt84YyQc/9+JS8mIfGmdp2d0iXfkffsofls5i+MGtMm0DCT6IOGG
         ADAJrG4uGy6yIVXH8RLQbGPJfw5xRrySJV8klxVu8L7oC5KRuGbQAmtqqCgpSiULv+
         efEeV6xqHeIAxUXKjvBKr1Y6nJd7NXj1SkrnzSJ8V1XyZIhPl43aswdNz/SkaGlurG
         N95lObFL+SQ7A6KdjclQMyR1vxx50hDg1wJzaYotZzNrD2jHIoy/vuWLB6XYrwwRTq
         Ixm2eV27qr2VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DC9BC3959E;
        Wed, 18 Jan 2023 22:47:07 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS fix for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1674051240.git.dsterba@suse.com>
References: <cover.1674051240.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1674051240.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-6.2-tag
X-PR-Tracked-Commit-Id: eef034ac6690118c88f357b00e2b3239c9d8575d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7026172bc334300652cb36d59b392c1a6b20926a
Message-Id: <167408202757.14684.3726739122872210919.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Jan 2023 22:47:07 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 18 Jan 2023 15:16:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-6.2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7026172bc334300652cb36d59b392c1a6b20926a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
