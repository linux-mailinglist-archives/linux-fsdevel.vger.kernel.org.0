Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B55678C88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 01:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjAXAF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 19:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjAXAF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:05:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E167A26B5;
        Mon, 23 Jan 2023 16:05:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E3215CE13DE;
        Tue, 24 Jan 2023 00:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F35C433EF;
        Tue, 24 Jan 2023 00:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674518753;
        bh=hBXjg01PaQHYf+Ggs6/zaY5Tjug7rDb4bQDRZBQLMEM=;
        h=Date:From:To:Cc:Subject:From;
        b=Mh6BvlmGfYDepPXnv6lJagmU/2/FKHdGHz4F7AIyAXUCqfksANU1RyCmBULwsWEEM
         Sd7RwhqJPhe2F0S0LLeTmKmGaiIGtC+dQ132S5Y5UATRJjtRCuF7D0v9cgZLRVJ8oY
         IHJx2ihQq9M8p8SmZO7ndqL7HXChJEEtB7NhcLOTxtYN4SE3pXrn7mEsc5vtFtORwY
         jCpl15W5CuXkc3AWfa8DnkIRitg1hote/AXc3r9Gvfs5pFjEO+RZ8poszS2HipAwhH
         1LAxv9Hi0WXW6q8xxklbx8WY1Q58v/DVy7h1uwFYTfo2GRKUmDy2ohhbO7nwNV1scY
         fIXebnr/Wvh/Q==
Date:   Mon, 23 Jan 2023 16:05:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscrypt MAINTAINERS entry update for 6.2-rc6
Message-ID: <Y88g398lWBul+756@sol.localdomain>
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

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 31e1be62abdebc28bd51d0999a25f0eea535b5af:

  MAINTAINERS: update fscrypt git repo (2023-01-16 15:40:48 -0800)

----------------------------------------------------------------
Update the MAINTAINERS file entry for fscrypt.

----------------------------------------------------------------
Eric Biggers (1):
      MAINTAINERS: update fscrypt git repo

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
