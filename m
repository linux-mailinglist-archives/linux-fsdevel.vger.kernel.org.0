Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0337B22C4D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGXMMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 08:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgGXMME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:12:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36AC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 05:12:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j187so10174644ybj.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j09FJFOs7ox27oQ/jw0Hg/h+WWOfzzYjATzxUrwtjag=;
        b=uinx4umNBzjZNhDldRFu/4q/KRDj/aDyTI/UPTsQCLp9QNIT/Pkx3JVsXg/gNYy18X
         8fzYbL2l+0BjejTs82TRocYlvCmHfn64VAHgBtAoxl223aUkRG3nBLgaaC3G9xOT+Ee1
         rnavYw4RFQWWpr4kEAgcyApl0DBMmQqQ425gWWhdRZjgy/8fQlCPdngERjFBN7JGM4dr
         U8tyJmjfakSMtKlyzL3/ej5FMsNjZGA0nrRghc67idy4m8GhAjIfh7Nj6B8JlxuCnCUI
         kVLkYfz/3ijWwgCZz1ul3FHiFmKsgTc48xkeKY1rm28DffqkcvD9qA1RRrydNx89Ft+E
         K0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j09FJFOs7ox27oQ/jw0Hg/h+WWOfzzYjATzxUrwtjag=;
        b=bF9gQqZN5kz037rDToVGjDFaCmBbFFaaPTN6YMZlEOH2j0uMyhJ/Adn3c73IjZEUgc
         NNV0PLSrZpgnzb9+sSuCDSVqKDHGuMheqOWMiKwuo9AgA+q+arY8cwWcgK5fU2hUcaa5
         Xv8cTOlYyxEa5GONKmcDtUeOP9ddz+eBkNPX9RZkr0eJjQ06XrY87gLpmqN9I8dadABd
         mlxqllg1KpuCBzV6CstbcoKPrxpxwQ5mxdmyaTW2qGJk0wmXVmGCWJKz+m/7BEIVd6TX
         teYaog0YMVACk3gBauz9T4lluct5A/ZFGFO/Vn3ODmoyMkaFxelfgRNk/URB1shwTyre
         u3Cg==
X-Gm-Message-State: AOAM532DbKhEoJ47u6hNetlf9UvgwHhVjrJbqOh6Zfm4JaY+x9bQI8SD
        atZ2hui4rhpeFFamVvJ92ujwlRTqFOk=
X-Google-Smtp-Source: ABdhPJx/kR9OGGrb08Cms1pOt8vKHYWUtxe5tDqnionkhbA71lMBxyPqAWtadG1S0CUcqUHbUujo0btmzCE=
X-Received: by 2002:a25:385:: with SMTP id 127mr14857247ybd.141.1595592721412;
 Fri, 24 Jul 2020 05:12:01 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:11:43 +0000
In-Reply-To: <20200724121143.1589121-1-satyat@google.com>
Message-Id: <20200724121143.1589121-8-satyat@google.com>
Mime-Version: 1.0
References: <20200724121143.1589121-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v5 7/7] fscrypt: update documentation for direct I/O support
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
index ec81598477fc..5367c03b17bb 100644
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

