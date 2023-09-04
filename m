Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7591A791C90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353403AbjIDSLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjIDSLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A589197;
        Mon,  4 Sep 2023 11:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D34676160E;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A55FC433BD;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851069;
        bh=6PRC2IiXOaVQ74rsqcqlaidhvNsvQl6gN6anNwKmH0Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sM5gXvVxBTbLKXM4zeMrnhi3wGLIX+kAeewNYN0MFxtWVI7SEPDf2wFxs2s3Pwnth
         yqpnH5JHbAWIcRhtwNZhAZhMJ6MGeIaJoTstJ/tkvt3FZyQwzMV6cOgUSocRSaXUz1
         5w2aLgeG4KUnKPBPu6QATkd85nxxzXS6zoEDB+lw/OsBRaR7mvQAXba6y69P9sLeXt
         54OZnTSjbSK6qDO2x8fsJEnQFSmpOhamIEqCAxEmXE4oydL6Ybr7AaH/fijRxsy8Yt
         ilvyJOum2raf9GBdSKVlAU4PraDAaMxQICKPMioyjy7UN6z9UHS0VAqZOWcJM35VOv
         nhY+rzU7Nh3wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 090F6C04DD9;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/3] Simplify rejection of unexpected casefold
 inode flag
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169385106903.19669.6849396083145416463.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Sep 2023 18:11:09 +0000
References: <20230814182903.37267-1-ebiggers@kernel.org>
In-Reply-To: <20230814182903.37267-1-ebiggers@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, krisman@suse.de,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Theodore Ts'o <tytso@mit.edu>:

On Mon, 14 Aug 2023 11:29:00 -0700 you wrote:
> This series makes unexpected casefold flags on inodes be consistently
> rejected early on so that additional validation isn't needed later on
> during random filesystem operations.  For additional context, refer to
> the discussion on patch 1 of
> https://lore.kernel.org/linux-fsdevel/20230812004146.30980-1-krisman@suse.de/T/#u
> 
> Applies to v6.5-rc6
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/3] ext4: reject casefold inode flag without casefold feature
    https://git.kernel.org/jaegeuk/f2fs/c/8216776ccff6
  - [f2fs-dev,2/3] ext4: remove redundant checks of s_encoding
    https://git.kernel.org/jaegeuk/f2fs/c/b81427939590
  - [f2fs-dev,3/3] libfs: remove redundant checks of s_encoding
    https://git.kernel.org/jaegeuk/f2fs/c/af494af38580

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


