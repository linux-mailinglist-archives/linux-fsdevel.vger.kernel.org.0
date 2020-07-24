Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A56622CE0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGXSpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGXSpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:45:19 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E8AC0619E5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:18 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id gp8so6590852pjb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xyIxbqTzEFkSiRwtwQaLWA16wfxvhvC5m78qlSH1ff0=;
        b=mBULbubnOs99wcWvCkuB8DaDJihSO0xMIW84PX5bW6WTDj309RqVaJPHsyAy2kaKCY
         sOD/egWqVHLZ7OUz7656r6qh6CE0O+9+ekoTB8ggySlZKOVBPFRyQhOpz3iP8O3KzA66
         TlNycAcYS2Bt5YOOhe3NHBNfRzmIluIfVqVEZaOTBNsFH2DN2tFUJgfwzvHk+Cfu4ktE
         Ux2qbNoUcHcJSGpYoyJrtPpZVCLD/G+F6TaLMtwwue8ZozjlRyZ5Pqd2SCUqaAjZRuwa
         2twdFk1AzPx/nwa4i8eqkv4wxZlZ4QpFLnVvKFEWArFlrDNn6OdFdOF+0n5c6jitoG4w
         V/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xyIxbqTzEFkSiRwtwQaLWA16wfxvhvC5m78qlSH1ff0=;
        b=pO5vU0Qx+BBrlA3WlB0UzXRKMqOucX5aM98od16BUwNQZYY33jSuwQH/VZF4aKwQAi
         u5KGUF2789zbuGJn4hE2lBwZ6aSJ6WEooAWrR3p1kn8aR/YJ62/Zwm48hvoNwUJqvzJW
         1/anlyVq98JSIX9a3e37Ohv4Cm6fYIA827DOJB+1kk4NMTweJoP4tni8N3hw9Lazazr8
         xF+eSp0WqCppcSotuwWoPawXnqEs8zlrSL4gUhISr9R+8Dt2R+MhJCEVx+303zgbarz3
         pYexJCeR+4JvAkvICGQQtyF7oXu4z8nWEXnc7614Nk1UoeJo+hA8GA1JyNYj1yPgfKw2
         orEw==
X-Gm-Message-State: AOAM532v2kjWEoxKRkyS8+alHLJ69gPoEjcFsna2YTXVlL4R4yGOusMZ
        TN3KoOxFjCwLJNP6jAMxBod8B0UEJvY=
X-Google-Smtp-Source: ABdhPJzkqIhgfmuH4Tw2HNitGStx6+I2VoJ2h2ZcDf2nCz9kSOHpDDkKAQY+0hH0A++BUEd5FyALMx/aU4Y=
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr1970016pjz.1.1595616317802;
 Fri, 24 Jul 2020 11:45:17 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:45:01 +0000
In-Reply-To: <20200724184501.1651378-1-satyat@google.com>
Message-Id: <20200724184501.1651378-8-satyat@google.com>
Mime-Version: 1.0
References: <20200724184501.1651378-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v6 7/7] fscrypt: update documentation for direct I/O support
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

Update fscrypt documentation to reflect the addition of direct I/O support
and document the necessary conditions for direct I/O on encrypted files.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/fscrypt.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 423c5a0daf45..b9bbd6c612ff 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1049,8 +1049,10 @@ astute users may notice some differences in behavior:
   may be used to overwrite the source files but isn't guaranteed to be
   effective on all filesystems and storage devices.
 
-- Direct I/O is not supported on encrypted files.  Attempts to use
-  direct I/O on such files will fall back to buffered I/O.
+- Direct I/O is supported on encrypted files only under some
+  circumstances (see `Direct I/O support`_ for details). When these
+  circumstances are not met, attempts to use direct I/O on encrypted
+  files will fall back to buffered I/O.
 
 - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
   FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
@@ -1123,6 +1125,20 @@ It is not currently possible to backup and restore encrypted files
 without the encryption key.  This would require special APIs which
 have not yet been implemented.
 
+Direct I/O support
+==================
+
+Direct I/O on encrypted files is supported through blk-crypto. In
+particular, this means the kernel must have CONFIG_BLK_INLINE_ENCRYPTION
+enabled, the filesystem must have had the 'inlinecrypt' mount option
+specified, and either hardware inline encryption must be present, or
+CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK must have been enabled. Further,
+any I/O must be aligned to the filesystem block size (*not* necessarily
+the same as the block device's block size) - in particular, any userspace
+buffer into which data is read/written from must also be aligned to the
+filesystem block size. If any of these conditions isn't met, attempts to do
+direct I/O on an encrypted file will fall back to buffered I/O.
+
 Encryption policy enforcement
 =============================
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

