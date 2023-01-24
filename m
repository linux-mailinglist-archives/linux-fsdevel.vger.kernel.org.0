Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91585678C7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 01:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjAXAEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 19:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAXAEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:04:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1DF65BA;
        Mon, 23 Jan 2023 16:04:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5483B80EF0;
        Tue, 24 Jan 2023 00:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B80C433D2;
        Tue, 24 Jan 2023 00:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674518648;
        bh=I/4HF/UWHkyj0AKgmX5aVea6n1NeFD9hJ3KsaZ4MVf0=;
        h=Date:From:To:Cc:Subject:From;
        b=OxQir4Py2cNgyc9lxe4vK3+YAk1cOT3NVbPbI5Ii16OlJH93waZ67KEftOxZgsXAG
         TA0H+rpKOxV8U8bkHmU1b0IXU5FdZpXinbPllq/yIvkodjhMrgPSWpMYQjYtHcfdmg
         X1DSGNpEunzMAq0rzbxSR8RRHIwTrgM3a/uXXyGhOsMz0YhZO2y0znJVaX5PoQIc8V
         drsrrALgmtDz6pABsccKRnBdqjOKgtJihNDx9ChrjjGNQ5Us3GyHFMykW0XRv02Qa4
         b1X1ZkE2MJyn5+RVDGWjVAXpZl8JXwTwNNM8+F5uevF8hhZXtuhtrOXwGUmpq/Zt6o
         vwIk/KE7RLc8Q==
Date:   Mon, 23 Jan 2023 16:04:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, fsverity@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] fsverity MAINTAINERS entry update for 6.2-rc6
Message-ID: <Y88gdkbdscJPOqSX@sol.localdomain>
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

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to ef7592e466ef7b2595fdfdfd23559a779f4b211a:

  MAINTAINERS: update fsverity git repo, list, and patchwork (2023-01-16 15:38:41 -0800)

----------------------------------------------------------------
Update the MAINTAINERS file entry for fsverity.

----------------------------------------------------------------
Eric Biggers (1):
      MAINTAINERS: update fsverity git repo, list, and patchwork

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
