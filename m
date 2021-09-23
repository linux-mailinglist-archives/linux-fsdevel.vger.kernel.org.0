Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE7415742
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 05:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhIWEAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 00:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhIWEAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 00:00:54 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBDC061574;
        Wed, 22 Sep 2021 20:59:23 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTFtJ-006aoz-V7; Thu, 23 Sep 2021 03:59:22 +0000
Date:   Thu, 23 Sep 2021 03:59:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] a couple of do_mounts.c followups
Message-ID: <YUv7mXzzl/JxZ6te@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Followups to nodev root stuff from this merge window.

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.init

for you to fetch changes up to 40c8ee67cfc49d00a13ccbf542e307b6b5421ad3:

  init: don't panic if mount_nodev_root failed (2021-09-19 22:24:52 -0400)

----------------------------------------------------------------
Leon Romanovsky (1):
      init: don't panic if mount_nodev_root failed

Vivek Goyal (1):
      init/do_mounts.c: Harden split_fs_names() against buffer overflow

 init/do_mounts.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)
