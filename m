Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3F404470
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 06:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhIIE0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 00:26:55 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35036 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIIE0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 00:26:55 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOBdB-002TSy-GX; Thu, 09 Sep 2021 04:25:45 +0000
Date:   Thu, 9 Sep 2021 04:25:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] root filesystem type handling series
Message-ID: <YTmMyUnlqjvIB/rr@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Teaching init/do_mounts.c to handle non-block filesystems, hopefully
preventing even more special-cased kludges (such as root=/dev/nfs, etc.)

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.init

for you to fetch changes up to 6e7c1770a212239e88ec01ddc7a741505bfd10e5:

  fs: simplify get_filesystem_list / get_all_fs_names (2021-08-23 01:25:40 -0400)

----------------------------------------------------------------
Christoph Hellwig (3):
      init: split get_fs_names
      init: allow mounting arbitrary non-blockdevice filesystems as root
      fs: simplify get_filesystem_list / get_all_fs_names

 fs/filesystems.c   | 27 ++++++++++------
 include/linux/fs.h |  2 +-
 init/do_mounts.c   | 90 +++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 83 insertions(+), 36 deletions(-)
