Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C155A0729
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 04:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiHYCJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 22:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiHYCJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:09:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A462F9
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 19:09:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso3446692pjh.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 19:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=YpGUv3UA3bPfO8cA3tEzw2kofy/fEmqVCKzZz0F+/I8=;
        b=X4CXk3+N4wIui5nAG5AnAWxFC1uhpmOJteAAw8YQpsACEkWm4L/p/N1IkdJZYYj4kZ
         65mKeb4QaugatROHlqqsel7G6yURYcaj0/8Z2jv4xB+Odqj6EPsWaCLtUIxyySXHgiDx
         IyiXMcXnDUyAGQa1Cp5cd6m7a344TTQhlts8OdXIBWdw6CDV6391rOA0MTaezIh1A3KW
         vKLUiuaB43nZ4szgLKZvxO6LIqF6LHn8PmDDHx5cIsUv6sN3gzV9t3GlQRo99uR5ixJE
         qCoqArkQWgER11QdCHemyyi2yUhD29/P1IQMJnfbhO3+FTDFx2pZs5zONtFx8sIq7bOx
         0RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YpGUv3UA3bPfO8cA3tEzw2kofy/fEmqVCKzZz0F+/I8=;
        b=L9T9sxunXCm+miV/6Q2F3yT6WM8f7LoFCkXfqybLonZ10dRflTxFABZhbBS6aSaOWT
         ZPj341oWzdFsIAfhdcZEm5w2Zm9aseNgwdogYWcL7RupeENOSAPvZSZp2xro4RvbR0/Q
         xD/hOjg9z6zomfXNulmkBMNv2aFkC8fdAS76fqcsv7AatkXPSGfFIl0QSmYix1wMvJrk
         QoyvRfy66DFl1i3xou1YcgCZz2HvjeLN+xHrQdDWgwGuTEYzaBchrBzWUOogdjg9EsQF
         oas8syokqutFq5Vcwn07ZehogHjvzn+VdQLUAcgt957IfOauMHxyzaeyjfHpowrawpXK
         rfxw==
X-Gm-Message-State: ACgBeo222NTeoAJAPB/cCrnZ41wHVokpZtuHSotMMBJb7DpQXMyhhK1v
        O95qCYzmDy2e6oUH2BgWnwrIoA==
X-Google-Smtp-Source: AA6agR6IU1tJEU0pMOJ4yXJCZh4RrwqIfQlQ0TbaDyt8SHKTQ8S9hm/Ui0b0icofrmdW4LPBzWxOXg==
X-Received: by 2002:a17:90b:4ad1:b0:1fb:eba:9977 with SMTP id mh17-20020a17090b4ad100b001fb0eba9977mr2030245pjb.182.1661393394478;
        Wed, 24 Aug 2022 19:09:54 -0700 (PDT)
Received: from yinxin.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79570000000b0052e6d6f3cb7sm4116186pfq.189.2022.08.24.19.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 19:09:53 -0700 (PDT)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     dhowells@redhat.com, hsiangkao@linux.alibaba.com,
        jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        zhujia.zj@bytedance.com, Xin Yin <yinxin.x@bytedance.com>,
        Yongqing Li <liyongqing@bytedance.com>
Subject: [PATCH v2] cachefiles: make on-demand request distribution fairer
Date:   Thu, 25 Aug 2022 10:09:45 +0800
Message-Id: <20220825020945.2293-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now, enqueuing and dequeuing on-demand requests all start from
idx 0, this makes request distribution unfair. In the weighty
concurrent I/O scenario, the request stored in higher idx will starve.

Searching requests cyclically in cachefiles_ondemand_daemon_read,
makes distribution fairer.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Reported-by: Yongqing Li <liyongqing@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes form v1:
add Reviewed-by for Jeffle and Gao
add Fixes line
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6cba2c6de2f9..2ad58c465208 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -111,6 +111,7 @@ struct cachefiles_cache {
 	char				*tag;		/* cache binding tag */
 	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
 	struct xarray			reqs;		/* xarray of pending on-demand requests */
+	unsigned long			req_id_next;
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
 };
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 1fee702d5529..247961d65369 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -238,14 +238,19 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	unsigned long id = 0;
 	size_t n;
 	int ret = 0;
-	XA_STATE(xas, &cache->reqs, 0);
+	XA_STATE(xas, &cache->reqs, cache->req_id_next);
 
 	/*
-	 * Search for a request that has not ever been processed, to prevent
-	 * requests from being processed repeatedly.
+	 * Cyclically search for a request that has not ever been processed,
+	 * to prevent requests from being processed repeatedly, and make
+	 * request distribution fair.
 	 */
 	xa_lock(&cache->reqs);
 	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
+	if (!req && cache->req_id_next > 0) {
+		xas_set(&xas, 0);
+		req = xas_find_marked(&xas, cache->req_id_next - 1, CACHEFILES_REQ_NEW);
+	}
 	if (!req) {
 		xa_unlock(&cache->reqs);
 		return 0;
@@ -260,6 +265,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	}
 
 	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
+	cache->req_id_next = xas.xa_index + 1;
 	xa_unlock(&cache->reqs);
 
 	id = xas.xa_index;
-- 
2.25.1

