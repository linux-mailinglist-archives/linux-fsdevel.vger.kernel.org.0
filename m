Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3C7BA0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbjJEOnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbjJEOlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:41:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA31587236;
        Thu,  5 Oct 2023 07:17:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6763CC43395;
        Thu,  5 Oct 2023 05:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696485568;
        bh=cCSCNZZslM+gfgDhLOiPNVMp1LbblmbMJUQl9x8MlBc=;
        h=From:To:Cc:Subject:Date:From;
        b=k97I2ThurWMNxl9tkFgNSEFVWw/8wjVdJOAUHDEFD+aqJCrtqKzzqniW2vCn6jYrP
         THg1m/QDlNN46G+FI0EYV1PbWPr+NdgyP5LtRyolbE3WvGfwubSjKVEIaO76wQkKVh
         dOzQTTXEyHezP7ndyccnw+QDOdDn4SOlvGkeZeCIsG8BizEJaRwRIJfA7mfGAiTqw6
         b1zstobsa+XZz/i76RXfOV7zcXMDrT1e5BAC+UCKZyoGu1czf3lOi6fomKmhf2Wxot
         W8m+mkNC9yef8FEa6YwBNp/r5vrqLMNq6LoNmYWdhyAnY1LgKs5KtMsBblevpIDrdU
         bid6C4c44bR6w==
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     chandanbabu@kernel.org
Cc:     dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 4e69f490d211
Date:   Thu, 05 Oct 2023 11:27:35 +0530
Message-ID: <87h6n5624j.fsf@debian-BULLSEYE-live-builder-AMD64>
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

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

4e69f490d211 Merge tag 'xfs-fstrim-busy-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.6-fixesC

4 new commits:

Chandan Babu R (1):
      [4e69f490d211] Merge tag 'xfs-fstrim-busy-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.6-fixesC

Dave Chinner (3):
      [428c4435b063] xfs: move log discard work to xfs_discard.c
      [89cfa899608f] xfs: reduce AGF hold times during fstrim operations
      [e78a40b85171] xfs: abort fstrim if kernel is suspending

Code Diffstat:

 fs/xfs/xfs_discard.c     | 266 ++++++++++++++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_discard.h     |   6 +-
 fs/xfs/xfs_extent_busy.c |  34 ++++--
 fs/xfs/xfs_extent_busy.h |  24 ++++-
 fs/xfs/xfs_log_cil.c     |  93 +++--------------
 fs/xfs/xfs_log_priv.h    |   5 +-
 6 files changed, 311 insertions(+), 117 deletions(-)
