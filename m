Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87F53DDD0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 21:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbiFETNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiFETNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:13:49 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94859338A1;
        Sun,  5 Jun 2022 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WBgWj2o0rQ0VeqJ5O4/YRTbEP3jJViaoLrQNykDYgME=; b=pqgq3feGVSSZNKPyYlgsCuptPZ
        MysECDtrrFOhWvuwVLpVb9Cblclr3zir/9LzkSA+lFglzrNrUIHq4EjSrMlsQRvmXWpCwab8hl5IA
        XbjfaqRzda9HaxNR6XffEP5/bsQDWNKUIGEfue5cjn5PtfIVGr75zytCMocjS9RfD6T3UgNHIPQcT
        j1roe7IezegXnJ+Qj8UYoBpa/SUVFbXyH0BdhNoWOzvO3Hs0rBtdJFD6P22BItcjAmR7hmYFYfpmw
        SSDT3T1FClzKUkEIBXXxcrwteHomJUtTjPVDH/nqO6pe7gzL11OYQ6RyKpd8hHRSJGOxPqfv2/xqR
        8skhsOdQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxvh4-003qoa-Bh; Sun, 05 Jun 2022 19:13:46 +0000
Date:   Sun, 5 Jun 2022 19:13:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] work.fd fix
Message-ID: <Yp0AamPDLOK6mTIn@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[BTW, what conventions are generally used for pull tag names?]

The following changes since commit 6319194ec57b0452dcda4589d24c4e7db299c5bf:

  Unify the primitives for file descriptor closing (2022-05-14 18:49:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.fd-fixes

for you to fetch changes up to 40a1926022d128057376d35167128a7c74e3dca4:

  fix the breakage in close_fd_get_file() calling conventions change (2022-06-05 15:03:03 -0400)

----------------------------------------------------------------
fix for breakage in #work.fd this window
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      fix the breakage in close_fd_get_file() calling conventions change

 drivers/android/binder.c | 2 ++
 fs/file.c                | 3 +--
 fs/io_uring.c            | 5 +----
 3 files changed, 4 insertions(+), 6 deletions(-)
