Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE4E58CDDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 20:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbiHHSmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 14:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbiHHSmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:42:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D615E2701;
        Mon,  8 Aug 2022 11:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D63DB8105C;
        Mon,  8 Aug 2022 18:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 477BAC43470;
        Mon,  8 Aug 2022 18:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659984127;
        bh=KeIN5c5eJicTt4ZSqt38/T8RFk02LjWpJQlaqnhmTXw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mtXPrdwpAre9stBP9ex1j75nAfFaDxoWkMTbGlzqEQLp4qwr3bQ5XQGLi808oXVAD
         nfFfb4U0PSIzmZVYsGuIvcjG2Oqtgkl/06mY7TzYb8ymjmwIftT89/qqfA+4Px10Xb
         mZYW8xO6idIaDBkoCvd2phM1xJEaw9VyjNFS5p8qQm9Thn0zWG6wtMhj6gIQU89mPh
         PwOg/bkXPGYumkxyXh2G4qKi4HA+ToNaMiCPCR0gIN31LcB97+Xxv57zeBNkPcogO1
         e55kiYUSp342yiCUiqAi0qAWgEYWfIzJglvS1saeBfKP798uMZT4cSJuElk1zlxnbZ
         1gXiuvOLz85AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36B0EC43140;
        Mon,  8 Aug 2022 18:42:07 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvEDEKQSOaDaFiWb@miu.piliscsaba.redhat.com>
References: <YvEDEKQSOaDaFiWb@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvEDEKQSOaDaFiWb@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.0
X-PR-Tracked-Commit-Id: 247861c325c2e4f5ad3c2f9a77ab9d85d15cbcfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bd5d41e0e9d8e423a0bd446ee174584c8a495fe
Message-Id: <165998412721.757.16076021346842560131.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 18:42:07 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 8 Aug 2022 14:35:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bd5d41e0e9d8e423a0bd446ee174584c8a495fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
