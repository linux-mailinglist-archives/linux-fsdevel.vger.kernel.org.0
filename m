Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A067B41A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjI3PbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 11:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjI3PbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:31:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C5DE6;
        Sat, 30 Sep 2023 08:31:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F5DC433C7;
        Sat, 30 Sep 2023 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696087875;
        bh=D7woqAEInyvlcUuIxYuAYdtMvJ2I5loQNrNHQ1UFrOQ=;
        h=Date:From:To:Cc:Subject:From;
        b=b/Wjkgwgu6cfu3XRAyz7NRMPSNo6nWAC0FVUVtIJpzQvT7LGcF58iqOdrokbtKPpV
         YUk1qy3oUBuQkLRGqpY7/sJimkSVqeoryHfgMGrxSkVYmNTbOKu9JrikCeJWdz0xt6
         q0GBkyBOMTDXaezxqwDGcDEQ5K+qPpdHCRGR+QE2F0AxSR2g0fgd2SgQSR1One5MKF
         cvaToUbva6DDULUZ2LBwicZxWeTTnKkTpgBrNCs9X2eXjfbzVpT5B+VYNgdrQwzA1a
         jR3eSI9y3uS+H6VN7szgrxHtEOU6nJWw/fiA/nqHp65vJOG2cViMRlbvkTz9F2vdZp
         Z+sYX+tUilIjw==
Date:   Sat, 30 Sep 2023 08:31:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, torvalds@linux-foundation.org
Cc:     bodonnel@redhat.com, geert+renesas@glider.be, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Subject: [GIT PULL] iomap: bug fixes for 6.6-rc4
Message-ID: <169608776189.1016505.15445601632237284088.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for iomap for 6.6-rc4.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit a5f31a5028d1e88e97c3b6cdc3e3bf2da085e232:

iomap: convert iomap_unshare_iter to use large folios (2023-09-19 09:05:35 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-4

for you to fetch changes up to 684f7e6d28e8087502fc8efdb6c9fe82400479dd:

iomap: Spelling s/preceeding/preceding/g (2023-09-28 09:26:58 -0700)

----------------------------------------------------------------
Bug fixes for 6.6-rc4:

* Handle a race between writing and shrinking block devices by
returning EIO.
* Fix a typo in a comment.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (1):
iomap: add a workaround for racy i_size updates on block devices

Geert Uytterhoeven (1):
iomap: Spelling s/preceeding/preceding/g

fs/buffer.c            | 11 ++++++++++-
fs/iomap/buffered-io.c |  2 +-
2 files changed, 11 insertions(+), 2 deletions(-)
