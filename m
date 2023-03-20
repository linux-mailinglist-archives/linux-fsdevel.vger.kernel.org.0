Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6BE6C2362
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 22:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCTVHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 17:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCTVHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:07:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98231557D;
        Mon, 20 Mar 2023 14:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B370B810F7;
        Mon, 20 Mar 2023 21:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD33CC433EF;
        Mon, 20 Mar 2023 21:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679346446;
        bh=ADBmBXmTbG/6DZcwIw4s8rfvP8sNC2ah2K6Yy0QMwpg=;
        h=Date:From:To:Cc:Subject:From;
        b=NKcwNlNf2lXvd3vnYiWzg8wtyqZ6bCuEBv3h7IfSyVvPDrKIAyRi4jkH4yDs+OQBY
         ul9ZvTYSF7m4pZEPIQJ5RDOsSzuYrqFTkFN0z4g25ZlpUHAkr5+Q4x+tRaYO/NG1bl
         lK8/wccbxu6/XCR2bqWVVkSDxQUJYRIbm2WFnz0OyyrjO1CDZIuwVFlgP7m4m0+ow0
         qAjpOIkk/AHe6rvRStJ8p80teExO9Fr67vcT0P32jsK9XwLTWfLWwQxbQh9DIpoi/O
         l2o7N9O1+sjU9A9Pg9Wvc3/CsXgs6yllH+P+aUitXKDOnPCJ/9wK+MIwWGWPq8GCW9
         gP15V3ImMwr6g==
Date:   Mon, 20 Mar 2023 14:07:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Nathan Huckleberry <nhuck@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [GIT PULL] fsverity fixes for v6.3-rc4
Message-ID: <20230320210724.GB1434@sol.localdomain>
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

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to a075bacde257f755bea0e53400c9f1cdd1b8e8e6:

  fsverity: don't drop pagecache at end of FS_IOC_ENABLE_VERITY (2023-03-15 22:50:41 -0700)

----------------------------------------------------------------

Fix two significant performance issues with fsverity.

----------------------------------------------------------------
Eric Biggers (1):
      fsverity: don't drop pagecache at end of FS_IOC_ENABLE_VERITY

Nathan Huckleberry (1):
      fsverity: Remove WQ_UNBOUND from fsverity read workqueue

 fs/verity/enable.c | 25 +++++++++++++------------
 fs/verity/verify.c | 12 ++++++------
 2 files changed, 19 insertions(+), 18 deletions(-)
