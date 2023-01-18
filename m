Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3486727C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 20:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjARTCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 14:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjARTCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:02:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A015F5DC0A;
        Wed, 18 Jan 2023 11:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40318B81EBF;
        Wed, 18 Jan 2023 19:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E011EC433D2;
        Wed, 18 Jan 2023 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674068498;
        bh=R//0erIAH3xGnhlA0pabt4OzQwIqXcT7sJpnBc0/Abg=;
        h=Date:From:To:Cc:Subject:From;
        b=NJYrTEU7JIu3ATLpxOm0aKsKzhtRuR2Bxmhl7h+J1gRntlGZhUpZYIJMFBMV2pbXy
         j+Iu4Xj23qGUb8u9o0buTBvtTQuOuRZ0jxB/c/KXbQ7PS8tR41EyIoQC2c5ka7mOht
         TzVJhVENY0lazrk3RwTT3a1PTzAhrI9l02zxj0ch8okBgHWwP8nZ2jJQFoa/TCmChJ
         en47tDwsc//XvvmTIM4Gv3z1qvuFImoaXaiTREqSX0XQ/z08NqRrEQy2gRmrSsdLtl
         pbOP00ub1coxzJKbwHADjMQmOJvh9+MVA2t+s5HYMsh0nCwJS+VhhnFxtp4qwCTxwB
         vzB3C0dZWLNzA==
Date:   Wed, 18 Jan 2023 11:01:37 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org, hch@lst.de
Cc:     agruenba@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 471859f57d42
Message-ID: <167406781753.2327912.4817970864551606145.stg-ugh@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Just so everyone knows -- I've been summoned for local jury duty
service, which means that I will be out starting January 30th until
further notice.  "Further notice" could mean February 1st, or it could
mean March 1st.  Hopefully there won't be any other iomap changes
necessary for 6.3; I'll post here again when I figure out what the
backup plan is.  It is likely that I will be summoned *again* for
federal service before the end of 2023.

The new head of the iomap-for-next branch is commit:

471859f57d42 iomap: Rename page_ops to folio_ops

8 new commits:

Andreas Gruenbacher (8):
[7a70a5085ed0] iomap: Add __iomap_put_folio helper
[80baab88bb93] iomap/gfs2: Unlock and put folio in page_done handler
[40405dddd98a] iomap: Rename page_done handler to put_folio
[98321b5139f9] iomap: Add iomap_get_folio helper
[9060bc4d3aca] iomap/gfs2: Get page in page_prepare handler
[07c22b56685d] iomap: Add __iomap_get_folio helper
[c82abc239464] iomap: Rename page_prepare handler to get_folio
[471859f57d42] iomap: Rename page_ops to folio_ops

Code Diffstat:

fs/gfs2/bmap.c         | 38 ++++++++++++++-------
fs/iomap/buffered-io.c | 91 +++++++++++++++++++++++++++++++++-----------------
fs/xfs/xfs_iomap.c     |  4 +--
include/linux/iomap.h  | 27 ++++++++-------
4 files changed, 103 insertions(+), 57 deletions(-)
