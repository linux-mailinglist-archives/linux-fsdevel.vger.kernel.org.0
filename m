Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5084349D0B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243681AbiAZR06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 12:26:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56746 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiAZR0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:26:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6666361B14;
        Wed, 26 Jan 2022 17:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D5AC340E3;
        Wed, 26 Jan 2022 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643218014;
        bh=mMIWyUTHQDSsqUQPq5ufrDRlrhsXFeY9O8Hp9Xd8VUQ=;
        h=Date:From:To:Subject:From;
        b=rEmxCYe4PfhuE4XH8Mj5axVkQIOAYA08kA9lxzE2MiR1sUWIKNMleLEycG18Ug6Da
         zMfZtcsKo6UhS+B9PLxF6pJFqCUaSMzTbYzeyE5sAz0/q84nCP+aPo3kgrC21uecy7
         Aa4egpNzQNRAU3+Cs/Xh6jgvKjAywjm8UooCY/gmddSldpaFCPOgqrCeeKX9itktSt
         gcCQ0KF8G8E4iXz866/mKIQGQAyWso6cXswByH/QWZDS5EQAV2JFGHGsbcxaUHjwnO
         fiANWAWOnfA91POoV8pjVpMouH6wZBiDVledRywFvvOtO+vtStrbFs8e83WGnXDsyP
         gmcGLEsOeeVHQ==
Date:   Wed, 26 Jan 2022 09:26:54 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to ebb7fb1557b1
Message-ID: <20220126172654.GB13540@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The new head of the iomap-for-next branch is commit:

ebb7fb1557b1 xfs, iomap: limit individual ioend chain lengths in writeback

1 new commit:

Dave Chinner (1):
      [ebb7fb1557b1] xfs, iomap: limit individual ioend chain lengths in writeback

Code Diffstat:

 fs/iomap/buffered-io.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_aops.c      | 16 +++++++++++++++-
 include/linux/iomap.h  |  2 ++
 3 files changed, 65 insertions(+), 5 deletions(-)
