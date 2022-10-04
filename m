Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F56A5F47EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJDQxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJDQxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:53:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8D5F7F8;
        Tue,  4 Oct 2022 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=66aqUZWz2FgRnKGApbs38q4Mr+7W+Z+HaQp9np7pEZk=; b=UXLvwRbu+qKg6faONfJi18dvp3
        YReowfJYPiQkiVS+WAc/+bnAwDmAmjN3WvNLfArYSqdPvz5M4tiLE8ml1qQ8sCDMBLAU7F+QTGVvP
        eA9PuS+tnKxcWLUc9tGiXsdTEIz/DZPHf8Ol3RArL7InrGSfy7F9gPXL/OnJedvtLAwSTmfuqJHXj
        86vBNUb+KW7aKzYQxVwFLbowcMJRYJglO5gGJK5AMC96q/wTmhrAROQwmgxJClybdg8G4YuGKLuZv
        EhRWXUU3FEOhb7ebb2l+smZdAL0KNMxhMYcMZHANWNYiejNL/I5AhMpv3oyC8DvRvFjyes7T4a7nS
        /pQLLpZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oflAK-0072FQ-2i;
        Tue, 04 Oct 2022 16:53:08 +0000
Date:   Tue, 4 Oct 2022 17:53:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 2 (d_path)
Message-ID: <Yzxk9FF7G4LpBVCS@ZenIV>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-d_path

for you to fetch changes up to c4c8451147da569a79eff5edcd2864e8ee21d7aa:

  d_path.c: typo fix... (2022-08-20 11:34:33 -0400)

----------------------------------------------------------------
d_path pile

----------------------------------------------------------------
Al Viro (2):
      dynamic_dname(): drop unused dentry argument
      d_path.c: typo fix...

 drivers/dma-buf/dma-buf.c | 2 +-
 fs/anon_inodes.c          | 2 +-
 fs/d_path.c               | 5 ++---
 fs/nsfs.c                 | 2 +-
 fs/pipe.c                 | 2 +-
 include/linux/dcache.h    | 4 ++--
 net/socket.c              | 2 +-
 7 files changed, 9 insertions(+), 10 deletions(-)
