Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8E5B601E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiILSZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiILSZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:25:23 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34C713DD2;
        Mon, 12 Sep 2022 11:25:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c198so9410082pfc.13;
        Mon, 12 Sep 2022 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+d28bepiquHWlxilFueNkEADr0o+je+NLAZFPUKTbIY=;
        b=UAvqeyyLl/jMM4GcLetiAfdFe+mfb9lKdBJfnSYldnUlLqvzEBn5ucL+x7WyU328TX
         0/H9S52HSNuIFSWZ4YunFZhb9lMParyxzhpSfOriqzuEWl4nNQDfXBSCfd6PHcpEoArW
         hhkS/p47e7LTcdSDzPM5i4xcpSpua30NKF59fo2sfAm71y1h24VA6yU9gVJkZlr/HpKr
         kqbY0nqvYn5G/9BlH7ySmMvtkJ2+1WrYDojpVBZMQYHQaBxAnxx6msfYZA0Ac2gMEKOu
         fegLeVBCk9YxpsZnm6jcCKHOUZl7iJDeg1NFYcwjZsYJ40Ns924KMhs4Yi3zIL0Ak4bb
         eQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+d28bepiquHWlxilFueNkEADr0o+je+NLAZFPUKTbIY=;
        b=240KgzlZl2Rd6r64J4yT51LqDv7SQjzuOMVGa3/Rc+07Yp9cOjebFN+c/AGDvOLO+f
         aGnZ3aWqiaQJay+6Rs7AJL8ooJvxgcmAjQq4qi949L0KuUcIUNdT76i6jhyDbNbU2l8W
         a5CQUuP0MfH2x3B1euV3xzuKdJ9w/K5vCM4wGHB9DCFcjBvxkwbqvMiWVcDSDnSYRzlo
         AseWj3SnZDzIhfGLWj5xQjRHr6XUkrAVeieAdE5p+Fco+loITfLmHTb3f0C4OBBLWzDk
         J/ovXyx6r/tBbG5hNy3TNlO1ERJsWJN1X67KmCLA+0MPVmSScocRYiQIzWmoSYKYR7Q3
         Ilpg==
X-Gm-Message-State: ACgBeo0hNftJCE+7SA/Jf5j0lsbPlodse2TDmPCfEzukYyjnt+bQFF70
        kL4hBM6RyjynVUjhqqt8ToxRaZUcYocEBg==
X-Google-Smtp-Source: AA6agR4Zy8VhOF+ibmC8k8zrBCfvKjb+HhgReHqq+fiRHDk/WfuNUZ7mRsbRn+TR1ll+VP/jfqTVhg==
X-Received: by 2002:a05:6a00:1691:b0:53b:3f2c:3257 with SMTP id k17-20020a056a00169100b0053b3f2c3257mr28670886pfc.21.1663007122141;
        Mon, 12 Sep 2022 11:25:22 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:21 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 01/23] pagemap: Add filemap_grab_folio()
Date:   Mon, 12 Sep 2022 11:22:02 -0700
Message-Id: <20220912182224.514561-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
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

Add function filemap_grab_folio() to grab a folio from the page cache.
This function is meant to serve as a folio replacement for
grab_cache_page, and is used to facilitate the removal of
find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea3..4d3092d6b2c0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -547,6 +547,26 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
 	return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
 }
 
+/**
+ * filemap_grab_folio - grab a folio from the page cache
+ * @mapping: The address space to search
+ * @index: The page index
+ *
+ * Looks up the page cache entry at @mapping & @index. If no folio is found,
+ * a new folio is created. The folio is locked, marked as accessed, and
+ * returned.
+ *
+ * Return: A found or created folio. NULL if no folio is found and failed to
+ * create a folio.
+ */
+static inline struct folio *filemap_grab_folio(struct address_space *mapping,
+					pgoff_t index)
+{
+	return __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(mapping));
+}
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
-- 
2.36.1

