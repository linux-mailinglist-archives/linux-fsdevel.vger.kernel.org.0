Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D36740766
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 03:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjF1BB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 21:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjF1BBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C2A2975;
        Tue, 27 Jun 2023 18:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A5896124A;
        Wed, 28 Jun 2023 01:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC2C2C433C9;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687914080;
        bh=kcxmWFSqu/rIIej6l4AfxdR5n+4Ee1nLq/EBD4SeM24=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dkHDQK2fkSkcTyY/J4+PazHmOkmghV7dEB9j1Tx7+kg2vUoKnBuwdzPs/sfusbNbp
         4Ta3QBQfi9iNx3MiF2n7i2I6WcGUzRMPd7Zgau7v2HcL6jRdYVlECKE1SyUAKzYJKZ
         BLk1E/CKwp+bLo9C9imtweYzL4OWyKLhfmp1Xp15/I9iqzohg/YB/SR8Uh0JabKt3i
         xomkgQ3sVYBuriyEzDaAG9FdnuqgfGHXMR5TvFqvHO44ssAZ1mVSDAlGXRo+AOSPz2
         nTp4VYRYmk/WrW4fWXT0egZKftXqBadhy9GT14ZAXDEyyIsOxsa9yz+p7Fb4cyNANu
         0VNslvb8U+aBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 980F2E53807;
        Wed, 28 Jun 2023 01:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626084830.717289-1-mic@digikod.net>
References: <20230626084830.717289-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626084830.717289-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.5-rc1
X-PR-Tracked-Commit-Id: 35ca4239929737bdc021ee923f97ebe7aff8fcc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26642864f8b212964f80fbd69685eb850ced5f45
Message-Id: <168791408061.14121.7780809571829106804.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 01:01:20 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-um@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 10:48:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26642864f8b212964f80fbd69685eb850ced5f45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
