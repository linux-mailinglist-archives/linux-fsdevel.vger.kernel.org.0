Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4A3FBA55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 18:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbhH3QsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 12:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237882AbhH3QsN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:48:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E01B160F5B;
        Mon, 30 Aug 2021 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630342039;
        bh=/ZbEAxvBW5ig7WPYzIG6ftbGUGoR7j4+CJT1CyKUAgE=;
        h=Date:From:To:Cc:Subject:From;
        b=pPqSREqxmcM2xCHL9kODFPILmxDGalIsKDmDe4jGEPsUozDmh+ruX/O/LmhFODtxt
         VIYvEwC66svykfXl46dTWe79Ys9le0rVp8NZQw7+j4+oAkLtIeqaBDdNerIXmXcYy2
         DL1OPRMOsyyZ2q+lnCE7aOMpGrtF1gToEk+RLJeAnoj92vfbhp0ATxlcesE0t4ukna
         UCMbyhEXzp4HW4Eeddf/2PerQXND5kpqT+osxua6VBfYadx7WWHEOBZqSUV18dXwku
         NgpMAbi14Mi2x+cqbjH7Q8Ol9FNwDAMOZ5wOFyU3Kl+CO6fH5m7N17PykROLOlsM3a
         try7iQyJi19Lg==
Date:   Mon, 30 Aug 2021 09:47:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.15
Message-ID: <YS0LlXIhvZc4r5Vt@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 38ef66b05cfa3560323344a0b3e09e583f1eb974:

  fscrypt: document struct fscrypt_operations (2021-07-28 21:40:36 -0700)

----------------------------------------------------------------

Some small fixes and cleanups for fs/crypto/:

- Fix ->getattr() for ext4, f2fs, and ubifs to report the correct
  st_size for encrypted symlinks.

- Use base64url instead of a custom Base64 variant.

- Document struct fscrypt_operations.

----------------------------------------------------------------
Eric Biggers (7):
      fscrypt: add fscrypt_symlink_getattr() for computing st_size
      ext4: report correct st_size for encrypted symlinks
      f2fs: report correct st_size for encrypted symlinks
      ubifs: report correct st_size for encrypted symlinks
      fscrypt: remove mention of symlink st_size quirk from documentation
      fscrypt: align Base64 encoding with RFC 4648 base64url
      fscrypt: document struct fscrypt_operations

 Documentation/filesystems/fscrypt.rst |  15 ++---
 fs/crypto/fname.c                     | 106 +++++++++++++++++++------------
 fs/crypto/hooks.c                     |  44 +++++++++++++
 fs/ext4/symlink.c                     |  12 +++-
 fs/f2fs/namei.c                       |  12 +++-
 fs/ubifs/file.c                       |  13 +++-
 include/linux/fscrypt.h               | 116 ++++++++++++++++++++++++++++++++--
 7 files changed, 260 insertions(+), 58 deletions(-)
