Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07A6F0BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 19:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243767AbjD0R4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 13:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbjD0R4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EFD4C01;
        Thu, 27 Apr 2023 10:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40A3F63ECA;
        Thu, 27 Apr 2023 17:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982F7C433EF;
        Thu, 27 Apr 2023 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682618143;
        bh=LW8ReAjWtMU1W40NwcyyuwROoutMsV4ckgReAUyGQ5M=;
        h=Date:From:To:Cc:Subject:From;
        b=KMKH2ZahPaIV78ix0gW5xNQ8yWowZ9o8+pDZil7yEgIlKcpXF9U6ObbOyOUtgMf+J
         1JwmUgkL/Q15D3MzrIy/dVApc1bngZpw2WjQpf1oFNM8Zc4w+jLDFFh0Ea6LRiMcQM
         FU8XJPqBLay2FvKc0m026fpfbFzv0F+yrf7teL863u4Rk/mjnxCNgDCNkpzSl2uTDn
         stdx6nBLzLpSLW89Q5+jZLMumiXnvz1MObtNSFx5CaTsOEbJOTG4QGtsr9lEAkVCsJ
         n+DkhVtJLZEEGAB/mXaq13Wobtax4hIV8+V4IlQ7mCkPZomzYcrPdMJnCE0uneAkB8
         F7IHWFB4Vhr8g==
Date:   Thu, 27 Apr 2023 10:55:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     hch@lst.de, torvalds@linux-foundation.org
Cc:     david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        disgoel@linux.ibm.com, jack@suse.cz
Subject: [GIT PULL] iomap: new code for 6.4
Message-ID: <20230427175543.GA59213@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for iomap for 6.4-rc1.  The only
changes for this cycle are the addition of tracepoints to the iomap
directio code so that Ritesh (who is working on porting ext2 to iomap)
can observe the io flows more easily.  Dave will be sending you a pull
request for xfs code for this cycle.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.4-merge-1

for you to fetch changes up to 3fd41721cd5c30af37c860e6201c98db0a568fd2:

  iomap: Add DIO tracepoints (2023-04-21 08:54:47 -0700)

----------------------------------------------------------------
New code for 6.4:

 * Remove an unused symbol.
 * Add tracepoints for the directio code.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Ritesh Harjani (IBM) (3):
      fs.h: Add TRACE_IOCB_STRINGS for use in trace points
      iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
      iomap: Add DIO tracepoints

 fs/iomap/direct-io.c  |  9 ++++--
 fs/iomap/trace.c      |  1 +
 fs/iomap/trace.h      | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h    | 14 +++++++++
 include/linux/iomap.h |  6 ----
 5 files changed, 100 insertions(+), 8 deletions(-)
