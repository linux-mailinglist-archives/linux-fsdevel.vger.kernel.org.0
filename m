Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78ED1EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 04:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfJJC4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 22:56:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57082 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfJJC4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:56:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIOcj-0003mo-Dr; Thu, 10 Oct 2019 02:56:17 +0000
Date:   Thu, 10 Oct 2019 03:56:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] a couple of mount fixes
Message-ID: <20191010025617.GE26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	A couple of regressions from work.mount series.

The following changes since commit a3bc18a48e2e678efe62f1f9989902f9cd19e0ff:

  jffs2: Fix mounting under new mount API (2019-09-26 10:26:55 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount3

for you to fetch changes up to 6fcf0c72e4b9360768cf5ef543c4f14c34800ee8:

  vfs: add missing blkdev_put() in get_tree_bdev() (2019-10-09 22:53:57 -0400)

----------------------------------------------------------------
Al Viro (1):
      shmem: fix LSM options parsing

Ian Kent (1):
      vfs: add missing blkdev_put() in get_tree_bdev()

 fs/super.c | 5 ++++-
 mm/shmem.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
