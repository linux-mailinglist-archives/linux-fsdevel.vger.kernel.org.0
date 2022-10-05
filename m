Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D875F5F2B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 04:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJFCxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 22:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJFCvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:51:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718888DC7;
        Wed,  5 Oct 2022 19:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C87D3B81ED2;
        Thu,  6 Oct 2022 02:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0C0C433C1;
        Thu,  6 Oct 2022 02:51:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZjRINvwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665024674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mw6mQIkw0EUTS+KZQ2KSjRHdoL9NDRAH5QoihL5z5WY=;
        b=ZjRINvwJ8Y9RjW9mEsxvsruTRD/kCfvgVCkQ7u/7FdIMuudgLfBeipJujcK5PkA7gRibAE
        3JueW/NR7m/oXbBMBVnvqYoxLNjKuH/oJSyVnlnwJCBcUbNW9D0yGDKzhSBYRR6jQJKX/l
        SKoNsI97C5YuUj19TWpVavwkTswS1bY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a3526377 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 6 Oct 2022 02:51:14 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        brcm80211-dev-list.pdl@broadcom.com, cake@lists.bufferbloat.net,
        ceph-devel@vger.kernel.org, coreteam@netfilter.org,
        dccp@vger.kernel.org, dev@openvswitch.org,
        dmaengine@vger.kernel.org, drbd-dev@lists.linbit.com,
        dri-devel@lists.freedesktop.org, kasan-dev@googlegroups.com,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mm@kvack.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-raid@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-sctp@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lvs-devel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, rds-devel@oss.oracle.com,
        SHA-cyfmac-dev-list@infineon.com, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: [PATCH v1 5/5] prandom: remove unused functions
Date:   Wed,  5 Oct 2022 23:48:44 +0200
Message-Id: <20221005214844.2699-6-Jason@zx2c4.com>
In-Reply-To: <20221005214844.2699-1-Jason@zx2c4.com>
References: <20221005214844.2699-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With no callers left of prandom_u32() and prandom_bytes(), remove these
deprecated wrappers.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/prandom.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index 78db003bc290..e0a0759dd09c 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -12,18 +12,6 @@
 #include <linux/percpu.h>
 #include <linux/random.h>
 
-/* Deprecated: use get_random_u32 instead. */
-static inline u32 prandom_u32(void)
-{
-	return get_random_u32();
-}
-
-/* Deprecated: use get_random_bytes instead. */
-static inline void prandom_bytes(void *buf, size_t nbytes)
-{
-	return get_random_bytes(buf, nbytes);
-}
-
 struct rnd_state {
 	__u32 s1, s2, s3, s4;
 };
-- 
2.37.3

