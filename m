Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6356B5882DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiHBTzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 15:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiHBTzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:55:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49EDE9E;
        Tue,  2 Aug 2022 12:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCBF5B8205F;
        Tue,  2 Aug 2022 19:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6185FC433D6;
        Tue,  2 Aug 2022 19:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659470146;
        bh=peWWzehbf3IqEKCxVqXKq+x7rnMhBy0XuoXBw32BqhY=;
        h=Date:From:To:Cc:Subject:From;
        b=gKnUVA6T53A+zKuxotZrppQbDFgusMgjj3GmR2Qo57NEKyv5oVQLpPjkE+qGvW+xl
         ySO/W1xl5ZyoShzLwWIaOkq/SKGEHuAp93JNlHoToveZmM5mga8VRUKujCkk3pxAfq
         XCruKTAF6+cH06/oI0RqCuG8gWdjkiCXtzphRI9zFmE7f5x+9Mqqw2KiA/Yz13gQAW
         OelJETWaqiI+NmP5MguVbayOJLlHidqlyPS9HyGuiIeaR86U4W2ZbgaH+LsY+me6iQ
         r1BNi/Yqraju1rywywqrA64JNpuHHAU79KwiLG1Yi82r1Sdq2+vr4im9hLPzkxlI9y
         H0nFGsQqCIoKg==
Date:   Tue, 2 Aug 2022 12:55:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] fsverity update for 5.20
Message-ID: <YumBQPF6U9b6wGV9@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to 8da572c52a9be6d006bae290339c629fc6501910:

  fs-verity: mention btrfs support (2022-07-15 23:42:30 -0700)

----------------------------------------------------------------

Just a small documentation update to mention the btrfs support.

----------------------------------------------------------------
Eric Biggers (1):
      fs-verity: mention btrfs support

 Documentation/filesystems/fsverity.rst | 53 +++++++++++++++++++---------------
 fs/verity/Kconfig                      | 10 +++----
 2 files changed, 35 insertions(+), 28 deletions(-)
