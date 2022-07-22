Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A6E57E7A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 21:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiGVTv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiGVTv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:51:56 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322028AEF9;
        Fri, 22 Jul 2022 12:51:51 -0700 (PDT)
X-QQ-mid: bizesmtp76t1658519506t4knvcvc
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 03:51:35 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: v5d6m16HONU6RjYpJcwTIXY2y/kYlrlOUh9nzBxdPV+3mDHO0T3BDtf5vxRrw
        F6kCWQFo6dGfqgr6HLLPLr9eeDZqgqb1yBDtcYZZOYWYsNjL30WCpZ2uMQGTpyDkUFNUtrK
        GLk663v9023NxRMV5kAqLn5uIFwCOnM3BAAyCjYtrMcR6Ko7EfUwkgPEnyh/AttqR2VTl2G
        FmbrjdL6doHNgmVqZCr2LhfrdA4ARFnoaKMrY5IFq21tA1QxvrnXDojKFyc8jUaxToElgLp
        xFP5hzucSg2xoA5l1grmFLoHSd87SOlwT8Ql/7/UFvga3ZV5uBO9znhOKH3VrE85du7uVQu
        KXIRF2Z08yJGCau9PDESmSHfYocb7KfGG4fIDP6Yk2tXD7KKZ0=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] hfsplus: Fix code typo
Date:   Sat, 23 Jul 2022 03:51:33 +0800
Message-Id: <20220722195133.18730-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The double `free' is duplicated in line 498, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 fs/hfsplus/btree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 66774f4cb4fd..655cf60eabbf 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -495,7 +495,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	m = 1 << (~nidx & 7);
 	byte = data[off];
 	if (!(byte & m)) {
-		pr_crit("trying to free free bnode "
+		pr_crit("trying to free bnode "
 				"%u(%d)\n",
 			node->this, node->type);
 		kunmap(page);
-- 
2.30.2

