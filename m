Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B46530A1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 10:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiEWHY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiEWHXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 03:23:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F939696;
        Mon, 23 May 2022 00:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 769D6B80F10;
        Mon, 23 May 2022 07:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8469C385A9;
        Mon, 23 May 2022 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653289816;
        bh=IAOOiC06hudRZNZSQ1tFtrdnEBH2mP9eJjRcKNb1ZFo=;
        h=Date:From:To:Cc:Subject:From;
        b=WTN7gamih7ocrr+IWwuOXn2dQwM32MoBNyoo6fsBOuIBeQ2w9BaMC3dPEzJHx8h5c
         T0V9xFB5Hd5qFsxHNbiYYkPXoEBYddEZNttYTAxzCkCL4kHHrhZ8QU2T512xw8zvL/
         5DSWJJJWLubg5J/jNfg18086HakZKQHOreZQKx4k4Iawl24fccWAgB2ppbB31aG82u
         hT8I8WXyDf0pXmJRCU9YGtxz4lh/gQx+d/nJ2MHry9G/rsLQbqOkxPBSu9VA5/h8nl
         bUASg6m+iflTREnbQWwbbsVB9XAS3uutXWismc8+mkiCWhjoh+JhFPZbZwslhzO+6V
         YfHYrEVkEL84w==
Date:   Mon, 23 May 2022 00:10:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [GIT PULL] fsverity updates for 5.19
Message-ID: <YoszVvtG55xJnUJ6@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to e6af1bb07704b53bad7771db1b05ee17abad11cb:

  fs-verity: Use struct_size() helper in enable_verity() (2022-05-19 09:53:33 -0700)

----------------------------------------------------------------

A couple small cleanups for fs/verity/.

----------------------------------------------------------------
Zhang Jianhua (2):
      fs-verity: remove unused parameter desc_size in fsverity_create_info()
      fs-verity: Use struct_size() helper in enable_verity()

 fs/verity/enable.c           |  4 ++--
 fs/verity/fsverity_private.h |  6 ++----
 fs/verity/open.c             | 12 ++++--------
 fs/verity/read_metadata.c    |  5 ++---
 4 files changed, 10 insertions(+), 17 deletions(-)
