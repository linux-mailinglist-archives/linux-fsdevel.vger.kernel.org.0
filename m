Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86573D598
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 03:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFZBvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 21:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFZBvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D2F180;
        Sun, 25 Jun 2023 18:51:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AE1060BEF;
        Mon, 26 Jun 2023 01:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332FFC433C8;
        Mon, 26 Jun 2023 01:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687744293;
        bh=i0BJzq+S+kAaSYz2lVGfmZ1peFQkvlqg/MoLC/PWQNM=;
        h=Date:From:To:Cc:Subject:From;
        b=Z1WP7Qpa9MoQMJleHipXMqjw9XJj7JURYqO2FXlRJFLpaLKHH1Lr1AmiPCblAr/Px
         p9tL2CMSq8P58LVP7tX8VAgoSzrEKrnO6r9zsOv8SnxicNUiAWP4TOIngqyZFcV4Kw
         42LXDrFuqF3gp5DT7XT2zhVyk8WEInyTorXt2e6FlmcVzcdOK63l6W0x3sWpQPatkt
         SOF+UnEWlDS+WjMgaii8OVCojxHAOHNjkd+RqHGye7fAW8Xv6OkoiJuiZoFy67HipM
         CZRuSR+/pLX51l/t5oU9htHFIIN8wmQ4sAq47CIA/fwX5+y9YCY8gDMQYdCtRrf8Mt
         JxQ3sYkvXuQkg==
Date:   Sun, 25 Jun 2023 18:51:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt updates for 6.5
Message-ID: <20230626015131.GA1024@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to d617ef039fb8eec48a3424f79327220e0b7cbff7:

  fscrypt: Replace 1-element array with flexible array (2023-05-23 19:46:09 -0700)

----------------------------------------------------------------

Just one flex array conversion patch.

----------------------------------------------------------------
Kees Cook (1):
      fscrypt: Replace 1-element array with flexible array

 fs/crypto/fscrypt_private.h |  2 +-
 fs/crypto/hooks.c           | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)
