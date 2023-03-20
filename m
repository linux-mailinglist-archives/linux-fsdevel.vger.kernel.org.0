Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865786C24D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 23:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCTWlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 18:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCTWlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:41:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4833CFA;
        Mon, 20 Mar 2023 15:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86A9BB8108F;
        Mon, 20 Mar 2023 22:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36DC8C4339B;
        Mon, 20 Mar 2023 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679352058;
        bh=Y9+fRvoA6JYPY6fCFaksLpkN5oy7meel0lfHKE7i2Wk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UQYeAsXZlU81Ab+CZWcTDJ90C2AMox2MUjW8uH+OyIOyfvkDV0Dp/ZuNXcZjQkCmV
         +jpE+uVVr9MBraJDdKSjdQWb8NOvwTcDAqxPyzam8a6CKL2q/S33QI6phWksclDFNA
         PQBn/hNbqDi5VtIChR67NyAuDUp8MnuDldYvMX5htxBYA5TaVcxWqYOUZNPRpgoso5
         3Qw1DTT8T+XqPPY+04Gi+3Q31u8UNTR0sFUw/vs97Wx2E2njooB219z7iUQOlR0wMY
         KvU0TWT8C5MTzXdc3RlMMIIhIpP9YAIrcBcMIZU+aaefHj/dhVaUy8LWCCsWCLbrxU
         vRTKbTrmRyE2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CBC5E68C18;
        Mon, 20 Mar 2023 22:40:58 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt fix for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230320205617.GA1434@sol.localdomain>
References: <20230320205617.GA1434@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fscrypt.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230320205617.GA1434@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 4bcf6f827a79c59806c695dc280e763c5b6a6813
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f1e308df88ad25c88ab4240161cbac45ba2d78e
Message-Id: <167935205811.2111.13125595942983592868.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Mar 2023 22:40:58 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 20 Mar 2023 13:56:17 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f1e308df88ad25c88ab4240161cbac45ba2d78e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
