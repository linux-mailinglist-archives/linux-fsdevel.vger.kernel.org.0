Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48456EAEC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDUQJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjDUQJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F4146FC;
        Fri, 21 Apr 2023 09:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 367186519E;
        Fri, 21 Apr 2023 16:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81940C4339B;
        Fri, 21 Apr 2023 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682093370;
        bh=AdLUtiDztNiJ5wyO9AYYl8Rpx3ycd2fdrNvnJWunsbE=;
        h=Date:From:To:Cc:Subject:From;
        b=AXs/Y7DLbjsPrDHpkfqKf5zarbR2gHlQCudpubge05Ss8fpW/mxwSVxZfvKBS7rs+
         TmLeIJuHcIa42k8U5oJbLcPWs0ZyFm+xndwlGcgaKnrz7ABorWrfZwp7E2wWrKkPQr
         BS91M4Kf7ecoWft7grBei9PjOo+sll22ViItwyrEfyadonoKG5rYPr8fHuwNfDMxce
         4v710Q10wy67K5ZHU/bCuZ1T71vQNuZ9GXUZwN9k2/C4tlCBBpGi7lxKyfSgQuCv4x
         aCAH6dpXwYkbe4+afStQ1Ai4I7mVoPgyMabB0Exv8ISoykfJDuQqo2tKrgH08N8dyN
         dSq3FG8wG+Zjg==
Date:   Fri, 21 Apr 2023 09:09:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org, hch@lst.de
Cc:     disgoel@linux.ibm.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 3fd41721cd5c
Message-ID: <168209319411.1184399.4964096986008324860.stg-ugh@frogsfrogsfrogs>
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

The iomap-for-next branch of the xfs-linux repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

This push removes an unused symbol and adds some tracepoints for
directio, so in my judgement it's low-risk to add them even though the
merge window is probably opening on Sunday.  As a result, I intend to
send Linus a pull request later in the merge window to let the bots have
a chance to compile-test this thoroughly.

The new head of the iomap-for-next branch is commit:

3fd41721cd5c iomap: Add DIO tracepoints

3 new commits:

Ritesh Harjani (IBM) (3):
[f6c73a11133e] fs.h: Add TRACE_IOCB_STRINGS for use in trace points
[d3bff1fc50d4] iomap: Remove IOMAP_DIO_NOSYNC unused dio flag
[3fd41721cd5c] iomap: Add DIO tracepoints

Code Diffstat:

fs/iomap/direct-io.c  |  9 ++++--
fs/iomap/trace.c      |  1 +
fs/iomap/trace.h      | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
include/linux/fs.h    | 14 +++++++++
include/linux/iomap.h |  6 ----
5 files changed, 100 insertions(+), 8 deletions(-)
