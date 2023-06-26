Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A56873DF03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFZMYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjFZMYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:24:05 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4B80213E;
        Mon, 26 Jun 2023 05:22:26 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-28-64997d6edf5b
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
Subject: [PATCH v10 24/25] dept: Make Dept able to work with an external wgen
Date:   Mon, 26 Jun 2023 20:56:59 +0900
Message-Id: <20230626115700.13873-25-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUxTZxQH8D3Pvfe5baXLTSXu+hK3dCFOFxE31ONLdItLvHExWeYXnTps
        7A1UoXRFwTpNeKmLo6JoUt7VUkglUFGLMSgtqSBQZEI3CQKpMIibqxSJlSIF1LUavpz8ck7O
        /3w5EkrhZpZINNqjol6rSlUSGS0bj7Gu1p4qVSd4Rj6HC2cTIDR5hoaK63YC3vo6BPZbORj8
        bTvg8VQAwezDHgqKzV4ElSNPKLjVPoTAVZNL4NHTj6E3NEGg02wikFd1ncCfY3MYfEUXMdQ5
        dkFXoRWDO/yMhmI/gfLiPBwp/2EI22pZsGXHwWhNGQtzI2uhc6iPAdfgl1B62UfA6eqkob1x
        FMOjuxUEhuzvGOhq99DgvVDAwLUXVgJjUzYKbKEJFv5yWzDcMEaCns+5MPz26i0DHQXuiKpv
        YugdaELQfOZvDA57H4HWUABDg8NMwczVNgSj58ZZOH02zEJ5zjkEptNFNPS86WDA6FsHs9MV
        5JvNQmtgghKMDVmCa8pCCw+svHCn7AkrGJsHWcHiOCY01KwSqpx+LFQGQ4zgqP2dCI7gRVbI
        H+/Fgq/PSYQX3d2s4CmZpX9Y9pNsi1pM1WSK+jVbD8pS7FVdjM657XhRoB5no5Kv85FUwnOJ
        fM/rGTzv2zOlKGrCreD7+8NU1LHcZ3xDwb9MPpJJKK5qAf/Mc5+NDhZyu/jOS9dI1DQXxw8H
        Gumo5dx63m1zUh9CP+XrbrjfWxrpN/1hfX9Awa3jc30tJBrKcyYpf2V4AH1YWMzfq+mnC5Hc
        gj6qRQqNNjNNpUlNjE8xaDXH4w+lpzlQ5K9sp+b2NaKgd3cL4iRIGSNPWF6iVjCqzAxDWgvi
        JZQyVr5oulitkKtVhhOiPj1JfyxVzGhBSyW08hP5V1NZagWXrDoqHhFFnaifn2KJdEk20v9Y
        0hGz8eSG/VvI0tjb1ZOmL8KJ95NGVxou6VZfUZh/SVJ2HfDnfU/Uyz06dQEnfZ48nbwnlL/B
        Yb93c8Brkf3j//Xxz2T44UHDysPLdi767unktydqx156cnSmbQfwYLC6sjVdmri9/nzuRPwC
        aXnbiqw4Yu5GrYUbN6UE9xq9SjojRbV2FaXPUP0PuU4rIFMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0hTYRgH8N5zec9xtTgsqVNhl4FERWUX46mk+pQvQWEFBX3J4U651Cmb
        WhbG0tnF1Frh3UK3WqYzbVZYbTEvmdMulmYXlqVEZc2EcpK3aiv68vDj+cP/+fLwtMLMzuE1
        2mRJp1XFK7GMkW3fkLlMm16sDjM18GDKCQPf8CkGymptGDqvVyOw3TxOwcCDSHg54kUw/vgp
        DYX5nQgq+t7ScLO1F4GzMgND14fp0O0bwuDOP4Mh01KL4dnXCQo8BecpqLZvg45zZgpco58Y
        KBzAUFqYSfnHZwpGrVUcWA2h0F9ZwsFE30pw9/aw0HzRzYLzzVIovuTB4HC6GWht6Keg624Z
        hl7bbxY6WtsY6DTlslDzzYzh64iVBqtviIPnrnIK6oz+ti8TTgpO/PjFwsNcl1+Xb1DQ/foe
        gvun3lNgt/VgaPZ5Kai359MwdvUBgv68QQ6yckY5KD2eh+BMVgEDTycfsmD0hMP4zzK8OYI0
        e4doYqw/RJwj5QxpN4vkTslbjhjvv+FIuT2F1FcuIRbHAEUqvvtYYq86jYn9+3mOZA92U8TT
        48Dk25MnHGkrGmeiQvbKItRSvCZV0q3YGC2LtVk62CTHpsMF3uuUARWtzkZBvCisEW+PFaOA
        sbBIfPVqlA44WFgg1ud+ZLORjKcFy1TxU1sLFwhmCNtE98UaHDAjhIrvvA1MwHJhreiyOuh/
        pfPF6jrXXwf59/cemf8eUAjhYoanCZ9DsnI0pQoFa7SpCSpNfPhyfVxsmlZzeHlMYoId+T/H
        mj5hakDDXZFNSOCRcpo8bF6RWsGqUvVpCU1I5GllsHzmz0K1Qq5WpR2RdIn7dCnxkr4JzeUZ
        5Sz51j1StEI4oEqW4iQpSdL9Tyk+aI4BRfVbFrfLrmyevNY8Vd12crYVmSMylr4OqWtdv5Ne
        +KJMt+tAKFt5bPZkSkdfyXBFdM3W2IW7ttzat6r4QzJ/KLfRnZYVJ2s/uiEmtdSANYPynCTj
        rBCiMDTOXGA6+CV9hqHXXJBy8lbLukRX5urdn6NWjO3fMXeTYeTC7rNHBSFfqWT0saqVS2id
        XvUHLnj9EDUDAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a case where total maps for its wait/event is so large in size.
