Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33E7458F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjGCJuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjGCJtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:53 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0B00BE;
        Mon,  3 Jul 2023 02:49:49 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-a6-64a299b3d23d
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
Subject: [PATCH v10 rebased on v6.4 13/25] dept: Distinguish each work from another
Date:   Mon,  3 Jul 2023 18:47:40 +0900
Message-Id: <20230703094752.79269-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUxTZxQHcJ/n3vvcS6XmpmK8ajKXJsbMF9T5dlzmy/yyu8QtTdgHM0xm
        Y6/S2CIpiKCS4aji0EvQiIiWScF0DXSAt8QgUkUYICJYtUoltZGKYkMRxyyBwWTUzS8nv5xz
        8s/5cDhKc51ZyBlTMyRLqt6kJSpaNRxvX+kurTCsDjckwpnTqyH67iQNtloXAW9NNQJX/TEM
        4bavoXcsgmCy+z4FJcVeBPb+ZxTUtwcReJw/E3g0MAd80RECncWnCORV1hJ4MDSFIXD+LIZq
        5VvoKqrA0DwxSENJmMClkjw8U15jmHBUseDIXQIh50UWpvrXQGfwCQOevuVQ+muAQJOnk4b2
        hhCGR402AkHXNANd7Xdo8J6RGfj9TQWBoTEHBY7oCAsPm8sx1Flngk789Z6BDrkZw4krVzH4
        nt5AcPPkcwyK6wmB1mgEg1sppuDv39oQhAqHWTh+eoKFS8cKEZw6fp6G+/90MGANrIfJcRvZ
        9oXYGhmhRKv7kOgZK6fFuxWCeP3iM1a03uxjxXLloOh2LhMrm8JYtI9GGVGp+oWIyuhZViwY
        9mHxTU8PK965MEmLA74SrFv0g+pLg2QyZkqWVVt2q1JqXT4q7e3crN76eblI4QtQHCfw64Se
        1mn80da+Iipmwi8V/P6JD07gPxXc8iumAKk4is+fLTjfdpMCxHFz+SQhMKqJ7dD8EuFesI7E
        rOY3CPfkMuq/zMVCdV3zB8fN9F+OF6KYNfx6IVAaJLFMgc+PEy44nP8fsUC47fTTRUhdjmZV
        IY0xNdOsN5rWJaZkpxqzEvccMCto5qEcOVPJDWjUm9SCeA5p49X+I3aDhtFnpmebW5DAUdoE
        dV7/ZYNGbdBnH5YsB360HDRJ6S1oEUdr56s/Hztk0PD79BnSfklKkywfp5iLW5iLyjZcOzKU
        ti3UkPTCP7W0K3/+4/jBb7YavVfN/ue2to7tyY2Rz74LfZWhQ59Y92bvf51XI3fvXiFbdf3T
        8h6ZTTbpQ13D4caE0pxNkd4/R+TNT8eP+qzmnGjNw6adAybdOe+tn8q+r1e2eDYOrvCudQvv
        dPY/zIPxu+DcjrtZth1aOj1Fv2YZZUnX/wuCRdYFTAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSf0yMcRwHcN/v8zzf5+k4e3bCM0x2m5ksMuKzMTP+8Gh++4PxB8/cMx2V
        dlcpP7bokHStIukH+rXT6ijPNb9Lrl11hOiW5NyU/LgpJS7l8qOYfz577fP+7P3Xh6M0+cw0
        Th8dKxuipUgtUdGqDcuSQ2y5xbpQx/MpkJkWCr5vKTQUVFoJtFyrQGCtPobB61gDLwZ7EPgf
        P6UgJ7sFQVHnawqqGzwIasqOE2jtngguXx8BZ/YZAskllQSefRrB4D6fhaFCWQ+PMoox1A1/
        oCHHSyA/JxmPjo8Yhi3lLFiSZkNXWR4LI50LwelpY6D+opOBmo55kHvJTeBejZOGhltdGFrv
        FBDwWH8z8KihiYaWTDMDVz8XE/g0aKHA4utj4XldIYYq02jbya+/GGg012E4WXodg+vlXQS1
        KW8wKNY2AvW+Hgw2JZuCH1ccCLrSe1k4kTbMQv6xdARnTpyn4enPRgZM7jDwDxWQlcvE+p4+
        SjTZDoo1g4W0+LBYEG/nvWZFU20HKxYqcaKtLFgsuefFYtGAjxGV8tNEVAayWDG114XFz0+e
        sGLTBT8tdrty8KYZO1TLdXKkPl42LFixWxVRaXVRMf2TEl5UT05CCp+KAjiBXyyYOjKoMRN+
        jtDePvzXgfwswWZ+z6QiFUfxp8YLZf2PSSriuEn8VsE9oBm7ofnZQrOnioxZzS8Rms0XqX+d
        QUJFVd1fB4zu3w2lozFr+DDBneshGUhViMaVo0B9dHyUpI8Mm2/cH5EYrU+Yv+dAlIJGX8Zy
        dCTzFvrWusaOeA5pJ6jbDxfpNIwUb0yMsiOBo7SB6uTOyzqNWiclHpINB3YZ4iJlox1N52jt
        VHX4Nnm3ht8rxcr7ZTlGNvxPMRcwLQnZpoecqxKCG2/gbrI2LVBf1Ptl/SKFHr/y1PagnQ57
        f0rczO+umJBmc2f5jY1LH6wuCfLffNvkP12aN9MZvsoy93tFn96/etHygq/VFx5cjr17fZCT
        t3gd0pDgv9QWOnTEd1Z6F+q1t9xvvLl5X0NWtxcn2Kh4T23GOms4++pqhJY2RkgLgymDUfoD
        Zj/+/y4DAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Workqueue already provides concurrency control. By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let Dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     |  2 ++
 kernel/dependency/dept.c | 10 ++++++++++
 kernel/workqueue.c       |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index f62c7b6f42c6..d9ca9dd50219 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -515,6 +515,7 @@ extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
 extern void dept_kernel_enter(void);
+extern void dept_work_enter(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -567,6 +568,7 @@ struct dept_task { };
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
 #define dept_kernel_enter()				do { } while (0)
+#define dept_work_enter()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 4165cacf4ebb..6cf17f206b78 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1977,6 +1977,16 @@ void dept_hardirqs_off_ip(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(dept_hardirqs_off_ip);
 
+/*
+ * Assign a different context id to each work.
+ */
+void dept_work_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 void dept_kernel_enter(void)
 {
 	struct dept_task *dt = dept_task();
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c913e333cce8..fa23d876a8b5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -52,6 +52,7 @@
 #include <linux/sched/debug.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -2318,6 +2319,8 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_work_enter();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
2.17.1

