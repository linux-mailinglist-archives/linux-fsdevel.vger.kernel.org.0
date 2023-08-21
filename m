Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E25E7822D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjHUEer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjHUEeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:34:46 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A64B99;
        Sun, 20 Aug 2023 21:34:43 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-f9-64e2ded4f362
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
Subject: [RESEND PATCH v10 01/25] llist: Move llist_{head,node} definition to types.h
Date:   Mon, 21 Aug 2023 12:46:13 +0900
Message-Id: <20230821034637.34630-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRjA+37fn53O3p22XmI4YjKJYc8wPzab9x+bCX9g0829dFzHLiIb
        KyXkQugHnXaVnXOd4r0MUUvmKkR0U8hNd+KacjndKZVU5p9nn+35PJ+/HpZQVFFTWI3uoKjX
        qbRKWkbKesKKFzhdbnVswfBMyDHEQqDvNAnGChsNzeVlCGyVaRi6nq6H1mA3gsGmVwTk5zYj
        KO74SEClw4Wg2nKChpbPE8EZ8NHQmHuWhvTSChpefxvC0J53EUOZtAGeXyjBUDvwlYT8LhoK
        89Px6PBiGDBbGTCnRoHbcpWBoY5F0Oh6S0H1+/lwpaidhkfVjSQ47rsxtFQZaXDZRih47mgg
        oTknm4Jb30to+BY0E2AO+Bh4U2vCcDtjNJT58w8F9dm1GDKv38HgfPcQQc3pTxgk21sangS6
        MdilXAJ+33iKwH2uh4GThgEGCtPOITh7Mo+EV8P1FGS0L4XBfiO9ZrnwpNtHCBn2w0J10EQK
        z0p44cHVj4yQUfOeEUzSIcFuiRZKH3VhodgfoATJeoYWJP9FRsjqcWLh+8uXjNBQMEgKn535
        eGPkNtlKtajVJIv6haviZQmGNx7qwDXZkc5ySEU1bBYKZXluCZ/TZ6P/s+R2jDPNzeXb2gaI
        MQ7nZvD27C9UFpKxBHdqAm/pbRqXJnFb+IA/iMaY5KL4kXs+aozl3FLe5LuD/0Wn82W3a8dD
        odwyXnpYNe4rRp0fHR5yLMpz50N5v+Mu8e9gMv/Y0kZeQHITCrEihUaXnKjSaJfEJKToNEdi
        du1PlNDoR5mPDW2/j/zNcXWIY5EyTB4/1a1WUKrkpJTEOsSzhDJcHvmrQ62Qq1UpR0X9/p36
        Q1oxqQ5FsqQyQr44eFit4PaoDor7RPGAqP+/xWzolFRU4H1XZCwKmb/G29ow7XhhyO5VFf2r
        1+V4rJtZqfOykV5+U9kWfaPKU9rgKrobsdWauSf20rQ5L3o37TZF5aXPCtNFbLO3tsvDqUrO
        gHvneevj6iOb5ml3VlomG7x9caa9tzydwxMfuKf6+vqvldTtCDAtm9Z+mC1LO2YPWaGIGVGS
        SQmqRdGEPkn1FylsathNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiGed9zznsOdV1OKsajsGCakBlQhCjzURfjjzlPXLYsmYaEmEhj
        j1KBwlpEMJqgLY7xYcAFOrWYClobwK9TjSgCFcKXRGG0UWGAtqJIRKrMogjCAOOfJ1dyX7l+
        PRylsjLLOZ0+QzLoNSlqoqAVv2wyrfYM+rQxJbUESgpjIPAujwbrlRoC3ZerEdRcP4phpGUb
        PJoYRTB1v4sCS2k3gnPeAQqutw4iqHccI+Ae+ho8AT+BjtICAqbKKwT+eTWNob/sJIZq+Wfo
        LK7A4JocpsEyQuCMxYTnzksMk/YqFuw5EeBznGZh2hsLHYMPGWgu72Cgvi8KTp3tJ3CnvoOG
        1lofBvdtK4HBmlkGOlvbaeguKWLg0lgFgVcTdgrsAT8LPS4bhqvmudrx/2YYaCtyYTh+/hoG
        T28dgoa8pxjkmocEmgOjGJxyKQUfL7Yg8J14zUJu4SQLZ46eQFCQW0ZD16c2Bsz9cTD1wUq2
        bBKbR/2UaHYeFOsnbLR4r0IQb50eYEVzQx8r2uQDotMRKVbeGcHiufEAI8pVfxJRHj/Jivmv
        PVgce/CAFdv/nqLFIY8F/xqWoPheK6XoMiXDms2JiqTCnmdMerki6/llyEENXD4K5gR+nSD7
        Wsk8E/5b4fHjSWqeQ/gVgrPoBZOPFBzF/7FIcLy5vyAt5ncKgfEJNM80HyHM3vQz86zk4wSb
        /xr+HA0Xqq+6FkLB/HeCXHd7wVfNOW+9z+hipLChoCoUotNnpmp0KXHRxuSkbL0uK3pPWqqM
        5n7GfmS6pBa9c29rQjyH1F8pE8N8WhWjyTRmpzYhgaPUIcrQ916tSqnVZB+SDGm7DQdSJGMT
        CuVo9VLl9ngpUcXv02RIyZKULhm+rJgLXp6DMt46a8OODPy4LPFJULTFFr9iUXmW6fDagn2h
        pjSqbuuOG5U2745w+82+59bZqKUNfVF5M/urloxt/dQ7lbA+qDEvmjhWF99tazGfMqyKcv8e
        2jvc3vjNxvQZ9NcFff5G5w+us/8GmsL3bti+rMvd+FOuPW3llh4+Ytdvh0sdhV3xpExNG5M0
        sZGUwaj5HwEiwkAvAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

