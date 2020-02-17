Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F42161759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgBQQNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nqNSPkzh8/D2d8xJRRCECJiyYzat+CwmXBky8mdSui0=; b=oUtEnxHcxs75rRSBSVy8KddvLk
        Q9mMC8Yi0vBbpsAF2A3J7HTnUqYe+b3P4CFwZ7pPEWYrG+p9THmYsrsC9xtrr7E+3gaMdN1Xsl0/o
        oe9FzAEySB872IVa+H97SdwfL8aRQ1Sv9/+oalHNAx0MnFDA7cKsPn81kdAJXfuOtlQX3ubhKBOma
        49EISi/0ww0iK4cZ2wjm9HG4wK3utqBFtAi1DA30gKfQchfE9yzO4JbbbRPCahqbT61My0ZFFbBnb
        FpsAt6zD5rxaYcc58hfVhk2xmW1YRHZFwRTOdrofbJrJEEAUaVtEfr+lzxDQG21XmkIbgNw1OzJ21
        I0ZMH/Dw==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0b-0006uT-NZ; Mon, 17 Feb 2020 16:12:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZX-QG; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 08/44] docs: filesystems: convert btrfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:54 +0100
Message-Id: <1ef76da4ac24a9a6f6187723554733c702ea19ae.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just trivial changes:

- Add a SPDX header;
- Add it to filesystems/index.rst.

While here, adjust document title, just to make it use the same
style of the other docs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/{btrfs.txt => btrfs.rst} | 3 +++
 Documentation/filesystems/index.rst                | 1 +
 2 files changed, 4 insertions(+)
 rename Documentation/filesystems/{btrfs.txt => btrfs.rst} (96%)

diff --git a/Documentation/filesystems/btrfs.txt b/Documentation/filesystems/btrfs.rst
similarity index 96%
rename from Documentation/filesystems/btrfs.txt
rename to Documentation/filesystems/btrfs.rst
index f9dad22d95ce..d0904f602819 100644
--- a/Documentation/filesystems/btrfs.txt
+++ b/Documentation/filesystems/btrfs.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====
 BTRFS
 =====
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f74e6b273d9f..dae862cf167e 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -54,6 +54,7 @@ Documentation for filesystem implementations.
    autofs-mount-control
    befs
    bfs
+   btrfs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

