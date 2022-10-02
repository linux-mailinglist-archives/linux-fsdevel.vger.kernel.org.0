Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBCD5F257C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 23:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiJBVep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Oct 2022 17:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBVen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B0E60E1;
        Sun,  2 Oct 2022 14:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B8560DEA;
        Sun,  2 Oct 2022 21:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D787FC433C1;
        Sun,  2 Oct 2022 21:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664746479;
        bh=hkcM3QflXQNRNuaOiTE5uvZ4RqOUrIO2O2ufVw6+WuA=;
        h=Date:From:To:Subject:From;
        b=dk2Y/n06E6yomwtj0JZVRQIQ7RP2qKooofVDdRy/PRgY8Bufj70JCRZrTltuWJAxg
         /dwrTsU1UHYfKKso8PAw20KC6sawgbqY2Fw9GJmFAaHhhWhYQB0MOSFdFBb/0v0jPk
         /t8JnaaEUrStUegHxgb2Mrcoy9WF2fVvDUTFyyOhoYtr7imAcr8HgfI49aQ7QhPxm2
         gwkF0cmhq9My1BUagJasHarY41jPttBPz+5NWMdUVnQezbrA8SUIl1Ye9kSq0VB+a3
         pl0TEBGfvmI3BTM/PPdWShKiSD90S2ckHKDWsoZkjoPw08VnZOdz/jNyKMH8DvNAob
         jAB0ziczoOsVA==
Date:   Sun, 2 Oct 2022 14:34:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-6.1-merge updated to adc9c2e5a723
Message-ID: <YzoD75GLqZRc0xRG@magnolia>
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

The iomap-6.1-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  This (admittedly late) push contains a single bugfix
and an extra tracepoint; no functional changes this cycle!

The new head of the iomap-6.1-merge branch is commit:

adc9c2e5a723 iomap: add a tracepoint for mappings returned by map_blocks

2 new commits:

Darrick J. Wong (2):
      [3d5f3ba1ac28] iomap: iomap: fix memory corruption when recording errors during writeback
      [adc9c2e5a723] iomap: add a tracepoint for mappings returned by map_blocks

Code Diffstat:

 fs/iomap/buffered-io.c | 3 ++-
 fs/iomap/trace.h       | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)