For instance, struct page for PG_locked and PG_writeback is the case.
The additional memory size for the maps would be 'the # of pages *
sizeof(struct dept_map)' if each struct page keeps its map all the way,
which might be too big to accept.

It'd be better to keep the minimum data in the case, which is timestamp
called 'wgen' that Dept makes use of. So made Dept able to work with an
external wgen when needed.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 18 ++++++++++++++----
 include/linux/dept_sdt.h |  4 ++--
 kernel/dependency/dept.c | 30 +++++++++++++++++++++---------
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 0aa8d90558a9..ad32ea7b57bb 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -487,6 +487,13 @@ struct dept_task {
 	bool				in_sched;
 };
 
+/*
+ * for subsystems that requires compact use of memory e.g. struct page
+ */
+struct dept_ext_wgen{
+	unsigned int wgen;
+};
+
 #define DEPT_TASK_INITIALIZER(t)				\
 {								\
 	.wait_hist = { { .wait = NULL, } },			\
@@ -518,6 +525,7 @@ extern void dept_task_exit(struct task_struct *t);
 extern void dept_free_range(void *start, unsigned int sz);
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_ext_wgen_init(struct dept_ext_wgen *ewg);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
 
 extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
@@ -527,8 +535,8 @@ extern void dept_clean_stage(void);
 extern void dept_stage_event(struct task_struct *t, unsigned long ip);
 extern void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *c_fn, const char *e_fn, int sub_l);
 extern bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f);
-extern void dept_request_event(struct dept_map *m);
-extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn);
+extern void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg);
+extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn, struct dept_ext_wgen *ewg);
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
@@ -559,6 +567,7 @@ extern void dept_hardirqs_off_ip(unsigned long ip);
 struct dept_key  { };
 struct dept_map  { };
 struct dept_task { };
+struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 #define DEPT_TASK_INITIALIZER(t)   { }
@@ -571,6 +580,7 @@ struct dept_task { };
 #define dept_free_range(s, sz)				do { } while (0)
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_ext_wgen_init(wg)				do { } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
 
 #define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
@@ -580,8 +590,8 @@ struct dept_task { };
 #define dept_stage_event(t, ip)				do { } while (0)
 #define dept_ecxt_enter(m, e_f, ip, c_fn, e_fn, sl)	do { (void)(c_fn); (void)(e_fn); } while (0)
 #define dept_ecxt_holding(m, e_f)			false
-#define dept_request_event(m)				do { } while (0)
-#define dept_event(m, e_f, ip, e_fn)			do { (void)(e_fn); } while (0)
+#define dept_request_event(m, wg)			do { } while (0)
+#define dept_event(m, e_f, ip, e_fn, wg)		do { (void)(e_fn); } while (0)
 #define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
