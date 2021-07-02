Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571FA3B9C83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 08:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhGBG5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 02:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhGBG5X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 02:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1F366141D;
        Fri,  2 Jul 2021 06:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625208892;
        bh=ayeoPIhe+1s08/UaNpC3a37YFzxNe7bjxypfKHgUNos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6Yn1TVluxIn/JJFYkOy5+lRoF9vC12KdanEUnM4zrAZOprYGMps7cdmMLWxJavhD
         mMsIbETp12zPxypnUK3ATnelRJfK/ziY6z+UE8cqwU6O5PwhfIgQwQoU14hm6uLind
         jSCdBg2kpZbttNLOu6/+b5gWEVfB37pTDtV2r6pwVIqmr9j0vEv/C8lO6rTVTUJE70
         vWyUq6mQq8ieMYQzHcrz86OZ2WaGZO9Pqf0r5et/J7ZN9XolFqdOt3blxktv9kqDMn
         X75GJK3n3UB3SvY/yPEU/IFeYTarVVr3ncwxhxGL9/z3fyGvleNhmJpv0MU5ie0DPm
         ykMU84u2xEGUw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] fscrypt: remove mention of symlink st_size quirk from documentation
Date:   Thu,  1 Jul 2021 23:53:50 -0700
Message-Id: <20210702065350.209646-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702065350.209646-1-ebiggers@kernel.org>
References: <20210702065350.209646-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that the correct st_size is reported for encrypted symlinks on all
filesystems, update the documentation accordingly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 44b67ebd6e40..02ec57818920 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1063,11 +1063,6 @@ astute users may notice some differences in behavior:
 
 - DAX (Direct Access) is not supported on encrypted files.
 
-- The st_size of an encrypted symlink will not necessarily give the
-  length of the symlink target as required by POSIX.  It will actually
-  give the length of the ciphertext, which will be slightly longer
-  than the plaintext due to NUL-padding and an extra 2-byte overhead.
-
 - The maximum length of an encrypted symlink is 2 bytes shorter than
   the maximum length of an unencrypted symlink.  For example, on an
   EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
-- 
2.32.0

