Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD152749269
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 02:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjGFASW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 20:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjGFASV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A268619B6;
        Wed,  5 Jul 2023 17:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C596617CF;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC42FC433CC;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688602695;
        bh=xIK8FsM0y6IdTXxoj2yUtX8ybh4E/hSNnrTgFUHcmA8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ksZHAgHMiqjHHNI+HBfmh/tl3uHBBT0nfbChSIFhUHykziJMCSV/dXLYK3T1W2p9U
         CirRv9+voPPJIwygedt30zAR6PpNsTqJ6iiu3TVFL5TNFBAhEa7XCLXru7Pxe8gh7q
         g4a2eOmEDNhcCl+xlsMDNsHW2SW6gLnNfgOwk7VSYh7OzpsGT9NjdI+ITbQ/WcG9Wn
         fIp3qfeQtscPJ+OpOWfQRZh4xECVMU2dlje1Cr3uA9UldOejm8bKH1tP/qXpJ7er3w
         3jYQGpCyQ1ko5Njz6BZi4VANr+UNx+6bTyfw+gMFEXf+gHhZEkKp+Ojf0kEDAn6G35
         fB5WZ+CX6Rz1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC72CC6445A;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v21 19/30] f2fs: Provide a splice-read stub
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168860269483.29151.4192794448591336624.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 00:18:14 +0000
References: <20230520000049.2226926-20-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-20-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, hch@infradead.org,
        linux-block@vger.kernel.org, hdanton@sina.com, jack@suse.cz,
        david@redhat.com, torvalds@linux-foundation.org,
        jlayton@kernel.org, brauner@kernel.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgg@nvidia.com,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, logang@deltatee.com,
        hch@lst.de
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Sat, 20 May 2023 01:00:38 +0100 you wrote:
> Provide a splice_read stub for f2fs.  This does some checks and tracing
> before calling filemap_splice_read() and will update the iostats
> afterwards.  Direct I/O is handled by the caller.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jaegeuk Kim <jaegeuk@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: linux-f2fs-devel@lists.sourceforge.net
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v21,19/30] f2fs: Provide a splice-read stub
    https://git.kernel.org/jaegeuk/f2fs/c/ceb11d0e2da2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


