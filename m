Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0264C756876
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 17:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjGQP6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 11:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGQP6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EBCD8;
        Mon, 17 Jul 2023 08:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D8C6113A;
        Mon, 17 Jul 2023 15:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB4DC433C7;
        Mon, 17 Jul 2023 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689609500;
        bh=E3WQDmvbMr9g++qYe5eJfisyc4QJ7fepJT7ML7kTuDU=;
        h=Date:From:To:Cc:Subject:From;
        b=egn7RyN5rXrbZzLdlWr2bXPl3CKQLkwyYe239GTP7ozF5mdMva7wWdFmiVr5/FML1
         ZD0Wb+6S6nHR/I/NYHqvskPSpd4OorMPk09/2NqWp7XVbIATqBal8/qsKy7V+U0f/4
         JONTARS1O+L7umMavH4IOm+EtanuGsQc5kcNxaWnRoiYwdV8IjiScjhxlyjkKfO6xA
         2kRBwU7JdImbuKT6Z6Tyc/StFyippJgK22BAiNtDtdV3x9mRyymL6bgUi9a9b3AZh5
         lLCeVHg4fcYYSXrDIbcRGmuHffd5Ydz/Jr8E4bG++rt4gLCcOKRl59eySCrkBGrn68
         QP6UW/uVtUhYw==
Date:   Mon, 17 Jul 2023 08:58:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org
Cc:     chrubis@suse.cz, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, oliver.sang@intel.com,
        ritesh.harjani@gmail.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to efa96cc99793
Message-ID: <168960931578.372681.16081228005926090503.stg-ugh@frogsfrogsfrogs>
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

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  I based this off -rc2 because it includes a few
bugfixes that hanged the recoveryloop tests.

The new head of the iomap-for-next branch is commit:

efa96cc99793 iomap: micro optimize the ki_pos assignment in iomap_file_buffered_write

2 new commits:

Christoph Hellwig (2):
[20c64ec83a9f] iomap: fix a regression for partial write errors
[efa96cc99793] iomap: micro optimize the ki_pos assignment in iomap_file_buffered_write

Code Diffstat:

fs/iomap/buffered-io.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)
