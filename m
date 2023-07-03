Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF37458C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGCJtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGCJtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:46 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 649B518D;
        Mon,  3 Jul 2023 02:49:40 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-e5-64a299b173bd
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 01/25] llist: Move llist_{head,node} definition to types.h
Date:   Mon,  3 Jul 2023 18:47:28 +0900
Message-Id: <20230703094752.79269-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiGec/He04rnSediWdinKvBLZqhLLo9Mc6YYeLrjzkN0R+QqJ09
        kUZatCgCkwRWREVAIYEKIpSKtWlR8KCbAyGIEUFiqdowZkoHCJsoX0OLdiBKNf65cyX381y/
        bp5WN7CLeL3xkGQyahM1WMkoR8OrvpZLbbrVLycUUJi3GgIvTzBQXluDwXPFhaDmWhYFw3c2
        w59TIwim73fRYCn2IKjq76XhWpsfQZPjVwyPBj8Bb2AcQ0fxKQzmC7UYHjyfocBXUkSBS/4R
        Os/YKGgJ/suAZRjDOYuZmounFATtTg7smZEw4CjjYKY/Gjr83Sw0PV4JpRU+DDebOhhouzFA
        waOGcgz+mrcsdLa1M+ApzGfh8pgNw/MpOw32wDgHD1usFNRlz4lyXsyycDe/hYKc6qsUeP9q
        RNB8oo8CuaYbw+3ACAX1cjEN/1+6g2CgYJSDY3lBDs5lFSA4dayEga43d1nI9q2F6dfleOM6
        cntknCbZ9UdI05SVIfdsIvmjrJcj2c2POWKVD5N6xwpy4eYwRaomAyyRnScxkSeLOJI76qXI
        mNvNkfaz0wwZ9FqobRFxyvU6KVGfIplWbdijTMh7+IQ9cF6ZOnQFMlEzn4sUvCisEZ91zTIf
        2f7Ez4UYC1+KPT1BOsQLhKViff4/bC5S8rRwfJ7omLiPQ8Wnwi6x2uljQ8wIkeJIZ857Vglr
        xcpgO/4g/Vx01bW8FymEb8Wh1wUoxOq5G1+pH4ekomBWiI5XFejDw2fiLUcPcwaprCjMidR6
        Y4pBq09cE5WQZtSnRu1NMshoblH2jJn4G2jSE9uKBB5pwlU9v1Tp1Kw2JTnN0IpEntYsUJn7
        K3VqlU6bli6ZknabDidKya0ogmc0C1XfTB3RqYV92kPSfkk6IJk+thSvWJSJzFuXfBHWvefV
        06wle13blymtqVtjazW5TsvgaXtDmTu6z9U7+3PrdW9dxOjBq0xh386hhTsevIk1zM/4ziDE
        xE9mbbx+sYCtbkzS/u3+KRD3n21T5PrFF6c3J7nTPVu+Ot4Y9cNveTJZrjoalhG+rNu9IYb7
        /ft049Cm0t3Pdsbsz2/QMMkJ2ugVtClZ+w4jw7xDTQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRzGe99zznuOxxaHJXSooFhEYGRWGv8wJOhDx6KIIroQ6WqHNnIW
        m5p2AWtm3slKTV3lJaaopW0F3RRRvCxpmYppraWWlXkLdebSLq7oy8MPnoffp4ejlGZmMaeL
        ipYNUepIFeFpfleIac39vGJNYMnnAMhKDwT3ZDIN5qpKAm33KhBUPriAYbBxG7yeGkYw8+Il
        BbnZbQiK+t5R8KDJhaCm7CKBjo8LoNM9RsCenUbAVFJF4NXQLAZnzlUMFdad0HqlGEOd5zMN
        uYMECnJNeC6+YPBYylmwJKyE/rJ8Fmb71oHd1cVAw007AzVvVkPeLSeBZzV2Gpoe9WPoeGIm
        4Kr8zUBrUwsNbVkZDNwdLSYwNGWhwOIeY6G9rhBDdeKcLWniFwPNGXUYku7cx9DZ8xRBbXIv
        BmtlF4EG9zAGmzWbgh+ljQj6M0dYuJTuYaHgQiaCtEs5NLz82cxAojMYZqbNZEuI1DA8RkmJ
        ttNSzVQhLT0vFqXH+e9YKbH2DSsVWmMkW5m/VPJsEEtF425GspanEMk6fpWVUkc6sTTqcLBS
        y40ZWvrYmYt3Lz3Eb9bIkbpY2bA2NILXprd/YE7d5OMG7kECquVSkQ8nCkGi5YOL9TIRVond
        3R7Ky37CctGW8YlJRTxHCZd9xbJvL4i3WCgcEe+UOxkv08JKcbg16S8rhGDxtqeF/JMuEyuq
        6/6KfISN4sB0JvKycm7jzHORK4gvRPPKkZ8uKlav1kUGBxhPaOOjdHEBx07qrWjuM5bzs1mP
        0GTHtnokcEg1X9F9tkijZNSxxnh9PRI5SuWnMPXd1igVGnX8GdlwMtwQEykb69ESjlYtUmzf
        L0cohePqaPmELJ+SDf9bzPksTkB90Qv4tyNhSdrmLJIibz207HBBqWLTufGlVct7Nuzssc+M
        Ps8fWu/4NbkiLZRvfMj76bcc2JEW/mUo8NNEjr9HuB42ookBfFQbZH6/uSks4sd3R0pQmH7S
        kWEP+v1tT7rTpj1t0p7dXr3vScDANd/A61MTmw6GJn/tXejJV+81hqhoo1a9zp8yGNV/AArV
        ij0vAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

llist_head and llist_node can be used by very primitives. For example,
Dept for tracking dependency uses llist things in its header. To avoid
header dependency, move those to types.h.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/llist.h | 8 --------
 include/linux/types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d02d65..99cc3c30f79c 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -53,14 +53,6 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-struct llist_head {
-	struct llist_node *first;
-};
-
-struct llist_node {
-	struct llist_node *next;
-};
-
 #define LLIST_HEAD_INIT(name)	{ NULL }
 #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
 
diff --git a/include/linux/types.h b/include/linux/types.h
index 688fb943556a..0ddb0d722b3d 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -193,6 +193,14 @@ struct hlist_node {
 	struct hlist_node *next, **pprev;
 };
 
+struct llist_head {
+	struct llist_node *first;
+};
+
+struct llist_node {
+	struct llist_node *next;
+};
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 #ifdef CONFIG_ARCH_32BIT_USTAT_F_TINODE
-- 
2.17.1

