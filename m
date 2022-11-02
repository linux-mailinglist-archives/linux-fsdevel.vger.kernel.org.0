Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915316167F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiKBQNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiKBQLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B972CDDE;
        Wed,  2 Nov 2022 09:11:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l6so16727794pjj.0;
        Wed, 02 Nov 2022 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9oQGBma55+7a0HBQARXA8wNbnmnkmU7HtFBuB0SMcU=;
        b=lgRGvbBXfYuj04wlBtpVHwy2yZsFFIANJMcP3krdA79wzBh4OScTeSvjJg4lQ3GiI3
         qzedQnIEursJo8Y8wrorW1k3nnG6uW/QS2vrVmIvXFZlg1i7O4HcsiQIkHBi6LqK3Hws
         /m7aEjRd4+lrOka8mBd7EHcq45xsSi/7s+3yt3h27vjVFT6859E+s3o4irrHvYyKTxlH
         6KXijZ6dtNgWx/FcJ0jqINoyCdNdAJm6gC+OU2m4I7MMiT2P+IkB6xQggwX5UN9tdlUH
         oIy8W/ni9KIfG99ZHM5kVgqC7Om0fcn8SoY/XV7phYth7Ym2e9szQ6efXI8rxGZIQ5Qz
         7ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9oQGBma55+7a0HBQARXA8wNbnmnkmU7HtFBuB0SMcU=;
        b=MHHBZD8O7utpwysZd9uYPClYXcghq0sGBdtUDDIzwgvgu/q8LVeNH/Ic7M8D3mjxu6
         9axXsIbC31xgrolgAlCGT79hvIatuwBNLg5/GxAyM8f0HU+QmRNBzSU7nNVmO32O5RGL
         xFh9fancZbOsXrOAoaxNzGuD1pYyylfwJCWZ68ePVtMA/UoLQX5PTh93qa9OBS+vcnAX
         1IiZ95l7H1JB/qy9RuMKp7Jo0K8F6IlT6hKz/smx19oL+y1jmjFnGsCeMhPRkDZWS/rl
         CrjurPQraZ1SVzyoQaPTjnhfbLUvkVdT8eZxqIsaq7NeS1ffdhEfstNj5dt5T4lWyvi6
         RPpg==
X-Gm-Message-State: ACrzQf0Thlk5ZGu3rMb/VSCSY6cBXPiq56X0izXwvM990zbQeTe0RFCk
        wpvg3439EZDkTp9cc+8Y0McHU/enDGYaSw==
X-Google-Smtp-Source: AMsMyM6/72+MYEmeobRp0nXOdIc9AWtvXPDkE1Loq96kr4fO9Vd06b8/zC8fQ3xgY4YxH0AYxNXhtQ==
X-Received: by 2002:a17:90a:3c8a:b0:213:8043:4b7f with SMTP id g10-20020a17090a3c8a00b0021380434b7fmr34554910pjc.99.1667405480651;
        Wed, 02 Nov 2022 09:11:20 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:20 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 09/23] cifs: Convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:17 -0700
Message-Id: <20221102161031.5820-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
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
 fs/cifs/file.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f6ffee514c34..789fd0397cb4 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2520,14 +2520,40 @@ wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
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
+		folio_ref_inc(folio);
+		if (++*found_pages == tofind) {
+			folio_batch_release(&fbatch);
+			goto out;
+		}
+		if (++idx < p)
+			goto add_more;
+	}
+	folio_batch_release(&fbatch);
+	goto again;
+out:
 	return wdata;
 }
 
-- 
2.38.1

