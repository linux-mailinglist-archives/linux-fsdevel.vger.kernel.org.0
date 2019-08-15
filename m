Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D098E8F19E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfHORK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 13:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbfHORKZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:10:25 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB2FF2084D;
        Thu, 15 Aug 2019 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565889024;
        bh=mu8LD5qZnhRCtDTT0NY1oQ6FPPJv/PceMZl2lhZPTpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cMC9A5dLSFqTd+vHnTaus8/oNnEY0p1mAMS4VR0BtBD9UhXeTTKBi3gpcIrngm5MQ
         TANMY7g4/HVlxdRUmWL6ul3OFDYlkHWzlRacDNsHX/+Li1yvohxPh45b6PFWOiutZV
         tMv6xZGlWIAilOWI2HXUB3tZKUsqOSOfB3svvNpY=
Date:   Thu, 15 Aug 2019 10:10:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Subject: [GIT PULL] iomap: small fixes for 5.3-rc5
Message-ID: <20190815171024.GC15186@magnolia>
References: <20190719162221.GF7093@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719162221.GF7093@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here's a single update to the MAINTAINERS entry for iomap.
I test-merged it with this morning's master and didn't see any
conflicts.  Please let me know if you encounter any funniness.

--D

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.3-fixes-1

for you to fetch changes up to 9a67b72552f8d019948453e56ca7db8c7e5a94ba:

  MAINTAINERS: iomap: Remove fs/iomap.c record (2019-08-13 08:15:07 -0700)

----------------------------------------------------------------
Changes since last update:
- Update MAINTAINERS now that we've removed fs/iomap.c.

----------------------------------------------------------------
Denis Efremov (1):
      MAINTAINERS: iomap: Remove fs/iomap.c record

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)
