Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19AA18883D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 15:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCQOyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 10:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgCQOyc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:32 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D129F20776;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456871;
        bh=pYqp3V8om86FL58tAYcy6HsVElUzQYABiLF0qnOWlC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07qH0UhQsX0hroFfzEaKuj11efC4g1D2sIfqA+D3VgoiszOAc9F2VaRSSGeV49sBT
         /bQxjNI2Mkyd2jbJuP3cEGCH95uVXUVL2fa+rltoMwaWUzQgzkg03Pq5IaSDViWj5U
         A0ks+hEZqxq1IH6zJQZkP2+/8Jlcac5rKtxrchlQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000ANN-VB; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/17] fs: inode.c: get rid of docs warnings
Date:   Tue, 17 Mar 2020 15:54:25 +0100
Message-Id: <11e32eed47d0c6604ae0d9d3f56d6ee0a2af786a.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
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
2.24.1

