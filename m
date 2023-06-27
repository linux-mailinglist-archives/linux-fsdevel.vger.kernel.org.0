Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F773FD3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjF0NvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjF0NvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:51:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80322115;
        Tue, 27 Jun 2023 06:51:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso2269152a91.0;
        Tue, 27 Jun 2023 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687873882; x=1690465882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yC0qdsVlzqom1maXrFmWbBV9EFBNb4pDFIg7xKX9iVU=;
        b=NMXss8hEntoOBfcERaamzECMxwW0IQb8YoySdVTtM3Z4qg/iIwH1bK9KxtaWCdWWHr
         005b9wSIiaFMqYzGpbcLUAD0hEmEx+6jtCXxln7D73zyY4T950uoPgaAiAlgc9JGXAm6
         1qQdu8nYFEzfrS+tPixR1P9/TvSXezbbynBRAOWVVrQLA0i6t2+/GSPCysTKX67xNdRO
         o3Qs6TiLAY6wIHAhyK4a7tRAMWfq5pOIR66AK3bg+w251KftsmmQlwOlJPy3Zl8lhUR/
         Ha8E6gKj+qcHG306E6yHhwyvMakN76BQg9F/WLDFWjcRHBmiTmxItqtE7TiCo6W0s5Sq
         oTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873882; x=1690465882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yC0qdsVlzqom1maXrFmWbBV9EFBNb4pDFIg7xKX9iVU=;
        b=MT2fhiqRMKu6lWKoPMpws1gIq1MqlElOV4XdNc8+KB8eO7SrT0cmccEuCjeE8sR0YC
         tpxzmpcaZAudFLtAWPAZE1Qwjf2HCkD2Io/SEPGkVDBD8t2BmMKXxsKAXrm2cog9Eb+r
         t8VVRxfjJxF9HIjt7VlVwmCjlkKLv629F6o5Ii31foznws//+99Ocj+7H9VCgZ01jUZ7
         EzKFBm4vYX6du/Tdj5QM/zF5eUcjSRrw4+OYuho6N/sLmAzuyKb+ywUfrUhSvfdkzdJC
         plBtAC4ZbyyrFDPG+EDFGj+P+D1xUcVL3Di1SSxFf3A1AqCm9/4c1k22XeDb+IEF43Nx
         sidw==
X-Gm-Message-State: AC+VfDwdQdaiGydVNmCWSUNk1Q/8CxsKr5FDHzBaWA8ya0T5Kshgiq1p
        78E3AlAln97ktaMJnY8MtN8=
X-Google-Smtp-Source: ACHHUZ49dr9ljaZNtQs5Bh3Z8C7XBeneMjIG11GIfgKoqNqPtGHTbQIwmp+n97pjpNI/8sCXoU4wyQ==
X-Received: by 2002:a17:90b:390a:b0:262:f550:6413 with SMTP id ob10-20020a17090b390a00b00262f5506413mr7683107pjb.6.1687873881919;
        Tue, 27 Jun 2023 06:51:21 -0700 (PDT)
Received: from sumitra.com ([59.95.154.112])
        by smtp.gmail.com with ESMTPSA id m7-20020a17090a414700b00262d368b220sm5553968pjg.40.2023.06.27.06.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:51:21 -0700 (PDT)
Date:   Tue, 27 Jun 2023 06:51:15 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <20230627135115.GA452832@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() has been deprecated in favor of the kmap_local_page() due to high
cost, restricted mapping space, the overhead of a global lock for
synchronization, and making the process sleep in the absence of free
slots.

kmap_local_{page, folio}() is faster than kmap() and offers thread-local
and CPU-local mappings, can take pagefaults in a local kmap region and
preserves preemption by saving the mappings of outgoing tasks and
restoring those of the incoming one during a context switch.

The difference between kmap_local_page() and kmap_local_folio() consist
only in the first taking a pointer to a page and the second taking two
arguments, a pointer to a folio and the byte offset within the folio which
identifies the page.

The mappings are kept thread local in the functions 'vboxsf_read_folio',
'vboxsf_writepage', 'vboxsf_write_end' in file.c

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 fs/vboxsf/file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 572aa1c43b37..5190619bc3c5 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -234,7 +234,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
 	u8 *buf;
 	int err;
 
-	buf = kmap(page);
+	buf = kmap_local_folio(folio, off);
 
 	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
 	if (err == 0) {
@@ -245,7 +245,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
 		SetPageError(page);
 	}
 
-	kunmap(page);
+	kunmap_local(buf);
 	unlock_page(page);
 	return err;
 }
@@ -286,10 +286,10 @@ static int vboxsf_writepage(struct page *page, struct writeback_control *wbc)
 	if (!sf_handle)
 		return -EBADF;
 
-	buf = kmap(page);
+	buf = kmap_local_page(page);
 	err = vboxsf_write(sf_handle->root, sf_handle->handle,
 			   off, &nwrite, buf);
-	kunmap(page);
+	kunmap_local(buf);
 
 	kref_put(&sf_handle->refcount, vboxsf_handle_release);
 
@@ -320,10 +320,10 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
 	if (!PageUptodate(page) && copied < len)
 		zero_user(page, from + copied, len - copied);
 
-	buf = kmap(page);
+	buf = kmap_local_page(page);
 	err = vboxsf_write(sf_handle->root, sf_handle->handle,
 			   pos, &nwritten, buf + from);
-	kunmap(page);
+	kunmap_local(buf);
 
 	if (err) {
 		nwritten = 0;
-- 
2.25.1

