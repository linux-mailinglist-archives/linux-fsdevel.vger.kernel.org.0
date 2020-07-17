Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046EB2230B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 03:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGQBqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 21:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGQBpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:45:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229A7C08C5E1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:45:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p22so9530622ybg.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M2BARCIgcttWxNELPw4zNOFpxD9+a8coXLhy2/p7EJA=;
        b=IuienX4mga40GmSRRKzTF+joRBlWaewlilX9kK4DbxKVxKtc0HgNzNmwzCZ1zOSkZS
         /sl4RwiktZzyDIGk22y0rBU4/6to0p2Mb+0sHuOgVc59Of+mmEYUSL/X8GIx7S9N2g7k
         AAsNYq+yOp1P9y/M3dpmzdp+iTmYeg60KNpHeU9Q4DinrRedG6NGSsYmC3G3+ZszcxWF
         iiLyYi1e8fZMhBIQmpfrA1eMen9sCtNU9W9nDP6q6QwGvJa13W8tY3dxZyWvEvjE0cyb
         7vhn6iWIVWyfKhLFtLO/KNWOxq8m9tNiM/Xk00LgFuq+iUFipff48yn3YZCVEhX9KuBH
         cXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M2BARCIgcttWxNELPw4zNOFpxD9+a8coXLhy2/p7EJA=;
        b=tsjCLZgyjLmBiL5H8uwWlVMw7rv07xaP8D2hjdyhur37nnzxUx8bfkkwJquuMly3zj
         /DlWfsp6OtYOKn+TeM4HAFkZ3BEnPYZbcsOg3RqSxs+rXvsmQfRX3gLURY+zgjaDZ/vg
         ucitUaIRqeNR/c5d+SgBnZwBhX9cM+5l6wlU7wRFjP5A9pdWzCp9Xlo8toD2vJM7YOYa
         PGDS9p+QmKgRSqe2TtxOosA5MFbYUMTXJVz3i8dxdjBclu7/Yex6h/5XH0CbcJ+6XGxL
         /kVwSFWIx40kbcnTSUdKWzTDvoMHIkTB0JI+o5eZuhGdT7lTPmSMnpayy8LmqKE6Q5XG
         cSMg==
X-Gm-Message-State: AOAM5323UPFEbG1RezvFsS5lS92cX/8ShmUhziboKMe7vqTXDqs9RSyJ
        hS1NYi2qPT6jdITDztTDkj+OcDCq9OQ=
X-Google-Smtp-Source: ABdhPJxSclWXD3pWyzJ/EO11UCYSucRKXFbMR9YelueZjjlG1f9W2/r7ez0qwF6s0pIusA0evwMmb2iIxEk=
X-Received: by 2002:a25:3789:: with SMTP id e131mr10722971yba.417.1594950354393;
 Thu, 16 Jul 2020 18:45:54 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:45:39 +0000
In-Reply-To: <20200717014540.71515-1-satyat@google.com>
Message-Id: <20200717014540.71515-7-satyat@google.com>
Mime-Version: 1.0
References: <20200717014540.71515-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 6/7] fscrypt: document inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the fscrypt documentation file for inline encryption support.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/filesystems/fscrypt.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index f5d8b0303ddf..f3d87a1a0a7f 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1204,6 +1204,18 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
 buffers regardless of encryption.  Other filesystems, such as ext4 and
 F2FS, have to allocate bounce pages specially for encryption.
 
+Fscrypt is also able to use inline encryption hardware instead of the
+kernel crypto API for en/decryption of file contents.  When possible, and
+if directed to do so (by specifying the 'inlinecrypt' mount option for
+an ext4/F2FS filesystem), it adds encryption contexts to bios and
+uses blk-crypto to perform the en/decryption instead of making use
+of the above read/write path changes.  Of course, even if directed to make
+use of inline encryption, fscrypt will only be able to do so if either
+hardware inline encryption support is available for the selected encryption
+algorithm or CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is selected.  If neither
+is the case, fscrypt will fall back to using the above mentioned read/write
+path changes for en/decryption.
+
 Filename hashing and encoding
 -----------------------------
 
@@ -1250,7 +1262,9 @@ Tests
 
 To test fscrypt, use xfstests, which is Linux's de facto standard
 filesystem test suite.  First, run all the tests in the "encrypt"
-group on the relevant filesystem(s).  For example, to test ext4 and
+group on the relevant filesystem(s).  One can also run the tests
+with the 'inlinecrypt' mount option to test the implementation for
+inline encryption support.  For example, to test ext4 and
 f2fs encryption using `kvm-xfstests
 <https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md>`_::
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog

