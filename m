Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A766B742F05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 22:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjF2Uwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjF2Uvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D103591;
        Thu, 29 Jun 2023 13:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88D1861637;
        Thu, 29 Jun 2023 20:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4037C433CC;
        Thu, 29 Jun 2023 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688071898;
        bh=s5eXwcXBsvu1MInqna9UFxR4vxWdKqPzgom51C5z3Z0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Aq+/tP2WM+kwSbsTIIyTMMmvC6cEhJupyxgmFblR6GSprJST3fZVuuEX4Db1HtuWk
         KiBtPyFQRsd/gRU7eT3wLeT5rUfTy3GEqZf7CREBPSVVWi5FbUaOkKbrPC84XxWkfg
         GlMLlk7tqHM10v/fsNB/JEe5IWtJ+q939F+PmiuZKsohnpn5iHbJugML8EKwvthm1w
         Ud0s64Ortf6+u8/WgUSaBzsV7XYTS1P+2UN52IteL0dWf42hKlgdFSINyR4olXdfOk
         76bxUwZ3WYnJMPVKzuMt3KDd3JH4Va0EWc/C1EZIWyu7KSCGkAYu3CcI8P4Z/5mEJK
         eYT/fe7JfAZdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D32C4E5381B;
        Thu, 29 Jun 2023 20:51:37 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: new code for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168805669039.2186118.13633298500357673357.stg-ugh@frogsfrogsfrogs>
References: <168805669039.2186118.13633298500357673357.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168805669039.2186118.13633298500357673357.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.5-merge-2
X-PR-Tracked-Commit-Id: c3b880acadc95d6e019eae5d669e072afda24f1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e06150d3c04d1a5028a485263912ea892545d2f
Message-Id: <168807189785.21634.13859826231703076942.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 20:51:37 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     djwong@kernel.org, torvalds@linux-foundation.org,
        dchinner@redhat.com, hch@lst.de, leo.lilong@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 29 Jun 2023 09:41:30 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.5-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e06150d3c04d1a5028a485263912ea892545d2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
