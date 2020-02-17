Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64FE161767
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgBQQNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sbalNe8GPhxriQnoQDqyFDZa3zOWbwh7URV7YbtN518=; b=DCBDbNyUkVfAM+GpA/PsjMv/zl
        qP/WcCijYvIQ+C9LTHSMbRjzftJiTO8Dnbg7iTvg3yNpXeSXOIgLBRrrKZ0AGH8R77jR9qyBCzslQ
        6Pex/Vp1mBY81i6EbYxTAa920m/6IfwafH/n+JWXgytQSYj3Yq570r2aWp+cBOyhznwAHETLJDEZE
        TVoFKOfD3HoBC+MlUFEHVhLq6sdcVqKcS+50WEUFBAQ5Wez5n02dfB2JtMBDfsx4jO4lNZ+0lJ+pk
        uiZEgifQDF58YH4mih00rYhipqbDuHvJ/P9Ro1dRMOtZKql6N0FQhygMGAZE8ICeYUJI93Ol2L+QK
        F5v9rZMg==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006ua-4p; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000fa1-1l; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/44] docs: filesystems: convert efivarfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:00 +0100
Message-Id: <215691d747055c4ccb038ec7d78d8d1fe87fe2c0.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trivial changes:

- Add a SPDX header;
- Adjust document title;
- Mark a literal block as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/{efivarfs.txt => efivarfs.rst} | 5 ++++-
 Documentation/filesystems/index.rst                      | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)
 rename Documentation/filesystems/{efivarfs.txt => efivarfs.rst} (85%)

diff --git a/Documentation/filesystems/efivarfs.txt b/Documentation/filesystems/efivarfs.rst
similarity index 85%
rename from Documentation/filesystems/efivarfs.txt
rename to Documentation/filesystems/efivarfs.rst
index 686a64bba775..90ac65683e7e 100644
--- a/Documentation/filesystems/efivarfs.txt
+++ b/Documentation/filesystems/efivarfs.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
 
+=======================================
 efivarfs - a (U)EFI variable filesystem
+=======================================
 
 The efivarfs filesystem was created to address the shortcomings of
 using entries in sysfs to maintain EFI variables. The old sysfs EFI
@@ -11,7 +14,7 @@ than a single page, sysfs isn't the best interface for this.
 Variables can be created, deleted and modified with the efivarfs
 filesystem.
 
-efivarfs is typically mounted like this,
+efivarfs is typically mounted like this::
 
 	mount -t efivarfs none /sys/firmware/efi/efivars
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index d6d69f1c9287..4230f49d2732 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -60,6 +60,7 @@ Documentation for filesystem implementations.
    debugfs
    dlmfs
    ecryptfs
+   efivarfs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

