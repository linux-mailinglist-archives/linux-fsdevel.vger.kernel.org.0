Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7573EB90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 22:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjFZUGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 16:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjFZUF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613511716;
        Mon, 26 Jun 2023 13:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9079E61359;
        Mon, 26 Jun 2023 20:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDF64C433C0;
        Mon, 26 Jun 2023 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687809759;
        bh=NxxnjZZAxPhJTnl5+BHG9TFV/wjyN/XPRp2AViKTMf8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cMm8pK+d6eXxtRqk/jrRlOFhw7pPyCTXL/gbz7yWi5bWYEVwz1SmPBkhUZUxua+d7
         wvFQ7rzw9nzDHaiE0byDaUobvJGwXHItEG2kBEACEphBj8w5VpygisndylpLxHXYsE
         9eLytnF7Q8p2fttQKr1h5m3RkMINVGvlPC+oY5lEaJ2Lz3U1JbfUoyzJdspt4PeRts
         BVWqo+gq7BEciZToZTm7XkiUItTv0gNUqf8T0Bd9O/QmhIHPL9/6DP2KmrlWEJCM4e
         9D4bcc5iQV0TeHZTuy9p0e8VKMCMBJ1DuRFKsh7raLFy5lRr3E/9FNGRoOxYPQEyjC
         qCt+NuMB/AXdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6C75C43170;
        Mon, 26 Jun 2023 20:02:38 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626015415.GB1024@sol.localdomain>
References: <20230626015415.GB1024@sol.localdomain>
X-PR-Tracked-List-Id: <fsverity.lists.linux.dev>
X-PR-Tracked-Message-Id: <20230626015415.GB1024@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 672d6ef4c775cfcd2e00172e23df34e77e495e85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74774e243c5ff0903df22dff67be01f2d4a7f00c
Message-Id: <168780975887.7651.4555094720412338997.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 20:02:38 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Larsson <alexl@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 25 Jun 2023 18:54:15 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74774e243c5ff0903df22dff67be01f2d4a7f00c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
