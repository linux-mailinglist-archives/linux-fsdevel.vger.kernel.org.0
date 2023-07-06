Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C251749259
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 02:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGFASU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 20:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFASR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25612170F;
        Wed,  5 Jul 2023 17:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E0261790;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6755C433C9;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688602694;
        bh=AxWXKj6xZqemoSJn5MReVNiSmwIaz00ZUW5JY/dFnnI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=N9MqcuYOKPuUBGYHZnYa7a09QGb8sYMhdXqUpXp7esNKBVEkYMuPoq5AVD+3qh2eN
         Em7P8VSRq1nnM3kVorDfGw0CG4Ko3UTg/FZrbFY8bS8mgvIjKy10p/J9Ebx4mgRCtK
         dD0RYCAFPYcxneynHfN3gd+8xRJDPOpQqUDe6/hztjedbHh/3Z/85+Tx9sJWFBYVnH
         SS5PqMV39SozDnJ1l+2kaF62qWIEqZDsjaARtj0dX/d6ldGVyRCKQbtq9zClTM6usR
         IjaMSlNczNg5O4xkv1lWLNzEr7uH0/7dA3QHj+zvFYcigVAePKt3cPcxr4keh0aegy
         ZSDp3qgB+j38w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91A30C40C5E;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 01/12] backing_dev: remove
 current->backing_dev_info
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168860269459.29151.8627542432532930093.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 00:18:14 +0000
References: <20230601145904.1385409-2-hch@lst.de>
In-Reply-To: <20230601145904.1385409-2-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        agruenba@redhat.com, miklos@szeredi.hu, cluster-devel@redhat.com,
        idryomov@gmail.com, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
        dlemoal@kernel.org, viro@zeniv.linux.org.uk, jaegeuk@kernel.org,
        ceph-devel@vger.kernel.org, xiubli@redhat.com,
        trond.myklebust@hammerspace.com, axboe@kernel.dk,
        brauner@kernel.org, tytso@mit.edu, johannes.thumshirn@wdc.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        anna@kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, hare@suse.de
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
by Andrew Morton <akpm@linux-foundation.org>:

On Thu,  1 Jun 2023 16:58:53 +0200 you wrote:
> The last user of current->backing_dev_info disappeared in commit
> b9b1335e6403 ("remove bdi_congested() and wb_congested() and related
> functions").  Remove the field and all assignments to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Acked-by: Theodore Ts'o <tytso@mit.edu>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,01/12] backing_dev: remove current->backing_dev_info
    https://git.kernel.org/jaegeuk/f2fs/c/0d625446d0a4
  - [f2fs-dev,02/12] iomap: update ki_pos a little later in iomap_dio_complete
    https://git.kernel.org/jaegeuk/f2fs/c/936e114a245b
  - [f2fs-dev,03/12] filemap: update ki_pos in generic_perform_write
    https://git.kernel.org/jaegeuk/f2fs/c/182c25e9c157
  - [f2fs-dev,04/12] filemap: add a kiocb_write_and_wait helper
    https://git.kernel.org/jaegeuk/f2fs/c/3c435a0fe35c
  - [f2fs-dev,05/12] filemap: add a kiocb_invalidate_pages helper
    https://git.kernel.org/jaegeuk/f2fs/c/e003f74afbd2
  - [f2fs-dev,06/12] filemap: add a kiocb_invalidate_post_direct_write helper
    https://git.kernel.org/jaegeuk/f2fs/c/c402a9a9430b
  - [f2fs-dev,07/12] iomap: update ki_pos in iomap_file_buffered_write
    https://git.kernel.org/jaegeuk/f2fs/c/219580eea1ee
  - [f2fs-dev,08/12] iomap: use kiocb_write_and_wait and kiocb_invalidate_pages
    https://git.kernel.org/jaegeuk/f2fs/c/8ee93b4bb626
  - [f2fs-dev,09/12] fs: factor out a direct_write_fallback helper
    https://git.kernel.org/jaegeuk/f2fs/c/44fff0fa08ec
  - [f2fs-dev,10/12] fuse: update ki_pos in fuse_perform_write
    https://git.kernel.org/jaegeuk/f2fs/c/70e986c3b4f4
  - [f2fs-dev,11/12] fuse: drop redundant arguments to fuse_perform_write
    https://git.kernel.org/jaegeuk/f2fs/c/596df33d673d
  - [f2fs-dev,12/12] fuse: use direct_write_fallback
    https://git.kernel.org/jaegeuk/f2fs/c/64d1b4dd826d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


