Return-Path: <linux-fsdevel+bounces-4926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA58C806641
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 05:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40DB1C2097F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B9C10785
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KgF5wg0F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB2A129
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 18:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=26A3YHjICnDcH88vC6VbljrhakN/zxAeim86TOcMSOg=; b=KgF5wg0FnDsCqDGbCUNgGZs6SX
	yZKFNzk19SoRM9ixr3ky9W0fsmAe9DxsQ0nqIJe8AQfFqOLvt8Vpgh7tNakMSDleIfX+f0PV3hKDZ
	Nq5W34mmHtTQNl/4ygs2GEGHQBwwvAXfykBVwFnDJgTYFc/OAtUVcOTTrVPPqAHvkTN15HRXjT0+x
	8JT42T5YytjXLvOB0UnZlhzlwRRXu8nPYx5HjO0mCdeE6LoVjwO7zcHFZI2RnBL34AT+s9JMhsIgX
	J5HjJgy5dsytPfgDViXHJQIjNIQQyrfNcq57KNY3hGh7grNe8hVXMh9tARCVfm+Vi9VrluwYoffw5
	AvbcPGqg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAhsc-008uHC-1P;
	Wed, 06 Dec 2023 02:43:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs/hfsplus: wrapper.c: fix kernel-doc warnings
Date: Tue,  5 Dec 2023 18:43:17 -0800
Message-ID: <20231206024317.31020-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings found when using "W=1".

wrapper.c:48: warning: No description found for return value of 'hfsplus_submit_bio'
wrapper.c:49: warning: Function parameter or member 'opf' not described in 'hfsplus_submit_bio'
wrapper.c:49: warning: Excess function parameter 'op' description in 'hfsplus_submit_bio'
wrapper.c:49: warning: Excess function parameter 'op_flags' description in 'hfsplus_submit_bio'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 fs/hfsplus/wrapper.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -- a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -30,8 +30,7 @@ struct hfsplus_wd {
  * @sector: block to read or write, for blocks of HFSPLUS_SECTOR_SIZE bytes
  * @buf: buffer for I/O
  * @data: output pointer for location of requested data
- * @op: direction of I/O
- * @op_flags: request op flags
+ * @opf: request op flags
  *
  * The unit of I/O is hfsplus_min_io_size(sb), which may be bigger than
  * HFSPLUS_SECTOR_SIZE, and @buf must be sized accordingly. On reads
@@ -43,6 +42,8 @@ struct hfsplus_wd {
  * that starts at the rounded-down address. As long as the data was
  * read using hfsplus_submit_bio() and the same buffer is used things
  * will work correctly.
+ *
+ * Returns: %0 on success else -errno code
  */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 		       void *buf, void **data, blk_opf_t opf)

