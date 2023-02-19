Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338C569C252
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Feb 2023 21:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjBSUha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Feb 2023 15:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBSUh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Feb 2023 15:37:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A615317CF5;
        Sun, 19 Feb 2023 12:37:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 538B9B80502;
        Sun, 19 Feb 2023 20:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34D8C433EF;
        Sun, 19 Feb 2023 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676839046;
        bh=iTe0OcSqwl6lEg6Ylv8otlLHv1N+efZfZXNkztSLoIE=;
        h=Date:From:To:Cc:Subject:From;
        b=hmU/ReWdkFwW0Ws8IuBgL9dlSbZiG8GOMovVLCe1VgSrgTw2eVfp3YdZh5LygaKk/
         e7cELOsXMXNURB5X0TzI9uKhx9m5AYwcvTnicERhaoh37Ahb/8B4nbxxMqOD6zuJsB
         i2qIqQo4292V+2TtJNFoHwvEfq93Zf4T0nBfBRjVlSgNaAJ5m7a06myTDlhqB2GvaC
         WnBvBaKkr0P1NatSWar24NbVNrymCicJKUowWm0hp4wJyDwYBE/0vDy7kRR6xinKry
         NeVbEaQnp199+109ajvjgJgVZ+YKPhokDF6YsX4Vrxafyv7Zmb4CPV9vcRZzN8caiU
         RKHIj0H2G1sYA==
Date:   Sun, 19 Feb 2023 12:37:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 6.3
Message-ID: <Y/KIgw8gAI/gtN8E@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 097d7c1fcb8d4b52c62a36f94b8f18bc21a24934:

  fscrypt: clean up fscrypt_add_test_dummy_key() (2023-02-07 22:30:30 -0800)

----------------------------------------------------------------

Simplify the implementation of the test_dummy_encryption mount option by
adding the "test dummy key" on-demand.

----------------------------------------------------------------
Eric Biggers (5):
      fscrypt: add the test dummy encryption key on-demand
      ext4: stop calling fscrypt_add_test_dummy_key()
      f2fs: stop calling fscrypt_add_test_dummy_key()
      fs/super.c: stop calling fscrypt_destroy_keyring() from __put_super()
      fscrypt: clean up fscrypt_add_test_dummy_key()

 fs/crypto/fscrypt_private.h |  4 ++++
 fs/crypto/keyring.c         | 26 +++++++-------------------
 fs/crypto/keysetup.c        | 23 +++++++++++++++++++++--
 fs/crypto/policy.c          |  3 +--
 fs/ext4/super.c             | 13 +------------
 fs/f2fs/super.c             |  6 ------
 fs/super.c                  |  1 -
 include/linux/fscrypt.h     |  9 ---------
 8 files changed, 34 insertions(+), 51 deletions(-)
