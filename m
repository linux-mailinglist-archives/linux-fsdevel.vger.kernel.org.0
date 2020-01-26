Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 946AA149C44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgAZSZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jan 2020 13:25:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49002 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZSZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jan 2020 13:25:19 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivmaz-002uba-Ms; Sun, 26 Jan 2020 18:25:17 +0000
Date:   Sun, 26 Jan 2020 18:25:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20200126182517.GO23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Fixes a use-after-free in do_last() handling of sysctl_protected_... checks.
UAF normally doesn't happen there, but race with rename() and it becomes possible.

The following changes since commit 508c8772760d4ef9c1a044519b564710c3684fc5:

  fix autofs regression caused by follow_managed() changes (2020-01-15 01:36:46 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to d0cb50185ae942b03c4327be322055d622dc79f6:

  do_last(): fetch directory ->i_mode and ->i_uid before it's too late (2020-01-26 09:31:07 -0500)

----------------------------------------------------------------
Al Viro (1):
      do_last(): fetch directory ->i_mode and ->i_uid before it's too late

 fs/namei.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)
