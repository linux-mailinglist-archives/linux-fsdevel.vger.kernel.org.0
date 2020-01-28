Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C39914C0E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 20:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgA1TZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 14:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgA1TZh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:25:37 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA6C2467E;
        Tue, 28 Jan 2020 19:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580239536;
        bh=M3Y7uG3L87hHEIblJRkwGCUrIWxfUyUuQcFB65l6IOU=;
        h=From:To:Cc:Subject:Date:From;
        b=wTXco5V78aTgUxIfwidPR1INdxREciyqDqF7/pont4zqUkKXRrsNfKNTjuIRuIHZi
         HsblQFNH95dkMKqBw5aclAbH+itf7iLvYRjERPOvlbxYPyvh1sZPAml/cAuxvPEZN8
         trvb/I0cedRqTxCE15eKdSyDtZLYoF5gFJyGdWOI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [man-pages PATCH v2] statx.2: document STATX_ATTR_VERITY
Date:   Tue, 28 Jan 2020 11:24:49 -0800
Message-Id: <20200128192449.260550-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document the verity attribute for statx(), which was added in
Linux 5.5.

For more context, see the fs-verity documentation:
https://www.kernel.org/doc/html/latest/filesystems/fsverity.html

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 man2/statx.2 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man2/statx.2 b/man2/statx.2
index d2f1b07b8..d015ee73d 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -461,6 +461,11 @@ See
 .TP
 .B STATX_ATTR_ENCRYPTED
 A key is required for the file to be encrypted by the filesystem.
+.TP
+.B STATX_ATTR_VERITY
+Since Linux 5.5: the file has fs-verity enabled.  It cannot be written to, and
+all reads from it will be verified against a cryptographic hash that covers the
+entire file, e.g. via a Merkle tree.
 .SH RETURN VALUE
 On success, zero is returned.
 On error, \-1 is returned, and
-- 
2.25.0.341.g760bfbb309-goog

