Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964D03E9893
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 21:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhHKTTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 15:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKTTu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C730760EB9;
        Wed, 11 Aug 2021 19:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628709566;
        bh=bGDSG1mvNoSGXoWCdlXtz5vunbswBGR4ysAcTDU7IrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmDUhFMqwLHhW723ghURcd+KHPCXUl8kG44jh1mFrY7/QjlWOzZq2OEEyvGidW1/V
         y3VMfaVErfu1VeCNkkFamm/lwa4ib9MeWjK1eUGHQ0JqwfuUGmLHnBCQR4ETYveIbN
         aY6SbWdfqV8bxLdfNwXf/E8nMdn3zYn4Oigrso/detdUnU4CS9rYPuqAeA1kAnW0tn
         bWmxAFLbT+ATp7DPL+MxhtKipLtpIkom8wzS7aGO61yLR2+dNzcTAFxU10FnSi2kBj
         0mMfKNU3wAgi3foM/QzOSK1h34j16k/sCc1tAnDTj2B/fW9vITxx1NdCyvH+6kr5DV
         V/ksPC3TQOtFw==
Date:   Wed, 11 Aug 2021 12:19:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 31/30] iomap: move iomap iteration code to iter.c
Message-ID: <20210811191926.GJ3601443@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Now that we've moved iomap to the iterator model, rename this file to be
in sync with the functions contained inside of it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/Makefile |    2 +-
 fs/iomap/iter.c   |    0 
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/iomap/{apply.c => iter.c} (100%)

diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index e46f936dde81..bb64215ae256 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -26,9 +26,9 @@ ccflags-y += -I $(srctree)/$(src)		# needed for trace events
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
 iomap-y				+= trace.o \
-				   apply.o \
 				   buffered-io.o \
 				   direct-io.o \
 				   fiemap.o \
+				   iter.o \
 				   seek.o
 iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/apply.c b/fs/iomap/iter.c
similarity index 100%
rename from fs/iomap/apply.c
rename to fs/iomap/iter.c
