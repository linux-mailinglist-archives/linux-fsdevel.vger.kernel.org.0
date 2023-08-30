Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8454878E27B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 00:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbjH3Wnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 18:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjH3Wns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:43:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1251B2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 15:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4B6BB82010
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 19:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96D02C433C7;
        Wed, 30 Aug 2023 19:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693425045;
        bh=6sAqaxSY7YJu9L3azi5lfBccC0ARlI/+XBYOGeZa2Yc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hlla8aNEM7dDVKRa6px/rqFHarBE/NJMqzMErS0Hs27i3zYMV2Fp7Nn6dX9JCerOe
         PNlN7/ezh2YGMuUQM1fsOgXTcoodDgGE+KMK4t3EYnzsxsXYdm073JUs9yfEcvaoOB
         x44UQiKHA5RlzzEfdRzB3rhKVFHgpPAR9e4fZBgNqf7klWYvKjCT4+rAKUqvtVwP4B
         kA+5p4LNUSyP3QgmwPkhHuFgI4xLNyCFETGgrmndnDq2tJiRWVNH7c9P4EIe+ucIjy
         JvA5RX2YVxR9NwLUXy8eN27MVkHCqO7RlWUn/BSOe1w3fkwGw7DzU8P68Wb5/1avcy
         KOYSVPpY7X6xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86FB0C64457;
        Wed, 30 Aug 2023 19:50:45 +0000 (UTC)
Subject: Re: [GIT PULL] fsnotify cleanup for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230830102738.e2qg3odqvxjzmpbl@quack3>
References: <20230830102738.e2qg3odqvxjzmpbl@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230830102738.e2qg3odqvxjzmpbl@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.6-rc1
X-PR-Tracked-Commit-Id: a488bc16225efa7e3d25977ac1472c3d4cf0e958
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38663034491d00652ac599fa48866bcf2ebd7bc1
Message-Id: <169342504553.11446.15502586545190059201.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 19:50:45 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 12:27:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38663034491d00652ac599fa48866bcf2ebd7bc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
