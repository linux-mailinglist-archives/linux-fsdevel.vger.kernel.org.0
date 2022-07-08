Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E803956B036
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 03:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiGHBnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 21:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiGHBm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:42:59 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB65973580;
        Thu,  7 Jul 2022 18:42:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 0FCD41007DA;
        Fri,  8 Jul 2022 11:42:56 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4nyuI2736-md; Fri,  8 Jul 2022 11:42:56 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 04CF61005DD; Fri,  8 Jul 2022 11:42:56 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 757C410005B;
        Fri,  8 Jul 2022 11:42:55 +1000 (AEST)
Subject: [PATCH 0/5] autofs: misc patches
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Jul 2022 09:42:55 +0800
Message-ID: <165724445154.30914.10970894936827635879.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series contains several patches that resulted mostly from comments
made by Al Viro (quite a long time ago now).

They are:
- make use of the .permission() method for access checks.
- use dentry info count instead of simple_empty() to avoid
  taking a spinlock.
- add a use cases comment to autofs_mountpoint_changed().

Others:
- fix usage consistency problem with dentry info count.
- remove unused inode field from info struct.

Signed-off-by: Ian Kent <raven@themaw.net>
---

Ian Kent (5):
      autofs: use inode permission method for write access
      autofs: make dentry info count consistent
      autofs: use dentry info count instead of simple_empty()
      autofs: add comment about autofs_mountpoint_changed()
      autofs: remove unused ino field inode


 fs/autofs/autofs_i.h |   7 ++-
 fs/autofs/expire.c   |   2 +-
 fs/autofs/inode.c    |   1 +
 fs/autofs/root.c     | 108 ++++++++++++++++++++-----------------------
 4 files changed, 57 insertions(+), 61 deletions(-)

--
Ian

