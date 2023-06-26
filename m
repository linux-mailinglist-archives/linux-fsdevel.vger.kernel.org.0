Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CC473DE98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjFZMOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjFZMOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:14:02 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07684E73;
        Mon, 26 Jun 2023 05:13:55 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-95-64997d6a6eda
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
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 01/25] llist: Move llist_{head,node} definition to types.h
Date:   Mon, 26 Jun 2023 20:56:36 +0900
Message-Id: <20230626115700.13873-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0xTWRSG2eeyz6FSc1KNc0Sj2IRgmIBg0Kw4aCTRuDXRGH0x44NUe2Zo
        hGKKgExCwqV4KaCgQhVRoJgOAdTa8oADh+kAIohCHQjTMRW1maiMIIq2WsFLqfFl5cv61/89
        LZ5W/clG8jr9Ucmg16SrsYJRTEVY4g7nX9QmDA3yUFmWAL53JxmovdGKwXW9BUFrWyEFE7e3
        wT/+SQSz94dpMFe5EDQ8fURDW984ArmpCMPIfwth1DeNYaCqFENx4w0MD17OUeCpPktBi30n
        DFZYKHAGnjNgnsBwyVxMBccLCgLWZg6sBdHgbarhYO5pIgyMj7EgP/wRLl7xYOiUBxjoa/dS
        MPJHLYbx1i8sDPb1M+CqLGfh2isLhpd+Kw1W3zQHfzvrKbAZg6L/52QKjr/9zMKdcmeQrt6k
        YPTfDgRdJ59QYG8dw9Djm6TAYa+i4ePvtxF4T09xUFIW4OBS4WkEpSXVDAx/usOC0bMOZj/U
        4s0/kZ7JaZoYHblE9tcz5K5FJLdqHnHE2PWQI/X2bOJoiiWNnRMUaZjxscTefAoT+8xZjpim
        RiniGevE5NXQEEf6L8wyu5f/rEjWSum6HMmwZlOqIu3M2GV05LLi2PkSG1uAungT4nlRSBLr
        ntAmFB5Cb4WRmWcsxIhudyC0XyxEiY7yZ6wJKXhaaFwgPu/v5eaDRcIu0f1ODjEjRIt33z8L
        lZXCOvFEkcx+k64UW2zOkChcWC923LOgeVYFb4o83XheKgql4WJv8zn8rbBU/KvJzVQgZT0K
        a0YqnT4nQ6NLT4pPy9PrjsUfysywo+BbWfPn9rejGdfebiTwSB2hTFhxQatiNTlZeRndSORp
        9WLlkg9mrUqp1eT9JhkyDxiy06WsbrSMZ9Q/KNf6c7Uq4VfNUemwJB2RDN9Tig+PLEAHU/x1
        MdH++KhNq1Yn9cSoT9lsFVand6Y3T3a69HVxOam/GKIyxRF56x53L309rrhT9TjCZKC25IaV
        1Wxr3Jn/OmxfILkuRVu4OvZA9gt+YO2OycpdyY6NsbL3/spIRUGpsYgUjwy9ySzcEHnrWuqe
        jup8194rZm5RirS9T+bVTFaaJjGWNmRpvgKDLJEiUgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PHWc/p/FbJG6alklN2cfDzGzWb7aMabPlD27uxx13J3dE
        hvVw0bNq1Ull18WVinLXH1GXdimVh6KWtBNuJilFukgP3GX+ee+1vT+f119vBpeYSB9GqTkj
        aDUylZQSEaK92xI3nLhUIA+eTQmC7PRgcE0kE1BUXUVB171KBFW18RgMtYTD68kRBNPPO3Ew
        5HUhKPnwFofa1gEEtvIECro/LoYe1xgF7XlpFCSWVlPwcngGA0d+DgaVlgh4mmXCoGlqkADD
        EAWFhkTMHZ8xmDJX0GCO8wdn+Q0aZj6EQPtALwnNxe0k2PrXQ8FNBwUNtnYCWuucGHQ/LKJg
        oOoPCU9b2wjoys4g4e6oiYLhSTMOZtcYDa+ajBjU6N22LzM2DK78mCPhSUaTm27dx6DnTT2C
        xuT3GFiqeilodo1gYLXk4fC7rAWBM/MrDUnpUzQUxmciSEvKJ6Bz9gkJekcYTP8qonZu55tH
        xnBebz3H2yaNBN9h4vgHN97SvL6xn+aNlrO8tTyQL20YwviScRfJWypSKN4ynkPzqV97MN7R
        20Dxoy9e0Hzb9Wlin2+UaLtcUCljBO3GHUdEimu9xSi6WHQ+N6mGjEONTCryYjg2lHNm6QkP
        U+w6rq9vCvewN7uas2Z8IlORiMHZ0oXcYNtj2lMsZfdyfRO2eSZYf67j56f5ZzEbxl1NsJH/
        pH5cZU3TvMiL3czVPzMhD0vcNwkOO5WFREa0oAJ5KzUxaplSFRakO6mI1SjPBx09pbYg93LM
        l2ay69BEd7gdsQySLhIHr7oul5CyGF2s2o44Bpd6i5f9MsglYrks9oKgPXVYe1Yl6OxoBUNI
        l4v3HBSOSNjjsjPCSUGIFrT/W4zx8olDzpYtNfFWdpP22JLIH6cvzoUNWu60DNvfdT8PTFsj
        Kwl5F3AgP9OLe+n7zO+0oj567YOjzDH/jq3NF3Mybi//lrR+X1ms2tAwQupuce+jVIFD6ZVR
        +wsGCg91+n//vnvxXZWPJiYgV7GyTtJRFr01UpTuN16NIi47ri6ofjQxatwVKiV0CllIIK7V
        yf4Ci/xDFDUDAAA=
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
index ea8cf60a8a79..b12a44400877 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -187,6 +187,14 @@ struct hlist_node {
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

