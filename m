Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6336EC45C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 06:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjDXE0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 00:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXE0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:26:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C1819A4;
        Sun, 23 Apr 2023 21:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JqDs4xkf7Ug1Jc+sjAC8OMHWtMT118JZ11ZlIoVhBXs=; b=RUITMNzjZPCxNGjv+GxNEhG4e6
        FxWsW5yXVCTaNFs+/V+LGGjWNrJ4RbCW0c7U0Rs2GuSZMoNy7ZOb9sfY++yTY0NEeCx9XxnnDWR6V
        GU6+Z2dewSVqeVxQeZE6srme94BtCZO2VAZFYNXRsKYTKJPJB7jk4qS9W1+G+CyKLfKYqWN07rQLL
        p7L32TU4lTv8Zq6y5rM7OhXcYXo/A1jVyKa/tJeCc/yNc4mi5z8C1hCx2KzEfEm8bOm7y5A0ECrhS
        SA8FQbJoqdEWjGYIs5yDO/8z7rLWYYQ0zRHa95P8hXm7IIxpGN40Dne7+zMUBP2UsR78wylFO+Xc8
        Q45bGL+Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqnmg-00C0Ho-0s;
        Mon, 24 Apr 2023 04:26:38 +0000
Date:   Mon, 24 Apr 2023 05:26:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] the rest of write_one_page() series
Message-ID: <20230424042638.GJ3390869@ZenIV>
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

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-write-one-page

for you to fetch changes up to 2d683175827171c982f91996fdbef4f3fd8b1b01:

  mm,jfs: move write_one_page/folio_write_one to jfs (2023-03-12 20:00:42 -0400)

----------------------------------------------------------------
write_one_page series

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Christoph Hellwig (3):
      ufs: don't flush page immediately for DIRSYNC directories
      ocfs2: don't use write_one_page in ocfs2_duplicate_clusters_by_page
      mm,jfs: move write_one_page/folio_write_one to jfs

 fs/jfs/jfs_metapage.c   | 39 ++++++++++++++++++++++++++++++++++-----
 fs/ocfs2/refcounttree.c |  9 +++++----
 fs/ufs/dir.c            | 29 +++++++++++++++++++----------
 include/linux/pagemap.h |  6 ------
 mm/page-writeback.c     | 40 ----------------------------------------
 5 files changed, 58 insertions(+), 65 deletions(-)
