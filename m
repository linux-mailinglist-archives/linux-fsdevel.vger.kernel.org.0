Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0D654F8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 12:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiLWLPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 06:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLWLP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:15:28 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378AE95;
        Fri, 23 Dec 2022 03:15:24 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 00301C01B; Fri, 23 Dec 2022 12:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671794136; bh=VN5EBYZqJL3wQsJ8/hshGhgSI3cKSXMIvWYt8/UPKFM=;
        h=Date:From:To:Cc:Subject:From;
        b=GvUwMFT0Q6aYikdx7+ZWM69hPxdNa0tfsCa0zyvxN5AGOR2mzoqBpf5hTdluw552j
         NcUZVbAwPk+Q6QaLM4SBJfXG+uMh/thXSBkscaP5OT0xD293L485SbIlwyDCXmMRXw
         XuhsCzHTxUI0HsaNHe8EUcnfuvcOLcktHEy0qbbs+e0FZFJOJSxOmeZ2yDrwgpB2GO
         z0vWfoxc2UcneQr8p2jGupykyZVkvsqnMt+GPv3ONNQpT0+DwCucO8kV11bnfAMDFv
         2BqTq5QbMtBGQ15ytRRB3G+SW1zZwVmAgzZ5uEBQ3ChszRytXobxC9uAm1zknvW2ZM
         sXAbXW3iaI7dg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 020A0C009;
        Fri, 23 Dec 2022 12:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1671794135; bh=VN5EBYZqJL3wQsJ8/hshGhgSI3cKSXMIvWYt8/UPKFM=;
        h=Date:From:To:Cc:Subject:From;
        b=jOIbSBD9sy53EBNLvHZoaDht+SWLUur99xN+t8rN/Iq/KOSSsXhz4OWts8/XOVvid
         qlAAqfzFC9tbdEuxgkSPLQa8lzc1K0uElivb3PlF8i4ISlgDGEkZY6A5lhN8jtLcto
         Wtx8rDPRuogYQQ8uC9CbllnziA94bauWo6LYrbBAT3Pqa0OVBVHiZ0KAPDIn4W05X3
         NFliLgwxrTvX6x5M5Ranzgo6zkEOJ/SCHk/jO8sUeFNfo9RKKBEwvT2bt+pjyPmnPf
         ia1ohKTTHEXS00Sx/lYinTD1j3jdujTQnafgAxkE4WWjubNP8q65wZ/RrTyFX6OK2V
         9SZvqifuhhKgw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id c8efe9ed;
        Fri, 23 Dec 2022 11:15:18 +0000 (UTC)
Date:   Fri, 23 Dec 2022 20:15:03 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: [GIT PULL] 9p fixes for 6.2-rc1
Message-ID: <Y6WNt21HKZmWTG3/@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.2-rc1

for you to fetch changes up to 1a4f69ef15ec29b213e2b086b2502644e8ef76ee:

  9p/client: fix data race on req->status (2022-12-13 13:02:15 +0900)

----------------------------------------------------------------
9p-for-6.2-rc1

- improve p9_check_errors to check buffer size instead of msize when possible
(e.g. not zero-copy)
- some more syzbot and KCSAN fixes
- minor headers include cleanup

----------------------------------------------------------------
Christian Schoenebeck (2):
      net/9p: distinguish zero-copy requests
      net/9p: fix response size check in p9_check_errors()

Christophe JAILLET (2):
      9p/fs: Remove unneeded idr.h #include
      9p/net: Remove unneeded idr.h #include

Dominique Martinet (2):
      9p/xen: do not memcpy header into req->rc
      9p/client: fix data race on req->status

Schspa Shi (1):
      9p: set req refcount to zero to avoid uninitialized usage

 fs/9p/fid.c            |  1 -
 fs/9p/v9fs.c           |  1 -
 fs/9p/vfs_addr.c       |  1 -
 fs/9p/vfs_dentry.c     |  1 -
 fs/9p/vfs_dir.c        |  1 -
 fs/9p/vfs_file.c       |  1 -
 fs/9p/vfs_inode.c      |  1 -
 fs/9p/vfs_inode_dotl.c |  1 -
 fs/9p/vfs_super.c      |  1 -
 include/net/9p/9p.h    |  2 ++
 net/9p/client.c        | 33 ++++++++++++++++++++++-----------
 net/9p/trans_fd.c      | 13 ++++++-------
 net/9p/trans_rdma.c    |  5 ++---
 net/9p/trans_virtio.c  | 10 +++++-----
 net/9p/trans_xen.c     |  8 +++++---
 15 files changed, 42 insertions(+), 38 deletions(-)
--
Dominique
