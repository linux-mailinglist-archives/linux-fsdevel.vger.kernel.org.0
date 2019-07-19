Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8616D974
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 05:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfGSDqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 23:46:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56578 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSDqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:46:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoJqO-0007U5-7g; Fri, 19 Jul 2019 03:46:04 +0000
Date:   Fri, 19 Jul 2019 04:46:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc
Message-ID: <20190719034604.GZ17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Assorted stuff.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 02e5ad973883c36c0868b301b8357d9c455bb91c:

  perf_event_get(): don't bother with fget_raw() (2019-06-26 20:43:53 -0400)

----------------------------------------------------------------
Al Viro (1):
      perf_event_get(): don't bother with fget_raw()

Ian Kent (1):
      vfs: update d_make_root() description

 Documentation/filesystems/porting | 15 +++++++++++++--
 kernel/events/core.c              |  4 +---
 2 files changed, 14 insertions(+), 5 deletions(-)
