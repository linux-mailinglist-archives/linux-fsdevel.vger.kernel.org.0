Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C35E407DBD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Sep 2021 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhILONs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhILONs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 10:13:48 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1981AC061574;
        Sun, 12 Sep 2021 07:12:34 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPQDe-003UFn-PU; Sun, 12 Sep 2021 14:12:30 +0000
Date:   Sun, 12 Sep 2021 14:12:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] namei fixes
Message-ID: <YT4KzvXdKg6fJGk3@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Clearing fallout from mkdirat in io_uring series.  The fix in
the kern_path_locked() patch plus associated cleanups.

The following changes since commit 4b93c544e90e2b28326182d31ee008eb80e02074:

  thunderbolt: test: split up test cases in tb_test_credit_alloc_all (2021-09-06 12:27:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git misc.namei

for you to fetch changes up to ea47ab111669b187808b3080602788dec26cb9bc:

  putname(): IS_ERR_OR_NULL() is wrong here (2021-09-07 16:14:05 -0400)

----------------------------------------------------------------
Al Viro (2):
      rename __filename_parentat() to filename_parentat()
      putname(): IS_ERR_OR_NULL() is wrong here

Stephen Brennan (3):
      namei: Fix use after free in kern_path_locked
      namei: Standardize callers of filename_lookup()
      namei: Standardize callers of filename_create()

 fs/fs_parser.c |   1 -
 fs/namei.c     | 116 ++++++++++++++++++++++++++++-----------------------------
 2 files changed, 58 insertions(+), 59 deletions(-)
