Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54578A4D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 05:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjH1Dru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 23:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjH1Drp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3849BF;
        Sun, 27 Aug 2023 20:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72EFE61FCB;
        Mon, 28 Aug 2023 03:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BBEC433C7;
        Mon, 28 Aug 2023 03:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693194462;
        bh=BuWINHrRquDDWmHEVhKsAhSrCUkzcCM2neHXaS8GC/E=;
        h=Date:From:To:Cc:Subject:From;
        b=sf9DLcuyCilCSPUJnCQ6uHZqUz6wLm2jQhxc9NarLw9h4Ln+pCjpdbdJT0SL9IofC
         A4OqQs4lhkRuUlPm/Ge9OmyBgaVc71QXPR/tOZ5En9tkWHh8OC6IWCZxXM+Xzen8c4
         0VJ5sxNNURtggbgRnfUceWc3s9mYBT48jdvXdKjyuGvedzL4BWw0oMBlSan37ykgsl
         W4b/MQLmXjaOEcTRRsGkLdxM0S/do0rC85ZSYHPUsqOtw69X4EuGb82lBDJ2QmbNhr
         1KF5PQFcUTjX0MA+2V6Ki2KE8MT+6zvZEkwiVyGjcJvAdxiGvqjH+YlgCjwIIvnUtp
         F+O6uiEYw9Abw==
Date:   Sun, 27 Aug 2023 20:47:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fsverity updates for 6.6
Message-ID: <20230828034741.GB5028@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 919dc320956ea353a7fb2d84265195ad5ef525ac:

  fsverity: skip PKCS#7 parser when keyring is empty (2023-08-20 10:33:43 -0700)

----------------------------------------------------------------

Several cleanups for fs/verity/, including two commits that make the
builtin signature support more cleanly separated from the base feature.

----------------------------------------------------------------
Eric Biggers (4):
      fsverity: explicitly check that there is no algorithm 0
      fsverity: simplify handling of errors during initcall
      fsverity: move sysctl registration out of signature.c
      fsverity: skip PKCS#7 parser when keyring is empty

 fs/verity/fsverity_private.h | 12 +++----
 fs/verity/hash_algs.c        |  8 +++++
 fs/verity/init.c             | 56 ++++++++++++++++++++------------
 fs/verity/open.c             | 18 +++--------
 fs/verity/signature.c        | 77 ++++++++++++++------------------------------
 fs/verity/verify.c           | 11 ++-----
 6 files changed, 79 insertions(+), 103 deletions(-)

