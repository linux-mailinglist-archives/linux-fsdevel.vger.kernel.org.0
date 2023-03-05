Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E2B6AB1E9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 20:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCETh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 14:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCEThZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:37:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E3313D54;
        Sun,  5 Mar 2023 11:37:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66CC0B80B10;
        Sun,  5 Mar 2023 19:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29875C433EF;
        Sun,  5 Mar 2023 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678045042;
        bh=zEJI7yk42TZcaVP8xqLw5rhLMIuJEUHNURqp3RX0DFU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GDJ30jhPA2OKTvtwOx6uhfAAzNkBAVILdfS1C9HPyRCIuH3f0Oo/XpCjb1jhg3yTk
         3L1LbxhlpozGP/9xJLBxDb0hecXJB6a5sq2+ca2IBQfhz02njVf5zENrzANIiFb7Ne
         z0iAWBKl7VUy3iKOyBjSmUe+nYXVSy/1/5EZnq/hBXxWiT0bPSmcEFMoSRbMwaKyaA
         ud8Jlw9FZQhrFt2gT8ZGvBnAW7Cw0Yz4pbSEm7JTGNB8oBh2s+InkOe8wOfcAN1VMx
         Jzepu00KoM1gJgtrNrr26fIFVCveeAsyRyYZmY9EMUC9LylG4u4hv3vw+bq6HTmad7
         LbAPcyfVIHhpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1127EC41679;
        Sun,  5 Mar 2023 19:37:22 +0000 (UTC)
Subject: Re: [git pull] add Christian Brauner as co-maintainer
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZAToVz5v5WlhzskY@ZenIV>
References: <ZAToVz5v5WlhzskY@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZAToVz5v5WlhzskY@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc
X-PR-Tracked-Commit-Id: 3304f18bfcf588df0fe3b703b6a6c1129d80bdc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a90673e17b6bcc6b6e8c072015956a6204e0f2d
Message-Id: <167804504206.1860.12952686498509871025.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Mar 2023 19:37:22 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 5 Mar 2023 19:07:03 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a90673e17b6bcc6b6e8c072015956a6204e0f2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
