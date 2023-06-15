Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D886731D9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjFOQTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjFOQTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B82BA;
        Thu, 15 Jun 2023 09:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A32AE625F3;
        Thu, 15 Jun 2023 16:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C7BC433C0;
        Thu, 15 Jun 2023 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686845946;
        bh=eLywBdtw2OT0lYnrHaxGA94+UjHsJ4eZn2S59MNtty0=;
        h=Date:From:To:Cc:Subject:From;
        b=Vhs87SwBW3MUMMVpLYnFP2+BuhAtvkCkyx3mBAr9lfXfA4nivxuDu5xR8ykRPKapn
         yrDXeAxwclzPKXFQDz0aLnvKNkP1GpRFuFGRdROhDic1Yas25YVukkni4u9eWOE+f6
         pdOiosWeMLM9nnU5sbtnU2nI7xa6DwNwahNhFmVBUljCTuz9yAy0zQF06UvMgbTrYP
         5mxhzi+9blqTfYhE8JSSrM1FerglkdehBzhC/kcG6Y3Boipw+w/X7WeGPqk9RmNJYX
         bE6ba0Gfz0L+j9aKR5ufWibHgbU6gUkt4P7IRlMLzvAHmaZyvNbv4JbPNt89Dgx5bU
         53EI1jJrAqTpw==
Date:   Thu, 15 Jun 2023 09:19:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, hch@lst.de, leo.lilong@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to c3b880acadc9
Message-ID: <168684574866.334914.10408768179575760458.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The for-next branch of the xfs-linux repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  That'll be the EFI deadlock fixes that Dave and
Wengang and Chandan have been working on for a while now.

The new head of the for-next branch is commit:

c3b880acadc9 xfs: fix ag count overflow during growfs

4 new commits:

Christoph Hellwig (1):
[b29434999371] xfs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method

Darrick J. Wong (2):
[06f3ef6e1705] xfs: don't deplete the reserve pool when trying to shrink the fs
[61d7e8274cd8] xfs: drop EXPERIMENTAL tag for large extent counts

Long Li (1):
[c3b880acadc9] xfs: fix ag count overflow during growfs

Code Diffstat:

fs/xfs/libxfs/xfs_fs.h |  2 ++
fs/xfs/xfs_aops.c      |  2 --
fs/xfs/xfs_file.c      |  2 +-
fs/xfs/xfs_fsops.c     | 23 ++++++++++++++++-------
fs/xfs/xfs_super.c     |  4 ----
5 files changed, 19 insertions(+), 14 deletions(-)
