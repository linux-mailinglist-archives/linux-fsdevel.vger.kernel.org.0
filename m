Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591A31A8600
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502476AbgDNQxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 12:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440340AbgDNQtQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:16 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42236221F6;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=HotOvguNSrEPHftfF9hKyBfJBsne6Ihdoy/T4tXbhYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prVWUfSoL29beoF3B8BnWxinw0hgTYZ9QutzwrR5I+mcnioelfXrouule3uEC+8r5
         8/ZE53E7GLZhJxItuhFPRr1px26DEdXpmaj99q8plWyON67f+8mLBpAeEyl33tY5b2
         VQAWbSypRYasYtJaQq8C3MxOFRFyK5GDv81Na4Rc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068nN-Hg; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 31/33] fs: inode.c: get rid of docs warnings
Date:   Tue, 14 Apr 2020 18:48:57 +0200
Message-Id: <e8da46a0e57f2af6d63a0c53665495075698e28a.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use *foo makes the toolchain to think that this is an emphasis, causing
those warnings:

	./fs/inode.c:1609: WARNING: Inline emphasis start-string without end-string.
	./fs/inode.c:1609: WARNING: Inline emphasis start-string without end-string.
	./fs/inode.c:1615: WARNING: Inline emphasis start-string without end-string.

So, use, instead, ``*foo``, in order to mark it as a literal block.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 93d9252a00ab..37226a9cfa4f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1606,14 +1606,14 @@ EXPORT_SYMBOL(iput);
  *	@inode:  inode owning the block number being requested
  *	@block: pointer containing the block to find
  *
- *	Replaces the value in *block with the block number on the device holding
+ *	Replaces the value in ``*block`` with the block number on the device holding
  *	corresponding to the requested block number in the file.
  *	That is, asked for block 4 of inode 1 the function will replace the
- *	4 in *block, with disk block relative to the disk start that holds that
+ *	4 in ``*block``, with disk block relative to the disk start that holds that
  *	block of the file.
  *
  *	Returns -EINVAL in case of error, 0 otherwise. If mapping falls into a
- *	hole, returns 0 and *block is also set to 0.
+ *	hole, returns 0 and ``*block`` is also set to 0.
  */
 int bmap(struct inode *inode, sector_t *block)
 {
-- 
2.25.2

