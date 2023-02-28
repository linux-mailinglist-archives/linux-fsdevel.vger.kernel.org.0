Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295706A506E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 02:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjB1BCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 20:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjB1BCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:02:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75B329E0A;
        Mon, 27 Feb 2023 17:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B5E7B80D2B;
        Tue, 28 Feb 2023 01:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26477C4339C;
        Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677546115;
        bh=GjKuzdb4uP02dWcsVKBFNOoh1YCehKLSlNBQ+sAkvDU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VvLwYFhmpm5uOu8hBSEIfqD//WOvfe6k9S1qZvLHwTW8BSPY/5VzZdIah1KMh/NrY
         /muCIXkVhH5bg4Hz0qNE42WG3kCHdh8GNbrr+ZjN0X/kBJjphlLBJEZin5kasznNoj
         kWYOipnTkRdmTtmORrdESxJzlUrars286olVWqTQ+TMmxmi/WN1yb9zwrxhbUZoM5J
         8TBiNay35e+fxCurNFSJU0r59d8w8IMiQYZSX3LIVhcuOLAVwWnula1x0tj0VSJdK3
         bqwjRpGlDatnwCnUHTxZlJekLFshv0R3rDFGCW/1zsrFkQ0mO8WE61IOQLosjGpMWW
         Sf7t4EA4lG9uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03E83E524D2;
        Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/5] Add the test_dummy_encryption key on-demand
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167754611501.27916.12033201555755310755.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Feb 2023 01:01:55 +0000
References: <20230208062107.199831-1-ebiggers@kernel.org>
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, torvalds@linux-foundation.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@google.com>:

On Tue,  7 Feb 2023 22:21:02 -0800 you wrote:
> This series eliminates the call to fscrypt_destroy_keyring() from
> __put_super(), which is causing confusion because it looks like (but
> actually isn't) a sleep-in-atomic bug.  See the thread "block: sleeping
> in atomic warnings", i.e.
> https://lore.kernel.org/linux-fsdevel/CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com
> and its responses.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/5] fscrypt: add the test dummy encryption key on-demand
    https://git.kernel.org/jaegeuk/f2fs/c/60e463f0be98
  - [f2fs-dev,2/5] ext4: stop calling fscrypt_add_test_dummy_key()
    https://git.kernel.org/jaegeuk/f2fs/c/7959eb19e4a3
  - [f2fs-dev,3/5] f2fs: stop calling fscrypt_add_test_dummy_key()
    https://git.kernel.org/jaegeuk/f2fs/c/1ad2a626762d
  - [f2fs-dev,4/5] fs/super.c: stop calling fscrypt_destroy_keyring() from __put_super()
    https://git.kernel.org/jaegeuk/f2fs/c/ec64036e6863
  - [f2fs-dev,5/5] fscrypt: clean up fscrypt_add_test_dummy_key()
    https://git.kernel.org/jaegeuk/f2fs/c/097d7c1fcb8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


