Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4575322C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 08:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjGNGoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 02:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjGNGoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:44:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297AF30CA
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 23:44:09 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2MQF45VqzBR9sg
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 14:44:05 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689317045; x=1691909046; bh=8qQymKzSaqSgCpyPyUdGZHKQac1
        YCfpQGK6qdfDQU6I=; b=gBd1ms+1KiZnv8E/cqLluyb9570ZnFVvPKR4mGgyoeu
        ZpLns6r/NVnmqCo2S1m0612rq2rxAj89vjAWt+Nqyx3E3xJ1585KBwW7PRmBqlSh
        swCv8R3ITgs76gySos9RiogeMMSp18YDNPFMIwnN/v+ifyxuTZcoZhvwtorjolrs
        f2kRJKJbVpVf91HyLTx2Enni1WKaYW1qpweGOmuluJZvO/RrXaWXt1mgallp+QN/
        swOmqGyxhx0gaLvvVGKDdT6xi/3/1+Othp3TysGPDczH6UP47B6MtbrclO6Lx+GC
        3DHR0Eciy6xPEnUhwlXdMmN2nvr1AZgu7EmN0Y72pGw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gjBON9paMkpY for <linux-fsdevel@vger.kernel.org>;
        Fri, 14 Jul 2023 14:44:05 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2MQF1GKtzBJFS7;
        Fri, 14 Jul 2023 14:44:05 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 14:44:05 +0800
From:   huzhi001@208suo.com
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        fullspring2018@gmail.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc: Fix four errors in array.c
In-Reply-To: <tencent_0E7C6CFA6AE1AA6BEA9E185CEC3DB582CA09@qq.com>
References: <tencent_0E7C6CFA6AE1AA6BEA9E185CEC3DB582CA09@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <f9eefe1e9ffbb24e08426057f067e3a3@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following checkpatch errors are removed:
ERROR: trailing statements should be on next line
ERROR: trailing statements should be on next line
ERROR: trailing statements should be on next line
ERROR: trailing statements should be on next line

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  fs/proc/array.c | 12 ++++++++----
  1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index d35bbf35a874..9cd8d703ade8 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -236,10 +236,14 @@ void render_sigset_t(struct seq_file *m, const 
char *header,
          int x = 0;

          i -= 4;
-        if (sigismember(set, i+1)) x |= 1;
-        if (sigismember(set, i+2)) x |= 2;
-        if (sigismember(set, i+3)) x |= 4;
-        if (sigismember(set, i+4)) x |= 8;
+        if (sigismember(set, i+1))
+            x |= 1;
+        if (sigismember(set, i+2))
+            x |= 2;
+        if (sigismember(set, i+3))
+            x |= 4;
+        if (sigismember(set, i+4))
+            x |= 8;
          seq_putc(m, hex_asc[x]);
      } while (i >= 4);
