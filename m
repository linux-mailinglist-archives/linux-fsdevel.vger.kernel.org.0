Return-Path: <linux-fsdevel+bounces-4922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF21980650A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 03:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B561F20F05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 02:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D812D5CB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XL01WMkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808FDD43
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 18:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tcVvLkeARznKJ7I7W64h2n3ZsVMIzw772g6N9dL5GAw=; b=XL01WMkKeJ6dx2DnR9vQJhp3N/
	ikux01UkNhdvzXtY47ASaZR/OA/nkcRG3GsUYJ04BVVEJFLRqoGz6GK4/rj/2UzFwamifvyjwtS1u
	m+GrYuN8I1BXkzgAvMC37LlMXfUAh55NUIh3N++K2R2TNn5WachvzEgIdpKcBJfgHEqUegj+gPSWW
	vzH7g+SfUSXmg8J5CTrECln2w1WsX9vMSOUSFvcectDN71lVX6QWba5tva7WABYl2V5gtK1uHiLeY
	/QUqEl7OaXkRzAYPrtQBeF2F70hD3kuiZ3le/VaLxcxiOSfyyq8baEd6V53jzZ4Dx4xDG8Yp2FnlT
	x8rvAyqg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAhju-008tRM-16;
	Wed, 06 Dec 2023 02:34:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] befs: fix datastream.c kernel-doc warnings
Date: Tue,  5 Dec 2023 18:34:17 -0800
Message-ID: <20231206023417.30323-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings found when using "W=1".

datastream.c:51: warning: No description found for return value of 'befs_read_datastream'
datastream.c:97: warning: No description found for return value of 'befs_fblock2brun'
datastream.c:132: warning: expecting prototype for befs_read_lsmylink(). Prototype was for befs_read_lsymlink() instead
datastream.c:132: warning: No description found for return value of 'befs_read_lsymlink'
datastream.c:173: warning: No description found for return value of 'befs_count_blocks'
datastream.c:253: warning: No description found for return value of 'befs_find_brun_direct'
datastream.c:309: warning: No description found for return value of 'befs_find_brun_indirect'
datastream.c:418: warning: No description found for return value of 'befs_find_brun_dblindirect'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>
Cc: Salah Triki <salah.triki@gmail.com>
---
 fs/befs/datastream.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff -- a/fs/befs/datastream.c b/fs/befs/datastream.c
--- a/fs/befs/datastream.c
+++ b/fs/befs/datastream.c
@@ -42,7 +42,7 @@ static int befs_find_brun_dblindirect(st
  * @pos: start of data
  * @off: offset of data in buffer_head->b_data
  *
- * Returns pointer to buffer_head containing data starting with offset @off,
+ * Returns: pointer to buffer_head containing data starting with offset @off,
  * if you don't need to know offset just set @off = NULL.
  */
 struct buffer_head *
@@ -86,7 +86,7 @@ befs_read_datastream(struct super_block
  * Takes a file position and gives back a brun who's starting block
  * is block number fblock of the file.
  *
- * Returns BEFS_OK or BEFS_ERR.
+ * Returns: BEFS_OK or BEFS_ERR.
  *
  * Calls specialized functions for each of the three possible
  * datastream regions.
@@ -118,13 +118,13 @@ befs_fblock2brun(struct super_block *sb,
 }
 
 /**
- * befs_read_lsmylink - read long symlink from datastream.
+ * befs_read_lsymlink - read long symlink from datastream.
  * @sb: Filesystem superblock
  * @ds: Datastream to read from
  * @buff: Buffer in which to place long symlink data
  * @len: Length of the long symlink in bytes
  *
- * Returns the number of bytes read
+ * Returns: the number of bytes read
  */
 size_t
 befs_read_lsymlink(struct super_block *sb, const befs_data_stream *ds,
@@ -166,6 +166,8 @@ befs_read_lsymlink(struct super_block *s
  * inode occupies on the filesystem, counting both regular file
  * data and filesystem metadata (and eventually attribute data
  * when we support attributes)
+ *
+ * Returns: count of blocks used by the file
 */
 
 befs_blocknr_t
@@ -229,8 +231,7 @@ befs_count_blocks(struct super_block *sb
  * in the file represented by the datastream data, if that
  * blockno is in the direct region of the datastream.
  *
- * Return value is BEFS_OK if the blockrun is found, BEFS_ERR
- * otherwise.
+ * Returns: BEFS_OK if the blockrun is found, BEFS_ERR otherwise.
  *
  * Algorithm:
  * Linear search. Checks each element of array[] to see if it
@@ -290,8 +291,7 @@ befs_find_brun_direct(struct super_block
  * in the file represented by the datastream data, if that
  * blockno is in the indirect region of the datastream.
  *
- * Return value is BEFS_OK if the blockrun is found, BEFS_ERR
- * otherwise.
+ * Returns: BEFS_OK if the blockrun is found, BEFS_ERR otherwise.
  *
  * Algorithm:
  * For each block in the indirect run of the datastream, read
@@ -381,8 +381,7 @@ befs_find_brun_indirect(struct super_blo
  * in the file represented by the datastream data, if that
  * blockno is in the double-indirect region of the datastream.
  *
- * Return value is BEFS_OK if the blockrun is found, BEFS_ERR
- * otherwise.
+ * Returns: BEFS_OK if the blockrun is found, BEFS_ERR otherwise.
  *
  * Algorithm:
  * The block runs in the double-indirect region are different.

