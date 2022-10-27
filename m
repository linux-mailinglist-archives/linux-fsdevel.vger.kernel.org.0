Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A50860EF3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 06:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiJ0Eys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 00:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiJ0Eyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B242963D7;
        Wed, 26 Oct 2022 21:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B07E6216E;
        Thu, 27 Oct 2022 04:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BDBC433D6;
        Thu, 27 Oct 2022 04:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666846481;
        bh=un9lzumgYGFX4N31OPIAznIJ14qEZHgfKlS9DrUzqA4=;
        h=Date:From:To:Cc:Subject:From;
        b=QRYIrPM313GyosWvE+FOcKoxg3goWTSbV+S6s5InwdsO24p5oonKkiNmEFxxjBBcf
         nh/Hi2Gl3ELVetHY8KmGb3qjLpj5wyAGM0p/QgXbctc7Q3auFJz0p9nZ4GprUlOUrz
         +tYD3eRqdahnusnU7kBuKLU5zDrDNnEg6D152ctsCHRpibOY1paUBdk62g7k49mZmO
         Ez2hYckWfdA0lS0hYqSVanmSGjDbCEqu/9qMQvKL2+YZktspSJpudeEbCIz7REZTHq
         Eb4k44OwwkRafpFGlzSNNz5MhOmzxoAa5xGDJSW+wDpsPnSAH3pjmrq1V32M/Wrh3Q
         K462hLShUXVBw==
Date:   Wed, 26 Oct 2022 21:54:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fscrypt fix for 6.1-rc3
Message-ID: <Y1oPDy2mpOd91+Ii@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to ccd30a476f8e864732de220bd50e6f372f5ebcab:

  fscrypt: fix keyring memory leak on mount failure (2022-10-19 20:54:43 -0700)

----------------------------------------------------------------

Fix a memory leak that was introduced by a change that went into -rc1.

----------------------------------------------------------------
Eric Biggers (1):
      fscrypt: fix keyring memory leak on mount failure

 fs/crypto/keyring.c     | 17 +++++++++++------
 fs/super.c              |  3 ++-
 include/linux/fscrypt.h |  4 ++--
 3 files changed, 15 insertions(+), 9 deletions(-)
