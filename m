Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D09227319
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 01:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGTXhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 19:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgGTXhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:37:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DF5C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j187so23373050ybj.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tw1KSRy/RGzW6ODk14gxzXMD1U63GyiUElKhvIibFKY=;
        b=k8+Ro/5x2Ds8e0bES/Bb+gDgCsnAADAIatjX0/1CBooykk5yihxlBcIPwIcH6hmIYe
         LXgaXg/vkkL9UXUHnDN0Z16DVY30zb2O41Pj/zsIcvsEDFvUeh5T3DucRY+6nxj01rVB
         SppvAXKyX1R0ewJnMIzP2HjuGgOd8T6KlcKrlcqZ+zdIBP210H86tZep7DVnjl24c1Be
         V9iOt9olg4hyXctpV5dJKKGEllcPDEJN+83bpBc2oIzIjScqOJDN7uFyJWR9k5QzLhMA
         g3CYGpZ6o3eNDf0h80e0YqabZFQXqa3RFVY12xkp7VFhtkZqBpKwU6Rsh4Lo+tyYM4tZ
         XTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tw1KSRy/RGzW6ODk14gxzXMD1U63GyiUElKhvIibFKY=;
        b=Vp8oHRH/kECe+B742BmVK5KB1Npof8SxZuX8OZQrZoz2Izd16X5VBuAFxkOCkn4Mk4
         zPOhv6qWBmSdzyM5ylKw4hQlp+ZFcz7wdwz38G57R5pZlevZgKPj2JmAT/X8u/WgSF0q
         PVZdaM5t4AeuXnYeXN9ZqB4D/vVUxndF6ilIbot4vTQQ0Yei4j38C0YfHkU0COq4zrGs
         RmYKShLG2PQ7DUYPlOp1fIQ8ag67t6PZA++tX741Njahv7buS4ZtFtiGjf/QMLW7P6iP
         EpmXIyTdB9LZylMUmEQJS4/sETaYn1MBqvjB4YYb8+buNNu0nZIswSpzFICPsoFY5ccf
         C/AQ==
X-Gm-Message-State: AOAM5312yWcabRESNX6k+i1xycKfFvv3/CdOSs/xHbfocIa3GyQgNjW4
        4rTqWMrS0qHNm3Isxle3Xvhefg16R9k=
X-Google-Smtp-Source: ABdhPJw+XaXhCgjy+lOT4XpcM5uskSX8btKU0m8htXqEOpWpD4vQYl5qgyAWPDG6ZgX/qqO1zLNrxVOOFRs=
X-Received: by 2002:a25:698a:: with SMTP id e132mr39855737ybc.177.1595288272542;
 Mon, 20 Jul 2020 16:37:52 -0700 (PDT)
Date:   Mon, 20 Jul 2020 23:37:38 +0000
In-Reply-To: <20200720233739.824943-1-satyat@google.com>
Message-Id: <20200720233739.824943-7-satyat@google.com>
Mime-Version: 1.0
References: <20200720233739.824943-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v4 6/7] fscrypt: document inline encryption support
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the fscrypt documentation file for inline encryption support.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
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
2.28.0.rc0.105.gf9edc3c819-goog

