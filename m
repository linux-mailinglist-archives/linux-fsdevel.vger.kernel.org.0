Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75662546DCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 21:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349761AbiFJT6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 15:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350690AbiFJT6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D61F2FA;
        Fri, 10 Jun 2022 12:58:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E496A60AEA;
        Fri, 10 Jun 2022 19:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 585F8C34114;
        Fri, 10 Jun 2022 19:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654891125;
        bh=uPLz0SbrR75GWOhUcjE75Ml6/P9AUj2BXzPG2lUDDBw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b6Yb9bKSBjsF+4vu3nY+wMkrxVetlKMk+1hUkdwuBTgtRMrOlELxBkjG/fd9UIMlv
         EgrtNjprohBaWDTPMbjbWLmQjr7522EfNoyrLH2cR2sQwcqqvIQTMWbfpFFORy5xl5
         UNmnWI1Q/WeN6cyBDH7BZY06T8dHtMhJU/hy0g2KPa6xQd9kwKvauXlHDCkygKe4da
         2Kyh7Bf5bNhPoHT2D1KwE20UkKCkb1V6+80a9KWehbrsdsbZkgD+xhnquSiEaH7VYP
         +1HY659c7dy4+hckgkVUW8zSj2IXJPFsXkLufEQiYbkFnqFKdrHz/UPGLCUHMKrHSO
         yBEHZ1xcJtGng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4265FE737EE;
        Fri, 10 Jun 2022 19:58:45 +0000 (UTC)
Subject: Re: [GIT PULL] Folio fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YqOZ3v68HrM9LI//@casper.infradead.org>
References: <YqOZ3v68HrM9LI//@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YqOZ3v68HrM9LI//@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.19a
X-PR-Tracked-Commit-Id: 334f6f53abcf57782bd2fe81da1cbd893e4ef05c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a32e7ea362356af8e89e67600432bad83d2325da
Message-Id: <165489112526.18106.2150220321689862930.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 19:58:45 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 20:22:06 +0100:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.19a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a32e7ea362356af8e89e67600432bad83d2325da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
