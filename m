Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52857D105B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfJINkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:40:15 -0400
Received: from mout02.posteo.de ([185.67.36.66]:51195 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731229AbfJINkN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:40:13 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Oct 2019 09:40:12 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 826D62400E6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1570627927; bh=m1/aV5A6az2PrkSkWyiglNpzQzGx1aqO/iE3sRko5/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=a6x0QA8uQU/FPIAgkhBGrjtbIQlpwYM5i6T8JPx7Uu1NN8JXkPRaKoT1CY1tyz72A
         rAiygLBWnxcT2M1gkG9qW1cwswzCHs7R9giMerfnMwpDvTheTSSsiZXmZG8E2cPS8K
         jhfI6Ins++9pLsI6ViGp37sw7ls0psBgQ+w1w20ofqjDxfOFT7WSk0HJE46lkZ9VVy
         yCZ5OxIRUjI5sMClSuamq52S1zrBd2yefRqGE9Y+0BWWclwz1T6t1wAfMB6MklDXuO
         qUSh/4+L9eqdnAQoUWsDH76l4h//jeTNb4rQHX4kGu+WKyBpMyiAnN0/Ky3wfL6Ugj
         ICTlVoXMuFcig==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46pFWC1QhMz9rxM;
        Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
From:   philipp.ammann@posteo.de
To:     linux-fsdevel@vger.kernel.org
Cc:     Andreas Schneider <asn@cryptomilk.org>
Subject: [PATCH 4/6] Add the exfat version to the module info
Date:   Wed,  9 Oct 2019 15:31:55 +0200
Message-Id: <20191009133157.14028-5-philipp.ammann@posteo.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009133157.14028-1-philipp.ammann@posteo.de>
References: <20191009133157.14028-1-philipp.ammann@posteo.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andreas Schneider <asn@cryptomilk.org>

Signed-off-by: Andreas Schneider <asn@cryptomilk.org>
---
 drivers/staging/exfat/exfat_super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index b63186a67af6..29fb5e88fe5f 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -4049,4 +4049,5 @@ module_exit(exit_exfat);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("exFAT Filesystem Driver");
+MODULE_VERSION(EXFAT_VERSION);
 MODULE_ALIAS_FS("exfat");
-- 
2.21.0

