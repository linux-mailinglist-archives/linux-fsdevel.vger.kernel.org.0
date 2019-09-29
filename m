Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E59C192C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2019 21:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfI2TmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Sep 2019 15:42:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54296 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbfI2TmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Sep 2019 15:42:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEf4z-0000et-Bc; Sun, 29 Sep 2019 19:42:01 +0000
Date:   Sun, 29 Sep 2019 20:42:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [git pull] a couple of misc patches
Message-ID: <20190929194201.GC26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 473ef57ad8edc25efd083a583a5f6604b47d3822:

  afs dynroot: switch to simple_dir_operations (2019-09-15 12:19:48 -0400)

----------------------------------------------------------------
Al Viro (1):
      afs dynroot: switch to simple_dir_operations

Valdis Kletnieks (1):
      fs/handle.c - fix up kerneldoc

 fs/afs/dynroot.c  | 7 -------
 fs/afs/inode.c    | 2 +-
 fs/afs/internal.h | 1 -
 fs/fhandle.c      | 2 +-
 4 files changed, 2 insertions(+), 10 deletions(-)
