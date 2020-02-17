Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA616176E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgBQQNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UC80+vCdD5sLoOoIMXgZDLxFUIOtpDDGQZYUZ0PxziA=; b=KS/saJwsXbT0av3fe6yGMwO4Fp
        iFOFXzWZBMfjjmtUtTdJ9XCiqrWfA3sO4j+KfOaOTBLsjjAAV7oKwCaghfD2DjdpudfzBBEtq4LY0
        2xsg+z79IHModVN1UrY9HB60FhbGPrtKXI7ebJw29Cgrckm/L9hPPXy6AGX62/TTJiSa/ZdXVg1ei
        hWa+fC+eAINBtk/c/VgwxCzi0VHg0mWzu3tMp9rYnPDdPyYE+UvkYavixZe13CfL4gNOrzBTnfShV
        rEriFvpwwcFFjyUq0fHi7DzMJ4bAzvzkYQtJ5h2XPDGvk4ecywRQpZVwAR5cnFkT3/G3umuOnlGjR
        V+iFZS1Q==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uf-6O; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000faI-8d; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/44] docs: filesystems: convert ext3.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:03 +0100
Message-Id: <26960235e3e7c972bd543f5dd59f1ef4f3a877c6.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nothing really required here. Just renaming would be enough.

Yet, while here, lets add a SPDX header and adjust document title
to met the same standard we're using on most docs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/{ext3.txt => ext3.rst} | 2 ++
 Documentation/filesystems/index.rst              | 1 +
 2 files changed, 3 insertions(+)
 rename Documentation/filesystems/{ext3.txt => ext3.rst} (88%)

diff --git a/Documentation/filesystems/ext3.txt b/Documentation/filesystems/ext3.rst
similarity index 88%
rename from Documentation/filesystems/ext3.txt
rename to Documentation/filesystems/ext3.rst
index 58758fbef9e0..c06cec3a8fdc 100644
--- a/Documentation/filesystems/ext3.txt
+++ b/Documentation/filesystems/ext3.rst
@@ -1,4 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
 
+===============
 Ext3 Filesystem
 ===============
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 102b3b65486a..aa2c3d1de3de 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -63,6 +63,7 @@ Documentation for filesystem implementations.
    efivarfs
    erofs
    ext2
+   ext3
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

