Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3F1F8E67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 08:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgFOGtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 02:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgFOGrN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:13 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEDF207D4;
        Mon, 15 Jun 2020 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=PW9Q9Rza1Ft5d+Y1Xvp+VMcPsWF+aTDSQqNL4AP5hME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6fYrewWRmselqLG9JODA72OGGQjbGxxp8ZbLZyegyMElYHPqyGjvqufdf///qz+e
         uCIzSXfz3k1Hzp+T+k6ESVtG5rl9wzh3f8HtPPYy78gE5m3Lm4ftfqZQqH0RYZRhEA
         r5626n7m50PHZaUhlBHxBj+Qd6D33YDVosaEXEEQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nmP-IX; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/29] fs: fs.h: fix a kernel-doc parameter description
Date:   Mon, 15 Jun 2020 08:46:46 +0200
Message-Id: <e6b1201c3b5fa88085919908f01ea7337d9c9359.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changeset 3b0311e7ca71 ("vfs: track per-sb writeback errors and report them to syncfs")
added a variant of filemap_sample_wb_err(), but it forgot to
rename the arguments at the kernel-doc markup. Fix it.

Fix those warnings:
	./include/linux/fs.h:2845: warning: Function parameter or member 'file' not described in 'file_sample_sb_err'
	./include/linux/fs.h:2845: warning: Excess function parameter 'mapping' description in 'file_sample_sb_err'

Fixes: 3b0311e7ca71 ("vfs: track per-sb writeback errors and report them to syncfs")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c4ab4dc1cd7..7e17ecc461d5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2829,7 +2829,7 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
 
 /**
  * file_sample_sb_err - sample the current errseq_t to test for later errors
- * @mapping: mapping to be sampled
+ * @file: file pointer to be sampled
  *
  * Grab the most current superblock-level errseq_t value for the given
  * struct file.
-- 
2.26.2

