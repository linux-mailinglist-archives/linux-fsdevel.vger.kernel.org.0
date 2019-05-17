Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD0C21D74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfEQShK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:10 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57648 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729379AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000q2-Fy; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 19/22] coda: add __init to init_coda_psdev()
Date:   Fri, 17 May 2019 14:36:57 -0400
Message-Id: <a12a5a135fa6b0ea997e1a0af4be0a235c463a24.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>

init_coda_psdev() was only called by __init function.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/psdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index b69b6108f595..482b7ba0339c 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -361,7 +361,7 @@ static const struct file_operations coda_psdev_fops = {
 	.llseek		= noop_llseek,
 };
 
-static int init_coda_psdev(void)
+static int __init init_coda_psdev(void)
 {
 	int i, err = 0;
 	if (register_chrdev(CODA_PSDEV_MAJOR, "coda", &coda_psdev_fops)) {
-- 
2.20.1

