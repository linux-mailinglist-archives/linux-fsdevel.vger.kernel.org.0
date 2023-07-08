Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C2B74BB8C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 05:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGHDRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 23:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGHDRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 23:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F501FEA;
        Fri,  7 Jul 2023 20:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E18BC61AED;
        Sat,  8 Jul 2023 03:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF81C433C7;
        Sat,  8 Jul 2023 03:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688786248;
        bh=8x7oCN4yCIl++4wJ1ViNNRKDHuhAhF+RgBG8FwhmwvU=;
        h=Date:From:To:Cc:Subject:From;
        b=OjJASUjjEDgR0oTOCvDMzsMwo7iMWOCcU4EeYiakZULtnteCqGpfXXr1zn0tGbLhi
         54c6B8POXKAiGTphqMdXYca6MgOdsT93p7/b8QedemUxBrcu48eCgMnM53Yjzjxuq7
         aA/UffWjkw8yK12/2WGx0h4KxTuSZX16gqYYoWka+y/gkdB1WtRt70p3qX9CrhI9rM
         EOLsxvrjCs9senSalmaUOx3fUAYnDEOzNHpL4FF1hOkCoJUy8gEhkYWHB4qXF11Wy1
         I91SHR++Xes2jG+A9L6ToimGAbnElVTdirD4c/tHO4t2Gjn5rv2vPdXK8Z7+AuU/ZZ
         FFPSrgv8aWqqg==
Date:   Fri, 7 Jul 2023 20:17:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to ed04a91f718e
Message-ID: <168878621332.2192440.7387111627826405668.stg-ugh@frogsfrogsfrogs>
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
the next update.  We're well into the bugfixes now...

The new head of the for-next branch is commit:

ed04a91f718e xfs: fix uninit warning in xfs_growfs_data

1 new commit:

Darrick J. Wong (1):
[ed04a91f718e] xfs: fix uninit warning in xfs_growfs_data

Code Diffstat:

fs/xfs/xfs_fsops.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)
