Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23A9742ACB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjF2QrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjF2QrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3FC30DD;
        Thu, 29 Jun 2023 09:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A9DF6159B;
        Thu, 29 Jun 2023 16:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1C9C433C0;
        Thu, 29 Jun 2023 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688057243;
        bh=uTPqfbLpFK91fX+/+3fqqb+PVotmFsbVbNjN3oAmvVg=;
        h=Date:From:To:Cc:Subject:From;
        b=TeA+sJh26QF4jD07mj29FENZY3FTPBZzWVSGxYoe2QenPcRE35d5lFxUh7mQIWx5R
         rDZD2nzc1H/P6qRFfRw+A8K/XXDyn6xVaqAzY8JOj2pn5HLv78O10v0kR+iUT4hDEP
         Lwj92uW868Pe46R5+L4226FjjnaBZrgtYNRLwMfSlqlP9HLiiFz9vxrssii/qTOcb6
         Gifesy8z4E/6kw6pnFwvrdIApLJG4Pwa9eQetjcAWT4qRtRN7Vp/W2+VGE+K27MjlG
         xGatNnGC6goUDxE3BYGsEL4IQVIJt5XiRb/NKwlEDl4eCtgmzexBIzZrd8XOtoCHpg
         cf0k/MpE+AxtA==
Date:   Thu, 29 Jun 2023 09:47:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org, hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        luhongfei@vivo.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 447a0bc108e4
Message-ID: <168805719071.2195215.10961365906596770083.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-for-next branch is commit:

447a0bc108e4 iomap: drop me [hch] from MAINTAINERS for iomap

2 new commits:

Christoph Hellwig (1):
[447a0bc108e4] iomap: drop me [hch] from MAINTAINERS for iomap

Lu Hongfei (1):
[302efbef9d77] fs: iomap: Change the type of blocksize from 'int' to 'unsigned int' in iomap_file_buffered_write_punch_delalloc

Code Diffstat:

MAINTAINERS            | 1 -
fs/iomap/buffered-io.c | 2 +-
2 files changed, 1 insertion(+), 2 deletions(-)
