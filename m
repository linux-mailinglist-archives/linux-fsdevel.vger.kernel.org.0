Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81E46382E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 04:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKYDw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 22:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYDwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:52:25 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E45B2BB04;
        Thu, 24 Nov 2022 19:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WQE2bljkwPcZSIStrA9SXLqEb1ffALT2A7cgUChcQN4=; b=NjxvMeDq005NtgJf+e8rS3MnhN
        G3WTAqWkzHhVgWVkWCLTomN1rvCsfRN/DtRueq3mIJmID4xG2TygAon4RZfSn8+XoEIq/SZyB2g+o
        EGPAzLEqB3I0sxBdravAbe7qZ/TgHHYkfHztIzQViWjncRQtBW0qMUL8ZVuhz5C3qJwFE1dOktiJx
        NhTiKoE8m0b/BQBEDMoMNWGO+W9vPit+a/5PfApggrUao75t3oty4Kz0prfzmEawGZ0DKU1DsEPzd
        IZvVqCNdrvqODjv/rD4Yd1ODu6HiWNzQVu000xYvp7BeRKsV4Fa0+UF8t9p8WQObH+5pc4hRBwUH8
        5bH2iynQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyPlG-006aJf-2n;
        Fri, 25 Nov 2022 03:52:22 +0000
Date:   Fri, 25 Nov 2022 03:52:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] (vfs.git) a couple of fixes
Message-ID: <Y4A79tAvPFcC3Hu7@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 406c706c7b7f1730aa787e914817b8d16b1e99f6:

  vfs: vfs_tmpfile: ensure O_EXCL flag is enforced (2022-11-19 02:22:11 -0500)

----------------------------------------------------------------
a couple of fixes, one of them for this cycle regression...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Jann Horn (1):
      fs: use acquire ordering in __fget_light()

Peter Griffin (1):
      vfs: vfs_tmpfile: ensure O_EXCL flag is enforced

 fs/file.c  | 11 ++++++++++-
 fs/namei.c |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)
