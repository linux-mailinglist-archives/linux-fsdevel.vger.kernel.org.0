Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD98355A16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346804AbhDFRPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346790AbhDFRP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:15:28 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64354C06174A;
        Tue,  6 Apr 2021 10:15:17 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTpIF-0039az-9C; Tue, 06 Apr 2021 17:15:11 +0000
Date:   Tue, 6 Apr 2021 17:15:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] a couple of fixes in vfs.git
Message-ID: <YGyXH6qTQbcoOLJ+@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Fairly old hostfs bug (in setups that are not used
by anyone, apparently) + fix for this cycle regression:
extra dput/mntput in LOOKUP_CACHED failure handling.

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 7d01ef7585c07afaf487759a48486228cd065726:

  Make sure nd->path.mnt and nd->path.dentry are always valid pointers (2021-04-06 12:33:07 -0400)

----------------------------------------------------------------
Al Viro (2):
      hostfs: fix memory handling in follow_link()
      Make sure nd->path.mnt and nd->path.dentry are always valid pointers

 fs/hostfs/hostfs_kern.c | 7 +++----
 fs/namei.c              | 6 ++++--
 2 files changed, 7 insertions(+), 6 deletions(-)
