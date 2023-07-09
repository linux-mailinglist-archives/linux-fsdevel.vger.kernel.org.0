Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7318974C6DA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjGIRqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjGIRqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D3D13D;
        Sun,  9 Jul 2023 10:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E6D60C16;
        Sun,  9 Jul 2023 17:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75235C433C7;
        Sun,  9 Jul 2023 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688924802;
        bh=SetvWBBN9Go3C0p5Lfz6RahHO1ZWI96pnVgXNGJDIR4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W63fcVVoghy4bKq1z6K/vP3u1G+9sjxGKNi9M0r/ej/PjZ0ofgGGn9LkWYF3PDafv
         +38qlHmFsdXnhA27FdOxPcxzEG4b16Vqv6NBX1jZD3AGOJ+9jEaGM4uiNRD9gQnmKN
         wlGXa/FTdEOMwoAYRRkN943+ulIRhHtVo+qeGeRYI7Qy5Qd3tdKqzo5rtThbgob0Ai
         q6TmlvnVgNsnS/0BiPLO8HDUDcoKsdzMsA5FCZiTJw1rGQqLO9Ia5LpdDDv3/4zxfi
         zUqTDs06arJimGLv6hy0Rzz2/3gn+rMUykYxOLKYLNDcO2LA/meVwLqRz47NOm0dOR
         JSkZCnATxMLaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6142CC4167B;
        Sun,  9 Jul 2023 17:46:42 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: more new code for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168891728293.3329585.14912305268240705363.stg-ugh@frogsfrogsfrogs>
References: <168891728293.3329585.14912305268240705363.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <168891728293.3329585.14912305268240705363.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.5-merge-6
X-PR-Tracked-Commit-Id: ed04a91f718e6e1ab82d47a22b26e4b50c1666f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76487845fd23bc2346244fbf7c1a6eb1ed845d28
Message-Id: <168892480239.9789.3327746963938297586.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jul 2023 17:46:42 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     djwong@kernel.org, torvalds@linux-foundation.org,
        dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 9 Jul 2023 08:44:11 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.5-merge-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76487845fd23bc2346244fbf7c1a6eb1ed845d28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
