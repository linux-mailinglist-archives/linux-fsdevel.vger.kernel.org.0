Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568271DA4F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 00:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgESWsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 18:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgESWsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 18:48:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46955C061A0E
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 15:48:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbB2E-00C3mh-KO; Tue, 19 May 2020 22:48:30 +0000
Date:   Tue, 19 May 2020 23:48:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git fix
Message-ID: <20200519224830.GV23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	-stable fodder - copy_fdtable() would get screwed on 64bit boxen
with sysctl_nr_open raised to 512M or higher, which became possible
since 2.6.25; nobody sane would set the things up that way, but...

The following changes since commit b0d3869ce9eeacbb1bbd541909beeef4126426d5:

  propagate_one(): mnt_set_mountpoint() needs mount_lock (2020-04-27 10:37:14 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 4e89b7210403fa4a8acafe7c602b6212b7af6c3b:

  fix multiplication overflow in copy_fdtable() (2020-05-19 18:29:36 -0400)

----------------------------------------------------------------
Al Viro (1):
      fix multiplication overflow in copy_fdtable()

 fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
