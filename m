Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6C42065C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfEPLwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfEPLwW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:52:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C61730BB557;
        Thu, 16 May 2019 11:52:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5DA619733;
        Thu, 16 May 2019 11:52:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/4] uapi,
 fsopen: use square brackets around "fscontext" [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        christian@brauner.io, arnd@arndb.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 May 2019 12:52:20 +0100
Message-ID: <155800754023.4037.16467196300711376052.stgit@warthog.procyon.org.uk>
In-Reply-To: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 16 May 2019 11:52:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian@brauner.io>

Make the name of the anon inode fd "[fscontext]" instead of "fscontext".
This is minor but most core-kernel anon inode fds already carry square
brackets around their name:

[eventfd]
[eventpoll]
[fanotify]
[io_uring]
[pidfd]
[signalfd]
[timerfd]
[userfaultfd]

For the sake of consistency lets do the same for the fscontext anon inode
fd that comes with the new mount api.

Signed-off-by: Christian Brauner <christian@brauner.io>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsopen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index a38fa8c616cf..83d0d2001bb2 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -92,7 +92,7 @@ static int fscontext_create_fd(struct fs_context *fc)
 {
 	int fd;
 
-	fd = anon_inode_getfd("fscontext", &fscontext_fops, fc,
+	fd = anon_inode_getfd("[fscontext]", &fscontext_fops, fc,
 			      O_RDWR | O_CLOEXEC);
 	if (fd < 0)
 		put_fs_context(fc);

