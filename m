Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C10D74594A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjGCJtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGCJtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:47 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 650991A1;
        Mon,  3 Jul 2023 02:49:40 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-08-64a299b2432f
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
Subject: [PATCH v10 rebased on v6.4 03/25] dept: Add single event dependency tracker APIs
Date:   Mon,  3 Jul 2023 18:47:30 +0900
Message-Id: <20230703094752.79269-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG/c7lO22146Qz4YhRSBMlYfECXvLGLMs0Ub7EkZCZLJvLsjX2
        KM3KxYLlFgMOUFYBUYOlQEYBUxoolx38Q0Wwwwmi4SJWKYpVCF64T7Z2VNhci/OfN788z/s8
        fz0yWnWdDZPpktJEQ5JGr8YKRjG7pmaLZKnVbu9+uQHOF20H71+FDFS1ODAMNjcicFw5RcHk
        7VgY9s0gWOoboMFcNoigZuwpDVe6PQg67D9heDDxEbi88xh6y85iyKtrwXB/epmC0UsXKGiU
        4uBeaS0FTv8rBsyTGCrNeVTgvKbAb2vgwJa7CcbtFRwsj0VDr+cRCx2PPwHLL6MYbnT0MtB9
        dZyCB9erMHgc71i4132HgcHzxSw0zdVimPbZaLB55zkYclopaM0PFJ3+818WeoqdFJy+/CsF
        rpF2BJ2FzymQHI8w3PLOUNAmldHwtv42gvGSWQ4KivwcVJ4qQXC24BIDA//0sJA/uguWFqvw
        53vIrZl5muS3pZMOn5Uhd2sFcq3iKUfyOx9zxCqdIG32KFJ3Y5IiNQtelkgNP2MiLVzgiGnW
        RZG5/n6O3ClfYsiEy0zFrz+s+FQr6nVG0bDtsx8UCV2lFWzKcGiGzxyei1wqE5LLBH6nUF3Y
        zn3gvrE3bJAxHym43X46yGv5CKGt+GVAV8ho/sxqwf5HHw4aH/PfCFP111YCDL9JaHcsrASU
        /C7B6jSz70vDhcZW54ou53cLLxZLUJBVgZ9RiwcHSwX+jFx4eG7k/8A64Te7mylFSita1YBU
        uiRjokan37k1ITNJl7H1SHKihAKLsp1c/vYqWhg81IV4GVKvUbqza7QqVmNMzUzsQoKMVq9V
        5o1Va1VKrSYzSzQkf284oRdTu9B6GaMOVcb40rUq/pgmTfxRFFNEwweXksnDctHe/dnGAxmR
        BZb4Z++ytdVf4HMxI6uPD9v64vdugO/SNn9l3JHeXLR/Y5h0sTLZtDElZ0qIywrJuhneGeI3
        HV11bKilOK5naqRu6g35OqfOMz30ImLPycXIg6asOfc+9ORh7N+08mJU7Mxi+cRyyPywvrM/
        5+aXEQd/l1sObW4qf4XUTGqCJjqKNqRq/gOTtbUrTQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/L/xxXi9OSPFhRjCIoMoOMtwsRRXToRhAURWWjHXSl07Yy
        Z2nmrTInGtjSls1pa+rMOvahm7Im3grNckyLJSl2sSzL2mppl2n05eXH87zP8+lhSYWZDmc1
        2qOiTquKU2IZJdu2KnOxVGxVR5orKCjMiwTft7MUmGsdGDpvVCNw3D5NwGDTRuj2DyEYbX9C
        gqmoE0FZ30sSbjf3Iqi3Z2DoGpgKbt8whrai8xgyy2sxPP0wRoD34gUCqqWt8LjASoAz8JYC
        0yCGy6ZMInjeERCwVTFgS58P/fYSBsb6lkJbr4eGxittNNS/WATFpV4MD+rbKGi+009A1z0z
        hl7HHxoeN7dS0FlopKHmkxXDB7+NBJtvmIFnTgsBN7OCbTlff9PQYnQSkFNxiwD38/sIGs6+
        IkByeDA0+oYIqJOKSPh5vQlBf/5HBrLzAgxcPp2P4Hz2RQqe/GqhIcsbBaM/zHjtKqFxaJgU
        suqOC/V+CyU8svLC3ZKXjJDV8IIRLNIxoc6+UCh/MEgIZSM+WpCqzmFBGrnACLkf3YTwqaOD
        EVovjVLCgNtEbJ+1R7ZaLcZpkkTdkjUHZLGughI6sTss2W+ak47cilwUwvLcMr697ws9zphb
        wPf0BMhxDuXm8nXGN0FdxpLcmcm8/XM7Hjemc7v599fvTgQobj5/3zEyEZBzUbzFaaL/lc7h
        q286J/QQbjn/+kc+GmdF8Mdb3IsLkMyCJlWhUI02KV6liYuK0B+ONWg1yREHE+IlFNyMLXWs
        8A761rXRhTgWKafIe06UqRW0KklviHchniWVofLMvqtqhVytMqSIuoRo3bE4Ue9CM1lKGSbf
        tEs8oOBiVEfFw6KYKOr+uwQbEp6OtOs2pc6UYvY3dpyy7FAYajwb9m0Ob3EebD40Y7pkr658
        uPxadPLULWuM642O2qaMPMM0c+S2xOzPO+8Fdt+w4oQGz8qw3JbsJWlYP5AW873ii2v9m5Pl
        EQ6Pl927qDhxdcHP1IeV6zaXprBpfqXlROvegdkrlRk5866tGExJr+w+oqT0saqlC0mdXvUX
        eQqn0i8DAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wrapped the base APIs for easier annotation on wait and event. Start
with supporting waiters on each single event. More general support for
multiple events is a future work. Do more when the need arises.

How to annotate (the simplest way):

1. Initaialize a map for the interesting wait.

   /*
    * Recommand to place along with the wait instance.
    */
   struct dept_map my_wait;

   /*
    * Recommand to place in the initialization code.
    */
   sdt_map_init(&my_wait);

2. Place the following at the wait code.

   sdt_wait(&my_wait);

3. Place the following at the event code.

   sdt_event(&my_wait);

That's it!

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_sdt.h | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/linux/dept_sdt.h

diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
new file mode 100644
index 000000000000..12a793b90c7e
--- /dev/null
+++ b/include/linux/dept_sdt.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Single-event Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_SDT_H
+#define __LINUX_DEPT_SDT_H
+
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define sdt_map_init(m)							\
+	do {								\
+		static struct dept_key __key;				\
+		dept_map_init(m, &__key, 0, #m);			\
+	} while (0)
+
+#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
+
+#define sdt_wait(m)							\
+	do {								\
+		dept_request_event(m);					\
+		dept_wait(m, 1UL, _THIS_IP_, __func__, 0);		\
+	} while (0)
+
+/*
+ * sdt_might_sleep() and its family will be committed in __schedule()
+ * when it actually gets to __schedule(). Both dept_request_event() and
+ * dept_wait() will be performed on the commit.
+ */
+
+/*
+ * Use the code location as the class key if an explicit map is not used.
+ */
+#define sdt_might_sleep_start(m)					\
+	do {								\
+		struct dept_map *__m = m;				\
+		static struct dept_key __key;				\
+		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__);\
+	} while (0)
+
+#define sdt_might_sleep_end()		dept_clean_stage()
+
+#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
+#else /* !CONFIG_DEPT */
+#define sdt_map_init(m)			do { } while (0)
+#define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start(m)	do { } while (0)
+#define sdt_might_sleep_end()		do { } while (0)
+#define sdt_ecxt_enter(m)		do { } while (0)
+#define sdt_event(m)			do { } while (0)
+#define sdt_ecxt_exit(m)		do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_SDT_H */
-- 
2.17.1

