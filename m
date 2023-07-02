Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B8E744E94
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjGBQW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 12:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGBQW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 12:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCFEE60;
        Sun,  2 Jul 2023 09:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1337D60C24;
        Sun,  2 Jul 2023 16:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F3EC433C8;
        Sun,  2 Jul 2023 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688314976;
        bh=Bonqwaq84HlTxxgKO2F368+ySZfQO++EzwRLAyLLXtU=;
        h=Date:From:To:Cc:Subject:From;
        b=lzsjDCt8SHkXV4DlI7ZXTeryRBVycTTBafczKaC79jj6Z3tC4cugysblm+EJgDQFV
         HJerdzq3vHhOhZsZkq2Yx8NNAM2j+Jj7xcGFJ6BvULHIrPnIiN8tjOmCjaKYPpPnzS
         p8mud3t2jwr67ZrSE/kKwtdhlGMdlDw1BiXNDvLgQCyW+/xCcZza83k3WpeCXRKj/e
         zxTljU2C8G/y0BPfhfl2RtRnKM8hUE82hByHDGhVW1b2AUp1Itd/YsvN51zG+2hsMN
         CjZcJ4tKGpTB2U4Kt4sPmyeHdN7NpMc4d7eclS1g6r1IqJWH8y14HnvQcewdeDJifz
         Qea2VKbLWpa/g==
Date:   Sun, 2 Jul 2023 09:22:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        torvalds@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        luhongfei@vivo.com
Subject: [GIT PULL] iomap: new code for 6.5
Message-ID: <168831482682.535407.9162875426107097138.stg-ugh@frogsfrogsfrogs>
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

Hi Linus,

Please pull this branch with changes for iomap for 6.5-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.5-merge-1

for you to fetch changes up to 447a0bc108e4bae4c1ea845aacf43c10c28814e8:

iomap: drop me [hch] from MAINTAINERS for iomap (2023-06-29 09:22:51 -0700)

----------------------------------------------------------------
New code for 6.5:

* Fix a type signature mismatch.
* Drop Christoph as maintainer.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (1):
iomap: drop me [hch] from MAINTAINERS for iomap

Lu Hongfei (1):
fs: iomap: Change the type of blocksize from 'int' to 'unsigned int' in iomap_file_buffered_write_punch_delalloc

MAINTAINERS            | 1 -
fs/iomap/buffered-io.c | 2 +-
2 files changed, 1 insertion(+), 2 deletions(-)