index 21fce525f031..8cdac7982036 100644
--- a/include/linux/dept_sdt.h
+++ b/include/linux/dept_sdt.h
@@ -24,7 +24,7 @@
 
 #define sdt_wait_timeout(m, t)						\
 	do {								\
-		dept_request_event(m);					\
+		dept_request_event(m, NULL);				\
 		dept_wait(m, 1UL, _THIS_IP_, __func__, 0, t);		\
 	} while (0)
 #define sdt_wait(m) sdt_wait_timeout(m, -1L)
@@ -49,7 +49,7 @@
 #define sdt_might_sleep_end()		dept_clean_stage()
 
 #define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
-#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__, NULL)
 #define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
 #else /* !CONFIG_DEPT */
 #define sdt_map_init(m)			do { } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index cdfda4acff58..335e5f67bf55 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2230,6 +2230,11 @@ void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u,
 }
 EXPORT_SYMBOL_GPL(dept_map_reinit);
 
+void dept_ext_wgen_init(struct dept_ext_wgen *ewg)
+{
+	WRITE_ONCE(ewg->wgen, 0U);
+}
+
 void dept_map_copy(struct dept_map *to, struct dept_map *from)
 {
 	if (unlikely(!dept_working())) {
@@ -2415,7 +2420,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
  */
 static void __dept_event(struct dept_map *m, unsigned long e_f,
 			 unsigned long ip, const char *e_fn,
-			 bool sched_map)
+			 bool sched_map, unsigned int *wgp)
 {
 	struct dept_class *c;
 	struct dept_key *k;
@@ -2437,14 +2442,14 @@ static void __dept_event(struct dept_map *m, unsigned long e_f,
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
 
 	if (c && add_ecxt(m, c, 0UL, NULL, e_fn, 0)) {
-		do_event(m, c, READ_ONCE(m->wgen), ip);
+		do_event(m, c, READ_ONCE(*wgp), ip);
 		pop_ecxt(m, c);
 	}
 exit:
 	/*
 	 * Keep the map diabled until the next sleep.
 	 */
-	WRITE_ONCE(m->wgen, 0U);
+	WRITE_ONCE(*wgp, 0U);
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f,
@@ -2654,7 +2659,7 @@ void dept_stage_event(struct task_struct *t, unsigned long ip)
 	if (!m.keys)
 		goto exit;
 
-	__dept_event(&m, 1UL, ip, "try_to_wake_up", sched_map);
+	__dept_event(&m, 1UL, ip, "try_to_wake_up", sched_map, &m.wgen);
 exit:
 	dept_exit(flags);
 }
@@ -2833,10 +2838,11 @@ bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f)
 }
 EXPORT_SYMBOL_GPL(dept_ecxt_holding);
 
-void dept_request_event(struct dept_map *m)
+void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg)
 {
 	unsigned long flags;
 	unsigned int wg;
+	unsigned int *wgp;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2849,32 +2855,38 @@ void dept_request_event(struct dept_map *m)
 	 */
 	flags = dept_enter_recursive();
 
+	wgp = ewg ? &ewg->wgen : &m->wgen;
+
 	/*
 	 * Avoid zero wgen.
 	 */
 	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
-	WRITE_ONCE(m->wgen, wg);
+	WRITE_ONCE(*wgp, wg);
 
 	dept_exit_recursive(flags);
 }
 EXPORT_SYMBOL_GPL(dept_request_event);
 
 void dept_event(struct dept_map *m, unsigned long e_f,
-		unsigned long ip, const char *e_fn)
+		unsigned long ip, const char *e_fn,
+		struct dept_ext_wgen *ewg)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
+	unsigned int *wgp;
 
 	if (unlikely(!dept_working()))
 		return;
 
+	wgp = ewg ? &ewg->wgen : &m->wgen;
+
 	if (dt->recursive) {
 		/*
 		 * Dept won't work with this even though an event
 		 * context has been asked. Don't make it confused at
 		 * handling the event. Disable it until the next.
 		 */
-		WRITE_ONCE(m->wgen, 0U);
+		WRITE_ONCE(*wgp, 0U);
 		return;
 	}
 
@@ -2883,7 +2895,7 @@ void dept_event(struct dept_map *m, unsigned long e_f,
 
 	flags = dept_enter();
 
-	__dept_event(m, e_f, ip, e_fn, false);
+	__dept_event(m, e_f, ip, e_fn, false, wgp);
 
 	dept_exit(flags);
 }
-- 
2.17.1

