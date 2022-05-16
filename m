Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06252528066
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 11:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiEPJIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 05:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbiEPJIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 05:08:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC55ABE2B;
        Mon, 16 May 2022 02:08:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p8so13461994pfh.8;
        Mon, 16 May 2022 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whKmTTMPgrsmaBTT+liiA9Q6qWWn3/ujAQeCBvW7hg4=;
        b=J+s41SYBzaZiF+BIqdqio5MKIMM9Nbu+9tNDfxzaRzgIIK6Ryvu9Hr1pF0qBtmJQS2
         dAX2b2Xwr0q1HJ67aetOdYf4CSjsm83RcpZ1aL4grETuvtJimawDHnNsU51aAlm8gUW3
         p++HcQDqoyq2nDi7or6r5JXNFopckzWb6iDBo8TsJrDmvP9eUvOo3GK2+Gf2c9XdzT9l
         sKGba6PITaMUnw1jahSUZqRCnEGoY+YXD/Oq13YFDGBCga1UMEWI5nRc8qK7bJj7QHK6
         2EcPHv0OndoxJdyEs9OeOlnMVyG1GWY/F1+pkvLXmFH4vsXSxvfD2DCun3yRnPzJbzT0
         8rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whKmTTMPgrsmaBTT+liiA9Q6qWWn3/ujAQeCBvW7hg4=;
        b=4bu35NpGg63dEJLH45BNY/XrH1IqZp4MUYl8C3ONwKGvFdK03kkE+twXovZCdV184t
         0KIFA8d9PQ4INxQcm7Qwb00WjstLcFCJs4GADCh7zQeJoPA7BUGlHyBcTKy+GmNBm5zM
         fGPbFrUfb+3DrgPkVNDi/LA9vGgSwvs45pZYHhv0iAAYRkr/2Lc/9cgM5vinP/dQ5pLW
         G21JPYin1+tdaCMENGl8HZjGRhAJuFn+f799LiVw7A0rxw+E/mhqIT49kUh91ADHgRqc
         6HRYYirvGApZ9cslJzxKtSYHyJjYSixox9ud4y6EBzKy5wE2S9W4SmU7kwonq89X3DwR
         aGsA==
X-Gm-Message-State: AOAM531PAcmM/ddWbUwVqlI2ntikPTQIt1asc7+7+Kly5Qe3DR20nDu8
        tEQ15lJ82qjf8DaIvcZmmfE=
X-Google-Smtp-Source: ABdhPJwLub86flnlwWLj9AmkxcpGA/5RSSJ41bKr/TcufVkI/FoPIxlQxg4n4XoCeukAGz2xv8Cg/Q==
X-Received: by 2002:a63:a06:0:b0:3c2:3345:bf99 with SMTP id 6-20020a630a06000000b003c23345bf99mr14710016pgk.477.1652692102334;
        Mon, 16 May 2022 02:08:22 -0700 (PDT)
Received: from localhost (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id u6-20020a654c06000000b003db904128d5sm6170096pgq.21.2022.05.16.02.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:08:21 -0700 (PDT)
From:   bh1scw@gmail.com
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        songmuchun@bytedance.com, Fanjun Kong <bh1scw@gmail.com>
Subject: [PATCH] kernel/sysysctl.c: Remove trailing white space
Date:   Mon, 16 May 2022 17:07:53 +0800
Message-Id: <20220516090752.2137286-1-bh1scw@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Fanjun Kong <bh1scw@gmail.com>

This patch removes the trailing white space in kernel/sysysctl.c
Special thanks to Muchun Song.

Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
---
 kernel/sysctl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e52b6e372c60..e68a3e70d44e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -492,12 +492,12 @@ static int __do_proc_dointvec(void *tbl_data, struct ctl_table *table,
 	int *i, vleft, first = 1, err = 0;
 	size_t left;
 	char *p;
-	
+
 	if (!tbl_data || !table->maxlen || !*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
-	
+
 	i = (int *) tbl_data;
 	vleft = table->maxlen / sizeof(*i);
 	left = *lenp;
@@ -729,7 +729,7 @@ int proc_dobool(struct ctl_table *table, int write, void *buffer,
  * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string. 
+ * values from/to the user buffer, treated as an ASCII string.
  *
  * Returns 0 on success.
  */
@@ -1246,7 +1246,7 @@ static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *lvalp,
  * @ppos: file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string. 
+ * values from/to the user buffer, treated as an ASCII string.
  * The values read are assumed to be in seconds, and are converted into
  * jiffies.
  *
@@ -1268,8 +1268,8 @@ int proc_dointvec_jiffies(struct ctl_table *table, int write,
  * @ppos: pointer to the file position
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string. 
- * The values read are assumed to be in 1/USER_HZ seconds, and 
+ * values from/to the user buffer, treated as an ASCII string.
+ * The values read are assumed to be in 1/USER_HZ seconds, and
  * are converted into jiffies.
  *
  * Returns 0 on success.
@@ -1291,8 +1291,8 @@ int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
  * @ppos: the current position in the file
  *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string. 
- * The values read are assumed to be in 1/1000 seconds, and 
+ * values from/to the user buffer, treated as an ASCII string.
+ * The values read are assumed to be in 1/1000 seconds, and
  * are converted into jiffies.
  *
  * Returns 0 on success.
-- 
2.36.0

