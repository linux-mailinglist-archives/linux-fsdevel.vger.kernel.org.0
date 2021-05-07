Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB3375DEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 02:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhEGAis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 20:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231720AbhEGAir (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 20:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70977610FA;
        Fri,  7 May 2021 00:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620347868;
        bh=q+FiFIxomoqbf4xZuy4ZFOv2O07VEa+3Q8MH4ji2ueY=;
        h=Date:From:To:Cc:Subject:From;
        b=g63QHqTkvpWdPQ3KAgf5HnVlI28pIK/N0WIb5QqHYetTJ/MnDav0vh/5wwVgTEWpQ
         EzZvf+rPzrZ1qZBcP7X3XhNrJXhno+juNYJ/ce17g4rIRJc42+C55/zZ2KOP+Mty7u
         91TjWBuLTpzHipxuyQfCjzlJTncc9/YpLeM7nPEacZOOgWfda1M5EEhQeoEyi7lrxs
         ZsIPmjjwwJCCr0tNelaYs3Jo9mzcw4ZwwHCugCzgk67S0aaZcOUnvOlRzthMtDaenE
         n8RQ0jYO3qnJT2ZlY61JmZZZewRTH+Kj43tyiV993zSrPtCRhnpQEh7EDRd5h57ew3
         mroryTjvxQVHw==
Date:   Thu, 6 May 2021 17:37:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] iomap: one more change for 5.13-rc1
Message-ID: <20210507003748.GG8582@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second patch to the iomap code for 5.13-rc1, which
removes a now-unused field from one of the iomap structs.  I don't know
if Christoph intends to send a %pD fix for last week's swapfile patch;
so far he hasn't sent me anything...

The branch merges cleanly with upstream as of a few minutes ago.  Please
let me know if there are any strange problems.

--D

The following changes since commit 5e321ded302da4d8c5d5dd953423d9b748ab3775:

  Merge tag 'for-5.13/parisc' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2021-05-03 13:47:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.13-merge-3

for you to fetch changes up to 6e552494fb90acae005d74ce6a2ee102d965184b:

  iomap: remove unused private field from ioend (2021-05-04 08:54:29 -0700)

----------------------------------------------------------------
More new code for 5.13-rc1:
- Remove the now unused "io_private" field from struct iomap_ioend, for
  a modest savings in memory allocation.

----------------------------------------------------------------
Brian Foster (1):
      iomap: remove unused private field from ioend

 fs/iomap/buffered-io.c | 7 +------
 fs/xfs/xfs_aops.c      | 2 +-
 include/linux/iomap.h  | 5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)
