Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002954E4AE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 03:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiCWC2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 22:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbiCWC2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:28:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6E670076
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 19:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89121B81DE6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 02:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 467B8C340EC;
        Wed, 23 Mar 2022 02:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648002423;
        bh=kWoB4bnRJuzFtrdjkmT47yoebQ63FyngWpV49ttsfUo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hBEOMyOEoW73Tsfy8MuZct53WBUGmjENUB3aoQ+aCDNf6PdrNBf9ykWg4T4M4MCOq
         da0XcbF45EXNSxrJVJQhwVl6QwJnWvn6374UNvRWKzrkgm63JlH/XlruJLgdnp/xnR
         fXBYAaej9k8MRLbfoKyOY2qs90SBQjh3iwAfhxRYUO1a4BfsBrlvuxj86+PoBjV2+b
         Fk4622MxxDmgzw6suOIj4S05/Nsl+DeTg/pX19+IJzQdQMyFfczL2VD57ypfeHkm8u
         cHFb2bhAO7HuQit/asq+kusPPphX30D/JE2Htj4SJ+C1BxcSDBigi63uMPruqS41eN
         zjKSy+uRksY0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3510DE6D402;
        Wed, 23 Mar 2022 02:27:03 +0000 (UTC)
Subject: Re: [GIT PULL] Folio patches for 5.18 (FS part)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjiJt4L7mkPrA/En@casper.infradead.org>
References: <YjiJt4L7mkPrA/En@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjiJt4L7mkPrA/En@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18b
X-PR-Tracked-Commit-Id: 3a3bae50af5d73fab5da20484029de77ca67bb2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b1f86f8e9c7f9de7ca1cb987b2cf25e99b1ae3a
Message-Id: <164800242321.31111.1955279086392020754.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 02:27:03 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 14:20:39 +0000:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18b

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b1f86f8e9c7f9de7ca1cb987b2cf25e99b1ae3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
