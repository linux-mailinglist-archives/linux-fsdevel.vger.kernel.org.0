Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0FA62EE65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 08:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiKRHbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 02:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiKRHbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:31:03 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB47D525;
        Thu, 17 Nov 2022 23:31:03 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g10so3833774plo.11;
        Thu, 17 Nov 2022 23:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wss4l8+ki3bcqZpf4pXWKdXS9Ah4/Shxx0wHVdp0ynM=;
        b=ckE22BdRtTbcTpcAczDBDx142TEzFlzwaz45MGFZZgwWkx2w7J9ONyEK1YVTBtjfR6
         RqbV2slZHKwdlqMT3lnVqoWGcRGASMPNbRG0a2ZrIDEaqZNX3aw9GppTxZWNyx6UaYyq
         /ZXWxeUL/0Ezt57Yz21sJQrooj599j6KBMdv/q/RYuFFdCIM4Yqt2Xr0oLGb5vXXsPOg
         r6eaZJ/pKRNO2dyZ4Bd5ISXKU7nzL84AoEDMUBU7Gw51pMl98qYM2mFUepjU9gkvOFX3
         XxF7OVdMMEoAcAvgYU0CPiRt9xKcZFhO4Bnpn6/jj0RbAutl40YuQiuwkUsz0eBDueq8
         YxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wss4l8+ki3bcqZpf4pXWKdXS9Ah4/Shxx0wHVdp0ynM=;
        b=ePkV4Lnc4v6UkaPIVXehfr2h0Gf+rFdKEe+dTL8hfKyJJ4BILKb9uW4Yj7IcuO2z5c
         fIWHmb2VqHclN4yjKRcEoNR8XGHFqyrFtdqIi2MW15/zVFqm1zVOZnTyDsPyTAo8fYi3
         0BOdN0nQmyIP8OJo1alMpfnqOgeDQOzyPp0z13+zx3qyr1oT7FHFO6F+AFcYVrPm8oSZ
         biHxN21C3waXyePjPf645PX+cXNBFkMIi2T/HmOUobOKQiJY0gPGOZj2yNn6bGeiLU8H
         KbH2kj/o0v7SWPIiVhxrv8muAKb3p8CawLlwZluR+6HFHKPPHKPrnoknqq2Y9oqmAxpG
         jn5g==
X-Gm-Message-State: ANoB5pneVgBtJ3Gwv8cXn3utorB+8aWjUVkZbQ1b3GMH5oH0uN7TCY5B
        5rP6mqP1sSG1T+eBZvdJdSw=
X-Google-Smtp-Source: AA0mqf5rq6PJFQI1QyEafiKw6xrOHDycZs2gbfK12hDo+brU69QumLv0AmatzvvNoW9m3BJjhDEi/Q==
X-Received: by 2002:a17:902:c141:b0:186:c958:64f with SMTP id 1-20020a170902c14100b00186c958064fmr6370295plj.33.1668756662876;
        Thu, 17 Nov 2022 23:31:02 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f7-20020a625107000000b0056b818142a2sm2424325pfb.109.2022.11.17.23.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:31:02 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 3/4] memory-failure: Convert truncate_error_page() to use folio
Date:   Thu, 17 Nov 2022 23:30:54 -0800
Message-Id: <20221118073055.55694-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118073055.55694-1-vishal.moola@gmail.com>
References: <20221118073055.55694-1-vishal.moola@gmail.com>
MIME-Version: 1.0
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

Replaces try_to_release_page() with filemap_release_folio(). This change
is in preparation for the removal of the try_to_release_page() wrapper.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 145bb561ddb3..92ec9b0e58a3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -827,12 +827,13 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
 	int ret = MF_FAILED;
 
 	if (mapping->a_ops->error_remove_page) {
+		struct folio *folio = page_folio(p);
 		int err = mapping->a_ops->error_remove_page(mapping, p);
 
 		if (err != 0) {
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
-		} else if (page_has_private(p) &&
-			   !try_to_release_page(p, GFP_NOIO)) {
+		} else if (folio_has_private(folio) &&
+			   !filemap_release_folio(folio, GFP_NOIO)) {
 			pr_info("%#lx: failed to release buffers\n", pfn);
 		} else {
 			ret = MF_RECOVERED;
-- 
2.38.1

