Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4337063DDDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 19:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiK3SbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 13:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiK3SbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:31:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2D4900E2;
        Wed, 30 Nov 2022 10:31:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78EDB61D5F;
        Wed, 30 Nov 2022 18:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AB7C433C1;
        Wed, 30 Nov 2022 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669833073;
        bh=CoppqC9sD4aT0JxEl0gMdTG3Kd0qcYy8DUINRnclsq8=;
        h=Date:From:To:Cc:Subject:From;
        b=C6zxgrGfuCUWatStM/TFcq4hsVEYA1YIT5OngM+JNFe7KjsD/gjVAU5YabUowiGnT
         ne8v+JNKHWFyFY3urNtNpEhq/WpsRsU873pjv/TURNyx4DW9AMVGjFlXyeNxpLvk74
         oje6esLqx5S+bERD9kp6kFsqFXzYt/lcwaUgCJRIQ2b09YPpQ8b5H1zV5VOzMXkITV
         0ynk3apSdDrjM0cLUw1bgHObLZUZbGK0WCiY1ArbWVYhpIOV/5cWvVAP1tOaibu8MW
         PzaAbb+pbjcUGh77cdKLGrOo27FIpSI6/4w3Uaj8cEFgv9Ri0ujRuV+Z/ownFxRRX/
         1N+ttRyDZATSg==
Date:   Wed, 30 Nov 2022 10:31:13 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: vfs-for-next updated to a79168a0c00d
Message-ID: <166983291881.4153678.13848297897421960854.stg-ugh@magnolia>
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

The vfs-for-next branch of the xfs-linux repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the vfs-for-next branch is commit:

a79168a0c00d fs/remap_range: avoid spurious writeback on zero length request

1 new commit:

Brian Foster (1):
[a79168a0c00d] fs/remap_range: avoid spurious writeback on zero length request

Code Diffstat:

fs/remap_range.c | 7 ++-----
1 file changed, 2 insertions(+), 5 deletions(-)
