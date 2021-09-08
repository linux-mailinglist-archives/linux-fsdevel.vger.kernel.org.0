Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB2403B88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351930AbhIHOaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:21 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41490 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351925AbhIHOaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:21 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAP-0004rz-3F; Wed, 08 Sep 2021 10:03:09 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] coda: Bump module version to 7.2
Date:   Wed,  8 Sep 2021 10:03:08 -0400
Message-Id: <20210908140308.18491-10-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
References: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Helps with tracking which patches have been propagated upstream and if
users are running the latest known version.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/psdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 7e23cb22d394..b39580ad4ce5 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -384,7 +384,7 @@ MODULE_AUTHOR("Jan Harkes, Peter J. Braam");
 MODULE_DESCRIPTION("Coda Distributed File System VFS interface");
 MODULE_ALIAS_CHARDEV_MAJOR(CODA_PSDEV_MAJOR);
 MODULE_LICENSE("GPL");
-MODULE_VERSION("7.0");
+MODULE_VERSION("7.2");
 
 static int __init init_coda(void)
 {
-- 
2.25.1

