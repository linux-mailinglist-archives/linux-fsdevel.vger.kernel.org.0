Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B3DF3AE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 23:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfKGWFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 17:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfKGWFj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:05:39 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F1820679;
        Thu,  7 Nov 2019 22:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573164338;
        bh=cygUg6uzZhrE0QtmMOaogM8YgrVMvUUpNVFQTtn+FhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2ahxXJfpD62ZZyL2kWYVQCil+YiEuYvGM8qrEkDSjEVJjfGgM3GEvh0BPqaKZlR2
         3AK1LyQIj/blgbUFME6KpJ1OgdutTDdk902RgybzDOjQPJjSSRYVTaCtNIbbKUWQO7
         BxkzKA5F71d6dLX4jWeEJPrEmQnD9ad5nJk92Dt0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     darrick.wong@oracle.com, dhowells@redhat.com, jaegeuk@kernel.org,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, victorhsieh@google.com
Subject: [man-pages RFC PATCH] statx.2: document STATX_ATTR_VERITY
Date:   Thu,  7 Nov 2019 14:02:48 -0800
Message-Id: <20191107220248.32025-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191107014420.GD15212@magnolia>
References: <20191107014420.GD15212@magnolia>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document the verity attribute for statx().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 man2/statx.2 | 4 ++++
 1 file changed, 4 insertions(+)

RFC since the kernel patches are currently under review.
The kernel patches can be found here:
https://lkml.kernel.org/linux-fscrypt/20191029204141.145309-1-ebiggers@kernel.org/T/#u

diff --git a/man2/statx.2 b/man2/statx.2
index d2f1b07b8..713bd1260 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -461,6 +461,10 @@ See
 .TP
 .B STATX_ATTR_ENCRYPTED
 A key is required for the file to be encrypted by the filesystem.
+.TP
+.B STATX_ATTR_VERITY
+The file has fs-verity enabled.  It cannot be written to, and all reads from it
+will be verified against a Merkle tree.
 .SH RETURN VALUE
 On success, zero is returned.
 On error, \-1 is returned, and
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

