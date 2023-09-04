Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FE0791C6B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353429AbjIDSLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 14:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353411AbjIDSLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:11:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8C4E6;
        Mon,  4 Sep 2023 11:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20CB2B80ED0;
        Mon,  4 Sep 2023 18:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D11E1C433C9;
        Mon,  4 Sep 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851068;
        bh=r/KSGQSC2NTgHdn0OJxxPyQs5JUPuWZgLFSrloxRrHA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WY31BwYbsVaGAsAtOYrlZpg1KnLgAs5RHjbBmkE63X+qnTxnsbYUW9NjQiKOCOSGM
         35dAjc/16r8x9+4UIY1GQvYdcgSsF77G7M2umeI4achKQwD1r8kxyKpsMJDAeQKbTj
         u6bTnoPshfWTKPGcNpvjSFXZ9frMcmaQ0P9oEyxf+sCu7ki/Kd6jSbGw0PTGvlI3UD
         RA7tIDXWOm7Wp2tIjI5uMzknfLnXGn9YM9MyAad0LLRUPYtXYJ8QofSzgrkLH468um
         4pvwF6c7OW0hlvH9nqUhoyMV8I8+BpXY3iW5/itS6xyJ86O/cYKn3kkqQsfYzZub2B
         DuKDMXXQ3sPjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6BD6C0C3FD;
        Mon,  4 Sep 2023 18:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 01/17] fs: unexport buffer_check_dirty_writeback
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169385106874.19669.13506137748616735375.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Sep 2023 18:11:08 +0000
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
    (no matching commit)
  - [f2fs-dev,02/17] fs: remove the special !CONFIG_BLOCK def_blk_fops
    (no matching commit)
  - [f2fs-dev,03/17] fs: rename and move block_page_mkwrite_return
    (no matching commit)
  - [f2fs-dev,04/17] fs: remove emergency_thaw_bdev
    https://git.kernel.org/jaegeuk/f2fs/c/4a8b719f95c0
  - [f2fs-dev,05/17] filemap: update ki_pos in generic_perform_write
    (no matching commit)
  - [f2fs-dev,06/17] filemap: add a kiocb_write_and_wait helper
    (no matching commit)
  - [f2fs-dev,07/17] filemap: add a kiocb_invalidate_pages helper
    (no matching commit)
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
    (no matching commit)
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


