Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8BF6ED6E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjDXVpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjDXVpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:45:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B481769F;
        Mon, 24 Apr 2023 14:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 919EB62965;
        Mon, 24 Apr 2023 21:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0664AC433D2;
        Mon, 24 Apr 2023 21:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682372740;
        bh=QgMOPmxwyfvkJtZeu70ycsGJCnAcoqtWCdeNivBn5DA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gqyJKyc3fZSMztzdY+9Kq3kSAeq3Opz5Db+4cfhuQsGPQ4IsCsyp3Y47NXYCt3ofK
         JGIHJHcs+OWkLqqurU/35YxaSpNE8osTajZvOcm8yv2PsuOHYqk/lZYezPIZmX9jNM
         NgtwAkkkkv/igPgCd37HTxUHeF4yU9kocmQeTR9wFyw3wHJWi4P842pGCYRD4IZJdN
         BxfsF++bR5AThqWrtDvhYJLw4brGanzrvusBOa5yLl3PE/NQLb7eJ4rVhjlI/xORgE
         7UPYW4xtMV/0+pk1Stn9KykixzOY9MJhMtaYjl85gsi41T+WsdGqgSYchbp03RDxwF
         KGjv3JLHs4Owg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E681EE5FFC9;
        Mon, 24 Apr 2023 21:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] vfs: misc updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230421-mitspielen-frucht-996edfeceba5@brauner>
References: <20230421-mitspielen-frucht-996edfeceba5@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230421-mitspielen-frucht-996edfeceba5@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.misc
X-PR-Tracked-Commit-Id: 81b21c0f0138ff5a499eafc3eb0578ad2a99622c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2eff52ce512ec725f9f1daf975c45a499be1e1e
Message-Id: <168237273994.2393.6079594158063506923.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 21:45:39 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 15:48:44 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2eff52ce512ec725f9f1daf975c45a499be1e1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
