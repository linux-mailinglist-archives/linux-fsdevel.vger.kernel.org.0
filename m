Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993BD639C62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Nov 2022 19:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiK0Sez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Nov 2022 13:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiK0Sex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Nov 2022 13:34:53 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9EFDF84;
        Sun, 27 Nov 2022 10:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HbkyPqtk4FWZA0Swpp/Ynilr1ADcBAXSKQQTZhA6dSQ=; b=owDdRAPN1wbgK+RWx93FJY56aQ
        wvhGI7c7HPKJVRAynYXrANlNLmbookQEmyRq0c0Tsw9ARqG2MGf8zgc3TJPqgNQJF8V8jN637vHm2
        A6PkjsSt4bGrC2I3T6tEJw4pnPRQUlNb32h4o7otjXe1ndVZN9qP8GHWZLQVntqXWoKW4Ct0RWY/7
        /FK6d+gPLhS1lTnL13468xJmhTlPJ0xdVYOMKEkEBZMpyT8walcnBBvNwVg+hjKOdLmNRokxI/4FK
        GSlpT9tmDyrxgDqHl6l6tgcFf+DagNmc66l1oVJ6Df9uH46z00EObakmTcGsnV4oNrjWcXYW7Dvo6
        yVnO5IVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ozMUM-007BiS-21;
        Sun, 27 Nov 2022 18:34:50 +0000
Date:   Sun, 27 Nov 2022 18:34:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Subject: [git pull] more fixes
Message-ID: <Y4Otysg7VQdEj1Jp@ZenIV>
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

The following changes since commit 406c706c7b7f1730aa787e914817b8d16b1e99f6:

  vfs: vfs_tmpfile: ensure O_EXCL flag is enforced (2022-11-19 02:22:11 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 10bc8e4af65946b727728d7479c028742321b60a:

  vfs: fix copy_file_range() averts filesystem freeze protection (2022-11-25 00:52:28 -0500)

----------------------------------------------------------------
Amir's copy_file_range() fix

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Amir Goldstein (1):
      vfs: fix copy_file_range() averts filesystem freeze protection

 fs/ksmbd/vfs.c     |  6 +++---
 fs/nfsd/vfs.c      |  4 ++--
 fs/read_write.c    | 19 +++++++++++++++----
 include/linux/fs.h |  8 ++++++++
 4 files changed, 28 insertions(+), 9 deletions(-)
