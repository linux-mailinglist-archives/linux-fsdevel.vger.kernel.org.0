Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E60441162
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 00:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJaXRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 19:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhJaXRh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 19:17:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6632F60E98;
        Sun, 31 Oct 2021 23:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635722104;
        bh=suxkNGmue9aghjYNtvFMsxbmCggQU/mTEGgyuyM6yEo=;
        h=Date:From:To:Cc:Subject:From;
        b=fpGO32U+MsTNZbHohxpPwvg1Uq/nPjwDaBlA9NFDdb8JtWAGK6sTrbB+lu3yBYkyF
         C912kGL8/qX6nG76cT0WwM6WPK707JMNhvnTL1WWkGh2M5LK7Tqxpqo/tLnDABJkLt
         KquLGV9Z/3RgrdBlXFR2D/SFGhuDx+DdXnJHPEKL4noPzfIGweLhwzdWt36jzXblFS
         M9bf+mET+ZIt9lAOOjbeyet8ziREuNph58SvdfojegO9FZiaaJKNICUKkzQspjqpEz
         Ig8eS55+3Rs5M0buwjx5/KDMVkSANT3fdnOoTLsW761BJyErEqIFMlRRFT2g6yS1Yk
         gJbeRw++6EQtQ==
Date:   Sun, 31 Oct 2021 16:15:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.16
Message-ID: <YX8jdp73zUDwlB5E@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to b7e072f9b77f4c516df96e0c22ec09f8b2e76ba1:

  fscrypt: improve a few comments (2021-10-25 19:11:50 -0700)

----------------------------------------------------------------

Some cleanups for fs/crypto/:

- Allow 256-bit master keys with AES-256-XTS

- Improve documentation and comments

- Remove unneeded field fscrypt_operations::max_namelen

----------------------------------------------------------------
Eric Biggers (5):
      fscrypt: remove fscrypt_operations::max_namelen
      fscrypt: clean up comments in bio.c
      fscrypt: improve documentation for inline encryption
      fscrypt: allow 256-bit master keys with AES-256-XTS
      fscrypt: improve a few comments

 Documentation/block/inline-encryption.rst |  2 +
 Documentation/filesystems/fscrypt.rst     | 83 +++++++++++++++++++++++--------
 fs/crypto/bio.c                           | 32 ++++++------
 fs/crypto/fname.c                         |  3 +-
 fs/crypto/fscrypt_private.h               | 16 ++++--
 fs/crypto/hkdf.c                          | 11 ++--
 fs/crypto/keysetup.c                      | 62 +++++++++++++++++------
 fs/ext4/super.c                           |  1 -
 fs/f2fs/super.c                           |  1 -
 fs/ubifs/crypto.c                         |  1 -
 include/linux/fscrypt.h                   |  3 --
 11 files changed, 150 insertions(+), 65 deletions(-)
