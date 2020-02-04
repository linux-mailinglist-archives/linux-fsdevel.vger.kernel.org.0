Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A968A151CC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 16:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBDPAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 10:00:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52392 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgBDPAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:00:17 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyzgV-007F28-EN; Tue, 04 Feb 2020 15:00:15 +0000
Date:   Tue, 4 Feb 2020 15:00:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [put pull] timestamp stuff
Message-ID: <20200204150015.GR23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	More 64bit timestamp work

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git imm.timestamp

for you to fetch changes up to f0f3588f7a95bb8e02b0f8f5138efb7064665730:

  kernfs: don't bother with timestamp truncation (2019-12-08 19:10:57 -0500)

----------------------------------------------------------------
Al Viro (1):
      kernfs: don't bother with timestamp truncation

Amir Goldstein (1):
      utimes: Clamp the timestamps in notify_change()

Deepa Dinamani (6):
      fs: fat: Eliminate timespec64_trunc() usage
      fs: cifs: Delete usage of timespec64_trunc
      fs: ceph: Delete timespec64_trunc() usage
      fs: ubifs: Eliminate timespec64_trunc() usage
      fs: Delete timespec64_trunc()
      fs: Do not overload update_time

 fs/attr.c            | 23 +++++++++++------------
 fs/ceph/mds_client.c |  4 +---
 fs/cifs/inode.c      | 13 +++++++------
 fs/configfs/inode.c  |  9 +++------
 fs/f2fs/file.c       | 18 ++++++------------
 fs/fat/misc.c        | 10 +++++++++-
 fs/inode.c           | 33 +++------------------------------
 fs/kernfs/inode.c    |  6 +++---
 fs/ntfs/inode.c      | 18 ++++++------------
 fs/ubifs/file.c      | 18 ++++++------------
 fs/ubifs/sb.c        | 11 ++++-------
 fs/utimes.c          |  4 ++--
 include/linux/fs.h   |  1 -
 13 files changed, 61 insertions(+), 107 deletions(-)
