Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94BC5FC45D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 13:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJLLiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJLLiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:38:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5539E2C2;
        Wed, 12 Oct 2022 04:38:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z97so24069806ede.8;
        Wed, 12 Oct 2022 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0T6nmePp2TxBInBRKTNwdtk0QBcDQcNUBzlpn0r3R4=;
        b=FhoHUghMukLhKd44RX7L+JuGjoZQW9PCBuFzYskYTSm9MZz0TYDYF9eSYlkGXFh/38
         sROxnN8q8RXac+P3sxNYt+ZiuIAaO0qfFbKA2U7eG+R0Ugt+8jg3i7ON67hNtyTur3GQ
         hfkvULN2Ys0k24Umbo+yvnlyN56kfg3RAaoHklJxgmWoIqzXb6/zJpCjQp5jbbLoZ9Le
         oCxB5/3ct6TxOd9O9SPdSbNAgzDpLyD0Xnd5hsD+2rvuYKvseK4z2gbWMcZh0ufPlZu4
         JiJylmTCW8EzV83TgK6RL6E0/YOpv7zUuJkSoJ4WjVrJgJ4Mmed/4eQHbAg15QhAwFvo
         2hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0T6nmePp2TxBInBRKTNwdtk0QBcDQcNUBzlpn0r3R4=;
        b=4G/KGbSw+tUCJJ64Ev/+EUf2Ohi3QSoouqWdbMwE/0qvGsukubGic9WSGLlgD4s3lg
         tNanmT+A4xZqRBFdHwmUltNGcWCU+lvXXe9h7FAvjhUbHxsVLsatBUVy0rpQYuH1FSH2
         GJLvQmI7i7Df8KeWc6uzEqyihAxIogh9Fl1TUAgoJvjrJZMaklc4zvVQ34SQ6tt/hK+r
         JU5205G3FSxQM6dNfl1/jqLb/c9BMOelnDSqP+1X4DN1E2fNvMFQcuiJyjBXQ5dcy2K7
         PuYo/kzcCB52HjVNNGhdOq8/Jm2C8WKZp/iMPTqtdK4c6RuF8dbCpZ2bJEVNxE6RfgAp
         KkOw==
X-Gm-Message-State: ACrzQf3i+mO/phrmKqbUlEgLX6Z/vnjkuK4HQXzRGp4NrHV2d0m1AXZI
        SFQyoA+nBwWEHDWhLLe7NZs=
X-Google-Smtp-Source: AMsMyM5+rPMlEdXd6W15optYwDQS72MSBluQwXiMX9x7kjUTAijliQkbs6rdxrGCuf2RM4hJ01rNEA==
X-Received: by 2002:a05:6402:3215:b0:45c:97de:b438 with SMTP id g21-20020a056402321500b0045c97deb438mr4706026eda.7.1665574729216;
        Wed, 12 Oct 2022 04:38:49 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-81-193.retail.telecomitalia.it. [87.17.81.193])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906360700b00781d411a63csm1098854ejb.151.2022.10.12.04.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 04:38:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] fs/fuse: Replace kmap() with kmap_local_page()
Date:   Wed, 12 Oct 2022 13:23:23 +0200
Message-Id: <20221012112323.23283-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Therefore, replace kmap() with kmap_local_page() in fuse_readdir_cached(), 
it being the only call site of kmap() currently left in fs/fuse.

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

These changes are not tested in a 32 bits VM as I use to do with other more
problematic conversions. Mere code inspection makes me reasonably think
that the rules of local mappings are not violated by this conversion.

Furthermore, I have no idea how to test this code. If maintainers think
that tests are absolutely necessary, any hints about how to perform them
would be greatly appreciated.

 fs/fuse/readdir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index b4e565711045..9e40c19e90dc 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -539,9 +539,9 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	 * Contents of the page are now protected against changing by holding
 	 * the page lock.
 	 */
-	addr = kmap(page);
+	addr = kmap_local_page(page);
 	res = fuse_parse_cache(ff, addr, size, ctx);
-	kunmap(page);
+	kunmap_local(addr);
 	unlock_page(page);
 	put_page(page);
 
-- 
2.37.3

