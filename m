Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755FB4EE437
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 00:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiCaWj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 18:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiCaWj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:39:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ECF1B988D;
        Thu, 31 Mar 2022 15:37:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j15so2180348eje.9;
        Thu, 31 Mar 2022 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jDnG0yED3EhVSGuEGJ6HJ38ZUXJXmhtdLq7M8giSgc=;
        b=W0kezZZDpxUVh7G7zSovCKYPK1WXt0WmzwjyrbEqA0GSQHjYkz+dF5+fba9kyHn1DK
         T5sqGXJlGGnCAob1TDToNlAsD04v26GKy6JutrYr49hDKNVuLxXRYhCk2cyJT7ECw3nS
         9vdjtd2PXTnxjRQPR1V5yTglGlYOFG78duMdaLqdbh7KaOU9C6lLjpq+oWThFyaJFdGr
         eiwpIkivMk72OVUvQXIIZMKLCap6+kCmmE9bjC/vcnnE5O4A86l6PFKWtXHvAtNyGfDG
         yxRGHw0A2eyVB1qAkY4TcGhomOK7AfFb7eDHimPOxgYxbxLASqz1rwih/PIGtYiH9zdY
         KY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6jDnG0yED3EhVSGuEGJ6HJ38ZUXJXmhtdLq7M8giSgc=;
        b=BCcmcXn3UpbBME45U2Q46mjMhjPvqOBe2Pr9ezQjGvNuo4j3k8o4FYHymKuFVC35R9
         RrCTLU63WvqdgOu7mMNoSHtr/bLCGxGdi+O2H+zaCiKS+8aMnxhNgGixkspZtoKk5X6Y
         EGWVlaNtyWUKbhgX3g6ZfPVNJUxAG438+479jtbNiqJxSMVJ7Wwo7prHGBa0Ma+dCOdw
         TUioug3F8RIyBQ4q8Lh4PiwbrDV/BP9ObI+P3Fw0N7kDqPHEm2SvO9u+C0vgAAXnqPIV
         7Ftpitk/23o6xcAucDwz2JUwHZmPVNJONZQVl8EK4iKhkFUwXLBO85u47ravDR/Hpo2G
         2ZoQ==
X-Gm-Message-State: AOAM532pc28QteBxF92gSjFSF+0fOtdt1lCM46sgBcXX/p5se4MDmOGn
        75DdPigf1Ama1kR3RrjfutV8oSEUdqV8aikF
X-Google-Smtp-Source: ABdhPJyfkrQJ1xqFDwsnCg57JhFsU+Agm0hss3ZlmWM7GlCyuZapiXPU5jqAty4sNZbUsz1ioaNc0w==
X-Received: by 2002:a17:907:3e94:b0:6d1:d64e:3141 with SMTP id hs20-20020a1709073e9400b006d1d64e3141mr6557600ejc.213.1648766258419;
        Thu, 31 Mar 2022 15:37:38 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm276709ejy.165.2022.03.31.15.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:37:38 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] fs/proc/kcore.c: remove check of list iterator against head past the loop body
Date:   Fri,  1 Apr 2022 00:37:00 +0200
Message-Id: <20220331223700.902556-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/proc/kcore.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 982e694aae77..344edcb2addd 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -316,6 +316,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	size_t page_offline_frozen = 1;
 	size_t phdrs_len, notes_len;
 	struct kcore_list *m;
+	struct kcore_list *iter;
 	size_t tsz;
 	int nphdr;
 	unsigned long start;
@@ -479,10 +480,13 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		 * the previous entry, search for a matching entry.
 		 */
 		if (!m || start < m->addr || start >= m->addr + m->size) {
-			list_for_each_entry(m, &kclist_head, list) {
-				if (start >= m->addr &&
-				    start < m->addr + m->size)
+			m = NULL;
+			list_for_each_entry(iter, &kclist_head, list) {
+				if (start >= iter->addr &&
+				    start < iter->addr + iter->size) {
+					m = iter;
 					break;
+				}
 			}
 		}
 
@@ -492,12 +496,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			page_offline_freeze();
 		}
 
-		if (&m->list == &kclist_head) {
+		if (!m) {
 			if (clear_user(buffer, tsz)) {
 				ret = -EFAULT;
 				goto out;
 			}
-			m = NULL;	/* skip the list anchor */
 			goto skip;
 		}
 

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

