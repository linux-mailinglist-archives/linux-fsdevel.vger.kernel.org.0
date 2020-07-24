Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DAB22C4C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 14:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGXMMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 08:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgGXMMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:12:01 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58141C08C5E1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 05:12:00 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id cq11so5354769pjb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 05:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U1mjdiTf1REytCgM0qXLRwHi12+4iLhjMHz6o0dObf4=;
        b=kiMq1ZWtQnJd4reX4VWrcLsQOtCggJ6Lx8/zqeNQSzQ7hT54ehmC/vMQjFsmcj5Bzl
         vfX6LCyxcL40ZX02qaEmRhcqWquQZcpcm14ND8JtsyogdqAL+HsczyPTJ/86YKvMEITC
         a+14IVbSsKlMoJEklV7JAH9lru+zgeEFcHQouasVGEZpC36HAZ0A8fXzWaPHdHwwh531
         3sgi8AC8myUTqxXOiGCGooXwGHlrL4xx7SKojIoIGoqgllfhRf7ZT072nwliYBJnNjsH
         kgVdv5uGrSMRIfdEbgA6jSqsd00RikhGl/OBLE9V+8itOqdO7bSHm0kJnSbdv6a48pA2
         Wz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U1mjdiTf1REytCgM0qXLRwHi12+4iLhjMHz6o0dObf4=;
        b=H0K/o1UxFxS0WkaZAga5fl2ZgUW8CjteQ+j95j5ydMLO7+o2ETVv+4e6o2TP6MWtWG
         9hamGTk+gBccjLLWj88DoCGhekIASKwZ42/+qwjTp8A4dd/Ajx6+bG2CAfsTHIu4uf49
         EWFyG+OSTi1SE00t0N+Jx4pB7FrEhFTpel06DLA+xjaENE8Kv31o270MUuv5Yd6dJG/c
         VAgKIYpNp0Tk+HwPwI11X6j0oUZ1hkdIXROpi7kxUUoxcpTgUTv1fM4xGwoIe4O+CQBX
         RW0vJCj7mjppr3npwQ+vSpFCNqj0N4Z+TcLs5+Nub3gNQIT7WiNJhBo2tbdRrteBENKN
         /9Eg==
X-Gm-Message-State: AOAM530SpEP2hkZccLMMxwXbEfa+2uTUzsjdZf+sygB2F4hTm7EOpuBe
        x1Al+FK0WrGx6TIhcbIDQjXoamNTKI0=
X-Google-Smtp-Source: ABdhPJxJfhv4J/Z8dONpLYUW4MpGcI1VRHtlxbqb93pVNIkZdbpJQqFPedb6S47261MqborqJwQs/SHfE9o=
X-Received: by 2002:a17:902:c389:: with SMTP id g9mr7645772plg.317.1595592719727;
 Fri, 24 Jul 2020 05:11:59 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:11:42 +0000
In-Reply-To: <20200724121143.1589121-1-satyat@google.com>
Message-Id: <20200724121143.1589121-7-satyat@google.com>
Mime-Version: 1.0
References: <20200724121143.1589121-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v5 6/7] fscrypt: document inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the fscrypt documentation file for inline encryption support.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/fscrypt.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index f5d8b0303ddf..ec81598477fc 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1204,6 +1204,18 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
 buffers regardless of encryption.  Other filesystems, such as ext4 and
 F2FS, have to allocate bounce pages specially for encryption.
 
+Fscrypt is also able to use inline encryption hardware instead of the
+kernel crypto API for en/decryption of file contents.  When possible,
+and if directed to do so (by specifying the 'inlinecrypt' mount option
+for an ext4/F2FS filesystem), it adds encryption contexts to bios and
+uses blk-crypto to perform the en/decryption instead of making use of
+the above read/write path changes.  Of course, even if directed to
+make use of inline encryption, fscrypt will only be able to do so if
+either hardware inline encryption support is available for the
+selected encryption algorithm or CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK
+is selected.  If neither is the case, fscrypt will fall back to using
+the above mentioned read/write path changes for en/decryption.
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
2.28.0.rc0.142.g3c755180ce-goog

