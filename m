Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3ED1FAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 06:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfJJEbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 00:31:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57944 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfJJEbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:31:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIQ6r-00066u-0q; Thu, 10 Oct 2019 04:31:29 +0000
Date:   Thu, 10 Oct 2019 05:31:29 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] dcache_readdir() fixes
Message-ID: <20191010043128.GF26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	The couple of patches you'd been OK with; no hlist
conversion yet, and cursors are still in the list of children.

The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

for you to fetch changes up to 26b6c984338474b7032a3f1ee28e9d7590c225db:

  libfs: take cursors out of list when moving past the end of directory (2019-10-09 22:57:30 -0400)

----------------------------------------------------------------
Al Viro (2):
      Fix the locking in dcache_readdir() and friends
      libfs: take cursors out of list when moving past the end of directory

 fs/libfs.c | 137 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 71 insertions(+), 66 deletions(-)
