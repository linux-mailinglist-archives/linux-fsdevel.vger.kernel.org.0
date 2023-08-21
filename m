Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32497822A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjHUEN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjHUEN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:13:27 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAFC89B;
        Sun, 20 Aug 2023 21:12:59 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-6b-64e2ded78026
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
Subject: [RESEND PATCH v10 24/25] dept: Make Dept able to work with an external wgen
Date:   Mon, 21 Aug 2023 12:46:36 +0900
Message-Id: <20230821034637.34630-25-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x46zn9PmRzYc1uQxT/vMzMNs+m5mbHkaM27uN91U7C6d
        jIlKlMhD5aHlKs6pE37X5uHKKpNLUxchLUenSXMVx0WucBf++ey1z/u99+f9x4enVHZmHK+L
        T5D08ZpYNaugFd0jCme+crm1cwY7psPpE3PA9+0YDfk3rSw4y0oRWMsPY+h6FAWv+jwI/E8b
        KcjLcSIobH9DQXmtC0Gl5QgLzztGQrOvl4W6nEwWUopvstD0aQBDW+4ZDKXyaqjPLsJQ1d9J
        Q14XC5fyUnBgfMTQby7hwJw8FdyWixwMtEdCneslA5Wt0+FCQRsLFZV1NNTedWN4fj+fBZf1
        NwP1tQ4anKezGLjRU8TCpz4zBWZfLwfPqkwYbqUGgo5+/cXA46wqDEev3MbQ/NqO4MGxdxhk
        60sWHvo8GGxyDgU/rz1C4D7ZzUHaiX4OLh0+iSAzLZeGxsHHDKS2LQD/j3x22SLy0NNLkVSb
        kVT2mWjypEgk9y6+4Ujqg1aOmOS9xGaJIMUVXZgUen0MkUuOs0T2nuFIRnczJj0NDRxxnPfT
        pKM5D68N26xYrJVidYmSfvaS7YoYa3E9s6di6b5cTxlORufnZaAQXhTmi/KXTuY/NzkzUJBZ
        IVxsaemnghwqTBRtWR8CHgVPCenDRcvnp2xQGC2sE9+esw2ZaGGqWOqw4yArhYViucmJ/4ZO
        EEtvVQ15QgJ72X5/6IBKWCB+aX9PB0NF4WyIOPj5+L8WY8VqSwudjZQmNKwEqXTxiXEaXez8
        WTFJ8bp9s3bsjpNR4KXMBwe23EVeZ3QNEnikHqHcPt6tVTGaRENSXA0SeUodqgz73q5VKbWa
        pP2Sfvc2/d5YyVCDwnhaPUY5t8+oVQk7NQnSLknaI+n/q5gPGZeMFiavUk4wO6PTrt6p/YH9
        GxrCpyV5D4hnryf8ioha71B56JUz1kTTo1R3jNS3TZOmeHZFuuJcHT3esZcL7B8OTRzjDjU6
        ctamXDGsWP9iB+ks9LduZKu/buWi0huFamN+RTY/GcmZfoOxKaz8lLtm+aD3oDYGH0k/lLCh
        oXHFbDVtiNFERlB6g+YPcWdgxE4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG/b5zK91qjpWEEyG6NCEmGFCi6JtonMtCOFmicTdNSiJUe4RG
        QG0RRbcE5GoBuQyo46IVtHKpiqcYuZoGAlLwUmkVJYBScYoU2JQyKmwKLPvnyS/P8+R5/3kl
        hLySWiPRJCQK2gRVnIKWktI929OCB0Zc6k23rsihMHcTeGaySai4aabBfqMegbkxFcN4VwQM
        zLoRzD94RIChxI7g8ugwAY3dIwjaa87S4BhbCU7PNA22khwa0qpv0vB4YgHDUGkRhnpxN/QV
        VGGwet+QYBinodyQhhflLQavqY4BU0oguGrKGFgYDQXbyFMKOittFLQPboDfLw7R0NZuI6G7
        yYXB0VJBw4j5EwV93T0k2AvzKLg+VUXDxKyJAJNnmoF+qxFDQ/riWuaHfym4l2fFkHnlFgbn
        81YEd7NfYhDNT2no9LgxWMQSAj5e60LgOj/JQEaul4Hy1PMIcjJKSXj0zz0K0ofCYH6ugt61
        ne90TxN8uuUk3z5rJPneKo5vLhtm+PS7gwxvFE/wlpogvrptHPOX33soXqw7R/Pi+yKG1086
        MT/18CHD91yYJ/kxpwHvDVBKd6iFOE2SoN24M1oaa67uo461fX2q1H0Dp6ALm/XIR8KxW7jH
        dj1aYppdzz175iWW2Jf9irPk/UHpkVRCsFlfcDV/PqCXgtXsT9yLYstyiWQDufqeVrzEMnYr
        12i04/9G13H1Ddbljs+iL7a2LB+Qs2HcX6OvyAIkNaIVdchXk5AUr9LEhYXojsQmJ2hOhRw6
        Gi+ixacx/bpQ2IRmHBEdiJUgxZey6ACXWk6pknTJ8R2IkxAKX5n/36NquUytSj4taI9GaU/E
        CboO5C8hFX6y7/YL0XI2RpUoHBGEY4L2/xRLfNakIOXUmLI/xhbxWvoq8vYPw8WGM/7WtU/8
        9lYmRU5MRw7ed5f/Yplb+a4lpujnq459ZZPkHbbZuzsnKvT7mIOZxpOHvy16HhLQsC78TS+X
        6Fe3qjnQ1b/NVvsh6LeF/HNCb/6eA8yPl5zVoia7tuubXH3xmKNWOxDclBfup2xQZh2XrVaQ
        ulhVaBCh1ak+A8p1h94wAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

