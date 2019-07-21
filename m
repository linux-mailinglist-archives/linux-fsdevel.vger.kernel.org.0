Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2B6F159
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jul 2019 05:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfGUDUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jul 2019 23:20:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57644 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfGUDUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jul 2019 23:20:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hp2OH-00079s-4f; Sun, 21 Jul 2019 03:20:03 +0000
Date:   Sun, 21 Jul 2019 04:20:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] typo fix
Message-ID: <20190721031957.GE17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 02e5ad973883c36c0868b301b8357d9c455bb91c:

  perf_event_get(): don't bother with fget_raw() (2019-06-26 20:43:53 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 1b03bc5c116383b8bc099e8d60978c379196a687:

  typo fix: it's d_make_root, not d_make_inode... (2019-07-20 23:17:30 -0400)

----------------------------------------------------------------
Al Viro (1):
      typo fix: it's d_make_root, not d_make_inode...

 Documentation/filesystems/porting | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
