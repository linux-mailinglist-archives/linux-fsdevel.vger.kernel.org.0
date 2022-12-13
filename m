Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B364AE6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 04:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiLMDtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 22:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiLMDtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:49:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D61E3CD;
        Mon, 12 Dec 2022 19:49:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E76B3B810C3;
        Tue, 13 Dec 2022 03:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9603EC433D2;
        Tue, 13 Dec 2022 03:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670903372;
        bh=OwEXx2hBMqK4vs6p+/exXhWa0S8UaCeUmpvQUBuPB2Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GTLEVU7oDNg+szLIK9smFvAP3eFKp0dz8JLQkcjUPIhiuG2jQwcDLMKiHlukLVwdm
         zvl0xgacgtOOEtLD+zn3y/CcronYP2hNkrC7PPThijD8gNjOhThNhQVl1wzGuMQNkw
         k1O+lQ4FiTYc7wQwCPEXOMTx+zwrFgbfrtAFezKX0BQvkHkkv5JWQSxKvOXdDKTMvF
         zxJDZG8xzGwPHqJrVEkuiLuCzn/RuRhoZfh56J1TjZMhV0tbG2w5u5Q5K+UtJilh0s
         f+i89i8VR0yXVFF4SuWEtuv6Zv9lgEfAD9BzFhwC7a1d7lxtr+HJopZIrwVl0hizzJ
         nQ5Q8Wn6u0eZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 857C9C395EE;
        Tue, 13 Dec 2022 03:49:32 +0000 (UTC)
Subject: Re: [git pull] vfs.git namespace fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5Z3d+DP8TwJCDr8@ZenIV>
References: <Y5Z3d+DP8TwJCDr8@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5Z3d+DP8TwJCDr8@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-namespace
X-PR-Tracked-Commit-Id: 61d8e42667716f71f2c26e327e66f2940d809f80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13c574fec815f449fa812df60844bbb4b1548d19
Message-Id: <167090337254.3662.6302706966943477717.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 03:49:32 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 00:36:07 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-namespace

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13c574fec815f449fa812df60844bbb4b1548d19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
