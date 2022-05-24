Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0E5331FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 21:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbiEXTxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 15:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbiEXTxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 15:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C6063BC2;
        Tue, 24 May 2022 12:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABBB7616E2;
        Tue, 24 May 2022 19:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FA35C34115;
        Tue, 24 May 2022 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653421994;
        bh=sIX5nepxizjoL5CUIZMMrQ7EMyDjBxLiWbw2JWQ11CY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NEK2UjL9rBbHHy4NXYKRTLJyDgwZaVw/B6sBAkYZoAz/QfUPs9gYQSruZoRTRELvy
         PkoCh0nEVxvahDBr7mYA52TNVCUNJa4WsX9s3AJoX/ANec5ZgdmjwXMEXHfVxMzjEM
         CfxJucsq0bCCtz7BJ+bpT2dGiuJO115hzLXZYDeK/SatE9D2aahfJi0nurNKL5VH7I
         FKmLL6KQGYxs403zE1oKNcrwbQbi+F9vw0KxqApRnmf3XTRgdfDVm+Yc8VUcCYN9D8
         h87wwwjIYs3bAogORo7esUl74KxMCUhyvSBjFJyWm7DH+Ro1I9Xu4GFKTSqdHNT7zB
         QwOr7nGQD/gog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8D99E8DD61;
        Tue, 24 May 2022 19:53:13 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YoszVvtG55xJnUJ6@sol.localdomain>
References: <YoszVvtG55xJnUJ6@sol.localdomain>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <YoszVvtG55xJnUJ6@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: e6af1bb07704b53bad7771db1b05ee17abad11cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51518aa68c1ffb54f2fdfed5324af30325529b32
Message-Id: <165342199394.18932.13143767074670225290.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:13 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 00:10:14 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51518aa68c1ffb54f2fdfed5324af30325529b32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
