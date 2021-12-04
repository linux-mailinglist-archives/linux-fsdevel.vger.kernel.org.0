Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA2468866
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Dec 2021 00:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbhLDXxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 18:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbhLDXxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:53:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3CC061751;
        Sat,  4 Dec 2021 15:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 282AF60F38;
        Sat,  4 Dec 2021 23:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858D7C341C2;
        Sat,  4 Dec 2021 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638661820;
        bh=lPaMoq+uYE2nvrehPrXnlxNMoWmUyyxs7MiDVXwMv28=;
        h=Date:From:To:Cc:Subject:From;
        b=DQEwIFOBJgrKBSmsQimXnHKF5VDak81Zyy7qKlsc56eGjYgISW+UVV+qOdF4yp4/v
         wis/l49FDZuMVWNuRXsCFj2hjX5AT0KMb3CTMKhjuUoJuPuO+o3eZM3LCgk70HlRp4
         fj9LiMryDd2XcsfmwG0ho0q98gWLHn3u32WGSfzlZEgzcMT2444bva29ppGO234vmo
         hbcLHHAwWoDIy7k+sdAf5mqt+UpzxpQBBA+ikkUXCgM8p5wjJDB+H6mFJkD/N9EhGQ
         zpp/rhDxpTOskc9vkbVYU4VsKp8SlKfFYoaVrGVSyOCst42R/cQevviT4I9EU9s9IX
         q0g1B0biSUvug==
Date:   Sat, 4 Dec 2021 15:50:20 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: bug fixes for 5.16-rc3
Message-ID: <20211204235020.GO8467@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch for 5.16-rc3 which removes a broken and
pointless debugging assertion.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit 1090427bf18f9835b3ccbd36edf43f2509444e27:

  xfs: remove xfs_inew_wait (2021-11-24 10:06:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-fixes-2

for you to fetch changes up to e445976537ad139162980bee015b7364e5b64fff:

  xfs: remove incorrect ASSERT in xfs_rename (2021-12-01 17:27:48 -0800)

----------------------------------------------------------------
Fixes for 5.16-rc3:
 - Remove an unnecessary (and backwards) rename flags check that
   duplicates a VFS level check.

----------------------------------------------------------------
Eric Sandeen (1):
      xfs: remove incorrect ASSERT in xfs_rename

 fs/xfs/xfs_inode.c | 1 -
 1 file changed, 1 deletion(-)
