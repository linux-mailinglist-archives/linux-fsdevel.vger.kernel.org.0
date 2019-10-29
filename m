Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7A4E90F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 21:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfJ2Un5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 16:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfJ2Un5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:43:57 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F32721835;
        Tue, 29 Oct 2019 20:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572381836;
        bh=p5iqeRBG0wAn8vG31RO8K0J2sdKd+zlwDuiiVCe/arU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqLabC+4M1549VLoHu+fT+YMZrTGGCI6h26q23IVXUV+l623EaOFPGHWTbPJw6rZQ
         z6+Hb6lOhwnAuiq9iVMCCKczLZk3npUaZaH86ZnpoxrQvfeVOOuYLC9FnrJvJznCMQ
         fH9S1BHEqrrcJqKGPANaSpjGiCl63Sl7zkWvb3wE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 4/4] docs: fs-verity: mention statx() support
Date:   Tue, 29 Oct 2019 13:41:41 -0700
Message-Id: <20191029204141.145309-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191029204141.145309-1-ebiggers@kernel.org>
References: <20191029204141.145309-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document that the statx() system call can now be used to check whether a
file is a verity file.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fsverity.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 42a0b6dd9e0b68..3355377a24398d 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -226,6 +226,14 @@ To do so, check for FS_VERITY_FL (0x00100000) in the returned flags.
 The verity flag is not settable via FS_IOC_SETFLAGS.  You must use
 FS_IOC_ENABLE_VERITY instead, since parameters must be provided.
 
+statx
+-----
+
+Since Linux v5.5, the statx() system call sets STATX_ATTR_VERITY if
+the file has fs-verity enabled.  This can perform better than
+FS_IOC_GETFLAGS and FS_IOC_MEASURE_VERITY because it doesn't require
+opening the file, and opening verity files can be expensive.
+
 Accessing verity files
 ======================
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

