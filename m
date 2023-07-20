Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB33D75B4F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjGTQtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjGTQtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5732272C;
        Thu, 20 Jul 2023 09:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39EAA61B60;
        Thu, 20 Jul 2023 16:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8709DC433C8;
        Thu, 20 Jul 2023 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689871739;
        bh=DuD2wgdpVvuLiAqRF7Zn0+FnsXSJdgY65WHCFNEQDWI=;
        h=Date:From:To:Cc:Subject:From;
        b=gMQgtGMKJXDlnozqtvdqh6G6Cl7nRILPIlqFgXZnhaM0gswBapI/+QbRGlrAj2bT7
         IfH5jEzTx2Bder0eWx/9Lh2YwCmRtAsLBylghc4BFz/A4JLuWkgkW3EGjAzmypmAOx
         NgSl9AOyrB2GabSbhAoVMVQXtJdDJVazwVBlBqiuyPcuTZu6ImWAJZpo0U2THQP5cx
         OpMTKmWeFXpzGC7Fvh0T1a0DRV+1hAV2aioNU/rRAsSdwh1dD9Kzj1F+bhQmZlAKbE
         5/TiMP0epU0ayGmE6PMApmY92O3G/Y3SM0lneGul4Cvb12f2OLoa6xsrdda1DBzWe8
         QHjDJW685ci3w==
Date:   Thu, 20 Jul 2023 09:48:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org,
        torvalds@linux-foundation.org
Cc:     chrubis@suse.cz, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, oliver.sang@intel.com,
        ritesh.harjani@gmail.com
Subject: [GIT PULL] iomap: bug fixes for 6.5
Message-ID: <168987161500.3212821.11938475539735933401.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with bug fixes for iomap for 6.5-rc2.  It turns
out that fstests doesn't have any test coverage for short writes, but
LTP does.  Fortunately, this was caught right after -rc1 was tagged.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.5-fixes-1

for you to fetch changes up to efa96cc99793bafe96bdbff6abab94d81472a32d:

iomap: micro optimize the ki_pos assignment in iomap_file_buffered_write (2023-07-17 08:49:57 -0700)

----------------------------------------------------------------
Bug fixes for 6.5-rc2:

* Fix a bug wherein a failed write could clobber short write status.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (2):
iomap: fix a regression for partial write errors
iomap: micro optimize the ki_pos assignment in iomap_file_buffered_write

fs/iomap/buffered-io.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)
