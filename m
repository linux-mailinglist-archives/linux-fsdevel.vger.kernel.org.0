Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AEE320E4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 23:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhBUWct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 17:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhBUWcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:32:48 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1FFC061574;
        Sun, 21 Feb 2021 14:32:08 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDxGe-00GpT4-Bk; Sun, 21 Feb 2021 22:31:56 +0000
Date:   Sun, 21 Feb 2021 22:31:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] d_name whack-a-mole
Message-ID: <YDLfXNMwX6X4R/QS@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	A bunch of places that play with ->d_name in printks instead of
using proper formats...

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.d_name

for you to fetch changes up to d67568410ae1c95004fad85ff1fe78204752f46c:

  orangefs_file_mmap(): use %pD (2021-01-06 21:59:52 -0500)

----------------------------------------------------------------
Al Viro (4):
      cramfs: use %pD instead of messing with file_dentry()->d_name
      erofs: use %pd instead of messing with ->d_name
      cifs_debug: use %pd instead of messing with ->d_name
      orangefs_file_mmap(): use %pD

 fs/cifs/cifs_debug.c |  4 ++--
 fs/cramfs/inode.c    | 18 ++++++++----------
 fs/erofs/namei.c     |  4 ++--
 fs/orangefs/file.c   |  5 +----
 4 files changed, 13 insertions(+), 18 deletions(-)
