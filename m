Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968C669D4E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 21:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBTUXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 15:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjBTUXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:23:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBE821A18;
        Mon, 20 Feb 2023 12:22:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7838760F3E;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 485E3C43321;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676924405;
        bh=fp7OIdYbOdBg/TIA6BuvtGBBPP0rn1LeqIEx/iKKBwU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j8jIRMAP+Yx1YSKeLq2QDZYE4QggLsdNsA9Ks5D054/DS744/zXi7XmrQvuJr2J/F
         tOUuawYR+VngTm0j83Y8wtioxLfMEFgydH1DPSpDyahayoFB6CU6VZl4r1FpGfNRfA
         WOymKIx0zJZMxgyyEasm01LNGB7PW00RIFtYHKu7HT2UKYDNtnbeiiBjwRHJ7DD91k
         kXe/lmlhujD9X5EOB9lUiGY/injZXWvsWUC78YSILPCiVakviR/JAqLaBaTbeD+fL3
         IH/7MM/oHP4vT8J354FTs3K/cy9QlhRi/mv0dMg3kjOwd4nyYyOQdz1/Z0CASbch2u
         tiDaWtLV+6Ljg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3088AC43161;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] i_version handling changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0d67a8a252ef22c6506f45761c2f7d1185a44190.camel@kernel.org>
References: <0d67a8a252ef22c6506f45761c2f7d1185a44190.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0d67a8a252ef22c6506f45761c2f7d1185a44190.camel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/iversion-v6.3
X-PR-Tracked-Commit-Id: 58a033c9a3e003e048a0431a296e58c6b363b02b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de630176bdf885eed442902afe94eb60d8f5f826
Message-Id: <167692440519.19824.9061915764435780458.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 20:20:05 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 06:19:17 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/iversion-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de630176bdf885eed442902afe94eb60d8f5f826

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
