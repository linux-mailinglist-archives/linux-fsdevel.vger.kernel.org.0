Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512507B00AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjI0JjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjI0Jit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:38:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADDD1B5;
        Wed, 27 Sep 2023 02:38:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2DCC433CA;
        Wed, 27 Sep 2023 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695807526;
        bh=FnB6r/TsNbhHrX8rrhR5Zfuc6bPQcmN7sYf13qX6zAo=;
        h=From:To:Cc:Subject:Date:From;
        b=pvoWndKPQyRQhtv2ne50BlwCUVi+VjZ3SgbyczPYQ46MBEoVc8/c2vrY/ILxojACR
         Vq603JK5K9pnX+n+9OGoPfQ6EBGumndefPmkkNAIlinuAYY87vclpvL6igPaRC1Rni
         t/pUZtzFiTbGOsU9L94JPA6ByoTfIFcTrW2tKpGD9J7TqO+/UVyXpx6HARwgPyep3N
         hAylKCov73gFl28DkzwIQijRiXpM1mqm7uDTlQqaPWHoxm9Xn5coL8TpoJPqlcCXl0
         xcOv29QcAHE3V+MAinS93eoEPEy3vJ4kjDtOmNk75nV1ajwwMI6wO50+XNa0LVP3jU
         MjPFHgi3Z/GCQ==
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     chandanbabu@kernel.org
Cc:     dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 59c71548cf10
Date:   Wed, 27 Sep 2023 15:06:59 +0530
Message-ID: <87ttrg7y70.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

59c71548cf10 Merge tag 'fix-fix-iunlink-6.6_2023-09-25' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesB

2 new commits:

Chandan Babu R (1):
      [59c71548cf10] Merge tag 'fix-fix-iunlink-6.6_2023-09-25' of https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.6-fixesB

Darrick J. Wong (1):
      [537c013b140d] xfs: fix reloading entire unlinked bucket lists

Code Diffstat:

 fs/xfs/xfs_export.c | 16 ++++++++++++----
 fs/xfs/xfs_inode.c  | 48 +++++++++++++++++++++++++++++++++++-------------
 fs/xfs/xfs_itable.c |  2 ++
 fs/xfs/xfs_qm.c     | 15 ++++++++++++---
 4 files changed, 61 insertions(+), 20 deletions(-)
