Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D533B1EC530
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 00:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgFBWi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 18:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbgFBWiS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 18:38:18 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2472072F;
        Tue,  2 Jun 2020 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591137498;
        bh=tWT+BQ8hTGsDIEbbaTVUnMxlf+2G1IkCj6Z2Rc76cdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqazz3E5SiXHy0k7vKWwu5UQ+ZoSRW+7TjOhArb1X/18S/zHwDTNeDzl2JfJyNz+z
         jEKke3clpIiUMEbUXZgeQjjiK75WD6dKkXT7BTJ8acL1nrX9p4ST2Z5OQmJTxjkkDl
         JBMpWDn1FT000o62+N3Hor0OwDz/RZLl08lqNLZo=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jgFXz-004aXG-KW; Wed, 03 Jun 2020 00:38:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luigi Semenzato <semenzato@chromium.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        NeilBrown <neilb@suse.de>, Yang Shi <yang.shi@linux.alibaba.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] docs: fs: proc.rst: fix a warning due to a merge conflict
Date:   Wed,  3 Jun 2020 00:38:14 +0200
Message-Id: <28c4f4c5c66c0fd7cbce83fe11963ea6154f1d47.1591137229.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591137229.git.mchehab+huawei@kernel.org>
References: <cover.1591137229.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changeset 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
added a new parameter to a table. This causes Sphinx warnings,
because there's now an extra "-" at the wrong place:

	/devel/v4l/docs/Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
	Text in column margin in table line 29.

	==    =======================================
	rd    readable
	...
	bt  - arm64 BTI guarded page
	==    =======================================

Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
Fixes: c33e97efa9d9 ("docs: filesystems: convert proc.txt to ReST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/proc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 430963e0e8c3..7359741cf7cf 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -543,7 +543,7 @@ encoded manner. The codes are the following:
     hg    huge page advise flag
     nh    no huge page advise flag
     mg    mergable advise flag
-    bt  - arm64 BTI guarded page
+    bt    arm64 BTI guarded page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
-- 
2.26.2

