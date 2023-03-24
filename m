Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D96C7C7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 11:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCXK1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 06:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCXK1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:27:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EC720A1F
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 03:27:33 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id by8so1173377ljb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679653651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuhONKs+5RXYrZrVNmBNERZljzctIJQ0oXZhOnvnrwk=;
        b=qC11dFCxr6ZVrJEKy+Hccf/+PxVSzVTc2biJmtZVcXKVQMrd8oQ85HMZD5LqTkYOUf
         qUESHBt6sWlguKM82Kppv6mVUBJ3cEsQx67HWGgdruu4r44LSPRKx+cWxzwAVZ6KkW16
         ZpTR9fTZ03QnN1I5y4dUZcyGTTxQNC1xOzNjUzdwJf5SmXCULMPnkm0f1jVQwdriIW2V
         rof3AVT6JMUvdQQ++r/Ajwiw/72ApxdFyirrVYzaYXmsxXB93c/z8DSU1v5IpmtRjoKA
         pdv+WAN+MC9UW0Ws/JGXD64JMT2+Pfd20z9XG4r7/DK4uA1K1utTIvkaUonE6mvCy+jR
         8QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679653651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuhONKs+5RXYrZrVNmBNERZljzctIJQ0oXZhOnvnrwk=;
        b=aBxCVs+5TRgMKoQXwRKlPmp1jizn5ou46yrX1Ir0qs86umHH9uYc1SwrDekfD0WULX
         Gnm5MZ44GGBLVOTg2uGcAU4gyBfYPQsnmBepzzQ3oeMfNF42LIWFZhCBwBebb2ibPYd1
         Ah5pUjj942BnJwdX3i6RpZW+JlZH4hChFRat0gR3FgK8vsoCfcg+8pdKeVX+03JBz+wo
         nc6bGN19JPaAMKtFtxby7Sc1sgs5+NeuuCzn7TjM/pQknitZf3AjM/d6m5GrBJPOR+Vj
         OJr+ijNJJUjHIRrxF6MUUxbUlsVvqoEU8tBicvL2d/H7k16mVXVWKaHF9595HXJcLWGe
         TxWw==
X-Gm-Message-State: AAQBX9f/jSxvGf8Uc2yeS0FNEp/NkSoziF80bj9OjDhXXZ3M0NTj8rct
        N9zmTuA13Y6TWZkXFFGCZ/kEWA==
X-Google-Smtp-Source: AKy350a7EXKlHtCBsq4WyQ256V3cCgzCUUeEEiJC5MxO+Jmrs4nWLR5HpiBmGCLD4bkaNVy72lxuXg==
X-Received: by 2002:a2e:8016:0:b0:29b:3a19:bd71 with SMTP id j22-20020a2e8016000000b0029b3a19bd71mr780233ljg.35.1679653651538;
        Fri, 24 Mar 2023 03:27:31 -0700 (PDT)
Received: from fedora.. ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id s18-20020a2e9c12000000b00295765966d9sm3353449lji.86.2023.03.24.03.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 03:27:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Steve French <sfrench@samba.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] netfs: Pass a pointer to virt_to_page()
Date:   Fri, 24 Mar 2023 11:27:28 +0100
Message-Id: <20230324102728.712018-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like the other calls in this function virt_to_page() expects
a pointer, not an integer.

However since many architectures implement virt_to_pfn() as
a macro, this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix this up with an explicit cast.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/netfs/iterator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index e9a45dea748a..a506c701241e 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -240,7 +240,7 @@ static ssize_t netfs_extract_kvec_to_sg(struct iov_iter *iter,
 			if (is_vmalloc_or_module_addr((void *)kaddr))
 				page = vmalloc_to_page((void *)kaddr);
 			else
-				page = virt_to_page(kaddr);
+				page = virt_to_page((void *)kaddr);
 
 			sg_set_page(sg, page, len, off);
 			sgtable->nents++;
-- 
2.34.1

