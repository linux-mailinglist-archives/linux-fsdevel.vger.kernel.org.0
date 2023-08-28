Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1C78A4CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 05:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjH1Dql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 23:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjH1DqQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E3F4;
        Sun, 27 Aug 2023 20:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F56B61D25;
        Mon, 28 Aug 2023 03:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2FDC433C7;
        Mon, 28 Aug 2023 03:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693194372;
        bh=olTIeUIpgtCg5Y/b/i/lrN5RWEOsU17JCVbDQPiCHPY=;
        h=Date:From:To:Cc:Subject:From;
        b=mnb0yUSrHN6dxLf0Mu9i+PKSBSiSIpLE2Di+niLbt49bUZBBbbt/fvAHTeqQcvHDD
         Ionif9heJBLnM+23mWeiFQ/ckPri6iQIpXASNzDQc3DQ1lClkIOj65maAdG5sm4Cnm
         hA4AyHTfL+bjjODOU6XdMcyQl3qMgq+HraREqxVwANN7sMebibegi34UTb7V/reCin
         kKF9hDYwXSUYDgVYM6c4Za2Y9AYnoPUVoEa/SzNSQEmeP78+DyaSonqFu/U/h59/mY
         V1evRctvPJXGU1BtdjSp7kMQ3k3cSqRGn7y+LH2iFXaBDunPyQigvHrurUfYXLa/zO
         mJ/0rEnCmqVbw==
Date:   Sun, 27 Aug 2023 20:46:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt update for 6.6
Message-ID: <20230828034610.GA5028@sol.localdomain>
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

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 324718ddddc40905f0216062dfbb977809184c06:

  fscrypt: improve the "Encryption modes and usage" section (2023-07-11 22:56:24 -0700)

----------------------------------------------------------------

Just a small documentation improvement.

----------------------------------------------------------------
Eric Biggers (1):
      fscrypt: improve the "Encryption modes and usage" section

 Documentation/filesystems/fscrypt.rst | 164 ++++++++++++++++++++++++----------
 1 file changed, 119 insertions(+), 45 deletions(-)
