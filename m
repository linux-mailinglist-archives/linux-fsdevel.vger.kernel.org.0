Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDAB53D92E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 04:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbiFECOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jun 2022 22:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbiFECOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:14:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A273186D1;
        Sat,  4 Jun 2022 19:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8642B80AE6;
        Sun,  5 Jun 2022 02:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91325C36AE5;
        Sun,  5 Jun 2022 02:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654395240;
        bh=JHb8Tul9ahg29zHOZ7U7p+QysSMsJLc4gC4Osiffiq8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KWHXe+pXA7nqHpm0RY0lwCE4eIWuRyDr0AmInCFNcBqqYt4vlJeE16de7HKQJXOPI
         E27dwwIRPtuqTtO3wYEL5hvBY56ku4nFc9ACAdR3q77lfZkriyHA56urTzUD3qXldz
         3Dj2kthQUMi5q4TEqHJM/56kYta9K3lobQOpqkfkzDrt0WjvR/PGiTKS4jPke5QXxN
         jzOpe9FOV+rQOl50pC4YptKIRUJ4tbmQstmC843l+9MEVFRaVk12o5WwGJKLMG7TnV
         TGGqYXxvUzdiFcAESmuy7Pm9k3MHZTy4bIv90/KGSSDvRutjGqVIT4hPRh2KAVjT6K
         IyVkyI5LxFA2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EC0BF03875;
        Sun,  5 Jun 2022 02:14:00 +0000 (UTC)
Subject: Re: [git pull] several namei cleanups
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpwFac1yAziJu/z0@zeniv-ca.linux.org.uk>
References: <YpwFac1yAziJu/z0@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpwFac1yAziJu/z0@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-18-rc1-work.namei
X-PR-Tracked-Commit-Id: 30476f7e6dbcb075850c6e33b15460dd4868c985
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 952923ddc01120190dcf671e7b354364ce1d1362
Message-Id: <165439524051.29822.15968807123205030786.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 02:14:00 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
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

The pull request you sent on Sun, 5 Jun 2022 01:22:49 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-18-rc1-work.namei

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/952923ddc01120190dcf671e7b354364ce1d1362

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
