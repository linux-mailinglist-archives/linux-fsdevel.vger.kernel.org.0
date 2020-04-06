Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5FF19FB37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDFRTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 13:19:49 -0400
Received: from nautica.notk.org ([91.121.71.147]:42588 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgDFRTt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:19:49 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9E6C7C01D; Mon,  6 Apr 2020 19:19:47 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH] 9p: document short read behaviour with O_NONBLOCK
Date:   Mon,  6 Apr 2020 19:19:32 +0200
Message-Id: <1586193572-1375-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

Regular files opened with O_NONBLOCK allow read to return after a single
round-trip with the server instead of trying to fill buffer.
Add a few lines in 9p documentation to describe that.

Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
---
 Documentation/filesystems/9p.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/filesystems/9p.txt b/Documentation/filesystems/9p.txt
index fec7144e817c..3fb780ffdf23 100644
--- a/Documentation/filesystems/9p.txt
+++ b/Documentation/filesystems/9p.txt
@@ -133,6 +133,16 @@ OPTIONS
 		cache tags for existing cache sessions can be listed at
 		/sys/fs/9p/caches. (applies only to cache=fscache)
 
+BEHAVIOR
+========
+
+This section aims at describing 9p 'quirks' that can be different
+from a local filesystem behaviors.
+
+ - Setting O_NONBLOCK on a file will make client reads return as early
+   as the server returns some data instead of trying to fill the read
+   buffer with the requested amount of bytes or end of file is reached.
+
 RESOURCES
 =========
 
-- 
2.26.0

