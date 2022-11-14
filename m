Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331E862889E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 19:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiKNSzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 13:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNSzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:55:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1238E1C405;
        Mon, 14 Nov 2022 10:55:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C07B61355;
        Mon, 14 Nov 2022 18:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F0FC433C1;
        Mon, 14 Nov 2022 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668452134;
        bh=7LQB6+XiZse5Dnc4o5pGCnRPnyXUW/aVM8VfGewrOAc=;
        h=Date:From:To:Subject:From;
        b=OJbUUOO1iVoh9LPnjehkISosH3qTJ4UoFuDybNlsNrl71lcMP5r0+9DtTr+dEqSP4
         p9VEORB8RvK4xSeGzK0qB5rYdbvnlETnsjwOevg5AFsQG3J9x0MWZKUTMANpQlMgGu
         PZoiouyN092bFt6oZbYsSKjVfVvL/mrrG89uNkM2m68WiIwU3PKQEgydTQIw+iD3f2
         gVxa8glgl0DCxM+WcmWY6C7xsFSYsyZnZJDoWQOhC43sO2JblaozAxJlmoyhHJ/26c
         Eywk0fD28y++23nJgybYDhXpOdPPqn8E9PkonhtUO6CIqGDAe+clIcNtRoj79G88yZ
         j9+Hkvns3+hsw==
Date:   Mon, 14 Nov 2022 10:55:33 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-6.2-merge updated to f1bd37a47352
Message-ID: <Y3KPJVXL7v+WokHF@magnolia>
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

The iomap-6.2-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-6.2-merge branch is commit:

f1bd37a47352 iomap: directly use logical block size

1 new commit:

Keith Busch (1):
      [f1bd37a47352] iomap: directly use logical block size

Code Diffstat:

 fs/iomap/direct-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
