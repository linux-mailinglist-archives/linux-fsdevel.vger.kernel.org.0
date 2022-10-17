Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE1E6019F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiJQU2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJQU05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A57E32B;
        Mon, 17 Oct 2022 13:25:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pq16so12020722pjb.2;
        Mon, 17 Oct 2022 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF+S3kLPZzaI8oQb5OfM6HGraMAqxwArE1NOeePgjJI=;
        b=XUUSSIaIijy9nz3gVf5iV3Ax7/gZZZ7Kjy+jjIIePV53CqFWJIxxsOvnffQtyfkxjP
         Yj1nwTiH0AguMsbOTQeu+8Z9mi7qRPLyE0S6M0xCFwiO28OMVRcOXq6yKjJFASnj7zDP
         hHzCZ7l/wbiBSCCq8oyptJveE7nl6roT2dTX39Tmm+YHanI6ZLWRKL+GxVNnWAVi/aqd
         Utqx7yMucx2sjXgfOeQmOc8qMiwP1URFKwVETpEX4YOe1sQaY88gGBHBUZvpmMyb0f0m
         PLVAeL/JerSDZqt4gfmESRBxYd+ZqACu4QMuoto8SFxAd6Gjw4atWFM001xVBLWGQnUL
         y/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xF+S3kLPZzaI8oQb5OfM6HGraMAqxwArE1NOeePgjJI=;
        b=yqfdb1jfAX2IDjTWou36pkRJpWocYqsDmogwN8EQtZuACefbQFeFALZnqgs/I5pOHI
         7dUJIf1WNVvytmv+ml0zTTf89hej5fR3ftkjRY7v19Cpsy2gaZ+o7AIoIyIvpViUO/Ir
         mBMA2PmMRqspzZb1nmMpU9MUMKhC/hTY5qp0ddrFVOxfUJ9k7hcNuWFlyM784+7O1nJN
         m/m9E7W4NR4Mp+oH7soo85S7FnC9ZjPlNVgiYggJdr/MtIxb8xwpmCCKrDVN2s2fVd3X
         5bMSahps23yeYDBYekDzEO0tWNC561yNUQbJDaePfUOjo2ssfWfAAtnEWZG7Wyyh6nm5
         Kl7A==
X-Gm-Message-State: ACrzQf1vDUVESKQI9I6GMaxzRuBR/5cNzqrwCnNBh3MR4pB7No7BHIIO
        f19471mc+9Q/4T/i26QwIoh6ZD1bfU1rGA==
X-Google-Smtp-Source: AMsMyM5ypUsG5+WrImTP5bBtDzNgzyRwr/KD3LkLMPonj3Tjj7JKkPzBbmJwUrqdFqpFWlWztsuaxQ==
X-Received: by 2002:a17:90b:400f:b0:20a:9965:ef08 with SMTP id ie15-20020a17090b400f00b0020a9965ef08mr15928728pjb.155.1666038303106;
        Mon, 17 Oct 2022 13:25:03 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:02 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 09/23] cifs: Convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:37 -0700
Message-Id: <20221017202451.4951-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
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

This is in preparation for the removal of find_get_pages_range_tag(). Now also
supports the use of large folios.

Since tofind might be larger than the max number of folios in a
folio_batch (15), we loop through filling in wdata->pages pulling more
batches until we either reach tofind pages or run out of folios.

This function may not return all pages in the last found folio before
tofind pages are reached.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/cifs/file.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f6ffee514c34..9a0675dd2d3c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2520,14 +2520,41 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
 			  unsigned int *found_pages)
 {
 	struct cifs_writedata *wdata;
-
+	struct folio_batch fbatch;
+	unsigned int i, idx, p, nr;
 	wdata = cifs_writedata_alloc((unsigned int)tofind,
 				     cifs_writev_complete);
 	if (!wdata)
 		return NULL;
 
-	*found_pages = find_get_pages_range_tag(mapping, index, end,
-				PAGECACHE_TAG_DIRTY, tofind, wdata->pages);
+	folio_batch_init(&fbatch);
+	*found_pages = 0;
+
+again:
+	nr = filemap_get_folios_tag(mapping, index, end,
+				PAGECACHE_TAG_DIRTY, &fbatch);
+	if (!nr)
+		goto out; /* No dirty pages left in the range */
+
+	for (i = 0; i < nr; i++) {
+		struct folio *folio = fbatch.folios[i];
+
+		idx = 0;
+		p = folio_nr_pages(folio);
+add_more:
+		wdata->pages[*found_pages] = folio_page(folio, idx);
+		if (++*found_pages == tofind) {
+			folio_batch_release(&fbatch);
+			goto out;
+		}
+		if (++idx < p) {
+			folio_ref_inc(folio);
+			goto add_more;
+		}
+	}
+	folio_batch_release(&fbatch);
+	goto again;
+out:
 	return wdata;
 }
 
-- 
2.36.1

