Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC055864B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 20:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiFWSKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiFWSIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3ACBC26C;
        Thu, 23 Jun 2022 10:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE21A61E69;
        Thu, 23 Jun 2022 17:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03F98C341C5;
        Thu, 23 Jun 2022 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656004797;
        bh=4Vug+DV/xgpRkey0OOqNkk9nVBq+acJ5RMT6SPuvoV0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HDvUqirTlnIfUavyR/dfeLrrJW68kNSzhaAR8FPWvmqMTJ8IJVgaRxx0tOUCe2oW6
         wsJK7DyqSNwZG6OjZFqySX2SUxGzCw5FRtZ/0zwd7M6MwdJ5zRJlkgNFGeYTxQT9G6
         mblWwNKWPmIq7CswSkjvDqFqyo03Lx9xwmBv8/f3r0RHlrHzHtE4InVP7uvvfm7Wqn
         tN1Lw67qe3mtNSyqqDONL6ou/YK+/Kt5Rl1KUm8jxMXhMTfwmeaSLqgpAHUOgAmpG3
         f5jwhfrgKSJjiSptVPtlLg2m2Q/mCnbyODqtebzyqp413vqt/7NkaTcC0ltT65l/wr
         P56gdts7//5IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFAE2E7BA3C;
        Thu, 23 Jun 2022 17:19:56 +0000 (UTC)
Subject: Re: [GIT PULL] Pagecache fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YrSYAKtoRrrgayrZ@casper.infradead.org>
References: <YrSYAKtoRrrgayrZ@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YrSYAKtoRrrgayrZ@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.19b
X-PR-Tracked-Commit-Id: 00fa15e0d56482e32d8ca1f51d76b0ee00afb16b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16e4bce6de64c8f6a0f2f221154ffa8c5fe9cdd0
Message-Id: <165600479691.24638.8339551731180467148.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jun 2022 17:19:56 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 23 Jun 2022 17:42:40 +0100:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.19b

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16e4bce6de64c8f6a0f2f221154ffa8c5fe9cdd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
