Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E76BA6D971
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 05:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfGSDpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 23:45:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56568 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSDpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:45:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoJpb-0007Rf-JI; Fri, 19 Jul 2019 03:45:15 +0000
Date:   Fri, 19 Jul 2019 04:45:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git adfs patches
Message-ID: <20190719034515.GY17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	More ADFS patches from rmk.

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.adfs

for you to fetch changes up to b4ed8f75c82876342b3399942427392ba5f3bbb5:

  fs/adfs: add time stamp and file type helpers (2019-06-26 20:14:14 -0400)

----------------------------------------------------------------
Russell King (12):
      fs/adfs: correct disc record structure
      fs/adfs: add helper to get discrecord from map
      fs/adfs: add helper to get filesystem size
      fs/adfs: use format_version from disc_record
      fs/adfs: use %pV for error messages
      fs/adfs: clean up error message printing
      fs/adfs: clean up indirect disc addresses and fragment IDs
      fs/adfs: super: correct superblock flags
      fs/adfs: super: safely update options on remount
      fs/adfs: super: fix use-after-free bug
      fs/adfs: super: limit idlen according to directory type
      fs/adfs: add time stamp and file type helpers

 fs/adfs/adfs.h               |  70 ++++++++++++++++---------
 fs/adfs/dir.c                |  25 ++++-----
 fs/adfs/dir_f.c              |  38 ++++++--------
 fs/adfs/dir_fplus.c          |  21 ++++----
 fs/adfs/inode.c              |  12 ++---
 fs/adfs/map.c                |  15 ++----
 fs/adfs/super.c              | 121 +++++++++++++++++++++++++------------------
 include/uapi/linux/adfs_fs.h |   6 +--
 8 files changed, 164 insertions(+), 144 deletions(-)
