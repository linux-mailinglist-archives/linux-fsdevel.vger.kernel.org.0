Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC44E7E4D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 02:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiCZBBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 21:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiCZBBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469E4990B
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 17:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 457E1617F4
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 00:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6CBFC2BBE4;
        Sat, 26 Mar 2022 00:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648256375;
        bh=g02lc30eBVL2Fg9ALpEeYnfkxPoGgz3zAwFPLUnlLhs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ctXDmYhw+g7PugMPFJcoOcPEAis61eFsA0k5dm5Kt6FXe0XHyhros1nANa3KiXIVa
         wQuWwp35YMovdtTaQsTgNAalfrx5vgUntNH8aBnZ0lh9BJ/DThAZV/n2RodIS02M5h
         7aWJeODRDRsaJG4kE9ZBdrXzJFeflvXhuOtHmMKv2JaCS5mM2xW/ZpuNaqk2Js2WRc
         4q3eO9OVKAzrtVPXrDQTHOraG9CQV6OUtVVyU6EnqdVhFCbSlW8l8nskcqyAFy6Xtl
         UeAD6nc3Tvnp+DuGKiMAppeeUuGH3Onx94zs1z6Vt+WKDP5rYFvQA63dC2hKrfidQA
         Fh5KxTljy6uGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94397E7BB0B;
        Sat, 26 Mar 2022 00:59:35 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify changes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220323153125.p7fpgaeze6etunwa@quack3.lan>
References: <20220323153125.p7fpgaeze6etunwa@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220323153125.p7fpgaeze6etunwa@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.18-rc1
X-PR-Tracked-Commit-Id: f92ca72b0263d601807bbd23ed25cbe6f4da89f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8988507e577a89ccaf66b48ea645bcf6e861270
Message-Id: <164825637559.25400.3145932988949713921.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 00:59:35 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 16:31:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8988507e577a89ccaf66b48ea645bcf6e861270

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
