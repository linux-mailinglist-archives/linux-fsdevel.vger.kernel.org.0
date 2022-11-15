Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B835662AF08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 00:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbiKOXBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 18:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbiKOXBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:01:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8C6140DE;
        Tue, 15 Nov 2022 15:01:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE215B81B8F;
        Tue, 15 Nov 2022 23:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 732D5C433D6;
        Tue, 15 Nov 2022 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668553262;
        bh=xi2tiQCRuoMPu5vdJanj/W6Y98sznQKj82AFtTRd9hU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bGyPaMdGWY7hkH9VXXwcBXqdpNr/nJJ9SI2Gs1+j0uywryoxR3qKC1festJSpD6Mj
         em3vhqYBBsfSXkARs4ZvWRmoeCAzRr5P9UgkpQksqFuut5T3Az/YQiiqxF9dRaSdT6
         zf7D32L8GhBtYTjT0UZVZuxmNJCp8dap7so62xIhpTAHtb0aP/PWyeZo629j7CF0lm
         exXyOVgw9GF+GFxBTYtgLUp54DCj2hqTe8y/CQwQJW39o+fCrj3MmuaSXnHvdxZM9j
         wki4RkmZx6LomHLMlriKmY0Ba3Am4mhE2nrV11PoCm38Z1mSa0UhGUwzI0hsxQ47Eq
         w5w+OdfP6wZyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53A91C395F6;
        Tue, 15 Nov 2022 23:01:02 +0000 (UTC)
Subject: Re: [GIT PULL] netfs: Fix folio unmarking/unlocking loops
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1846994.1668547169@warthog.procyon.org.uk>
References: <1846994.1668547169@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1846994.1668547169@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-fixes-20221115
X-PR-Tracked-Commit-Id: 5e51c627c5acbcf82bb552e17533a79d2a6a2600
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59d0d52c30d4991ac4b329f049cc37118e00f5b0
Message-Id: <166855326232.27083.6280024386871580610.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Nov 2022 23:01:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        willy@infradead.org, Jeff Layton <jlayton@kernel.org>,
        JeffleXu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 15 Nov 2022 21:19:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-fixes-20221115

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59d0d52c30d4991ac4b329f049cc37118e00f5b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
