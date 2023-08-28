Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C404478B958
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjH1UPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjH1UPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC8FC;
        Mon, 28 Aug 2023 13:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 595BA65151;
        Mon, 28 Aug 2023 20:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2F9CC433C9;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253703;
        bh=gaQF1zCzLIu5/qDikrcTiwDrFOQGikM0cfHW4oUyRj8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E9rV/vmbxTCFIn0FkbEr5yA0tqoTiS+G/p5YJ9QDMeWS/jJjGZ/GMGSXhPTJ86/T2
         3iis+0/Nl4Y2QuZT1Q4E9jQ+1vzdoDbxs03VWzOpjn0dCaCGGQVIyKXWBb+yqICcmB
         jDlcQ8ES1o6ainuvFFE5AVdWmAX7JULfGKhFOgsdpE1jM3gwrag5Crg6LGADp3Q/mo
         lH/5kh7xIleOBeHkdJiN9Sm23OS0MAj4aK5wBua3bEcIQlzAvESYArLCMPfS4/z18K
         SYvi7oY5/bDqtxcGcf2Emut/B36kWjZm+lsZPP9j2lGQQC3vVCPFj+2NRsNU8JazQa
         /UlAv8UIvAOmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2479C3274C;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Subject: Re: [GIT PULL] autofs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824-komfort-aufkam-7a2b789dd532@brauner>
References: <20230824-komfort-aufkam-7a2b789dd532@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824-komfort-aufkam-7a2b789dd532@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.autofs
X-PR-Tracked-Commit-Id: 17fce12e7c0a53f0bed26af231a2a98a34d34c60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e0afa7e78c45a889954a7923642f013d6329d3a
Message-Id: <169325370372.5740.14920927990182675332.pr-tracker-bot@kernel.org>
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

The pull request you sent on Thu, 24 Aug 2023 16:47:33 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.autofs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e0afa7e78c45a889954a7923642f013d6329d3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
