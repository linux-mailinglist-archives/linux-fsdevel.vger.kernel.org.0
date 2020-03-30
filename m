Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9C1981B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgC3QyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 12:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbgC3QyB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:54:01 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BEF82072E;
        Mon, 30 Mar 2020 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585587240;
        bh=j/ppsQG0leh5vH+RTE+F7A3zvmhx3HDCWWopSVH2uDQ=;
        h=Date:From:To:Cc:Subject:From;
        b=M/wdnXbyHUTJv5ngtkxL30OP3/Kuj4H/2XLXZMGrhRmQHk4kBf8kUv4xIehJ2WNAi
         RYGO4xyaxQ0k6rkp1d/w6AkdnbU3iITZGeIBWDU4aBLtglq2LUaNtRCnK+4ktYJsaH
         Et7KNGgLmKcCwRBMlzckx0KzqoHRi1/YU5977jgo=
Date:   Mon, 30 Mar 2020 09:53:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.7
Message-ID: <20200330165359.GA1895@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 861261f2a9cc488c845fc214d9035f7a11094591:

  ubifs: wire up FS_IOC_GET_ENCRYPTION_NONCE (2020-03-19 21:57:06 -0700)

----------------------------------------------------------------

Add an ioctl FS_IOC_GET_ENCRYPTION_NONCE which retrieves a file's
encryption nonce.  This makes it easier to write automated tests which
verify that fscrypt is doing the encryption correctly.

----------------------------------------------------------------
Eric Biggers (4):
      fscrypt: add FS_IOC_GET_ENCRYPTION_NONCE ioctl
      ext4: wire up FS_IOC_GET_ENCRYPTION_NONCE
      f2fs: wire up FS_IOC_GET_ENCRYPTION_NONCE
      ubifs: wire up FS_IOC_GET_ENCRYPTION_NONCE

 Documentation/filesystems/fscrypt.rst | 11 +++++++++++
 fs/crypto/fscrypt_private.h           | 20 ++++++++++++++++++++
 fs/crypto/keysetup.c                  | 16 ++--------------
 fs/crypto/policy.c                    | 21 ++++++++++++++++++++-
 fs/ext4/ioctl.c                       |  6 ++++++
 fs/f2fs/file.c                        | 11 +++++++++++
 fs/ubifs/ioctl.c                      |  4 ++++
 include/linux/fscrypt.h               |  6 ++++++
 include/uapi/linux/fscrypt.h          |  1 +
 9 files changed, 81 insertions(+), 15 deletions(-)
