Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E786858844E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 00:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiHBW31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiHBW3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:29:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DC854CA0;
        Tue,  2 Aug 2022 15:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EDDEB81F3A;
        Tue,  2 Aug 2022 22:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DFA0C433B5;
        Tue,  2 Aug 2022 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659479359;
        bh=6k3OatMgPbFy7xQbQpUf56CUoLQuCPMnWjRX91wl4Bw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n2w4HuXyBe8fZe07vE4TDtpKnfj3DsgskRWnCzbhwday1qkjpBS45Ixv6tN5375pv
         1ev0d/Zr6KKCueIGVlWvwW/+nqd5xS1M09dLOwepoxEPiAOnbkzDusJwUIYofnKmiu
         8MGDREf1A6lELK1nw64CaBqnVPWnbqZn29PUNVZ3Pc44SdOFKRMkLrbC+n6NffeBsg
         418xyK5UgeV7KfWfFY8rxIbMM06alNCvABHisqCysB/3Y2WVT2TJGVqQtEV5Ul3wXa
         2KIcvwN9+NRbL/BBnbFBjFERSVk90vbSdtMrat2a/rnRsQNOBiYYRwNwLIAxZd4QWw
         6P/MdoQ+BY38Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40B8CC43140;
        Tue,  2 Aug 2022 22:29:19 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity update for 5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YumBQPF6U9b6wGV9@sol.localdomain>
References: <YumBQPF6U9b6wGV9@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fscrypt.vger.kernel.org>
X-PR-Tracked-Message-Id: <YumBQPF6U9b6wGV9@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 8da572c52a9be6d006bae290339c629fc6501910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 569bede0cff5e98c0f862d486406b79dcada8eea
Message-Id: <165947935925.5634.14595000911581676087.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 22:29:19 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 2 Aug 2022 12:55:44 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/569bede0cff5e98c0f862d486406b79dcada8eea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
