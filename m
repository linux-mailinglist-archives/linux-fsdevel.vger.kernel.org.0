Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280956EDB9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjDYG1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 02:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjDYG1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B103BBA4;
        Mon, 24 Apr 2023 23:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCFA862BA1;
        Tue, 25 Apr 2023 06:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F98DC433D2;
        Tue, 25 Apr 2023 06:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682404029;
        bh=nka1gA7XSDpO0YbpJJARB0ceyBmqTwmWDgxGdXCigbs=;
        h=Date:From:To:Cc:Subject:From;
        b=Zxug7M7tFcCpGQ+9bAnra1GCaDwr0bv4tj04hqBlXBeXSgIy2OyLX9dkdNaDgYeD1
         HoJYu7ixXaOyxsN+gejA7w8uMNckAg+p9/RMVm5KUyNNxMDqgXtv1JboFPZ/nuOBMb
         3FkiX3o8fZJc7uoVTpQea+rqTOPfCYHGIEIhvQzxl5rl7h+Rhxgy7hSVWRPBhud8TH
         +57dLxz66nOSFtUNx+80lQMatXlAdDpwKJB/ZhkWSdvNqnRuQZ43OBLJKRQ3B656pf
         U2W8b7Por/4G3Hx7eBtFbI2mLof6DpADKIh39QgcPpX2gNwjmrTE0K9IqjAibiPnGx
         RyY0FRgO5ySig==
Date:   Mon, 24 Apr 2023 23:27:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fsverity updates for 6.4
Message-ID: <20230425062707.GB77408@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 04839139213cf60d4c5fc792214a08830e294ff8:

  fsverity: reject FS_IOC_ENABLE_VERITY on mode 3 fds (2023-04-11 19:23:23 -0700)

----------------------------------------------------------------

Several cleanups and fixes for fs/verity/, including a couple minor
fixes to the changes in 6.3 that added support for Merkle tree block
sizes less than the page size.

----------------------------------------------------------------
Eric Biggers (4):
      fs/buffer.c: use b_folio for fsverity work
      fsverity: use WARN_ON_ONCE instead of WARN_ON
      fsverity: explicitly check for buffer overflow in build_merkle_tree()
      fsverity: reject FS_IOC_ENABLE_VERITY on mode 3 fds

Luis Chamberlain (1):
      fs-verity: simplify sysctls with register_sysctl()

 fs/buffer.c              |  9 ++++-----
 fs/verity/enable.c       | 21 +++++++++++++++++++--
 fs/verity/hash_algs.c    |  4 ++--
 fs/verity/open.c         |  2 +-
 fs/verity/signature.c    |  9 +--------
 include/linux/fsverity.h |  6 +++---
 6 files changed, 30 insertions(+), 21 deletions(-)
