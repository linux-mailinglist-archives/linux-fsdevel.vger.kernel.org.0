Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80B78B94F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjH1UPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjH1UPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3CD18D;
        Mon, 28 Aug 2023 13:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56EE765144;
        Mon, 28 Aug 2023 20:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF324C433C9;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253704;
        bh=NebJ1diQTRARjdY4DTAfJWxFhFsjW4kzgWBqSnH8h+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HIqqDpLlHJGZpXcfxzyMqmmp/ST5p0gsTMUYdN7Nq25HCUYSiNEu40gz/WUniVLHG
         bEokU8mfC7jlaxOrMxlUBDmTUTyAcl3sfyC29IRRpacJgEeKX0rZOamFZntxwfxOSN
         ZHX+EV9Do4q8mT6FRaWJLowgO6l+WfmKHB9D0hu2f0X860Ov1h0R8zTeoZVCDyvpvB
         HO4u1qCr5C6Gou3iqytM+qRVVEAkaty270VNNaGztUAaJu2cuwctsrNjIKul40C2hv
         BK9MrZY3tiR2q3ep0LBw/NuRuoEdp1XVqG0tlBhNsEI44SSy8ulOy7TQm+d/AeT/Au
         PLnpKg3KHPdyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABD95C3274C;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828034741.GB5028@sol.localdomain>
References: <20230828034741.GB5028@sol.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828034741.GB5028@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 919dc320956ea353a7fb2d84265195ad5ef525ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bb156a55668800b368856818807677eac207c75
Message-Id: <169325370469.5740.17319498547370760123.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:04 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 27 Aug 2023 20:47:41 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bb156a55668800b368856818807677eac207c75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
