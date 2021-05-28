Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12D393FEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhE1J22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 05:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhE1J21 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 05:28:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CE7E6128B;
        Fri, 28 May 2021 09:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622194013;
        bh=NANZZOD4iHEuG2BalPId6STrno2r5MeN/jIIE747vDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDyLxEYnSx4GtB0UG2fwkQ5Ha17NagcbRiUj2JawID6MhMzQK4MZFK9eG4E+oWVev
         U2Trufc5+Xl6FoKyVHunAI1SjixTIKvJSsqh0dpBpiUIKO7/8ypHeobRgydoSs5fyp
         K81ZX/dmtnYlm46PDGx34srqajyh0Zr5gZ1rtYgI22Fv/b6wZUyQR74F5qAEgGlLz6
         L43NqKTre4jBJIVqaN40QmomYXqYp3izzbE2p+17+UhzbZoIixoDdrxnX80mcRA6oJ
         XLl9hlNaC8mFVt5gxSm7YgJOeR0qjTpeYGe86LbMqX/KcBfr0CLvbCMKoclX2i9vte
         Mv6cMOdaM1v+w==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 1/3] fcntl: remove unused VALID_UPGRADE_FLAGS
Date:   Fri, 28 May 2021 11:24:15 +0200
Message-Id: <20210528092417.3942079-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528092417.3942079-1-brauner@kernel.org>
References: <20210528092417.3942079-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=DTBkIkRNd4bcqOtvuhl7Obc19oP2/yrBuWrgwMlrBXs=; m=jKjin0LP0quJpwA9N7t4NVUj9m+WI4gTZYsJsEIxnU4=; p=1vlusdo5gjwAF0kBP5kBKm1VG2vyL2qLrK4eGEkLgIQ=; g=9d11c722bc61e3dc9015e1ec2b7c3e9cbb3b59e8
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYLC2egAKCRCRxhvAZXjcorauAQDQ9DC AL19EkaqLy6PC1S9Gr+yW2CQYxOYPi+6otEnlRwD+JYt9AcIOOIAKwv8Fgk9vRDvkdPcTw5KxxtS7 4MLX2Q4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

We currently do not maky use of this feature and should we implement
something like this in the future it's trivial to add it back.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Suggested-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 include/linux/fcntl.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 766fcd973beb..a332e79b3207 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,10 +12,6 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
-/* List of all valid flags for the how->upgrade_mask argument: */
-#define VALID_UPGRADE_FLAGS \
-	(UPGRADE_NOWRITE | UPGRADE_NOREAD)
-
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-- 
2.27.0

