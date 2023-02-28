Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973856A507A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 02:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjB1BCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 20:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjB1BCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:02:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F329E2B;
        Mon, 27 Feb 2023 17:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7977DB80DD5;
        Tue, 28 Feb 2023 01:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15E2BC433EF;
        Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677546115;
        bh=SOFnAzz1BpATHblwfDPCUsbi+PYozLGsV7wjyMHjkQk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Yrv42d67C/zchBY/GRxlF2I0lPmwe05knllpu/5rTK8vNLkpKkCLGXRW/EjYeRcQY
         aHuxa5lUaSLE2Afe8ejaxjxddX83InNC8yYf/n7QqXsiOwRK1tdC/PAWG2IXcNQOgY
         ctsys9m1rsLd6yP7b7tBdN812nYX2LYEo8qPe+oBIPHLt89g0Cwqkm0p51fR8fPCcg
         TdetilTXNnPAfk0reqGCm2sT8/+GsltnN7i+3VER2zpwbvwtW7x3LYVUOVdHbsdst+
         nRsbnEVQZZ/TZDNRZDCtUZfjm+T1pc4gWZZkfyI00zmudv+MED+Nr1dAn0L670B0wj
         RaBYdXnRZfKoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E53C0E1CF31;
        Tue, 28 Feb 2023 01:01:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 00/11] fsverity: support for non-4K pages
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167754611492.27916.393758892204411776.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Feb 2023 01:01:54 +0000
References: <20221223203638.41293-1-ebiggers@kernel.org>
In-Reply-To: <20221223203638.41293-1-ebiggers@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, aalbersh@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
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
by Eric Biggers <ebiggers@google.com>:

On Fri, 23 Dec 2022 12:36:27 -0800 you wrote:
> [This patchset applies to mainline + some fsverity cleanups I sent out
>  recently.  You can get everything from tag "fsverity-non4k-v2" of
>  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git ]
> 
> Currently, filesystems (ext4, f2fs, and btrfs) only support fsverity
> when the Merkle tree block size, filesystem block size, and page size
> are all the same.  In practice that means 4K, since increasing the page
> size, e.g. to 16K, forces the Merkle tree block size and filesystem
> block size to be increased accordingly.  That can be impractical; for
> one, users want the same file signatures to work on all systems.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,01/11] fsverity: use unsigned long for level_start
    https://git.kernel.org/jaegeuk/f2fs/c/284d5db5f99e
  - [f2fs-dev,v2,02/11] fsverity: simplify Merkle tree readahead size calculation
    https://git.kernel.org/jaegeuk/f2fs/c/9098f36b739d
  - [f2fs-dev,v2,03/11] fsverity: store log2(digest_size) precomputed
    https://git.kernel.org/jaegeuk/f2fs/c/579a12f78d88
  - [f2fs-dev,v2,04/11] fsverity: use EFBIG for file too large to enable verity
    https://git.kernel.org/jaegeuk/f2fs/c/55eed69cc8fd
  - [f2fs-dev,v2,05/11] fsverity: replace fsverity_hash_page() with fsverity_hash_block()
    https://git.kernel.org/jaegeuk/f2fs/c/f45555bf23cf
  - [f2fs-dev,v2,06/11] fsverity: support verification with tree block size < PAGE_SIZE
    https://git.kernel.org/jaegeuk/f2fs/c/5306892a50bf
  - [f2fs-dev,v2,07/11] fsverity: support enabling with tree block size < PAGE_SIZE
    https://git.kernel.org/jaegeuk/f2fs/c/56124d6c87fd
  - [f2fs-dev,v2,08/11] ext4: simplify ext4_readpage_limit()
    https://git.kernel.org/jaegeuk/f2fs/c/5e122148a3d5
  - [f2fs-dev,v2,09/11] f2fs: simplify f2fs_readpage_limit()
    https://git.kernel.org/jaegeuk/f2fs/c/feb0576a361a
  - [f2fs-dev,v2,10/11] fs/buffer.c: support fsverity in block_read_full_folio()
    https://git.kernel.org/jaegeuk/f2fs/c/4fa512ce7051
  - [f2fs-dev,v2,11/11] ext4: allow verity with fs block size < PAGE_SIZE
    https://git.kernel.org/jaegeuk/f2fs/c/db85d14dc5c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


