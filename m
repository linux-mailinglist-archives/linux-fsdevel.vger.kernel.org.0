Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC9D404477
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 06:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350147AbhIIE2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 00:28:09 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35066 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIIE2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 00:28:09 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOBeN-002TUI-GT; Thu, 09 Sep 2021 04:26:59 +0000
Date:   Thu, 9 Sep 2021 04:26:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] gfs2 setattr patches
Message-ID: <YTmNE6/yK5Q+OIAb@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.gfs2

for you to fetch changes up to d75b9fa053e4cd278281386d860c26fdbfbe9d03:

  gfs2: Switch to may_setattr in gfs2_setattr (2021-08-13 00:41:05 -0400)

----------------------------------------------------------------
Andreas Gruenbacher (2):
      fs: Move notify_change permission checks into may_setattr
      gfs2: Switch to may_setattr in gfs2_setattr

 fs/attr.c          | 50 +++++++++++++++++++++++++++++++-------------------
 fs/gfs2/inode.c    |  4 ++--
 include/linux/fs.h |  2 ++
 3 files changed, 35 insertions(+), 21 deletions(-)
