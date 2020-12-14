Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C3C2D931A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 06:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404740AbgLNFyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 00:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgLNFyJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 00:54:09 -0500
Date:   Sun, 13 Dec 2020 21:53:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607925209;
        bh=i16BifUJiG908ADKX33lN3E+d1H+NPST+DKFRlua0sc=;
        h=From:To:Cc:Subject:From;
        b=Vz742K6NGVNpmN1b2Mu7MfDQY8/MpslxDH3rDOKvNd87Tq2HQdUGp9Zb28PahoBTo
         9KPjGVineDijLgwV+U7csBNuX0nb9QN6k83hjaxFeZNk2GTahWNQFC71XfcguogXN8
         +trPJwx0qNFUM8+41Iv05enSTy0VwY4KkCf/G/1i8NTMKV0TNzg7yRbHKXd9MN43wh
         po+FoQ3oHkG05hHTVnwWwtKuf+W4TvAE0FIZV7YWp16KTnzUOa8xR21rrX8gQn/3lF
         RbpB4SoHtb7EzqCCoueVr6+UL4NR02NttEHOBGIwt2+YnC4k2oUvX7yo4kzowW8Ygr
         wlnxN5hS3PGqg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fsverity updates for 5.11
Message-ID: <X9b910/Ldj6kdljm@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to bde493349025ca0559e2fff88592935af3b8df19:

  fs-verity: move structs needed for file signing to UAPI header (2020-11-23 19:30:14 -0800)

----------------------------------------------------------------

Some cleanups for fs-verity:

- Rename some names that have been causing confusion.

- Move structs needed for file signing to the UAPI header.

----------------------------------------------------------------
Eric Biggers (4):
      fs-verity: remove filenames from file comments
      fs-verity: rename fsverity_signed_digest to fsverity_formatted_digest
      fs-verity: rename "file measurement" to "file digest"
      fs-verity: move structs needed for file signing to UAPI header

 Documentation/filesystems/fsverity.rst | 68 ++++++++++++++++------------------
 fs/verity/enable.c                     |  8 ++--
 fs/verity/fsverity_private.h           | 36 ++----------------
 fs/verity/hash_algs.c                  |  2 +-
 fs/verity/init.c                       |  2 +-
 fs/verity/measure.c                    | 12 +++---
 fs/verity/open.c                       | 24 ++++++------
 fs/verity/signature.c                  | 14 +++----
 fs/verity/verify.c                     |  2 +-
 include/uapi/linux/fsverity.h          | 49 ++++++++++++++++++++++++
 10 files changed, 116 insertions(+), 101 deletions(-)
