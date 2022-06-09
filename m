Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38325545528
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 21:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiFITur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 15:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiFITuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:50:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0953A8FBB
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 12:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED117B83053
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 19:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1CF7C34114;
        Thu,  9 Jun 2022 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654804241;
        bh=r9xrnO9WoLM0ZhKHDg/T3dKyIrX/NZaXZTWOpzqY7yg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jkt8uvJocPJfZtrhUBePWjxlI4sOpWqHkGLAqWKrOEcLC5/t0YoDDRSh8SS5y8yVs
         1yolPizNSSCGTOap+aKglxireq+CEE1HmNT08RIuO2FnM1MKRoNkt/HgdmaaBcZ2V0
         FCm0B2kh6IU1+xucZZhJ9XL3YdiBsfoFIYhdWE4h+E0KcytnJxtwK7egc9s0HCj0MY
         DRadwi98PSU5MQ7BOck5PyLqAgE0BsaAmmtDkNZFxdOqs0QDw46IrlO+MmzRRWUOnY
         +7s8GkbJ4wXzil3AumjASfeuCrRkAyGFKQnmSoA0HivnQbxgjRKD+ORWDYqEvbljqG
         dQLs/kPEJRJrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F160E737ED;
        Thu,  9 Jun 2022 19:50:41 +0000 (UTC)
Subject: Re: [GIT PULL] ext2, writeback, quota fixes and cleanups for 5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220609183037.w67c7roxtkm7xsx2@quack3.lan>
References: <20220609183037.w67c7roxtkm7xsx2@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220609183037.w67c7roxtkm7xsx2@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.19-rc2
X-PR-Tracked-Commit-Id: 537e11cdc7a6b3ce94fa25ed41306193df9677b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d9f55c57bc3659f986acc421eac431ff6edcc83
Message-Id: <165480424157.15723.11883679327469643742.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Jun 2022 19:50:41 +0000
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

The pull request you sent on Thu, 9 Jun 2022 20:30:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d9f55c57bc3659f986acc421eac431ff6edcc83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
