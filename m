Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9E21D70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfEQShF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:05 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57642 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729375AbfEQShD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:03 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000pu-E8; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 18/22] coda: use SIZE() for stat
Date:   Fri, 17 May 2019 14:36:56 -0400
Message-Id: <e6cda497ce8691db155cb35f8d13ea44ca6cedeb.1558117389.git.jaharkes@cs.cmu.edu>
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

max_t expression was already defined in coda sources

Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/upcall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index eb8cc30f2589..15c0e4fdb0e3 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -553,7 +553,7 @@ int venus_statfs(struct dentry *dentry, struct kstatfs *sfs)
         union outputArgs *outp;
         int insize, outsize, error;
         
-	insize = max_t(unsigned int, INSIZE(statfs), OUTSIZE(statfs));
+	insize = SIZE(statfs);
 	UPARG(CODA_STATFS);
 
 	error = coda_upcall(coda_vcp(dentry->d_sb), insize, &outsize, inp);
-- 
2.20.1

