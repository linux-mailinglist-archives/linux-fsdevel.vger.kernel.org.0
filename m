Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36C404443
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 06:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbhIIEZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 00:25:45 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35026 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIIEZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 00:25:44 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOBZu-002TQO-KB; Thu, 09 Sep 2021 04:22:22 +0000
Date:   Thu, 9 Sep 2021 04:22:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] iov_iter fixes
Message-ID: <YTmL/plKyujwhoaR@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Fixes for io-uring handling of iov_iter reexpands

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter

for you to fetch changes up to 89c2b3b74918200e46699338d7bcc19b1ea12110:

  io_uring: reexpand under-reexpanded iters (2021-09-03 19:31:33 -0400)

----------------------------------------------------------------
Pavel Begunkov (2):
      iov_iter: track truncated size
      io_uring: reexpand under-reexpanded iters

 fs/io_uring.c       | 2 ++
 include/linux/uio.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)
