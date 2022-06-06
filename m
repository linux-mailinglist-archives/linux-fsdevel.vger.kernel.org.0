Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E344453DF12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 02:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348779AbiFFAXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 20:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiFFAXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 20:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD86389;
        Sun,  5 Jun 2022 17:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9496A60ACD;
        Mon,  6 Jun 2022 00:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02178C385A5;
        Mon,  6 Jun 2022 00:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654474983;
        bh=Z/cIi5ka3CYYztmRzLmhC5wiGi28GzFstDl76AdIzhI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tg/0mrKMLjjODaxBLoweCstGUtAaoQdCR0GPhZg5WHq3rBA4Jxhd8LA75CoxcvwJ9
         rzSGoFlEfX7ai60x2RatHf88LViWihQyjthkBBzfZylhya5LpMCTDFlk3y6Zb45aa1
         4YB9pHMQ4O+y0XtbFHm7nCoHaytwNU4VqVYbwgiHCoBfSZhBO5+3quTu1CS1vv3wq/
         a3rN3ZFxOxhATP8u+6vhHgXMUy/ATo1V2daphb4feOgcdjKXEJJb/GE9UkfHJyvKt5
         hCWihja8tVRR5m/Wbqnv6yuYZilqIpo9lnl3RLfdDZNORn5JXRfiEivfGQGqNWfKpp
         Aulb8dThCfUgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA75BF03942;
        Mon,  6 Jun 2022 00:23:02 +0000 (UTC)
Subject: Re: [git pull] work.fd fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yp0AamPDLOK6mTIn@zeniv-ca.linux.org.uk>
References: <Yp0AamPDLOK6mTIn@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yp0AamPDLOK6mTIn@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.fd-fixes
X-PR-Tracked-Commit-Id: 40a1926022d128057376d35167128a7c74e3dca4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6684cf42906ff5f44580e16a1f898e89c19aabd5
Message-Id: <165447498286.29908.11937634749071656490.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jun 2022 00:23:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 5 Jun 2022 19:13:46 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.fd-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6684cf42906ff5f44580e16a1f898e89c19aabd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
