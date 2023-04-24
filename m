Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C6D6EC462
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 06:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDXE3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 00:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXE3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:29:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7319A4;
        Sun, 23 Apr 2023 21:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9sytG9TQUSpZRe7C0gcwisFG6NIwhhQG87GFRPTKeG4=; b=g8MTuu93lWt+AmZI55wLFxoGL7
        r+r+dllIBdteAIj2ohJu5oJbEnRxOVEjP4iaG4up/3bx/mg0iPwJEdMl1qNs1BEWPqHPhUfQBCO/l
        +l0toVaPVjZRjhO809oCI/6OWUhrzZW0nwCMw4h/WrtYJA9XbXjcNSIbQGXWsEdzovI2FxJmhUaLC
        Kay+ffVC/xQl3usSfVUqs6T7iPJLj6rChiQ0vJqxUeqsbf38JNvdMBgqU/G/YZnrxO+z8mIWvwOj/
        x8v5SSyqkv+OhfpLnB03EMJyaJdbXeGChxUZcrJyhjs5j9Tc23/ue6ftOwavi0Ct1EkLBe9tBfxmK
        3hwo1XFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqnpl-00C0L7-2G;
        Mon, 24 Apr 2023 04:29:49 +0000
Date:   Mon, 24 Apr 2023 05:29:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc pile
Message-ID: <20230424042949.GM3390869@ZenIV>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

for you to fetch changes up to 73bb5a9017b93093854c18eb7ca99c7061b16367:

  fs: Fix description of vfs_tmpfile() (2023-03-12 20:03:48 -0400)

----------------------------------------------------------------
misc pile

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      sysv: switch to put_and_unmap_page()

Fabio M. De Francesco (1):
      fs/sysv: Don't round down address for kunmap_flush_on_unmap()

Roberto Sassu (1):
      fs: Fix description of vfs_tmpfile()

 fs/namei.c      |  4 ++--
 fs/sysv/dir.c   | 28 +++++++++++-----------------
 fs/sysv/namei.c |  8 ++++----
 fs/sysv/sysv.h  |  1 -
 4 files changed, 17 insertions(+), 24 deletions(-)
