Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ACE78E376
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 01:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbjH3Xsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 19:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjH3Xsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:48:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C48CCFE;
        Wed, 30 Aug 2023 16:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BB64B82032;
        Wed, 30 Aug 2023 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29032C433C8;
        Wed, 30 Aug 2023 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693425022;
        bh=YmlQnu8lSy9aUezoZlOgJnD1ZT5ReC4vbafRAqLxo1g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j4+4bQJ7eI1C8PBKKIBpsmjI8OZh5eJTMArw8U3z95Dn24/GlqDiJ4isLUlG3q46G
         vCZJ+EiTAGGwuQ3gR1JJSytCbgk0LBb2w7CECsSc72XFjomIZBYkP4MrFM7QRgF0BM
         2bomiTisSNf4OP5Qlvgj9epsI1m/RrOijq8+kyL4Pa6fY5FD+F3/x7d1s5x+l0x+B9
         S9d91RBx84WVyfIVHbwihgqlsTrMUU0LpwfTiMxfEb1qwuni9NaOObaUr6fsSxFBTo
         kHhzKsLDX3l2gjCuUXxEOucQ/9oBNnUccaqstHM8+CpH7Vp/d6HvLTHOYKAted1BEX
         6x5rZYYz75LKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15CA9C64457;
        Wed, 30 Aug 2023 19:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230829103512.2245736-1-amir73il@gmail.com>
References: <20230829103512.2245736-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230829103512.2245736-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git overlayfs-next
X-PR-Tracked-Commit-Id: adcd459ff805ce5e11956cfa1e9aa85471b6ae8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63580f669d7ff5aa5a1fa2e3994114770a491722
Message-Id: <169342502207.11446.2088268568301052078.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 19:50:22 +0000
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 13:35:12 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git overlayfs-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63580f669d7ff5aa5a1fa2e3994114770a491722

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
