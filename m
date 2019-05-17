Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D56021D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfEQShD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:03 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57596 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729360AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj2-0000oN-SY; Fri, 17 May 2019 14:37:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 09/22] coda: clean up indentation, replace spaces with tab
Date:   Fri, 17 May 2019 14:36:47 -0400
Message-Id: <ffc2bfa5a37ffcdf891c51b2e2ed618103965b24.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up indentation, replace spaces with tab

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/psdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 0cd646a5d0c2..7e9ee614ec57 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -364,7 +364,7 @@ static int init_coda_psdev(void)
 	if (register_chrdev(CODA_PSDEV_MAJOR, "coda", &coda_psdev_fops)) {
 		pr_err("%s: unable to get major %d\n",
 		       __func__, CODA_PSDEV_MAJOR);
-              return -EIO;
+		return -EIO;
 	}
 	coda_psdev_class = class_create(THIS_MODULE, "coda");
 	if (IS_ERR(coda_psdev_class)) {
-- 
2.20.1

