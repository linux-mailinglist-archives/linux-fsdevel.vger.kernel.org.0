Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF7B3B671F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhF1Q7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 12:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231848AbhF1Q7L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:59:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB87B61988;
        Mon, 28 Jun 2021 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624899406;
        bh=JEH9YvkX1tuS2gUabFZ9JaX5r+EudDtnu4dkjX3MpYc=;
        h=Date:From:To:Cc:Subject:From;
        b=vNj8RwCa5/BCXX2jdMugsk8BK+T6K04e/v9FzgdrgzJaJ9GUpOdsfeYfV0SOb63iX
         KL7IPMD4GPZmublCVb4UFA6hyl43mf6EeUErmU0R5DSBZP8BpQQ3r/bi8FSTh4e2gi
         NczpLPJDkY4I7g5pwR5imkna4VDn+nml2cM8AI54Eaw7VJd9H1CzYcZtqiaY8yuuv4
         9YSKJ1bXlhjcDEYskWqkVZVg3TCMvoZ2G7Yk1FXZEZsYG9/wJi1HK81jf3n6hopI8B
         h1HzZaMto30+F+Mb6UVEy/e+wEUaIXQHnMrDpal9oWPMhdeUAJdxfKafRcZMG20Dq6
         zNbaGKfd6Ai1Q==
Date:   Mon, 28 Jun 2021 09:56:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 5.14
Message-ID: <YNn/TL5lW44yAx3o@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 2fc2b430f559fdf32d5d1dd5ceaa40e12fb77bdf:

  fscrypt: fix derivation of SipHash keys on big endian CPUs (2021-06-05 00:52:52 -0700)

----------------------------------------------------------------

A couple bug fixes for fs/crypto/:

- Fix handling of major dirhash values that happen to be 0.

- Fix cases where keys were derived differently on big endian systems
  than on little endian systems (affecting some newer features only).

----------------------------------------------------------------
Eric Biggers (2):
      fscrypt: don't ignore minor_hash when hash is 0
      fscrypt: fix derivation of SipHash keys on big endian CPUs

 fs/crypto/fname.c    | 10 +++-------
 fs/crypto/keysetup.c | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 15 deletions(-)
