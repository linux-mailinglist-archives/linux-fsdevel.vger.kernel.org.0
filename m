Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF275C32A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 11:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGUJi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 05:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGUJi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:38:56 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 02:38:54 PDT
Received: from smtpout3.mo529.mail-out.ovh.net (smtpout3.mo529.mail-out.ovh.net [46.105.54.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7864F0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 02:38:54 -0700 (PDT)
Received: from mxplan6.mail.ovh.net (unknown [10.109.156.3])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 246502173F;
        Fri, 21 Jul 2023 09:21:55 +0000 (UTC)
Received: from jwilk.net (37.59.142.103) by DAG4EX1.mxp6.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 11:21:49 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-103G005d292e435-cda0-4d95-beaf-b1783b26d091,
                    92539600ABE250F1C2241F0D9CFADF6FB3149849) smtp.auth=jwilk@jwilk.net
X-OVh-ClientIp: 5.172.255.59
From:   Jakub Wilk <jwilk@jwilk.net>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fs/locks: Fix typo
Date:   Fri, 21 Jul 2023 11:21:47 +0200
Message-ID: <20230721092147.6009-1-jwilk@jwilk.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG4EX2.mxp6.local (172.16.2.32) To DAG4EX1.mxp6.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 3c100ccf-4011-41fb-af03-115e0d32dbda
X-Ovh-Tracer-Id: 5634847561113196512
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpeflrghkuhgsucghihhlkhcuoehjfihilhhksehjfihilhhkrdhnvghtqeenucggtffrrghtthgvrhhnpeefhfetfffhffehtedufedvfeehfffgudeljeehieetiefhfeffjeevleejveehieenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtfedphedrudejvddrvdehhedrheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhifihhlkhesjhifihhlkhdrnhgvtheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdgthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhohedvledpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index df8b26a42524..06f5ec769e34 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2136,7 +2136,7 @@ EXPORT_SYMBOL_GPL(vfs_test_lock);
  * @fl: The file_lock who's fl_pid should be translated
  * @ns: The namespace into which the pid should be translated
  *
- * Used to tranlate a fl_pid into a namespace virtual pid number
+ * Used to translate a fl_pid into a namespace virtual pid number
  */
 static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 {
-- 
2.39.2

