Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8078B1F5D3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFJUda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJUda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:33:30 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02337C03E96B;
        Wed, 10 Jun 2020 13:33:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jj7Pc-006dH5-1x; Wed, 10 Jun 2020 20:33:28 +0000
Date:   Wed, 10 Jun 2020 21:33:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] a bit of epoll stuff
Message-ID: <20200610203328.GX23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	epoll conversion to read_iter from Jens; I thought there might be
more epoll stuff this cycle, but uaccess took too much time.  It might
as well have sat in #work.misc, but I didn't want to rebase for no good
reason...

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll

for you to fetch changes up to 12aceb89b0bce19eb89735f9de7a9983e4f0adae:

  eventfd: convert to f_op->read_iter() (2020-05-06 22:33:43 -0400)

----------------------------------------------------------------
Jens Axboe (1):
      eventfd: convert to f_op->read_iter()

 fs/eventfd.c | 64 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 26 deletions(-)
