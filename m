Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107AE74925D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 02:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjGFASU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 20:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjGFASR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AA919B5;
        Wed,  5 Jul 2023 17:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7DE2617CA;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D9B4C433B6;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688602695;
        bh=QMrYJdg+aOWaiyZfZoVZY2OuILKdY/U5yz1KaTAkd7U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vCD4uGNUUhLG/V6I5lQjxVsUYosjHRyPmUV7k4XnRL8wBajrzjoJeO3ghL7rZecnt
         6/J1ZVlHr8/XIGXsEx/6/TU/U2Vh5GTfECRxfk7mIF/ed1nnHkRC9hreSdE4aAribH
         qxebfqc1G6XMmOFK4Qa9+Cheaw2tte+FdMBTY+dLa3gcEQqlz8gsjKyxd1UgR4+5nB
         6xQvUwe2G2aQ4pZSQs3pfHnETzGrzgwRgqzJd1EeAFSBxDAkNsm85SCe4E5Ns/+Qcy
         63BVtANWNnsg+w2LcUqPs84jjE64U3dFxwnJOStzHgP5Dkb26lOzt20CgFACLVFjed
         cYz8f9mT0B0FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8DE5C40C5E;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] fsverity: use shash API instead of ahash API
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168860269495.29151.10455269448863933897.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 00:18:14 +0000
References: <20230516052306.99600-1-ebiggers@kernel.org>
In-Reply-To: <20230516052306.99600-1-ebiggers@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@google.com>:

On Mon, 15 May 2023 22:23:06 -0700 you wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The "ahash" API, like the other scatterlist-based crypto APIs such as
> "skcipher", comes with some well-known limitations.  First, it can't
> easily be used with vmalloc addresses.  Second, the request struct can't
> be allocated on the stack.  This adds complexity and a possible failure
> point that needs to be worked around, e.g. using a mempool.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] fsverity: use shash API instead of ahash API
    https://git.kernel.org/jaegeuk/f2fs/c/8fcd94add6c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


