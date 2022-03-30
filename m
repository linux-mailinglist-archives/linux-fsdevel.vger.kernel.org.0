Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03E84EC712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347239AbiC3OvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347219AbiC3OvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65FB15FFA
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6Rbs8urQaKZqSJVCo9BZwBiVhNz+gPTlbSmsjfxuIZQ=; b=DAPSA7tzFLe85x99hV96VmEuL7
        oVm6hBEiSrmZlzu32qyVpmYzkldtj7sl8H8kn5AvPOZA2W7Or3aYbK6oSviinxEhYSlV/jvvQ5ovy
        38xx6qoZrjy7tQvMIHdxb54V9VDMa3V0gVkIKBPiIHJVj6edUeeXOd6jG0nX3qSHK0ZaK9fGxyQdB
        ouKLsH5dP0V9pjm37wwgB42MeiL2Fv50fFlKrLyanP/ItBdLWICYgQADNhCDoupy+Mjz8r3z2Hix0
        Dg17RR6BFgTFzvc/m5Tvg0PyDJX/OwgXEqlOMc1g5JENccvM2l5iWPGO/qNxo24oTqAs0xwW5B8mM
        J8s15fhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdc-001KD7-4M; Wed, 30 Mar 2022 14:49:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/12] fs: Remove read_actor_t
Date:   Wed, 30 Mar 2022 15:49:22 +0100
Message-Id: <20220330144930.315951-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220330144930.315951-1-willy@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This typedef is not used any more.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7c81887cc7e8..7588d3a0ced8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -357,9 +357,6 @@ typedef struct {
 	int error;
 } read_descriptor_t;
 
-typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
-		unsigned long, unsigned long);
-
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
-- 
2.34.1

