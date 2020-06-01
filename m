Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E319B1EAC8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgFASiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 14:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgFAShm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:37:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3038C008634
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 11:27:43 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jfp9x-001XBU-OG; Mon, 01 Jun 2020 18:27:41 +0000
Date:   Mon, 1 Jun 2020 19:27:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [git pull] uaccess readdir
Message-ID: <20200601182741.GC23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Finishing the conversion of readdir.c to unsafe_... API;
includes uaccess_{read,write}_begin series by Christophe Leroy.

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.readdir

for you to fetch changes up to 5fb1514164de20ddb21886ffceda4cb54d6538f6:

  readdir.c: get rid of the last __put_user(), drop now-useless access_ok() (2020-05-01 20:29:54 -0400)

----------------------------------------------------------------
Al Viro (3):
      switch readdir(2) to unsafe_copy_dirent_name()
      readdir.c: get compat_filldir() more or less in sync with filldir()
      readdir.c: get rid of the last __put_user(), drop now-useless access_ok()

Christophe Leroy (3):
      uaccess: Add user_read_access_begin/end and user_write_access_begin/end
      uaccess: Selectively open read or write user access
      drm/i915/gem: Replace user_access_begin by user_write_access_begin

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |   5 +-
 fs/readdir.c                                   | 104 ++++++++++++-------------
 include/linux/uaccess.h                        |   8 ++
 kernel/compat.c                                |  12 +--
 kernel/exit.c                                  |  12 +--
 lib/strncpy_from_user.c                        |   4 +-
 lib/strnlen_user.c                             |   4 +-
 lib/usercopy.c                                 |   6 +-
 8 files changed, 80 insertions(+), 75 deletions(-)
