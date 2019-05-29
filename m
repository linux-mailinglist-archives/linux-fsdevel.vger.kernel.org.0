Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106B12E757
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfE2VVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfE2VVL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:21:11 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5C0241F7;
        Wed, 29 May 2019 21:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559164870;
        bh=znwOEyKrenrVT41woZsMo3otFpoghvAVdCrMasSE+5k=;
        h=From:To:Subject:Date:From;
        b=Unj8WHaGUClC4zkOGx9fQTFQuWWyNX0td1QP51cYApPSh/7dDDZON885n+p1n+uoU
         Jm6DXYxzHzS3nNIBfRjyWXIo8DuLGfEA66qT3jUgNz7YHRuoLTWGfpJrmF8hdSSTuy
         9eI511mnrG2sDJmEopvBoZVmxMBObmgLeoPT8/mQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs/namespace.c: make to_mnt_ns() static
Date:   Wed, 29 May 2019 14:21:08 -0700
Message-Id: <20190529212108.164246-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make to_mnt_ns() static to address the following 'sparse' warning:

    fs/namespace.c:1736:22: warning: symbol 'to_mnt_ns' was not declared. Should it be static?

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ffb13f0562b07..0de85376c0c24 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1733,7 +1733,7 @@ static bool is_mnt_ns_file(struct dentry *dentry)
 	       dentry->d_fsdata == &mntns_operations;
 }
 
-struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
+static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
-- 
2.22.0.rc1.257.g3120a18244-goog

