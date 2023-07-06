Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56436749261
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 02:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjGFASV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 20:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjGFASR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFFE19B2;
        Wed,  5 Jul 2023 17:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86619617C3;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2605C433CB;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688602694;
        bh=jeWeqDBXdXSrmkvHTwsjlgtHwli8j2NwSy0V67m5OpY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LFc6trB/jWJ2d9sOD7qtD7F1TkVJxJA3m5cI+rfXCYLfQX/QeyZjdfTItM058ymbA
         oJs6O1qOWB60hFpY3OLmjnXfE0nT0lUT/GJSPcm3bQKVw/qvEOO3F4CwLed9tt08ZP
         STKAwSJaAdz3CvUKCr0rJt5tX6eip7tve5uIAC7vI6irUyCbuQlrqGebnj1zXX6AZh
         oQHN6ySkUg3nySOTWW3r8CmmVnqOo8N3NLtgq6n9TThLBWWV2+ABnQISSSTQOTxhnh
         eKRSv9ffqMh/Bl+H2ItsxP+g33rHwwQKyr6/4T2ZAF7bR25rk5BvWbIWA1rshIgCk2
         kFP1S/HYPCesw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0483C561EE;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 01/17] fs: unexport buffer_check_dirty_writeback
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168860269470.29151.2457227220614428868.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 00:18:14 +0000
References: <20230424054926.26927-2-hch@lst.de>
In-Reply-To: <20230424054926.26927-2-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, miklos@szeredi.hu, djwong@kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-f2fs-devel@lists.sourceforge.net, dhowells@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Mon, 24 Apr 2023 07:49:10 +0200 you wrote:
> buffer_check_dirty_writeback is only used by the block device aops,
> remove the export.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/buffer.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,01/17] fs: unexport buffer_check_dirty_writeback
    https://git.kernel.org/jaegeuk/f2fs/c/4bb218a65a43
  - [f2fs-dev,02/17] fs: remove the special !CONFIG_BLOCK def_blk_fops
    https://git.kernel.org/jaegeuk/f2fs/c/bda2795a630b
  - [f2fs-dev,03/17] fs: rename and move block_page_mkwrite_return
    (no matching commit)
  - [f2fs-dev,04/17] fs: remove emergency_thaw_bdev
    (no matching commit)
  - [f2fs-dev,05/17] filemap: update ki_pos in generic_perform_write
    (no matching commit)
  - [f2fs-dev,06/17] filemap: add a kiocb_write_and_wait helper
    https://git.kernel.org/jaegeuk/f2fs/c/3c435a0fe35c
  - [f2fs-dev,07/17] filemap: add a kiocb_invalidate_pages helper
    https://git.kernel.org/jaegeuk/f2fs/c/e003f74afbd2
  - [f2fs-dev,08/17] filemap: add a kiocb_invalidate_post_write helper
    (no matching commit)
  - [f2fs-dev,09/17] fs: factor out a direct_write_fallback helper
    (no matching commit)
  - [f2fs-dev,10/17] iomap: use kiocb_write_and_wait and kiocb_invalidate_pages
    (no matching commit)
  - [f2fs-dev,11/17] iomap: assign current->backing_dev_info in iomap_file_buffered_write
    (no matching commit)
  - [f2fs-dev,12/17] fuse: use direct_write_fallback
    (no matching commit)
  - [f2fs-dev,13/17] block: don't plug in blkdev_write_iter
    https://git.kernel.org/jaegeuk/f2fs/c/712c7364655f
  - [f2fs-dev,14/17] block: open code __generic_file_write_iter for blkdev writes
    (no matching commit)
  - [f2fs-dev,15/17] block: stop setting ->direct_IO
    (no matching commit)
  - [f2fs-dev,16/17] block: use iomap for writes to block devices
    (no matching commit)
  - [f2fs-dev,17/17] fs: add CONFIG_BUFFER_HEAD
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


