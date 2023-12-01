Return-Path: <linux-fsdevel+bounces-4627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0D801682
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31737B20C6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B83F8D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VbhRIX+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8110F3
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:06 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-da41acaea52so983251276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468725; x=1702073525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYVHSmz3QYock1Rn/5GLr5Ch+VJ6Y1Sc8gFeLki2OwI=;
        b=VbhRIX+p8/VzHYAegVuLG0ibnIxAbt4ECU0t1HI0eQRLhHH83TAY02BzCYYUWiPDiz
         EeOmR7VTu+/JWiSJtP+BTbJzEBbubh1dVk3sbn3kfa7GR8593wCjuevEgrlb1sz/eNJ1
         UhhK96/lxL16UFI8Ji2e3WuSEImAwvEis3uS77RWJqj+LlxZqwboLu65jKMgzPKmyLkX
         SpfDadWx0EEnEoh2MSkCk55u/qFMYzkHO9tdqdfvpC9mmVgRbCmTKqwrSIt12HNLXVi2
         c2Dy11aoBoeZO3RfQKaNGUw1kL02Uf7NVYfw/HWTM9u7s2nvp3ix5NqTXCfQIG1PU5f2
         4fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468725; x=1702073525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYVHSmz3QYock1Rn/5GLr5Ch+VJ6Y1Sc8gFeLki2OwI=;
        b=LtfpmCZxZEXWjqG1MzULfc1HVJ1fSrDXYBuUPSsIdC8peSonoK4PAWz8g/6L3QZlpT
         0wtTzmhX0MTIUZQFcHCV+vvISBReOU9pP5Kl2WDBncm3d1lgZG6R7cIf824d39MnChyJ
         QOQNh83OApuqVjsSh+m1AHGHdZVcQuKSSMXutERKF2nbSayZZa4e48j0UB4Mjgo/XrSj
         hIk5sT11IQD0XL6ee9N7vGKw36S+AeQLM8GAB3ILR7EOQHiGtY4OrpjaasZmvYhS61ba
         YkcPzRU1HmkzGyRe/tU/SBCl5s9kKpnue3Ydvs2P9F2jdU3K1jIcjz75ZRKhs6lKhip5
         qKjg==
X-Gm-Message-State: AOJu0Yz0RqJ4SPMNCZO4ims5zGQxydjNAHENXCf1rsd3TS+v/mQH430y
	hpGyBD3E9G3v3KW/4eehCx3eZ/GNfAqjo/KT1x/9UoTW
X-Google-Smtp-Source: AGHT+IEu1m3fKOVowcAxkrEKVQ5KZJ3yqxWd+Rrq4rW9myeJmiMuLaCUlVbaG1Ul38DPuL6e5FjUfQ==
X-Received: by 2002:a5b:4c1:0:b0:db7:dacf:3f9e with SMTP id u1-20020a5b04c1000000b00db7dacf3f9emr157668ybp.75.1701468725242;
        Fri, 01 Dec 2023 14:12:05 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 196-20020a2504cd000000b00d995a8b956csm639877ybe.51.2023.12.01.14.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 07/46] fscrypt: add documentation about extent encryption
Date: Fri,  1 Dec 2023 17:11:04 -0500
Message-ID: <16939187c6d8ae790a2a02e8326660cdcaf978c5.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a couple of sections to the fscrypt documentation about per-extent
encryption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/filesystems/fscrypt.rst | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 1b84f818e574..dc8bf04484ba 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -256,6 +256,21 @@ alternative master keys or to support rotating master keys.  Instead,
 the master keys may be wrapped in userspace, e.g. as is done by the
 `fscrypt <https://github.com/google/fscrypt>`_ tool.
 
+Per-extent encryption keys
+--------------------------
+
+For certain file systems, such as btrfs, it's desired to derive a
+per-extent encryption key.  This is to enable features such as snapshots
+and reflink, where you could have different inodes pointing at the same
+extent.  When a new extent is created fscrypt randomly generates a
+16-byte nonce and the file system stores it along side the extent.
+Then, it uses a KDF (as described in `Key derivation function`_) to
+derive the extent's key from the master key and nonce.
+
+Currently the inode's master key and encryption policy must match the
+extent, so you cannot share extents between inodes that were encrypted
+differently.
+
 DIRECT_KEY policies
 -------------------
 
@@ -1394,6 +1409,27 @@ by the kernel and is used as KDF input or as a tweak to cause
 different files to be encrypted differently; see `Per-file encryption
 keys`_ and `DIRECT_KEY policies`_.
 
+Extent encryption context
+-------------------------
+
+The extent encryption context mirrors the important parts of the above
+`Encryption context`_, with a few ommisions.  The struct is defined as
+follows::
+
+        struct fscrypt_extent_context {
+                u8 version;
+                u8 encryption_mode;
+                u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+                u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
+        };
+
+Currently all fields much match the containing inode's encryption
+context, with the exception of the nonce.
+
+Additionally extent encryption is only supported with
+FSCRYPT_EXTENT_CONTEXT_V2 using the standard policy, all other policies
+are disallowed.
+
 Data path changes
 -----------------
 
@@ -1417,6 +1453,11 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
 buffers regardless of encryption.  Other filesystems, such as ext4 and
 F2FS, have to allocate bounce pages specially for encryption.
 
+Inline encryption is not optional for extent encryption based file
+systems, the amount of objects required to be kept around is too much.
+Inline encryption handles the object lifetime details which results in a
+cleaner implementation.
+
 Filename hashing and encoding
 -----------------------------
 
-- 
2.41.0


