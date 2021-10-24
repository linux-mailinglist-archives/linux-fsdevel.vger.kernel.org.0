Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4E438B4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 20:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJXSPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Oct 2021 14:15:54 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:36242 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJXSPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:15:54 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mehxm-00Eyyz-Q0; Sun, 24 Oct 2021 18:11:18 +0000
Date:   Sun, 24 Oct 2021 18:11:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] autofs braino fix
Message-ID: <YXWhxthSSQgLryOk@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Fix for a braino of mine (in getting rid of open-coded dentry_path_raw()
in autofs a couple of cycles ago).  Mea culpa...  An obvious -stable fodder.

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 25f54d08f12feb593e62cc2193fedefaf7825301:

  autofs: fix wait name hash calculation in autofs_wait() (2021-10-20 21:09:02 -0400)

----------------------------------------------------------------
Ian Kent (1):
      autofs: fix wait name hash calculation in autofs_wait()

 fs/autofs/waitq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
