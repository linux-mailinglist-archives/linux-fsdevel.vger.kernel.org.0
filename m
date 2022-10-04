Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5B55F47F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJDQ4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJDQ4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:56:13 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2474F18E;
        Tue,  4 Oct 2022 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pWqBOpi2UwbYFYN/Ld2WJlUM8sZ9zCHe2jy9DCGouMY=; b=f7AqDnT6ipMtbO+xw8MJ2JYch6
        y1JUZ/yGNu3aHtulRBrhr0U+RHTeDmRgZVEyHxSLG4UZ048M8QaZ+Q4rzsuI6eeRVxpE3nXW9Y+jh
        aXO3BKbZdq/Bc9jdA5i6QfD0H9Co1/u5HAB1a6OXwYYz+/LnAzkrOG/dkwPPgDkKshZWdvoK/5Nrc
        8k+0NB49H7HEkpNoLYupeM2erug2cg77BXtQ1wCOc3ZK1mGriY1NmEYs7ho3/tqQHrAcpvkVR1f6B
        Gcyt6BMRippZPooRnDnF7R0jxK8CRQ5HT1exXI8xwH5d59wFJMGk9RSxF/W16ke5yTT1UFFxqa3Ow
        5terW2Dw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oflDG-0072LB-0y;
        Tue, 04 Oct 2022 16:56:10 +0000
Date:   Tue, 4 Oct 2022 17:56:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 4 (file_inode)
Message-ID: <YzxlqrEtoV37hm3l@ZenIV>
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

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-file_inode

for you to fetch changes up to 4094d98e3375833737b467998219338ffd46a68b:

  orangefs: use ->f_mapping (2022-09-01 17:46:06 -0400)

----------------------------------------------------------------
whack-a-mole: cropped up open-coded file_inode() uses...

----------------------------------------------------------------
Al Viro (8):
      ibmvmc: don't open-code file_inode()
      exfat_iterate(): don't open-code file_inode(file)
      sgx: use ->f_mapping...
      bprm_fill_uid(): don't open-code file_inode()
      nfs_finish_open(): don't open-code file_inode()
      dma_buf: no need to bother with file_inode()->i_mapping
      _nfs42_proc_copy(): use ->f_mapping instead of file_inode()->i_mapping
      orangefs: use ->f_mapping

 arch/x86/kernel/cpu/sgx/encl.c | 3 +--
 drivers/dma-buf/udmabuf.c      | 2 +-
 drivers/misc/ibmvmc.c          | 6 ++++--
 fs/exec.c                      | 3 +--
 fs/exfat/dir.c                 | 6 +++---
 fs/nfs/dir.c                   | 2 +-
 fs/nfs/nfs42proc.c             | 2 +-
 fs/orangefs/file.c             | 4 +---
 8 files changed, 13 insertions(+), 15 deletions(-)
