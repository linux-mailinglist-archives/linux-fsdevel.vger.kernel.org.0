Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819446A158D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 04:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBXDli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 22:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBXDl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:41:29 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD8161F17;
        Thu, 23 Feb 2023 19:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zV2PTjvErRgwnmTzz6vFMxKw2+5Wo2Bf4GVoQwQhANk=; b=b01dJR510FkYZROTnTjwTZ9GKH
        kPMUXKLi/Z8urjnJVTEsw1q90m0t4VP36LGUuv9yAC30Vtny3V6Q/WXshuiUFljKLa8ynIkqUzg9S
        /aorZyvW6Uv8CNKe69VX7dSli9vZRKr2D5SfqgW/fDC01oZeMwbNY7b8BK89s7d8yjb6PqAKVXOKj
        a0E7//CuZ6p+U96mKbvIhuGgxZLLe72cRsMVsBr01tzUcpBhvW/AkqsiNQUwx9Y54T+JeqibnZ/ZG
        +CHg6P0GXaM9zSKgUvTrHKCoLTE7Zbdwju6jEOD60bQUGSxznvkQQKceE1J5s0sTqdNKyILlBYblP
        48SIsJDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pVOx7-00BsJM-0R;
        Fri, 24 Feb 2023 03:40:57 +0000
Date:   Fri, 24 Feb 2023 03:40:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc bits
Message-ID: <Y/gxyQA+yKJECwyp@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted stuff that didn't fit anywhere else.

That should cover the rest of what I had in -next; I'd been sick for
several weeks, so a lot of pending stuff I hoped to put into -next
is going to miss this window ;-/

Al, off to deal with the remaining pile in the mailbox...

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 39ecb653f671bbccd4a3c40f7f803f2874252f81:

  nsfs: repair kernel-doc for ns_match() (2023-01-11 15:47:40 -0500)

----------------------------------------------------------------
Fabio M. De Francesco (1):
      fs/cramfs: Convert kmap() to kmap_local_data()

Lukas Bulwahn (1):
      nsfs: repair kernel-doc for ns_match()

Thomas Weiﬂschuh (1):
      nsfs: add compat ioctl handler

 fs/cramfs/inode.c | 9 ++++-----
 fs/nsfs.c         | 3 ++-
 2 files changed, 6 insertions(+), 6 deletions(-)
