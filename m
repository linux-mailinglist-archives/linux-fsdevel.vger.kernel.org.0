Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15065892D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiHCTkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbiHCTkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:40:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7165CDEA5;
        Wed,  3 Aug 2022 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=50f8HRU1DbcbH6610jLPXoi8vBrEv/VmRLpOBziYYVo=; b=l3Ejigwo2vUVYR1XpAV8c+EXrL
        C2BJ0WB2FKffVWpPzU73aX1FdU640+brm+DfyAC5x+t41CFEmOVX3X6yFaNJ26gaOatEMlk1+7Cdo
        +Yd6d+mnPUyCHN7lh3LXWJnq9jUOqFvvE/iqV6/xevRk6lXmRjCx8DEEQrNgHqV0YpASEA8j/E/B6
        hjgz/kvJeKZZ4R4q000Hj1bEa/UPMHg5IrI2H6p5dOOdrRWiQBravF8She6bfUgWrCQz0t5LsLv30
        3DhEKRc+hB6FQJTb88++PPOIS4yKyt4llVjHTnrCh7Tbpt25RpHHhS2vK0l9IzH3ZoZ+D865hJMdO
        KLbLsNMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oJKE4-000vUN-Mo;
        Wed, 03 Aug 2022 19:40:16 +0000
Date:   Wed, 3 Aug 2022 20:40:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git copy_mc_to_iter() backportable fix
Message-ID: <YurPILsZlc47V2+O@ZenIV>
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

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to c3497fd009ef2c59eea60d21c3ac22de3585ed7d:

  fix short copy handling in copy_mc_pipe_to_iter() (2022-06-28 17:37:11 -0400)

----------------------------------------------------------------
backportable fix for copy_to_iter_mc() - the second part of
iov_iter work will pretty much overwrite that one, but it's
much harder to backport.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      fix short copy handling in copy_mc_pipe_to_iter()

 include/linux/pipe_fs_i.h |  9 +++++++++
 lib/iov_iter.c            | 15 +++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)
