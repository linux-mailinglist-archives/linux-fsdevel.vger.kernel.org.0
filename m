Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9829A7CC56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfGaSx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 14:53:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39432 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfGaSx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:53:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hstj5-0002yp-D6; Wed, 31 Jul 2019 18:53:27 +0000
Date:   Wed, 31 Jul 2019 19:53:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git mount_capable() fix
Message-ID: <20190731185327.GV1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Since nobody gave any specific objections and the thing
appears to work...

The following changes since commit 19a1c4092e7ca1ad1a72ac5535f902c483372cd5:

  fix the struct mount leak in umount_tree() (2019-07-26 07:59:06 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to c2c44ec20a8496f7a3b3401c092afe96908eced1:

  Unbreak mount_capable() (2019-07-31 12:22:32 -0400)

----------------------------------------------------------------
Al Viro (1):
      Unbreak mount_capable()

 fs/super.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
