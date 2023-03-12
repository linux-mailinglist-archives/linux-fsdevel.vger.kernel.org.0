Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633B36B683C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Mar 2023 17:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjCLQYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Mar 2023 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjCLQYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E037AC17D;
        Sun, 12 Mar 2023 09:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B707A60F7D;
        Sun, 12 Mar 2023 16:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BA05C433D2;
        Sun, 12 Mar 2023 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678638057;
        bh=wj2Geue9PvdzS0yAyqRmaawig4f9KHGB2tzcOiHkIxA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RPubZuIb8O2BKhX4R5MjPjpyuZGoVNPD0Nhgor/ErVRC2ESQ7WFgMkXskAJfO/Wak
         sZGlakxjABAwSDS8aanMwc6UqbCGL1diucjytMhy1Pfs+vQrs3ewu01xy1xNrv0omF
         cFxK2AOAnP6RkG0oQr1uhFdgEK1TQJBlrxPmPy87CY9Ox6RjkMF/HRf6Zz8hIEzXWl
         Q9DoedJEmQvk5qhl6pP9Be3dyzMXT/7BMjYWrInWaw/brNuK3fwWKikkVi1ozqzkzg
         GkPDHa73/N0uao9bPdxea/SeZV/ovoOme1CKOSBIJTJTC7E5mkiOCkVKS4Hn+NSZiU
         //9CUpWbkpoqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 146EFC59A4C;
        Sun, 12 Mar 2023 16:20:57 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230312121821.919841-1-brauner@kernel.org>
References: <20230312121821.919841-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230312121821.919841-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/vfs.misc.v6.3-rc2
X-PR-Tracked-Commit-Id: 42d0c4bdf753063b6eec55415003184d3ca24f6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b11717f95b1880b9cab4b90bbaf61268e6bda2b
Message-Id: <167863805708.16000.7357010919326168091.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Mar 2023 16:20:57 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 12 Mar 2023 13:18:21 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/vfs.misc.v6.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b11717f95b1880b9cab4b90bbaf61268e6bda2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
