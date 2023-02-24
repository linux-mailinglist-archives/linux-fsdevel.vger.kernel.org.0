Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35CA6A1548
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 04:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBXDXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 22:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXDXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:23:45 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8C338B72;
        Thu, 23 Feb 2023 19:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+jQXP14Fv8uCf+jB79FH0/x1hRT1U9Hylh0Ix4ziegA=; b=fmMqWiyd9Jc5p6jF7ik+1HYHV7
        zE1Iv3GNzN4TA2vLVG7ckl82rLOuwjvBFgtf7gmMPsZQdaVeLelkJE8Wafnm1Gv9UpMEWgiwsCmH0
        2akmoVHWIxp33WYCuAJOvQ6VrLoGboX1fHuODEGR734C6OI9c7MMfv5cDwiUMV/0MjG9TmlALF5z3
        phPWywhaMRue1RucqT3JxAD77ai7yxOR5oK81Q8C7/uSg2Qy5uo3Ey/bwmHEWhfn7zxd0nRM0WC8x
        N2LtqvRcQQlivIUwAIjGx0IVNSSRNZxRnp8mz4bvEoWUChRQ3OEU2uSiq7nkk7o8KYpzdFGQlVJnO
        ixUk6XsA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pVOgO-00Bs1D-1f;
        Fri, 24 Feb 2023 03:23:40 +0000
Date:   Fri, 24 Feb 2023 03:23:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git minix pile
Message-ID: <Y/gtvKEGVuwHRZz6@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Assorted fixes - mostly Christoph's

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.minix

for you to fetch changes up to 2cb6a44220b974a7832d1a09630b4cee870b023a:

  minix_rename(): minix_delete_entry() might fail (2023-01-19 19:29:26 -0500)

----------------------------------------------------------------
Al Viro (2):
      minix: make minix_new_inode() return error as ERR_PTR(-E...)
      minix_rename(): minix_delete_entry() might fail

Christoph Hellwig (4):
      minix: move releasing pages into unlink and rename
      minix: fix error handling in minix_delete_entry
      minix: fix error handling in minix_set_link
      minix: don't flush page immediately for DIRSYNC directories

 fs/minix/bitmap.c |  16 ++++-----
 fs/minix/dir.c    |  62 ++++++++++++++++++---------------
 fs/minix/minix.h  |   5 +--
 fs/minix/namei.c  | 100 ++++++++++++++++++++++++++----------------------------
 4 files changed, 91 insertions(+), 92 deletions(-)
