Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B5E7B3467
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjI2OLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 10:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjI2OLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:11:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7ED1AC;
        Fri, 29 Sep 2023 07:11:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF00C433C8;
        Fri, 29 Sep 2023 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695996698;
        bh=ioZPd5s3zd75qIAlXJzl7L3yYfnePsy7+vDy4XLFg/8=;
        h=From:To:Cc:Subject:Date:From;
        b=mljtrZxswKaDVgC5n/YPppHk6ricDJEZdBIMHyjp0x80CofGASVGoM4F6Kw8Zv4QK
         zzdDJe35/duT+JV9Ii/S8yjQRNReomqt1GjI2Taiabv0dXSC3Gy8M7YEUo8v14ew1f
         CDgYnjDQVutFoXpXOdI9iqu8dhz6VQUuR+xqxW0sg+ONgDpOzb+VtKwvcSs+zmFEP8
         GV9NkJF+Y2xvsoHomsl1R9Gi92IhpHMJShh2liXs8jf9ToDZEFPJyDJhywKBAn8kwg
         B8xus/AOUyA09Hj5+nPf0ypQg0i8pFRjxF2RTKmvCrSby4r+d1FB1nVaiKbJ50lQoe
         hrQuISSJ3OeNw==
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.6
Date:   Fri, 29 Sep 2023 19:09:34 +0530
Message-ID: <87r0mhf4rs.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for xfs for 6.6-rc4. The changes are
limited to only bug fixes whose summary is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.6-fixes-2

for you to fetch changes up to 59c71548cf1090bf42e0b0d1bc375d83d6efed3a:

  Merge tag 'fix-fix-iunlink-6.6_2023-09-25' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesB (2023-09-25 21:19:33 +0530)

----------------------------------------------------------------
Bug fixes for 6.6-rc4:

* Include modifications made to commit "xfs: load uncached unlinked inodes
  into memory on demand" (Commit ID: 68b957f64fca1930164bfc6d6d379acdccd547d7)
  which address review comments provided by Dave Chinner.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Chandan Babu R (1):
      Merge tag 'fix-fix-iunlink-6.6_2023-09-25' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesB

Darrick J. Wong (1):
      xfs: fix reloading entire unlinked bucket lists

 fs/xfs/xfs_export.c | 16 ++++++++++++----
 fs/xfs/xfs_inode.c  | 48 +++++++++++++++++++++++++++++++++++-------------
 fs/xfs/xfs_itable.c |  2 ++
 fs/xfs/xfs_qm.c     | 15 ++++++++++++---
 4 files changed, 61 insertions(+), 20 deletions(-)
