Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6980791C67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353417AbjIDSLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbjIDSLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C55199;
        Mon,  4 Sep 2023 11:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E283616E4;
        Mon,  4 Sep 2023 18:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33EE4C433BC;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851069;
        bh=IbVZF2DzXUAo2USMUCstH3jPxauU/LW0IcO2K6LFI4c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ia58bjh4p1fO0/CGw8J5Rs1Vo1j5XfRVWItHIwgeFn8rfWurveiBV3yEbnmuuMJ6P
         0dX1mVg7Y6gTEzMa5Whxk59KrCLCTfB/PrZ0B0WolmEq4yaon1/tV+WLLLtJWG/xY0
         dy6lOtzzaLf+Z8WVNjmVninPcHYRo12hw6zL2O/c4cmCpp6u16HlD9D5vcqdrB2v+e
         G6QjlvbFoe94sLMMbEFQYkCueLzwZr9JAP+5uBddOS46Vz5NEj71bugNLgoSMI1ZvJ
         oNh6Ld267EMxOtUHbtgOPq4KvFjwoTafZWVGD0Gm74c6TV4c+RltqlDafHZDDmUn00
         hWR7BwYjNDGYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1461BC04E26;
        Mon,  4 Sep 2023 18:11:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 01/12] fs: export setup_bdev_super
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169385106908.19669.10487789391922478483.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Sep 2023 18:11:09 +0000
References: <20230802154131.2221419-2-hch@lst.de>
In-Reply-To: <20230802154131.2221419-2-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-nilfs@vger.kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        josef@toxicpanda.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, clm@fb.com, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, dsterba@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, konishi.ryusuke@gmail.com,
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
by Christian Brauner <brauner@kernel.org>:

On Wed,  2 Aug 2023 17:41:20 +0200 you wrote:
> We'll want to use setup_bdev_super instead of duplicating it in nilfs2.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/super.c                 | 3 ++-
>  include/linux/fs_context.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,01/12] fs: export setup_bdev_super
    https://git.kernel.org/jaegeuk/f2fs/c/cf6da236c27a
  - [f2fs-dev,02/12] nilfs2: use setup_bdev_super to de-duplicate the mount code
    https://git.kernel.org/jaegeuk/f2fs/c/c1e012ea9e83
  - [f2fs-dev,03/12] btrfs: always open the device read-only in btrfs_scan_one_device
    (no matching commit)
  - [f2fs-dev,04/12] btrfs: open block devices after superblock creation
    (no matching commit)
  - [f2fs-dev,05/12] ext4: make the IS_EXT2_SB/IS_EXT3_SB checks more robust
    https://git.kernel.org/jaegeuk/f2fs/c/4b41828be268
  - [f2fs-dev,06/12] fs: use the super_block as holder when mounting file systems
    (no matching commit)
  - [f2fs-dev,07/12] fs: stop using get_super in fs_mark_dead
    https://git.kernel.org/jaegeuk/f2fs/c/9c09a7cf6220
  - [f2fs-dev,08/12] fs: export fs_holder_ops
    https://git.kernel.org/jaegeuk/f2fs/c/7ecd0b6f5100
  - [f2fs-dev,09/12] ext4: drop s_umount over opening the log device
    https://git.kernel.org/jaegeuk/f2fs/c/6f5fc7de9885
  - [f2fs-dev,10/12] ext4: use fs_holder_ops for the log device
    https://git.kernel.org/jaegeuk/f2fs/c/8bed1783751f
  - [f2fs-dev,11/12] xfs: drop s_umount over opening the log and RT devices
    (no matching commit)
  - [f2fs-dev,12/12] xfs use fs_holder_ops for the log and RT devices
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


