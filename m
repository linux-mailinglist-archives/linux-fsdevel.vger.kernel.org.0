Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0391121D7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfEQShS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:18 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57604 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729366AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000pP-52; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/22] coda: bump module version
Date:   Fri, 17 May 2019 14:36:52 -0400
Message-Id: <8b0ab50a2da2f0180ac32c79d91811b4d1d0bd8b.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The out of tree module version had been bumped several times already,
but we haven't kept this in-tree one in sync, partly because most
changes go from here to the out-of-tree copy.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/psdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 4c8d968031bb..67092f069b32 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -393,7 +393,7 @@ MODULE_AUTHOR("Jan Harkes, Peter J. Braam");
 MODULE_DESCRIPTION("Coda Distributed File System VFS interface");
 MODULE_ALIAS_CHARDEV_MAJOR(CODA_PSDEV_MAJOR);
 MODULE_LICENSE("GPL");
-MODULE_VERSION("6.6");
+MODULE_VERSION("6.11");
 
 static int __init init_coda(void)
 {
-- 
2.20.1

