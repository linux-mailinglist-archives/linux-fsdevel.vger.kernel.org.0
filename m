Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF43E371E9F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhECRbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 13:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhECRbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 13:31:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE1FC06174A;
        Mon,  3 May 2021 10:30:08 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ldcOR-00AhwI-AN; Mon, 03 May 2021 17:30:03 +0000
Date:   Mon, 3 May 2021 17:30:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] #work.file
Message-ID: <YJAzG9Xur8Dk1OnY@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Cleanup of receive_fd mess.

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.file

for you to fetch changes up to 42eb0d54c08a0331d6d295420f602237968d792b:

  fs: split receive_fd_replace from __receive_fd (2021-04-16 00:13:04 -0400)

----------------------------------------------------------------
Christoph Hellwig (1):
      fs: split receive_fd_replace from __receive_fd

 fs/file.c            | 39 +++++++++++++++++++--------------------
 include/linux/file.h | 11 ++++-------
 kernel/seccomp.c     | 17 ++++++++++++-----
 3 files changed, 35 insertions(+), 32 deletions(-)
