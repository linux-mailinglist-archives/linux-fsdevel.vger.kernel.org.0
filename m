Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6B678B959
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjH1UPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjH1UPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C31718F;
        Mon, 28 Aug 2023 13:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3411565157;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C802C433C7;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253703;
        bh=9NgUH+KBalgFV1ekesMy0B0bbG2bpzjMTF7RFoSFh/8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RxVvqAG8kvi5ack81xylS3dd9JZ187laGaz7dchSsH9lKiY6DnI0ckYbgVLJSZVBW
         KISNWirV0llzslfvgfzCUVNH9hJ6+RYHepFQCfZJe5noVWPQrangAppj8Aal4GOICq
         E0jUHLvBAfzyzpuhhJxyg+CQtohvskL5ca+TQOWTPH4Nn91BD175UF4q2NDaWPzK3f
         27SaRPVju7F5RgdLaZqNU4C5YRpZ7WOtP1/zOwLpXtffEn/UZm/XvR8Z6h+X2k1txG
         FtnLA6xHNO3LrBAAWofj69BjhvXHV3Sbq1nlxm0Mvg5bikG+OCaczPhrDAxOkH2A1o
         zPC/syncNJ8Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B609C3959E;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Subject: Re: [GIT PULL] mount api updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824-anzog-allheilmittel-e8c63e429a79@brauner>
References: <20230824-anzog-allheilmittel-e8c63e429a79@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824-anzog-allheilmittel-e8c63e429a79@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.fs_context
X-PR-Tracked-Commit-Id: 22ed7ecdaefe0cac0c6e6295e83048af60435b13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84ab1277ce5a90a8d1f377707d662ac43cc0918a
Message-Id: <169325370356.5740.17308120640588157259.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:03 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 16:46:32 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.fs_context

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84ab1277ce5a90a8d1f377707d662ac43cc0918a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
